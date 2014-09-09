//
//  Ty_HomeVC.m
//  腾云家务
//
//  Created by 齐 浩 on 14-5-22.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_HomeVC.h"
#import "Ty_HuodongVC.h"
#import "CeshiViewController.h"
#import "CycleScrollView.h"
#import "Ty_HomeButtonCell.h"
#import "Ty_HomeBusine.h"
#import "Home_Button.h"
#import "Ty_HomeMainObject.h"
#import "Ty_HomeWorkTypeViewCell.h"
#import "Ty_News_busine_Order_DataBase.h"
#import "Ty_Pub_RequirementsVC.h"
#import "Ty_HomeFindVC.h"
#import "Ty_HomeWorkTypeButton.h"
#import "Ty_Home_SelectCityVC.h"
#import "Ty_HomeWorkButtonCell.h"
#import "My_LoginViewController.h"

#import "Ty_HomeBannerObject.h"
#import "Ty_WebViewVC.h"

#import "iflyMSC/IFlyRecognizerViewDelegate.h"
#import "iflyMSC/IFlyRecognizerView.h"
#import "iflyMSC/IFlySpeechConstant.h"
#import "Ty_MapHomeVC.h"
#import "Ty_MapGlobalSingleton.h"


@interface Ty_HomeVC ()<UITableViewDataSource,UITableViewDelegate,HomeWorkTypeViewDelegate,Ty_Home_SelectCityVCDelegate,Ty_HomeWorkButtonCellDelegate,IFlyRecognizerViewDelegate>
{
    Ty_HomeBusine *homeBusine;//业务层方法
    
    UIButton* cityButton;
    UIImageView* cityImage;
    UILabel* woyaozhaoLabel;
    Ty_Home_SelectCityVC* selectCity;
    UITableView* tableview;
    UITableView* tableviewSecond;
    UIScrollView* mainScrollView;
    UIPageControl* mainPageControl;
    
    UILabel* remenFuWuLabel;//热门服务推荐
    UILabel* quanbuFuWuLabel;//全部服务
    
    UIImageView* remenImage;//热门image
    UIImageView* quanbuImage;//全部image
    
    UIView* searchview;
    UIImageView *searchIcon;
    UIImageView *searchImage1;
    UIButton* searchButton;
    UIButton *beginButton;
    
    IFlyRecognizerView *_iFlyRecognizerView;
    NSString *_grammarID;
    
    UIView * tabView;
    UIView* searchView;
    CycleScrollView* bannerScorllView;//banner
    
    UIWebView* phoneCallWebView;//电话
}

@end

@implementation Ty_HomeVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        if (USERPROVINCE == nil||[USERPROVINCE isEqualToString:@""]) {
            NSLog(@"首次设置城市");
            SETUSERPROVINCE(@"直辖市");
            SETUSERCITY(@"北京");
        }
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
    if (homeBusine.requestBool) {
        [homeBusine queryWorkTree];//调用获取整个工种树，相继存入plist 以便使用
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self showLoadingInView:self.view];
    homeBusine = [[Ty_HomeBusine alloc]init];//实例化业务处理
    homeBusine.delegate = self;
    _iFlyRecognizerView = [[IFlyRecognizerView alloc] initWithCenter:self.view.center];//讯飞语音的一些设置
    [_iFlyRecognizerView setParameter:_grammarID forKey:[IFlySpeechConstant CLOUD_GRAMMAR]];
    [_iFlyRecognizerView setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
    [_iFlyRecognizerView setParameter:@"16000" forKey:[IFlySpeechConstant SAMPLE_RATE]];
    [_iFlyRecognizerView setParameter:@"1800" forKey:[IFlySpeechConstant VAD_EOS]];
    [_iFlyRecognizerView setParameter:@"6000" forKey:[IFlySpeechConstant VAD_BOS]];
    [_iFlyRecognizerView setParameter:@"0" forKey:[IFlySpeechConstant ASR_PTT]];
    
    _iFlyRecognizerView.delegate = self;
    
    //设置title
    UIImageView * titleImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 77, 40)];
    [titleImage setImage:JWImageName(@"Home_titleImage")];
    self.naviGationController.titleView = titleImage;
    titleImage = nil;
    
    //实例化页面左右滑动的scrollview
    mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 146, self.view.frame.size.width, self.view.frame.size.height-49-44-20-44-102-30)];
    mainScrollView.contentMode = UIViewContentModeCenter;
    mainScrollView.contentSize = CGSizeMake(2 * CGRectGetWidth(mainScrollView.frame), CGRectGetHeight(mainScrollView.frame));
    mainScrollView.delegate = self;
    mainScrollView.pagingEnabled = YES;
    mainScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:mainScrollView];
    
    remenFuWuLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, mainScrollView.frame.origin.y+mainScrollView.frame.size.height, 145 , 30)];
    [remenFuWuLabel setText:@"热门服务推荐"];
    [remenFuWuLabel setFont:FONT14_BOLDSYSTEM];
    [remenFuWuLabel setTextColor:text_RedColor];
    [remenFuWuLabel setTextAlignment:NSTextAlignmentRight];
    [remenFuWuLabel setBackgroundColor:[UIColor clearColor]];
    
    quanbuFuWuLabel = [[UILabel alloc]initWithFrame:CGRectMake(175, mainScrollView.frame.origin.y+mainScrollView.frame.size.height, 145 , 30)];
    [quanbuFuWuLabel setText:@"全部服务类别"];
    [quanbuFuWuLabel setFont:FONT14_BOLDSYSTEM];
    [quanbuFuWuLabel setTextColor:text_grayColor];
    [quanbuFuWuLabel setTextAlignment:NSTextAlignmentLeft];
    [quanbuFuWuLabel setBackgroundColor:[UIColor clearColor]];
    
    remenImage = [[UIImageView alloc]initWithFrame:CGRectMake(148, remenFuWuLabel.frame.origin.y+10, 10, 10)];
    [remenImage setImage:JWImageName(@"红")];
    
    quanbuImage = [[UIImageView alloc]initWithFrame:CGRectMake(162, quanbuFuWuLabel.frame.origin.y+10, 10, 10)];
    [quanbuImage setImage:JWImageName(@"灰")];
    
    //初始化全部服务tableview
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(mainScrollView.frame.size.width, 0, mainScrollView.frame.size.width, mainScrollView.frame.size.height) style:UITableViewStylePlain];
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.showsVerticalScrollIndicator = NO;
    tableview.dataSource = self;
    tableview.delegate = self;
    [tableview setBackgroundColor:view_BackGroudColor];
    
    //初始化热门服务tableview
    tableviewSecond = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, mainScrollView.frame.size.width, mainScrollView.frame.size.height) style:UITableViewStylePlain];
    tableviewSecond.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableviewSecond.showsVerticalScrollIndicator = NO;
    tableviewSecond.dataSource = self;
    tableviewSecond.delegate = self;
    [tableviewSecond setBackgroundColor:view_BackGroudColor];
    
