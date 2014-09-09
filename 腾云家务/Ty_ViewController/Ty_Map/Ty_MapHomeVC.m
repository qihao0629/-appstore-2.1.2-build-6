//
//  Ty_MapHomeVC.m
//  腾云家务
//
//  Created by AF on 14-7-22.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_MapHomeVC.h"
#import "CallOutAnnotationVifew.h"
#import "MyAnnotation.h"
#import "Ty_MapAnnotationCell.h"//cell
#import "Ty_Map_Model.h"//地图数据
#import "Ty_Map_Busine.h"//地图数据处理
#import "Ty_Home_UserDetailVC.h"

@interface Ty_MapHomeVC ()
{
    MyAnnotation * _myAnnotation;
}
@end

@implementation Ty_MapHomeVC
@synthesize _mapView;
@synthesize workGuid;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        workGuid = @"";
    }
    return self;
}
#pragma mark - 返回
-(void)backClick{

    _mapView.delegate = nil;
    _mapView.showsUserLocation = NO;
    [_mapView removeAnnotations:_mapView.annotations];
    [self.naviGationController popViewControllerAnimated:YES];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.imageView_background.hidden = YES;
    [self.naviGationController.leftBarButton setImageEdgeInsets:UIEdgeInsetsMake(5, 10, 0, 45)];
    [self.naviGationController.leftBarButton setImage:JWImageName(@"Home_map_2") forState:UIControlStateNormal];
    [self.naviGationController.leftBarButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchDown];
    self.naviGationController.leftBarButton.showsTouchWhenHighlighted = YES;
    
    _mapAnnotationArray = [[NSMutableArray alloc]init];
    _basicAnnotationArray = [[NSMutableArray alloc]init];
    
    //添加地图
    _mapView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 20 -44);
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;
    [self.view addSubview:_mapView];
    
    [self addNotificationForName:@"MapSearchShopReq"];
    
    if(![CLLocationManager locationServicesEnabled]) {
        [self alertViewTitle:nil message:@"请打开系统设置中”隐私→定位服务“,允许”腾云家务“使用您的位置。"];
    }
}


#pragma mark - _回调
-(void)netRequestReceived:(NSNotification *)_notification{
    [self hideLoadingView];
    if ([[_notification object] isKindOfClass:[NSString class]] && [[_notification object] isEqualToString:@"fail"]) {
        
        [self alertViewTitle:@"搜索失败" message:@"网络连接暂时不可用，请稍后再试"];
        
    }else {
        if ([[[_notification object] objectForKey:@"code"]intValue] == 200) {
            
            [_mapAnnotationArray addObjectsFromArray:[[_notification object] objectForKey:@"arrayMap"]];
            [_basicAnnotationArray addObjectsFromArray:[[_notification object] objectForKey:@"arrayAnnotation"]];
            
            [_mapView addAnnotations:[[_notification object] objectForKey:@"arrayAnnotation"]];

            
        }else if ([[[_notification object] objectForKey:@"code"]intValue] == 203 ){
            
            [self alertViewTitle:@"搜索失败" message:@"您的附近暂无家政信息"];
        
        }else{
            
            [self alertViewTitle:@"搜索失败" message:[[_notification object] objectForKey:@"msg"]];
            
        }
        
    }
    
}


#pragma mark - 地图位置更新
-(void) mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation

{
    if (!IsUpdateMap) {
        CLLocationCoordinate2D coordinate = userLocation.location.coordinate;
        MKCoordinateSpan span = {0.05, 0.05};//显示范围，数值越大，范围就越大
        MKCoordinateRegion region = {coordinate,span};//地图初始化时显示的区域
        [_mapView setRegion:region];//地图初始化时显示的区域
        IsUpdateMap = YES;
        
        NSMutableDictionary * _dic = [[NSMutableDictionary alloc]init];
        [_dic setObject:[NSString stringWithFormat:@"%f",userLocation.location.coordinate.latitude] forKey:@"lat"];
        [_dic setObject:[NSString stringWithFormat:@"%f",userLocation.location.coordinate.longitude] forKey:@"lng"];
        [_dic setObject:@"0" forKey:@"scopeType"];
        [_dic setObject:workGuid forKey:@"workGuid"];
        [[Ty_Map_Busine alloc]MapSearchShop:_dic];
        [self showLoadingInView:self.view];

     
    }
    
}


