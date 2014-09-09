//
//  Ty_MapHomeUserDetailVC.m
//  腾云家务
//
//  Created by AF on 14-7-25.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_MapHomeUserDetailVC.h"
#import "MyAnnotation.h"
#import "BasicMapAnnotation.h"
#import "CallOutAnnotationVifew.h"
#import "Ty_MapAnnotationCell.h"
@interface Ty_MapHomeUserDetailVC ()
{
    BOOL IsUpdateMap;
    MyAnnotation * _myAnnotation;

}
@end

@implementation Ty_MapHomeUserDetailVC
@synthesize _mapView;
@synthesize userService;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - 返回
-(void)backClick{
    
    _mapView.delegate = nil;
    [_mapView removeAnnotations:_mapView.annotations];
    [self.naviGationController popViewControllerAnimated:YES];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _mapView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 20 -44 - 49);
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    
    if(![CLLocationManager locationServicesEnabled]) {
        [self alertViewTitle:nil message:@"请打开系统设置中”隐私→定位服务“,允许”腾云家务“使用您的位置。"];
    }
    
    if ([[userService longitude] intValue ] == 0 || [[userService latitude] intValue ] == 0) {
        CLGeocoder *coder = [[CLGeocoder alloc] init];
        [coder geocodeAddressString:[NSString stringWithFormat:@"%@%@",[userService intermediary_Area],[userService intermediary_AddressDetail]] completionHandler:^(NSArray *placemarks, NSError *error) {
            if (!error) {
                if (placemarks.count > 0) {
                    
                    CLPlacemark * placemark = [placemarks objectAtIndex:0];
                    NSLog(@"aifei: = %lf",placemark.location.coordinate.latitude);
                    
                    BasicMapAnnotation * basicMap = [[BasicMapAnnotation alloc]initWithTitle:nil Subtitle:nil Coordinate:CLLocationCoordinate2DMake(placemark.location.coordinate.latitude, placemark.location.coordinate.longitude)];
                    [_mapView addAnnotation:basicMap];
                    
                    _myAnnotation = [[MyAnnotation alloc]initWithTitle:nil Subtitle:nil Coordinate:CLLocationCoordinate2DMake(placemark.location.coordinate.latitude, placemark.location.coordinate.longitude)];
                    [_mapView addAnnotation:_myAnnotation];
                    [_mapView setCenterCoordinate:_myAnnotation.coordinate animated:YES];
                    
                    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(placemark.location.coordinate.latitude, placemark.location.coordinate.longitude);
                    MKCoordinateSpan span = {0.05, 0.05};//显示范围，数值越大，范围就越大
                    MKCoordinateRegion region = {coordinate,span};//地图初始化时显示的区域
                    [_mapView setRegion:region];//地图初始化时显示的区域

                };
            }  
        }];
        
    }else{
    
        
        BasicMapAnnotation * basicMap = [[BasicMapAnnotation alloc]initWithTitle:nil Subtitle:nil Coordinate:CLLocationCoordinate2DMake([[userService latitude] floatValue ], [[userService longitude] floatValue ])];
        [_mapView addAnnotation:basicMap];
        
        _myAnnotation = [[MyAnnotation alloc]initWithTitle:nil Subtitle:nil Coordinate:CLLocationCoordinate2DMake([[userService latitude] floatValue ], [[userService longitude] floatValue ])];
        [_mapView addAnnotation:_myAnnotation];
        [_mapView setCenterCoordinate:_myAnnotation.coordinate animated:YES];
        
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([[userService latitude] floatValue ], [[userService longitude] floatValue ]);
        MKCoordinateSpan span = {0.05, 0.05};//显示范围，数值越大，范围就越大
        MKCoordinateRegion region = {coordinate,span};//地图初始化时显示的区域
        [_mapView setRegion:region];//地图初始化时显示的区域

        
    }
    
  
}




#pragma mark - MKMapView Delegate

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
	if ([view.annotation isKindOfClass:[BasicMapAnnotation class]]) {
        
        if (_myAnnotation.coordinate.latitude == view.annotation.coordinate.latitude&&
            _myAnnotation.coordinate.longitude == view.annotation.coordinate.longitude) {

            return;
        }
        
        if ([view.annotation isKindOfClass:[MyAnnotation class]]) {
            
//            [_mapView removeAnnotation:_myAnnotation];
            
            
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
        
        Ty_MapAnnotationCell * annotationcell = [[Ty_MapAnnotationCell alloc]init];
        annotationcell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        annotationcell.frame = CGRectMake(0, 0, 240, 70);
        
        [annotationcell.imagePhotoView setImageWithURL:[NSURL URLWithString:userService.companyPhoto] placeholderImage:JWImageName(@"Contact_image2")];
        
        annotationcell.labTitle.text = userService.respectiveCompanies;
        
        [annotationcell.labContent initWithStratString:userService.empCount startColor:[UIColor redColor] startFont:FONT14_SYSTEM centerString:@"位阿姨" centerColor:[UIColor grayColor] centerFont:FONT14_SYSTEM endString:@"" endColor:[UIColor grayColor] endFont:FONT14_SYSTEM];
        [annotationcell.customStar setCustomStarNumber:[userService.evaluate floatValue]];
        
        
        [annotationcell.butClickCell addTarget:self action:@selector(clickCell:) forControlEvents:UIControlEventTouchUpInside];

        [annotationView.contentView addSubview:annotationcell];
        
        
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
    
//    [_mapView removeAnnotation:_myAnnotation];
    
    NSLog(@"点击大头针泡泡");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