//    tableview.tableHeaderView = tabView;
    
    //初始化导航左侧按钮
    [self.naviGationController.leftBarButton setImageEdgeInsets:UIEdgeInsetsMake(5, 10, 0, 45)];
    //self.naviGationController.userInteractionEnabled = YES;
    [self.naviGationController.leftBarButton setImage:JWImageName(@"Home_map_1") forState:UIControlStateNormal];
    [self.naviGationController.leftBarButton addTarget:self action:@selector(map) forControlEvents:UIControlEventTouchUpInside];
    self.naviGationController.leftBarButton.showsTouchWhenHighlighted = YES;
    
    //初始化导航右侧按钮
    [self.naviGationController.rightBarButton setTitle:@"发抢单" forState:UIControlStateNormal];
    [self.naviGationController.rightBarButton.titleLabel setFont:FONT15_BOLDSYSTEM];
    [self.naviGationController.rightBarButton setExclusiveTouch:YES];
    [self.naviGationController.rightBarButton addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.naviGationController.rightBarButton setExclusiveTouch:YES];
    
#pragma mark ----banner 时间调整 待调整中。。。。
    //初始化banner
    bannerScorllView = [[CycleScrollView alloc] initWithFrame:CGRectMake(6, 2, 308, 97) animationDuration:5];
    bannerScorllView.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:0.1];
    
    
    
    //设置tabheadView
    tabView = [[UIView alloc]initWithFrame:CGRectMake(0, 44, 320, 101)];
    [tabView setBackgroundColor:view_BackGroudColor];
    [tabView addSubview:bannerScorllView];
    
    
    searchView = [[UIView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, 44)];
    UILabel* woLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, 14, 44)];
    [woLabel setText:@"在"];
    [woLabel setFont:FONT14_SYSTEM];
    [woLabel setTextColor:[UIColor grayColor]];
    [woLabel setBackgroundColor:[UIColor clearColor]];
    [searchView addSubview:woLabel];
    
    cityButton = [UIButton buttonWithType:UIButtonTypeCustom];
    NSLog(@"cityButtonMain=%@",cityButton);
    NSLog(@"~~~~~~~~~~~~~~~~~~~~~~~");
    [cityButton setFrame:CGRectMake(19, 0, 74, 44)];
    [cityButton setTitle:USERCITY forState:UIControlStateNormal];
    [cityButton.titleLabel setFont:FONT14_BOLDSYSTEM];
    [cityButton setTitleColor:text_RedColor forState:UIControlStateNormal];
    [cityButton addTarget:self action:@selector(selectCity) forControlEvents:UIControlEventTouchUpInside];
    [searchView addSubview:cityButton];
    
    cityImage = [[UIImageView alloc]initWithFrame:CGRectMake(cityButton.titleLabel.frame.size.width+cityButton.titleLabel.frame.origin.x+5, 18, 6, 6)];
    [cityImage setImage:JWImageName(@"DownSanjiao")];
    [cityButton addSubview:cityImage];
    
    CGSize citySize = [cityButton.titleLabel.text sizeWithFont:FONT14_BOLDSYSTEM constrainedToSize:CGSizeMake(200, cityButton.frame.size.height) lineBreakMode:NSLineBreakByCharWrapping];
    
    
    [cityButton setFrame:CGRectMake(19, 0, citySize.width+40, 44)];
    [cityButton setTitleEdgeInsets:UIEdgeInsetsMake(2, 2, 0, cityButton.frame.size.width-citySize.width-2)];
    [cityImage setFrame:CGRectMake(cityButton.titleLabel.frame.size.width+cityButton.titleLabel.frame.origin.x+5, 18, 6, 6)];
    
    
    woyaozhaoLabel = [[UILabel alloc]initWithFrame:CGRectMake(cityImage.frame.origin.x+cityImage.frame.size.width+5, 0, 20, 44)];
    [woyaozhaoLabel setText:@"找:"];
    [woyaozhaoLabel setFont:FONT14_SYSTEM];
    [woyaozhaoLabel setTextColor:[UIColor grayColor]];
    [woyaozhaoLabel setBackgroundColor:[UIColor clearColor]];
    
    [cityButton addSubview:woyaozhaoLabel];
    
    searchview = [[UIView alloc]initWithFrame:CGRectMake(cityButton.frame.origin.x+cityButton.frame.size.width, 0, searchView.frame.size.width-cityButton.frame.origin.x-cityButton.frame.size.width-5, searchView.frame.size.height)];
    [searchview setBackgroundColor:view_BackGroudColor];
    
    searchIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_searchBarIconImage"]];
    searchIcon.frame = CGRectMake(5, (searchview.frame.size.height-15)/2, 15, 15);
    
    searchImage1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 6, searchview.frame.size.width, 31)];
    [searchImage1 setImage:[JWImageName(@"home_searchbarBackImage") stretchableImageWithLeftCapWidth:20 topCapHeight:15]];
    
    searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchButton setFrame:CGRectMake(26, 0, searchview.frame.size.width-26-30, searchview.frame.size.height)];
    [searchButton setTitle:@"输入关键词，如保姆" forState:UIControlStateNormal];
    [searchButton.titleLabel setFont:FONT11_SYSTEM];
    [searchButton addTarget:self action:@selector(searchClick:) forControlEvents:UIControlEventTouchUpInside];
    [searchButton setTitleEdgeInsets:UIEdgeInsetsMake(2, 2, 0, searchButton.frame.size.width-103)];
    
    [searchButton setExclusiveTouch:YES];
    [searchButton setTitleColor:text_grayColor forState:UIControlStateNormal];
    
    
    //语音按钮
    beginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    beginButton.frame = CGRectMake(searchview.frame.size.width-30, 7, 30, 30);
    //    [beginButton setTitle:@"开始识别" forState:UIControlStateNormal];
    [beginButton setImage:JWImageName(@"home_voice") forState:UIControlStateNormal];
    [beginButton addTarget:self action:@selector(onBegin:) forControlEvents:UIControlEventTouchUpInside];
    [beginButton setExclusiveTouch:YES];
    
    
    [searchview addSubview:searchImage1];
    [searchview addSubview:searchButton];
    [searchview addSubview:searchIcon];
    [searchview addSubview:beginButton];
    
    [searchView addSubview:searchview];
    
    searchView.hidden = YES;
    tabView.hidden = YES;
    [self.view addSubview:searchView];
    
    
    [self.view addSubview:tabView];
    
    
    selectCity = [[Ty_Home_SelectCityVC alloc]init];
    selectCity.delegate = self;
    
	// Do any additional setup after loading the view.
}
#pragma mark ----加载banner 以及搜索控件等
-(void)loadBannerUI
{
    //给banner设置图片
    searchView.hidden = NO;
    tabView.hidden = NO;
    
    NSMutableArray *viewsArray = [@[] mutableCopy];
    
    for (int i = 0; i<homeBusine.bannerArr.count; i++) {
        UIImageView* image = [[UIImageView alloc]init];
        [image setFrame:CGRectMake(i*308, 0, 308,97)];
        [image setImageWithURL:[NSURL URLWithString:[homeBusine.bannerArr[i] photoUrl]] placeholderImage:JWImageName([homeBusine.bannerArr[i] photoUrl])];
        [viewsArray addObject:image];
        image = nil;
    }
    
    UIImageView* image = [[UIImageView alloc]init];
    [image setFrame:CGRectMake(viewsArray.count*308, 0, 308,97)];
    [image setImage:JWImageName(@"客服")];
    [viewsArray addObject:image];
    image = nil;
    
    NSLog(@"%@/////%@",viewsArray,homeBusine.bannerArr);
    
    
    bannerScorllView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
        return viewsArray[pageIndex];
    };
    
    bannerScorllView.totalPagesCount = ^NSInteger(void){
        return viewsArray.count;
    };
    
    //banner的点击方法
    bannerScorllView.TapActionBlock = ^(NSInteger pageIndex){
        NSLog(@"点击了第%d个",pageIndex);
        if (pageIndex == homeBusine.bannerArr.count) {
            NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:400-0049121"]];
            if ( !phoneCallWebView ) {
                phoneCallWebView = [[UIWebView alloc] initWithFrame:CGRectZero];
            }
            [phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];

        }else{
//            if ([homeBusine.bannerArr[pageIndex] selectUrl] == nil||[[homeBusine.bannerArr[pageIndex] selectUrl] isEqualToString:@""]) {
//                
//            }else{
                if (IFLOGINYES) {
                    
                    Ty_HuodongVC * huodong = [[Ty_HuodongVC alloc] init];
                    [self.naviGationController pushViewController:huodong animated:YES];

                    
                }else{
                    
                    My_LoginViewController* loginVC = [[My_LoginViewController alloc] init];
                    [self.naviGationController pushViewController:loginVC animated:YES];
                    
                }
//            }
            
        }
        
    };
    
}
#pragma mark ----语音

