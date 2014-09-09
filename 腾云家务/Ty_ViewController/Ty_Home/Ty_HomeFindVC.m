//
//  Ty_HomeFindVC.m
//  腾云家务
//
//  Created by 齐 浩 on 14-6-11.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_HomeFindVC.h"
#import "Ty_HomeFind_ShopCell.h"
#import "Ty_HomeFind_PersonalCell.h"
#import "Ty_CityPopView.h"
#import "Ty_PopView.h"
#import "Ty_Model_ServiceObject.h"
#import "RefreshView.h"
#import "Ty_Model_WorkListInfo.h"
#import "My_LoginViewController.h"
#import "Ty_Pub_RequirementsVC.h"
#import "Ty_MapHomeVC.h"
#import "Ty_MapGlobalSingleton.h"

@interface Ty_HomeFindVC ()<UITableViewDataSource,UITableViewDelegate,Ty_CityPopViewDelegate,Ty_PopViewDelegate>
{
    UITableView* tableview;
    
    UIButton* areaButton;//选择区域button
    UIButton* workButton;//选择工种button
    UIButton* sortButton;//选择排序方式button
    UIImageView* areaImage;
    UIImageView* workImage;
    UIImageView* sortImage;
    Ty_PopView* workPopView;
    Ty_PopView* sortPopView;
    Ty_CityPopView* cityPopView;
    RefreshView *_refreshLoadView;
    
    
}
@end