#pragma mark - MKMapView Delegate

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
	if ([view.annotation isKindOfClass:[BasicMapAnnotation class]]) {
//        if (_myAnnotation.coordinate.latitude == view.annotation.coordinate.latitude&&
//            _myAnnotation.coordinate.longitude == view.annotation.coordinate.longitude) {
//            
//            return;
//        }
        if ([view.annotation isKindOfClass:[MyAnnotation class]]) {
            
            [_mapView removeAnnotation:_myAnnotation];
            
        }else{
            
            _myAnnotation = [[MyAnnotation alloc]initWithTitle:nil Subtitle:nil Coordinate:view.annotation.coordinate];
            [mapView addAnnotation:_myAnnotation];
            [mapView setCenterCoordinate:_myAnnotation.coordinate animated:YES];
        }
	}
    else{
     
        NSLog(@"点击之后你要干啥");
    }
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    if (_myAnnotation && ![view isKindOfClass:[MyAnnotation class]]) {
        if (_myAnnotation.coordinate.latitude == view.annotation.coordinate.latitude&&
            _myAnnotation.coordinate.longitude == view.annotation.coordinate.longitude) {
            [mapView removeAnnotation:_myAnnotation];

        }
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
	if ([annotation isKindOfClass:[MyAnnotation class]]) {
        
        
        CallOutAnnotationVifew *annotationView = (CallOutAnnotationVifew *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"CalloutView"];
        
        if (!annotationView) {
            annotationView = [[CallOutAnnotationVifew alloc] initWithAnnotation:annotation reuseIdentifier:@"CalloutViewA"];
        
        }
        for (int i =  0 ; i < [_mapAnnotationArray count]; i++) {
            if ([annotation coordinate].latitude == [[_basicAnnotationArray objectAtIndex:i] coordinate].latitude &&
                [annotation coordinate].longitude == [[_basicAnnotationArray objectAtIndex:i] coordinate].longitude) {
                
                Ty_MapAnnotationCell * annotationcell = [[Ty_MapAnnotationCell alloc]init];
                annotationcell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                annotationcell.frame = CGRectMake(0, 0, 240, 70);
                
                [annotationcell.imagePhotoView setImageWithURL:[NSURL URLWithString:[[_mapAnnotationArray objectAtIndex:i] userPhoto]] placeholderImage:JWImageName(@"Contact_image2")];
                
                annotationcell.labTitle.text = [[_mapAnnotationArray objectAtIndex:i] intermediaryName];
                
                [annotationcell.labContent initWithStratString:[[_mapAnnotationArray objectAtIndex:i] intermediarySize] startColor:[UIColor redColor] startFont:FONT14_SYSTEM centerString:@"位阿姨" centerColor:[UIColor grayColor] centerFont:FONT14_SYSTEM endString:@"" endColor:[UIColor grayColor] endFont:FONT14_SYSTEM];
                [annotationcell.labContent setTextAlignment:NSTextAlignmentLeft];
                [annotationcell.labContent setVerticalAlignment:UIControlContentVerticalAlignmentBottom];
                
                
                [annotationcell.customStar setCustomStarNumber:[[[_mapAnnotationArray objectAtIndex:i] userEvaluate] floatValue]];

                
                [annotationcell.butClickCell addTarget:self action:@selector(clickCell:) forControlEvents:UIControlEventTouchUpInside];
                annotationcell.butClickCell.tag = i + 1000;
                [annotationView.contentView addSubview:annotationcell];
            }
        }
  
        
        
		return annotationView;
        
	} else if ([annotation isKindOfClass:[BasicMapAnnotation class]]) {
        
        MKAnnotationView * annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomAnnotation"];
        if (!annotationView) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                                           reuseIdentifier:@"CustomAnnotation"];
            annotationView.canShowCallout = NO;
            annotationView.image = [UIImage imageNamed:@"icon_map_cateid_default.png"];
        }
		
		return annotationView;
    }
	return nil;
}

#pragma mark - 详细界面
-(void)clickCell:(UIButton *)but{

    Ty_Home_UserDetailVC *userDetail = [[Ty_Home_UserDetailVC alloc] init];
    [userDetail Home_UserDetail:Ty_Home_UserDetailTypeMap];
    userDetail.userDetailBusine.userService.companiesGuid = [[_mapAnnotationArray objectAtIndex:but.tag - 1000  ] userGuid];
    [self.naviGationController pushViewController:userDetail animated:YES];

    NSLog(@"点击大头针泡泡");
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