- (void) onBegin:(id) sender
{
    [_iFlyRecognizerView start];
}
- (void) setGrammar:(NSString *)grammar
{
    _grammarID = grammar;
}

//语音识别结束成功
- (void)onResult:(NSArray *)resultArray isLast:(BOOL) isLast;
{
    if (!isLast) {
        NSMutableString *result = [[NSMutableString alloc] init];
        NSMutableString *resultString = [[NSMutableString alloc]init];
        NSDictionary *dic = resultArray [0];
        for (NSString* key in dic ){
            [result setString:key];
        }
        
        NSData *responseData = [result dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary* keyDic = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
        NSArray* wsArray = [[NSArray alloc]initWithArray:[keyDic objectForKey:@"ws"]];
        for (int i = 0; i<wsArray.count; i++) {
            NSDictionary* wsDic = [wsArray objectAtIndex:i];
            NSArray* cwArray = [[NSArray alloc]initWithArray:[wsDic objectForKey:@"cw"]];
            if (cwArray.count>0) {
                [resultString appendString:[NSString stringWithFormat:@"%@",[[cwArray objectAtIndex:0] objectForKey:@"w"]]];
            }
            wsDic = nil;
            cwArray = nil;
        }
        
        keyDic = nil;
        dic = nil;
        wsArray = nil;
        
        NSLog(@"识别结果：%@",[NSString stringWithFormat:@"%@",resultString]);
        
        [self.naviGationController pushViewController:[homeBusine searchClick:resultString] animated:YES];
        [_iFlyRecognizerView removeFromSuperview];
    }
    
}
//语音识别结束失败
- (void) onError:(IFlySpeechError *) error
{
    NSString *text ;
    if (error.errorCode  == 0 ) {
        
    }
    else
    {
        text = [NSString stringWithFormat:@"发生错误：%d %@",error.errorCode,error.errorDesc];
        NSLog(@"%@",text);
    }
}


#pragma mark ----搜索
-(void)searchClick:(id)sender
{
    [self.naviGationController pushViewController:[homeBusine searchClick:sender] animated:YES]; //serchClick 是点击搜索返回搜索VC
}
#pragma mark ----选择城市
-(void)selectCity
{
//    [self.leveyTabBarController hidesTabBar:YES animated:NO];
    //    [cityImage setImage:JWImageName(@"UpSanjiao")];
    
    UIImage* title_bg = [[UIImage alloc]init];
    if (IOS7) {
        title_bg = JWImageName(@"titleBar");
    }else{
        title_bg = JWImageName(@"titleBar1");
    }
    //给选择城市页加如导航
    UINavigationController* selectCityNavigation  = [[UINavigationController alloc]initWithRootViewController:selectCity];
    selectCityNavigation.navigationBar.translucent = NO;
    [selectCityNavigation.navigationItem setHidesBackButton:YES];
    UIColor * cc = [UIColor whiteColor];
    NSDictionary * dict = [NSDictionary dictionaryWithObject:cc forKey:UITextAttributeTextColor];
    selectCityNavigation.navigationBar.titleTextAttributes = dict;
    [selectCityNavigation.navigationBar setBackgroundImage:title_bg forBarMetrics:UIBarMetricsDefault];
    
    [self presentViewController:selectCityNavigation animated:YES completion:nil];
    
    //    TSLocateView* locateview = [[TSLocateView alloc]initWithTitle:@"选择城市" delegate:self];
    //    locateview.type = 0;
    //    locateview.number = 2;
    //    [locateview showInView:self.view];
}

#pragma mark -----选择城市代理方法执行
-(void)Home_SelectCity:(TSLocation *)_home_selectData
{
    NSLog(@"homeCity==%@,%@",_home_selectData.state,_home_selectData.city);
    NSLog(@"userCity==%@",USERCITY);
    if (![_home_selectData.city isEqualToString:USERCITY]) {
        SETUSERAREA(@"");
        SETUSERREGION(@"");
        SETUSERADDRESSDETAIL(@"");
        NSLog(@"执行了");
        
        SETUSERPROVINCE(_home_selectData.state);
        SETUSERCITY(_home_selectData.city);
        
        [homeBusine getNetHomeButton]; //调用方法。请求网络获取数据
        NSLog(@"USERCITY==%@",USERCITY);
        
        [cityButton setTitle:USERCITY forState:UIControlStateNormal];
        NSLog(@"cityButton=%@",cityButton);
        
        CGSize citySize = [cityButton.titleLabel.text sizeWithFont:FONT14_BOLDSYSTEM
                                                 constrainedToSize:CGSizeMake(200, cityButton.frame.size.height)
                                                     lineBreakMode:NSLineBreakByCharWrapping];
        
        [cityButton setFrame:CGRectMake(19, 0, citySize.width+40, 44)];
        [cityButton setTitleEdgeInsets:UIEdgeInsetsMake(2, 2, 0, cityButton.frame.size.width-citySize.width-2)];
        [cityImage setFrame:CGRectMake(cityButton.titleLabel.frame.size.width+cityButton.titleLabel.frame.origin.x+5,18, 6, 6)];
        [cityImage setImage:JWImageName(@"DownSanjiao")];
        [woyaozhaoLabel setFrame:CGRectMake(cityImage.frame.origin.x+cityImage.frame.size.width+5, 0, 20, 44)];
        [searchview setFrame:CGRectMake(cityButton.frame.origin.x+cityButton.frame.size.width, 0,
                                        self.view.frame.size.width-cityButton.frame.origin.x-cityButton.frame.size.width-5, 44)];
        searchIcon.frame = CGRectMake(5, (searchview.frame.size.height-15)/2, 15, 15);
        [searchImage1 setFrame:CGRectMake(0, 6, searchview.frame.size.width, 31)];
        [searchButton setFrame:CGRectMake(26, 0, searchview.frame.size.width-26-30, searchview.frame.size.height)];
        [searchButton setTitleEdgeInsets:UIEdgeInsetsMake(2, 2, 0, searchButton.frame.size.width-103)];
        beginButton.frame = CGRectMake(searchview.frame.size.width-30, 7, 30, 30);
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"CityChanged" object:nil];
    }
    
}
#pragma mark ----leftBarButtion Action
-(void)map
{
    Ty_MapHomeVC * mapHome = [[Ty_MapHomeVC alloc]init];
    mapHome.title = @"地图";
    mapHome._mapView = [[Ty_MapGlobalSingleton sharedInstance] mapView];
    [self.naviGationController pushViewController:mapHome animated:YES];
}