@implementation Ty_HomeFindVC
@synthesize findBusine;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        findBusine = [[Ty_HomeFindBusine alloc]init];
        findBusine.delegate = self;
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (IFLOGINYES) {
        if([MyLoginUserType isEqualToString:@"2"]){
            self.naviGationController.rightBarButton.hidden = NO;
        }else{
            self.naviGationController.rightBarButton.hidden = YES;
        }
    }else{
        self.naviGationController.rightBarButton.hidden = NO;
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [findBusine initShaiXuan];
    self.title = [NSString stringWithFormat:@"找%@",findBusine.selectworkName];
    
    //初始化导航左侧按钮
    [self.naviGationController.leftBarButton setImageEdgeInsets:UIEdgeInsetsMake(5, 10, 0, 45)];
    //self.naviGationController.userInteractionEnabled = YES;
    [self.naviGationController.leftBarButton setImage:JWImageName(@"Home_map_1") forState:UIControlStateNormal];
    [self.naviGationController.leftBarButton addTarget:self action:@selector(map) forControlEvents:UIControlEventTouchUpInside];
    self.naviGationController.leftBarButton.showsTouchWhenHighlighted = YES;
    
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, 320, self.view.frame.size.height-49-44-64) style:UITableViewStylePlain];
    tableview.dataSource = self;
    tableview.delegate = self;
    tableview.hidden = YES;
    [tableview setBackgroundColor:view_BackGroudColor];
    tableview.separatorColor = Color_218;
    UIImageView* tableviewBackimage = [[UIImageView alloc]initWithFrame:self.view.frame];
    [tableviewBackimage setBackgroundColor:view_BackGroudColor];
    [tableview setBackgroundView:tableviewBackimage];
    
    UIView* buttonView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,tableview.frame.size.width, 44)];
    
    areaButton = [UIButton buttonWithType:UIButtonTypeCustom];
    areaButton.showsTouchWhenHighlighted = YES;
    [areaButton setBackgroundColor:[UIColor whiteColor]];
    [areaButton setBackgroundImage:JWImageName(@"home_find_btn") forState:0];
    [areaButton setFrame:CGRectMake(0, 0,self.view.frame.size.width/3, 44)];
    [areaButton addTarget:self action:@selector(areaButtonclick:) forControlEvents:UIControlEventTouchUpInside];
    [areaButton setTitleColor:text_grayColor forState:0];
    [areaButton.titleLabel setFont:FONT13_SYSTEM];
    [areaButton setTitle:@"全部区域" forState:0];
    
    areaImage = [[UIImageView alloc]initWithFrame:CGRectMake(areaButton.titleLabel.frame.origin.x+areaButton.titleLabel.frame.size.width+5, 19, 12, 6)];
    areaImage.image = JWImageName(@"home_find_DownAccessory2");
    
    [areaButton addSubview:areaImage];
    
    workButton = [UIButton buttonWithType:UIButtonTypeCustom];
    workButton.showsTouchWhenHighlighted = YES;
    [workButton setBackgroundColor:[UIColor whiteColor]];
    [workButton setBackgroundImage:JWImageName(@"home_find_btn") forState:0];
    [workButton setFrame:CGRectMake(self.view.frame.size.width/3, 0, self.view.frame.size.width/3, 44)];
    [workButton addTarget:self action:@selector(workButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [workButton setTitleColor:text_grayColor forState:0];
    [workButton.titleLabel setFont:FONT13_SYSTEM];
    [workButton setTitle:findBusine.selectworkName forState:0];
    
    workImage = [[UIImageView alloc]initWithFrame:CGRectMake(workButton.titleLabel.frame.origin.x+workButton.titleLabel.frame.size.width+5, 19, 12, 6)];
    workImage.image = JWImageName(@"home_find_DownAccessory2");
    
    [workButton addSubview:workImage];

    sortButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sortButton.showsTouchWhenHighlighted = YES;
    [sortButton setBackgroundColor:[UIColor whiteColor]];
    [sortButton setBackgroundImage:JWImageName(@"home_find_btn") forState:0];
    [sortButton setFrame:CGRectMake(self.view.frame.size.width/3*2, 0, self.view.frame.size.width/3, 44)];
    [sortButton addTarget:self action:@selector(sortButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [sortButton setTitleColor:text_grayColor forState:0];
    [sortButton.titleLabel setFont:FONT13_SYSTEM];
    [sortButton setTitle:@"按距离" forState:0];
    
    sortImage = [[UIImageView alloc]initWithFrame:CGRectMake(sortButton.titleLabel.frame.origin.x+sortButton.titleLabel.frame.size.width+5, 19, 12, 6)];
    sortImage.image = JWImageName(@"home_find_DownAccessory2");
    
    [sortButton addSubview:sortImage];
    [buttonView addSubview:areaButton];
    [buttonView addSubview:workButton];
    [buttonView addSubview:sortButton];
    
    [self.view addSubview:buttonView];
    buttonView = nil;
    
    [self.view addSubview:tableview];
    
    [findBusine OpenGPS];

    workPopView = [[Ty_PopView alloc]initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height-44-49-64) dataArray:findBusine.workArray];
    workPopView.delegate = self;
    [workPopView setTag:2];
    
    sortPopView = [[Ty_PopView alloc]initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height-44-49-64) dataArray:findBusine.sortArray];
//    sortPopView.array = [findBusine.sortArray copy];
    sortPopView.delegate = self;
    [sortPopView setTag:3];
    
    [[Ty_CityPopView shareCityPopView:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height-44-49-64) States:USERPROVINCE City:USERCITY] disAppear];
    
    //初始化导航右侧按钮
    [self.naviGationController.rightBarButton setTitle:@"发抢单" forState:UIControlStateNormal];
    [self.naviGationController.rightBarButton.titleLabel setFont:FONT15_BOLDSYSTEM];
    [self.naviGationController.rightBarButton setExclusiveTouch:YES];
    [self.naviGationController.rightBarButton addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.naviGationController.rightBarButton setExclusiveTouch:YES];

    
    [self showLoadingInView:self.view];
    // Do any additional setup after loading the view.
}

#pragma mark ----leftBarButtion Action
-(void)map
{
    Ty_MapHomeVC * mapHome = [[Ty_MapHomeVC alloc]init];
    mapHome.title = @"地图";
    mapHome._mapView = [[Ty_MapGlobalSingleton sharedInstance] mapView];
    mapHome.workGuid = findBusine.selectworkGuid;
    [self.naviGationController pushViewController:mapHome animated:YES];
    
}
#pragma mark ----rightButtonAction
-(void)rightButtonAction
{
    if (IFLOGINYES){
        [self.naviGationController pushViewController:[findBusine Click_pub_Requirements] animated:YES];
    }else{
        [self.naviGationController pushViewController:[findBusine Click_LoginVC] animated:YES];
    }
}
#pragma mark ----网络回执
-(void)netRequestReceived:(NSNotification *)_notification
{
    NSLog(@"qhfind");
    [self hideLoadingView];
    [self hideMessageView];
    if ([[[_notification object]objectForKey:@"code"] isEqualToString:@"200"]) {
        tableview.hidden = NO;
        [tableview reloadData];
        if (findBusine.currentPage == 1) {
            [tableview scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
        }
        switch ([[[_notification object]objectForKey:@"queryType"] intValue]) {
            case 1:
                [self showToastMakeToast:@"为您扩大范围到5000m" duration:1 position:@"bottom"];
                [areaButton setTitle:@"5000m" forState:0];
                [areaImage setFrame:CGRectMake(areaButton.titleLabel.frame.origin.x+areaButton.titleLabel.frame.size.width+5, 19, 12, 6)];
                findBusine.userAddress = [NSString stringWithFormat:@"%@  %@",USERPROVINCE,USERCITY];;
                
                findBusine.range = @"5000";
                break;
                
            case 2:
//                [self showProgressHUD:@"为您扩大范围到全部区域"];
                [self showToastMakeToast:@"为您扩大范围到全部区域" duration:1 position:@"bottom"];
                [areaButton setTitle:@"全部区域" forState:0];
                [areaImage setFrame:CGRectMake(areaButton.titleLabel.frame.origin.x+areaButton.titleLabel.frame.size.width+5, 19, 12, 6)];
                findBusine.userAddress = [NSString stringWithFormat:@"%@  %@",USERPROVINCE,USERCITY];;
                findBusine.range = @"";
            default:
                break;
        }
        findBusine.currentPage++;
        if (tableview.contentSize.height>tableview.frame.size.height) {
            if (_refreshLoadView  ==  nil)
            {
                _refreshLoadView = [[RefreshView alloc]initWithFrame:CGRectMake(10, 0, self.view.bounds.size.width - 20, 40.0)];
                _refreshLoadView._messageLabel.text = @"正在加载...";
                _refreshLoadView.backgroundColor = [UIColor clearColor];
            }
            tableview.tableFooterView = _refreshLoadView;
        }else{
            tableview.tableFooterView = nil;
            _refreshLoadView = nil;
        }
        findBusine._isRefreshing = NO;
    }else if([[[_notification object]objectForKey:@"code"] isEqualToString:@"203"]){
        tableview.hidden = NO;
        if (findBusine.currentPage == 1) {
            [self showMessageInView:tableview message:@"无查询结果"];
            tableview.tableFooterView = nil;
        }
        [tableview reloadData];
        if (tableview.contentSize.height>tableview.frame.size.height) {
            tableview.tableFooterView = _refreshLoadView;
        }
        findBusine._isRefreshing = YES;
        _refreshLoadView._messageLabel.text = @"已加载全部";
    }else if([[[_notification object]objectForKey:@"code"] isEqualToString:REQUESTFAIL]){
        [self showNetMessageInView:self.view];
        //        _refreshLoadView._messageLabel.text = @"加载失败！";
        findBusine._isRefreshing = NO;
    }else{
        [self showToastMakeToast:[[_notification object] objectForKey:@"code"] duration:1.0f position:@"bottom"];
        findBusine._isRefreshing = NO;
    }
    [_refreshLoadView._netMind stopAnimating];
}
#pragma mark ----上拉刷新
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"Ani -- %d",_refreshLoadView._netMind.isAnimating);
    NSLog(@"ref --%d",findBusine._isRefreshing);
    if (scrollView.contentOffset.y >=  scrollView.contentSize.height - scrollView.bounds.size.height  && _refreshLoadView !=  nil)
    {
        NSLog(@" -- 我是上拉刷新");
        if (!findBusine._isRefreshing )
        {
            [_refreshLoadView._netMind startAnimating];
            _refreshLoadView._messageLabel.text = @"正在加载...";
            findBusine._isRefreshing = YES;
            [findBusine loadDatatarget];
        }
    }
}
-(void)loading{
    [self showLoadingInView:self.view];
    [findBusine loadDatatarget];
}
#pragma 筛选条件事件
-(void)areaButtonclick:(UIButton*)sender
{
    
    if (findBusine.cityBool) {
        [cityPopView dismissKeyBoard];
    }else{
        [workPopView dismissKeyBoard];
        [sortPopView dismissKeyBoard];
        cityPopView = [Ty_CityPopView shareCityPopView:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height-44-49-64) States:USERPROVINCE City:USERCITY];
        cityPopView.delegate = self;
        [cityPopView setTag:0];
        [cityPopView showInView:self.view];
        findBusine.workBool = NO;
        findBusine.sortBool = NO;
    }
    findBusine.cityBool = !findBusine.cityBool;
    
}
-(void)workButtonClick:(UIButton*)sender
{
    
    if (findBusine.workBool) {
        [workPopView dismissKeyBoard];
    }else{
        [cityPopView dismissKeyBoard];
        [sortPopView dismissKeyBoard];
        [workPopView showInView:self.view];
        findBusine.cityBool = NO;
        findBusine.sortBool = NO;
    }
    findBusine.workBool = !findBusine.workBool;
}
-(void)sortButtonClick:(UIButton*)sender
{
    
    if (findBusine.sortBool) {
        [sortPopView dismissKeyBoard];
    }else{
        [cityPopView dismissKeyBoard];
        [workPopView dismissKeyBoard];
        [sortPopView showInView:self.view];
        findBusine.cityBool = NO;
        findBusine.workBool = NO;
    }
    findBusine.sortBool = !findBusine.sortBool;
    
}
#pragma mark ----选择区域代理
-(void)CityPopView:(Ty_CityPopView* )_CityPopView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self showLoadingInView:self.view];
    
    [findBusine cityProcess:_CityPopView.locate];
    
    if ([_CityPopView.locate.quyu isEqualToString:@"附近"]) {
        [areaButton setTitle:_CityPopView.locate.region forState:0];
        [areaImage setFrame:CGRectMake(areaButton.titleLabel.frame.origin.x+areaButton.titleLabel.frame.size.width+5, 19, 12, 6)];
    }else if ([_CityPopView.locate.quyu isEqualToString:@"全部区域"]) {
        [areaButton setTitle:_CityPopView.locate.quyu forState:0];
        [areaImage setFrame:CGRectMake(areaButton.titleLabel.frame.origin.x+areaButton.titleLabel.frame.size.width+5, 19, 12, 6)];
    }else{
        [areaButton setTitle:_CityPopView.locate.region forState:0];
        [areaImage setFrame:CGRectMake(areaButton.titleLabel.frame.origin.x+areaButton.titleLabel.frame.size.width+5, 19, 12, 6)];
        if ([_CityPopView.locate.region isEqualToString:@"全部区域"]) {
        }else{
        }
    }
}
#pragma mark ----Ty_popViewDelegate
-(void)PopView:(Ty_PopView *)_PopView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self showLoadingInView:self.view];
    if (_PopView.tag == 2) {
        [findBusine workProcess:_PopView.popData.data];
        self.title = [NSString stringWithFormat:@"找%@",findBusine.selectworkName];
        [workButton setTitle:_PopView.popData.data forState:0];
        [workImage setFrame:CGRectMake(workButton.titleLabel.frame.origin.x+workButton.titleLabel.frame.size.width+5, 19, 12, 6)];
    }else if(_PopView.tag == 3){
        [findBusine sortProcess:_PopView.popData.data];
        [sortButton setTitle:_PopView.popData.data forState:0];
        [sortImage setFrame:CGRectMake(sortButton.titleLabel.frame.origin.x+sortButton.titleLabel.frame.size.width+5, 19, 12, 6)];
    }
}
-(void)BtnClick:(UITapGestureRecognizer *)imageTap
{
    NSLog(@"imageTag == %d", imageTap.view.tag );
    
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:1];
    //    for (int i = 0; i < [photos count]; i++) {
    // 替换为中等尺寸图片
    
    NSString * getImageStrUrl = [NSString stringWithFormat:@"%@", [[findBusine.shopArray objectAtIndex:imageTap.view.tag-10000] headPhotoGaoQing]];
    MJPhoto *photo = [[MJPhoto alloc] init];
    photo.url = [NSURL URLWithString: getImageStrUrl ]; // 图片路径
    
    UIImageView * imageView = (UIImageView *)[self.view viewWithTag: imageTap.view.tag ];
    photo.srcImageView = imageView;
    [photos addObject:photo];
    //    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = 0; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
    photos = nil;
    getImageStrUrl = nil;
    photo = nil;
    imageView = nil;
    
}
-(void)BtnClick2:(UITapGestureRecognizer *)imageTap
{
    NSLog(@"imageTag == %d", imageTap.view.tag );
    
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:1];
    //    for (int i = 0; i < [photos count]; i++) {
    // 替换为中等尺寸图片
    
    NSString * getImageStrUrl = [NSString stringWithFormat:@"%@", [[findBusine.personalArray objectAtIndex:imageTap.view.tag-10000] headPhotoGaoQing]];
    MJPhoto *photo = [[MJPhoto alloc] init];
    photo.url = [NSURL URLWithString: getImageStrUrl ]; // 图片路径
    
    UIImageView * imageView = (UIImageView *)[self.view viewWithTag: imageTap.view.tag ];
    photo.srcImageView = imageView;
    [photos addObject:photo];
    //    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = 0; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
    photos = nil;
    getImageStrUrl = nil;
    photo = nil;
    imageView = nil;
}
#pragma mark ----tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
//            return 5;
            return findBusine.shopArray.count;
            break;
        case 1:
//            return 5;
            return findBusine.personalArray.count;
            break;
        default:
            return 0;
            break;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* Cellshop = @"Cellshop";
    static NSString* Cellpersonal = @"Cellpersonal";

    if (indexPath.section == 0){
        Ty_HomeFind_ShopCell* cellshop = [tableView dequeueReusableCellWithIdentifier:Cellshop];
        if (cellshop == nil) {
            cellshop = [[Ty_HomeFind_ShopCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:Cellshop];
        }
        cellshop.shopNameLabel.text = [NSString stringWithFormat:@"%@",[[findBusine.shopArray objectAtIndex:indexPath.row] respectiveCompanies]];
        [cellshop.typeLabel setText:@"商户"];
//        NSMutableString* arr = [[NSMutableString alloc]init];
//        for (int i = 0; i<[[[findBusine.shopArray objectAtIndex:indexPath.row] workTypeArray] count]; i++) {
//            [arr appendFormat:@"%@.",[[[[findBusine.shopArray objectAtIndex:indexPath.row] workTypeArray] objectAtIndex:i] workName]];
//        }
        [cellshop.serviceNumLabel setText:[NSString stringWithFormat:@"共%@次接活",[[findBusine.shopArray objectAtIndex:indexPath.row] serviceNumber]]];
        
//        if ([[[findBusine.shopArray objectAtIndex:indexPath.row] workTypeArray] count]>0) {
            if ([[[findBusine.shopArray objectAtIndex:indexPath.row] price] isEqualToString:@""]) {
                [cellshop.priceLabel initWithStratString:@"暂无报价" startColor:text_RedColor startFont:FONT14_BOLDSYSTEM centerString:nil centerColor:text_RedColor centerFont:FONT11_SYSTEM endString:nil endColor:text_RedColor endFont:FONT11_SYSTEM];
            }else{
                [cellshop.priceLabel initWithStratString:[NSString stringWithFormat:@"￥%@",[[findBusine.shopArray objectAtIndex:indexPath.row] price]] startColor:text_RedColor startFont:FONT14_BOLDSYSTEM centerString:@"/" centerColor:text_RedColor centerFont:FONT11_SYSTEM endString:[[[NSDictionary alloc]initWithContentsOfFile:WorkUnitTypefileForPath] objectForKey:findBusine.selectworkName] endColor:text_RedColor endFont:FONT11_SYSTEM];
            }
//        }
        [cellshop.priceLabel setVerticalAlignment:UIControlContentVerticalAlignmentBottom];
        [cellshop.priceLabel setTextAlignment:NSTextAlignmentRight];
        
        [cellshop.headImage setImageWithURL:[NSURL URLWithString:[[findBusine.shopArray objectAtIndex:indexPath.row] headPhoto]] placeholderImage:JWImageName(@"Contact_image2")];
        cellshop.headImage.userInteractionEnabled = YES;
        cellshop.headImage.contentMode = UIViewContentModeScaleAspectFill;
        cellshop.headImage.tag = 10000+indexPath.row;
        [cellshop.headImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(BtnClick:)] ];
        
        if ([findBusine.orderByTerm isEqualToString:@"3"]) {
            if (![[[findBusine.shopArray objectAtIndex:indexPath.row] distanceString] isEqualToString:@""]) {
                
                if ([[[findBusine.shopArray objectAtIndex:indexPath.row] distanceString] intValue] < 0) {
                    [cellshop.distanceLabel setText:@""];
                }else if ([[[findBusine.shopArray objectAtIndex:indexPath.row] distanceString] intValue] < 100 && [[[findBusine.shopArray objectAtIndex:indexPath.row] distanceString] intValue] >= 0) {
                    [cellshop.distanceLabel setText:@"<100m"];
                }else if ([[[findBusine.shopArray objectAtIndex:indexPath.row] distanceString] intValue] >1000) {
                    [cellshop.distanceLabel setText:[NSString stringWithFormat:@"%0.2fkm",[[[findBusine.shopArray objectAtIndex:indexPath.row] distanceString] floatValue]/1000]];
                }else {
                    [cellshop.distanceLabel setText:[NSString stringWithFormat:@"%@m",[[findBusine.shopArray objectAtIndex:indexPath.row] distanceString]]];
                }
            }else{
                [cellshop.distanceLabel setText:@""];
            }
        }else{
            [cellshop.distanceLabel setText:@""];
        }
        [cellshop.customStar setCustomStarNumber:[[[findBusine.shopArray objectAtIndex:indexPath.row] evaluate] floatValue]];
        cellshop.areaLabel.text = [[findBusine.shopArray objectAtIndex:indexPath.row] intermediary_Region];
        [cellshop setLoadView];
        return cellshop;
    }else{
        Ty_HomeFind_PersonalCell* cellpersonal = [tableView dequeueReusableCellWithIdentifier:Cellpersonal];
        if (cellpersonal == nil) {
            cellpersonal = [[Ty_HomeFind_PersonalCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:Cellpersonal];
        }
        if ([[[findBusine.personalArray objectAtIndex:indexPath.row]userType] isEqualToString:@"1"]) {
            cellpersonal.personalNameLabel.text = [NSString stringWithFormat:@"%@",[[findBusine.personalArray objectAtIndex:indexPath.row] userRealName]];
            [cellpersonal.typeLabel setText:[NSString stringWithFormat:@"%@",[[findBusine.personalArray objectAtIndex:indexPath.row] respectiveCompanies]]];
            if ([[[findBusine.personalArray objectAtIndex:indexPath.row] workTypeArray] count]>0) {
                cellpersonal.serviceNumLabel.text = [NSString stringWithFormat:@"共%@次接活",[[findBusine.personalArray objectAtIndex:indexPath.row] serviceNumber]];
            }else{
                cellpersonal.serviceNumLabel.text = [NSString stringWithFormat:@"共%@次接活",[[findBusine.personalArray objectAtIndex:indexPath.row] serviceNumber]];
            }
            
//            if ([[[findBusine.personalArray objectAtIndex:indexPath.row] workTypeArray] count]>0) {
                if ([[[findBusine.personalArray objectAtIndex:indexPath.row] price] isEqualToString:@""]) {
                    [cellpersonal.customLable initWithStratString:@"暂无报价" startColor:text_RedColor startFont:FONT14_BOLDSYSTEM centerString:nil centerColor:text_RedColor centerFont:FONT11_SYSTEM endString:nil endColor:text_RedColor endFont:FONT11_SYSTEM];
                }else{
                    [cellpersonal.customLable initWithStratString:[NSString stringWithFormat:@"￥%@",[[findBusine.personalArray objectAtIndex:indexPath.row] price]] startColor:text_RedColor startFont:FONT14_BOLDSYSTEM centerString:@"/" centerColor:text_RedColor centerFont:FONT11_SYSTEM endString:[[[NSDictionary alloc]initWithContentsOfFile:WorkUnitTypefileForPath] objectForKey:findBusine.selectworkName] endColor:text_RedColor endFont:FONT11_SYSTEM];
                }
                
//            }
            [cellpersonal.customLable setVerticalAlignment:UIControlContentVerticalAlignmentBottom];
            [cellpersonal.customLable setTextAlignment:NSTextAlignmentRight];
            if ([[[findBusine.personalArray objectAtIndex:indexPath.row] sex]isEqualToString:@"0"]) {
                [cellpersonal.headImage setImageWithURL:[NSURL URLWithString:[[findBusine.personalArray objectAtIndex:indexPath.row] headPhoto]] placeholderImage:JWImageName(@"Contact_image1")];
            }else{
                [cellpersonal.headImage setImageWithURL:[NSURL URLWithString:[[findBusine.personalArray objectAtIndex:indexPath.row] headPhoto]] placeholderImage:JWImageName(@"Contact_image")];
            }
            cellpersonal.headImage.userInteractionEnabled = YES;
            cellpersonal.headImage.contentMode = UIViewContentModeScaleAspectFill;
            cellpersonal.headImage.tag = 10000+indexPath.row;
            [cellpersonal.headImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(BtnClick2:)] ];
        }else{
            //个人接活
            cellpersonal.personalNameLabel.text = [NSString stringWithFormat:@"%@",[[findBusine.personalArray objectAtIndex:indexPath.row] userRealName]];
            [cellpersonal.typeLabel setText:@"个人"];
            if ([[[findBusine.personalArray objectAtIndex:indexPath.row] workTypeArray] count]>0) {
                cellpersonal.serviceNumLabel.text = [NSString stringWithFormat:@"共%@次接活",[[findBusine.personalArray objectAtIndex:indexPath.row] serviceNumber]];
            }else{
                cellpersonal.serviceNumLabel.text = [NSString stringWithFormat:@"共%@次接活",[[findBusine.personalArray objectAtIndex:indexPath.row] serviceNumber]];
            }
//            if ([[[findBusine.personalArray objectAtIndex:indexPath.row] workTypeArray] count]>0) {
                if ([[[findBusine.personalArray objectAtIndex:indexPath.row] price] isEqualToString:@""]) {
                    [cellpersonal.customLable initWithStratString:@"暂无报价" startColor:text_RedColor startFont:FONT14_BOLDSYSTEM centerString:nil centerColor:text_RedColor centerFont:FONT11_SYSTEM endString:nil endColor:text_RedColor endFont:FONT11_SYSTEM];
                }else{
                    [cellpersonal.customLable initWithStratString:[NSString stringWithFormat:@"￥%@",[[findBusine.personalArray objectAtIndex:indexPath.row] price]] startColor:text_RedColor startFont:FONT14_BOLDSYSTEM centerString:@"/" centerColor:text_RedColor centerFont:FONT11_SYSTEM endString:[[[NSDictionary alloc]initWithContentsOfFile:WorkUnitTypefileForPath] objectForKey:findBusine.selectworkName] endColor:text_RedColor endFont:FONT11_SYSTEM];
                }
//            }
            [cellpersonal.customLable setVerticalAlignment:UIControlContentVerticalAlignmentBottom];
            [cellpersonal.customLable setTextAlignment:NSTextAlignmentRight];
            if ([[[findBusine.personalArray objectAtIndex:indexPath.row] sex]isEqualToString:@"0"]) {
                [cellpersonal.headImage setImageWithURL:[NSURL URLWithString:[[findBusine.personalArray objectAtIndex:indexPath.row] headPhoto]] placeholderImage:JWImageName(@"Contact_image1")];
            }else{
                [cellpersonal.headImage setImageWithURL:[NSURL URLWithString:[[findBusine.personalArray objectAtIndex:indexPath.row] headPhoto]] placeholderImage:JWImageName(@"Contact_image")];
            }
            cellpersonal.headImage.userInteractionEnabled = YES;
            cellpersonal.headImage.contentMode = UIViewContentModeScaleAspectFill;
            cellpersonal.headImage.tag = 10000+indexPath.row;
            [cellpersonal.headImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(BtnClick2:)] ];
        }
        [cellpersonal.customStar setCustomStarNumber:[[[findBusine.personalArray objectAtIndex:indexPath.row] evaluate] floatValue]];
        [cellpersonal setLoadView];
        return cellpersonal;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }else{
        if (findBusine.personalArray.count>0) {
            return 25;
        }else{
            return 0;
        }
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        if (findBusine.personalArray.count>0) {
            UIView* headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 25)];
            [headView setBackgroundColor:[UIColor colorWithRed:250.0/255.0 green:220.0/255.0 blue:218.0/255.0 alpha:1.0]];
            UILabel * headLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 300, 25)];
            [headLabel setBackgroundColor:[UIColor clearColor]];
            [headLabel setText:@"推荐阿姨"];
            [headLabel setTextColor:[UIColor redColor]];
            [headLabel setFont:FONT15_BOLDSYSTEM];
            [headView addSubview:headLabel];
            headLabel = nil;
            return headView;
        }else{
            UIView* headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 0)];
            [headView setBackgroundColor:[UIColor colorWithRed:250.0/255.0 green:220.0/255.0 blue:218.0/255.0 alpha:1.0]];
            UILabel * headLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 300, 0)];
            [headLabel setBackgroundColor:[UIColor clearColor]];
            [headLabel setText:@"推荐阿姨"];
            [headLabel setTextColor:[UIColor redColor]];
            [headLabel setFont:FONT15_BOLDSYSTEM];
            [headView addSubview:headLabel];
            headLabel = nil;
            return headView;
        }
        
    }else{
        return [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.naviGationController pushViewController:[findBusine didSelectIndexPath:indexPath] animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark ----- Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