#pragma mark ----发布需求 Action
-(void)rightButtonAction{
    if (IFLOGINYES) {
        [self.naviGationController pushViewController:[homeBusine Click_pub_Requirements] animated:YES]; //Click_pub_Requirements 方法是返回发布抢单VC
    }else{
        [self.naviGationController pushViewController:[homeBusine Click_LoginVC] animated:YES];//进入登录页
    }
}
#pragma mark ----UITableViewDataSource & UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableviewSecond == tableView) {
        return 100;
    }else{
        switch ([homeBusine.NumArray[indexPath.row] intValue]) {
            case 0:
                return [self tableView:tableView cellForRowAtIndexPath:indexPath].frame.size.height;
                //            return 73;
                break;
            default:
                return 73;
                break;
        }
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableviewSecond == tableView) {
        return homeBusine.MainArr.count;
    }else{
        return homeBusine.NumArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == tableview) {
        NSString* Cell = [NSString stringWithFormat:@"%dCell1",indexPath.row];
        static NSString* Cell2 = @"Cell2";
        if (![homeBusine.NumArray[indexPath.row]isEqualToString:@"0"]) {
            Ty_HomeButtonCell* cell = [tableView dequeueReusableCellWithIdentifier:Cell];
            if (cell == nil) {
                NSLog(@"Cellhome=%@",Cell);
                cell = [[Ty_HomeButtonCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cell];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            NSArray* arr = [homeBusine.MainArray objectAtIndex:indexPath.row];
            for (int i = 0; i<[arr count]; i++) {
                if ([arr count]<2) {
                    cell.rightpartButton.hidden = YES;
                }else{
                    cell.rightpartButton.hidden = NO;
                }
                NSDictionary* dic = [arr objectAtIndex:i];
                switch (i) {
                    case 0:
                        [cell.leftpartButton.workTypeImage setImageWithURL:[dic objectForKey:@"workPhoto"] placeholderImage:JWImageName([dic objectForKey:@"workName"])];
                        cell.leftpartButton.workTypeLabel.text = [dic objectForKey:@"workName"];
                        cell.leftpartButton.guid = [dic objectForKey:@"workGuid"];
                        if (cell.leftpartButton.change) {
                            cell.leftpartButton.jiantouImage.hidden = NO;
                        }else{
                            cell.leftpartButton.jiantouImage.hidden = YES;
                        }
                        if ([homeBusine.HomeButtonArray count]>0) {
                            cell.leftpartButton.workTypeLabel.text = [[homeBusine.HomeButtonArray objectAtIndex:(2*([[homeBusine.NumArray objectAtIndex:indexPath.row] intValue]-1)+i)] workName];
                            cell.leftpartButton.countString = [[homeBusine.HomeButtonArray objectAtIndex:(2*([[homeBusine.NumArray objectAtIndex:indexPath.row] intValue]-1)+i)] postCount];
                            [cell.leftpartButton.ShopLabel initWithStratString:[[homeBusine.HomeButtonArray objectAtIndex:(2*([[homeBusine.NumArray objectAtIndex:indexPath.row] intValue]-1)+i)] postCount] startColor:text_RedColor startFont:FONT12_SYSTEM centerString:[NSString stringWithFormat:@"位%@",[[homeBusine.HomeButtonArray objectAtIndex:(2*([[homeBusine.NumArray objectAtIndex:indexPath.row] intValue]-1)+i)] workName]] centerColor:text_grayColor centerFont:FONT12_SYSTEM endString:@"" endColor:nil endFont:nil];
                            
                            cell.leftpartButton.guid = [[homeBusine.HomeButtonArray objectAtIndex:(2*([[homeBusine.NumArray objectAtIndex:indexPath.row] intValue]-1)+i)] workGuid];
                        }
                        
                        [cell.leftpartButton.workTypeLabel setTextColor:[UIColor blackColor]];
                        [cell.leftpartButton setTag:(2*([[homeBusine.NumArray objectAtIndex:indexPath.row] intValue]-1)+i+1)*100];
                        
                        [cell.leftpartButton addTarget:self action:@selector(HomeButtonActionTouchUp:) forControlEvents:UIControlEventTouchUpInside];
                        [cell.leftpartButton addTarget:self action:@selector(HomeButtonActionTouchCancel:) forControlEvents:UIControlEventTouchDragExit];
                        [cell.leftpartButton addTarget:self action:@selector(HomeButtonActionTouchDown:) forControlEvents:UIControlEventTouchDown];
                        [cell.leftpartButton addTarget:self action:@selector(HomeButtonActionTouchCancel:) forControlEvents:UIControlEventTouchDragOutside];
                        [cell.leftpartButton addTarget:self action:@selector(HomeButtonActionTouchCancel:) forControlEvents:UIControlEventTouchCancel];
                        break;
                    case 1:
                        [cell.rightpartButton.workTypeImage setImageWithURL:[dic objectForKey:@"workPhoto"] placeholderImage:JWImageName([dic objectForKey:@"workName"])];
                        cell.rightpartButton.workTypeLabel.text = [dic objectForKey:@"workName"];
                        cell.rightpartButton.guid = [dic objectForKey:@"workGuid"];
                        if (cell.rightpartButton.change) {
                            cell.rightpartButton.jiantouImage.hidden = NO;
                        }else{
                            cell.rightpartButton.jiantouImage.hidden = YES;
                        }
                        if ([homeBusine.HomeButtonArray count]>0) {
                            cell.rightpartButton.workTypeLabel.text = [[homeBusine.HomeButtonArray objectAtIndex:(2*([[homeBusine.NumArray objectAtIndex:indexPath.row] intValue]-1)+i)] workName];
                            cell.rightpartButton.countString = [[homeBusine.HomeButtonArray objectAtIndex:(2*([[homeBusine.NumArray objectAtIndex:indexPath.row] intValue]-1)+i)] postCount];
                            [cell.rightpartButton.ShopLabel initWithStratString:[[homeBusine.HomeButtonArray objectAtIndex:(2*([[homeBusine.NumArray objectAtIndex:indexPath.row] intValue]-1)+i)] postCount] startColor:text_RedColor startFont:FONT12_SYSTEM centerString:[NSString stringWithFormat:@"位%@",[[homeBusine.HomeButtonArray objectAtIndex:(2*([[homeBusine.NumArray objectAtIndex:indexPath.row] intValue]-1)+i)] workName]] centerColor:text_grayColor centerFont:FONT12_SYSTEM endString:@"" endColor:nil endFont:nil];
                            
                            cell.rightpartButton.guid = [[homeBusine.HomeButtonArray objectAtIndex:(2*([[homeBusine.NumArray objectAtIndex:indexPath.row] intValue]-1)+i)] workGuid];
                        }
                        
                        [cell.rightpartButton.workTypeLabel setTextColor:[UIColor blackColor]];
                        [cell.rightpartButton setTag:(2*([[homeBusine.NumArray objectAtIndex:indexPath.row] intValue]-1)+i+1)*100];
                        [cell.rightpartButton addTarget:self action:@selector(HomeButtonActionTouchUp:) forControlEvents:UIControlEventTouchUpInside];
                        [cell.rightpartButton addTarget:self action:@selector(HomeButtonActionTouchCancel:) forControlEvents:UIControlEventTouchDragExit];
                        [cell.rightpartButton addTarget:self action:@selector(HomeButtonActionTouchDown:) forControlEvents:UIControlEventTouchDown];
                        [cell.rightpartButton addTarget:self action:@selector(HomeButtonActionTouchCancel:) forControlEvents:UIControlEventTouchDragOutside];
                        [cell.rightpartButton addTarget:self action:@selector(HomeButtonActionTouchCancel:) forControlEvents:UIControlEventTouchCancel];
                        break;
                    default:
                        break;
                }
            }
            return cell;
        }else{
            Ty_HomeWorkTypeViewCell* cell = [tableView dequeueReusableCellWithIdentifier:Cell2];
            if (cell == nil) {
                cell = [[Ty_HomeWorkTypeViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:Cell2];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.homework setData:homeBusine.worktypeArr];
            
            cell.homework.delegate = self;
            CGRect rect = cell.frame;
            rect.size.height = cell.homework.frame.size.height;
            cell.frame = rect;
            return cell;
        }
    }else{
        static NSString* Cell = @"Cell";
        Ty_HomeWorkButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell];
        if (cell == nil) {
            cell = [[Ty_HomeWorkButtonCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cell];
        }
        cell.delegate = self;
        [cell loadData:[homeBusine.MainArr objectAtIndex:indexPath.row]];
        return cell;
    }
    
}
-(void)click_homeWorkButton:(Ty_HomeWorkButton *)sender
{
    [self.naviGationController pushViewController:[homeBusine click_homeWorkButton:sender] animated:YES];
}
#pragma mark ----HomeButtonAction
-(void)HomeButtonActionTouchUp:(Home_Button*)sender
{
    [self HomeButtonColorIsCustom:sender];
    
    sender.change = !sender.change;
    [homeBusine.worktypeArr removeAllObjects];
    for (int i = 1; i <= [homeBusine.NumArray count]*2; i++) {
        UIView* view = [self.view viewWithTag:i*100];
        if ([view isKindOfClass:[Home_Button class]]) {
            if (sender != view) {
                Home_Button* home = (Home_Button*)view;
                home.change = NO;
                home.jiantouImage.hidden = YES;
            }else{
                Home_Button* home = (Home_Button*)view;
                if (home.change) {
                    home.jiantouImage.hidden = NO;
                }else{
                    home.jiantouImage.hidden = YES;
                }
            }
        }
    }
    for (int i = 0; i<homeBusine.MainArray.count; i++) {
        if ([[homeBusine.NumArray objectAtIndex:i] isEqualToString:@"0"]) {
            [homeBusine.NumArray removeObjectAtIndex:i];
            [homeBusine.MainArray removeObjectAtIndex:i];
            NSIndexPath* indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            [tableview deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
    if (sender.change) {
        [homeBusine.worktypeArr setArray:[[homeBusine.workPlist objectAtIndex:sender.tag/100-1] objectForKey:@"ChildrenWrok"]];
        homeBusine.workFristGuid = sender.guid;
        homeBusine.workFristName = sender.workTypeLabel.text;
        if (sender.tag%200 != 0) {
            [homeBusine.NumArray insertObject:@"0" atIndex:sender.tag/200+1];
            [homeBusine.MainArray insertObject:@"0" atIndex:sender.tag/200+1];
            NSIndexPath* indexPath = [NSIndexPath indexPathForRow:sender.tag/200+1 inSection:0];
            [tableview insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            if (self.view.frame.size.height <= 480) {
                if (sender.tag > 400) {
                    [tableview scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
                }
                
            }else{
                if (sender.tag > 600) {
                    [tableview scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
                    
                }
            }
        }else{
            [homeBusine.NumArray insertObject:@"0" atIndex:sender.tag/200];
            [homeBusine.MainArray insertObject:@"0" atIndex:sender.tag/200];
            NSIndexPath* indexPath = [NSIndexPath indexPathForRow:sender.tag/200 inSection:0];
            [tableview insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
            if (self.view.frame.size.height <= 480) {
                if (sender.tag > 400) {
                    [tableview scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
                }
                
            }else{
                if (sender.tag > 600) {
                    [tableview scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
                }
                
            }
        }
    }else{
        
    }
}
-(void)HomeWorkTypeViewButtonClick:(id)sender
{
    [self.naviGationController pushViewController:[homeBusine Click_WorkTypeList:sender] animated:YES];
}
-(void)HomeButtonActionTouchDown:(Home_Button*)sender
{
    [self HomeButtonColorIsWhrite:sender];
}
-(void)HomeButtonActionTouchCancel:(Home_Button*)sender
{
    [self HomeButtonColorIsCustom:sender];
}

#pragma mark ----HomeButton 颜色效果的切换
-(void)HomeButtonColorIsCustom:(Home_Button* )sender
{
    sender.workTypeLabel.highlighted = NO;
    sender.ShopLabel.startLabel.highlighted = NO;
    sender.ShopLabel.centerLabel.highlighted = NO;
    sender.ShopLabel.endLabel.highlighted = NO;
    sender.PartTimeLabel.startLabel.highlighted = NO;
    sender.PartTimeLabel.centerLabel.highlighted = NO;
    sender.PartTimeLabel.endLabel.highlighted = NO;
    sender.prayImage.image = JWImageName(@"prayimage_1");
}
-(void)HomeButtonColorIsWhrite:(Home_Button* )sender
{
    sender.workTypeLabel.highlighted = YES;
    sender.ShopLabel.startLabel.highlighted = YES;
    sender.ShopLabel.centerLabel.highlighted = YES;
    sender.ShopLabel.endLabel.highlighted = YES;
    sender.PartTimeLabel.startLabel.highlighted = YES;
    sender.PartTimeLabel.centerLabel.highlighted = YES;
    sender.PartTimeLabel.endLabel.highlighted = YES;
    sender.prayImage.image = JWImageName(@"prayimage_2");
}

//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//}
//-(void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    [self setNavigationBarHidden:NO animated:NO];
//}
#pragma mark ----网络回调
-(void)netRequestReceived:(NSNotification *)_notification
{
    NSLog(@"qhhome");
    if ([[[_notification object]objectForKey:@"type"] isEqualToString:@"工种"]) {
        if ([[[_notification object]objectForKey:@"code"] isEqualToString:REQUESTFAIL]){
            [self showNetMessageInView:self.view];
        }else if([[[_notification object] objectForKey:@"code"] isEqualToString:@"205"]){
            
        }else{
            [self hideLoadingView];
            [mainScrollView addSubview:tableview];
            [mainScrollView addSubview:tableviewSecond];
            [self.view addSubview:remenFuWuLabel];
            [self.view addSubview:remenImage];
            [self.view addSubview:quanbuFuWuLabel];
            [self.view addSubview:quanbuImage];
        }
    }else if([[[_notification object]objectForKey:@"type"] isEqualToString:@"banner"]){
        if ([[[_notification object]objectForKey:@"code"] isEqualToString:REQUESTFAIL]){
            
        }else{
            [self hideLoadingView];
            [self loadBannerUI];
        }
    }else{
    
    }
    [tableview reloadData];
    [tableviewSecond reloadData];
}
#pragma mark
-(void)loading{
    [self showLoadingInView:self.view];
    [homeBusine queryWorkTree];
    
}

#pragma mark ----ScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView  == mainScrollView) {
        int contentOffsetX = scrollView.contentOffset.x;
        if(contentOffsetX >=  CGRectGetWidth(scrollView.frame)) {
            [self setPageControl:NO];
        }
        if(contentOffsetX <=  0) {
            [self setPageControl:YES];
        }
    }
    
}
#pragma mark ----改变pageControl
-(void)setPageControl:(BOOL)_bool
{
    if (_bool) {
        [remenFuWuLabel setTextColor:text_RedColor];
        [remenImage setImage:JWImageName(@"红")];
        [quanbuFuWuLabel setTextColor:text_grayColor];
        [quanbuImage setImage:JWImageName(@"灰")];
    }else{
        [remenFuWuLabel setTextColor:text_grayColor];
        [remenImage setImage:JWImageName(@"灰")];
        [quanbuFuWuLabel setTextColor:text_RedColor];
        [quanbuImage setImage:JWImageName(@"红")];
    }
}

#pragma mark ------ denglu
- (void)loginWhenNotLogin
{
    
    My_LoginViewController *loginViewController = [[My_LoginViewController alloc]init];
    [self.naviGationController pushViewController:loginViewController animated:YES];
    
    loginViewController = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
