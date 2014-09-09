//
//  Ty_HomeFindBusine.m
//  腾云家务
//
//  Created by 齐 浩 on 14-6-11.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_HomeFindBusine.h"
#import "CSqlite.h"
#import "Ty_Model_ServiceObject.h"
#import "Ty_Home_UserDetailVC.h"
#import "Ty_Home_UserDetailBusine.h"
#import "Ty_Model_WorkListInfo.h"
#import "My_LoginViewController.h"
#import "Ty_Pub_RequirementsVC.h"
@implementation Ty_HomeFindBusine
@synthesize shopArray,personalArray;
@synthesize range,userAddress,orderByTerm,longitude,latitude,currentPage,FirstType;
@synthesize workArray,sortArray;
@synthesize workFristName,workFristGuid,selectworkGuid,selectworkName;
@synthesize childrenworkArray,childrenworkDic,workDic;
@synthesize _isRefreshing;
@synthesize sortBool,cityBool,workBool;

- (instancetype)init
{
    self = [super init];
    if (self) {
        shopArray = [[NSMutableArray alloc]init];
        personalArray = [[NSMutableArray alloc]init];
        currentPage = 1;
        sortBool = NO;
        workBool = NO;
        cityBool = NO;
        FirstType = @"0";
        latitude=@"0";
        longitude=@"0";
        orderByTerm = @"3";
        userAddress = [NSString stringWithFormat:@"%@  %@",USERPROVINCE,USERCITY];
        range = @"";
         m_sqlite = [[CSqlite alloc]init];
         [m_sqlite openSqlite];
//        [self OpenGPS];
    }
    return self;
}
#pragma mark ----开始定位
- (void)OpenGPS {
    if ([CLLocationManager locationServicesEnabled]) { // 检查定位服务是否可用
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.distanceFilter = 0.5;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [locationManager startUpdatingLocation]; // 开始定位
        NSLog(@"GPS 启动");
    }else{
        [self loadDatatarget];
    }
    
}

// 定位成功时调用
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    mylocation = newLocation.coordinate;//手机GPS
    
    mylocation = [self zzTransGPS:mylocation];///火星GPS
    
    if ([longitude isEqualToString:@"0"]) {
        [self ReceiveGps:mylocation];
    }
    
    [manager stopUpdatingLocation];
    
//    NSLog(@"%@,%@",latitude,longitude);
    //[geocoder release];
    
}
// 定位失败时调用
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    [manager stopUpdatingLocation];
    [self loadDatatarget];
}

-(CLLocationCoordinate2D)zzTransGPS:(CLLocationCoordinate2D)yGps
{
    int TenLat = 0;
    int TenLog = 0;
    TenLat = (int)(yGps.latitude*10);
    TenLog = (int)(yGps.longitude*10);
    NSString *sql = [[NSString alloc]initWithFormat:@"select offLat,offLog from gpsT where lat = %d and log = %d",TenLat,TenLog];
    NSLog(sql);
    sqlite3_stmt* stmtL = [m_sqlite NSRunSql:sql];
    int offLat = 0;
    int offLog = 0;
    while (sqlite3_step(stmtL) == SQLITE_ROW)
    {
        offLat = sqlite3_column_int(stmtL, 0);
        offLog = sqlite3_column_int(stmtL, 1);
        
    }
    [m_sqlite closeSqlite];
    yGps.latitude = yGps.latitude+offLat*0.0001;
    yGps.longitude = yGps.longitude + offLog*0.0001;
    
    
    return yGps;
    
}
#pragma mark ----定位之后
-(void)ReceiveGps:(CLLocationCoordinate2D)_mylocation
{
    latitude = [[NSString alloc]initWithFormat:@"%lf",_mylocation.latitude];
    longitude =  [[NSString alloc]initWithFormat:@"%lf",_mylocation.longitude];
    [self loadDatatarget];
}
#pragma mark ----初始化筛选数据
-(void)initShaiXuan
{
    workArray = [[NSMutableArray alloc]init];
    sortArray = [[NSMutableArray alloc]init];
    //    [workArray addObject:[NSString stringWithFormat:@"全部%@",workName]];
    childrenworkArray = [[NSMutableArray alloc]init];
    childrenworkDic = [[NSMutableDictionary alloc]init];
    workDic = [[NSMutableDictionary alloc]init];

    NSArray* workPlist = [[NSArray alloc]initWithContentsOfFile:WorkTypefileForPath];
    if ([workPlist count]>0) {
        for (int i = 0 ; i<[workPlist count]; i++) {
            if ([[[workPlist objectAtIndex:i] objectForKey:@"workGuid"] isEqualToString:workFristGuid]) {
                childrenworkDic = [workPlist objectAtIndex:i];
                childrenworkArray = [childrenworkDic objectForKey:@"ChildrenWrok"];
                for (int j = 0; j<[childrenworkArray count]; j++) {
                    workDic = [childrenworkArray objectAtIndex:j];
                    [workArray addObject:[workDic objectForKey:@"workName"]];
                }
            }
        }
    }
    [sortArray setArray:[[NSArray alloc]initWithObjects:@"最新",@"接活次数",@"评价",@"按距离", nil]];
    workPlist = nil;
    
}
#pragma mark ----筛选城市
-(void)cityProcess:(TSLocation*)_location
{
    if ([_location.quyu isEqualToString:@"附近"]) {
        if ([_location.region isEqualToString:@"附近"]||[_location.region isEqualToString:@"2000m"]) {
            range = @"2000";
        }else if ([_location.region isEqualToString:@"500m"]){
            range = @"500";
        }else if ([_location.region isEqualToString:@"1000m"]){
            range = @"1000";
        }else if ([_location.region isEqualToString:@"5000m"]){
            range = @"5000";
        }
        userAddress = [NSString stringWithFormat:@"%@  %@",USERPROVINCE,USERCITY];
        //        findAction.change = YES;
        currentPage = 1;
        [self loadDatatarget];
        
    }else if ([_location.quyu isEqualToString:@"全部区域"]) {
        userAddress = [NSString stringWithFormat:@"%@  %@",USERPROVINCE,USERCITY];;
        
        range = @"";
        //        findAction.change = YES;
        currentPage = 1;
        [self loadDatatarget];
        //        NSLog(@"loadData = 4");
        
    }else{
        if ([_location.region isEqualToString:@"全部区域"]) {
            userAddress = [NSString stringWithFormat:@"%@  %@  %@",USERPROVINCE,USERCITY,_location.quyu];
        }else{
            userAddress = [NSString stringWithFormat:@"%@  %@  %@  %@",USERPROVINCE,USERCITY,_location.quyu,_location.region];
        }
        range = @"";
        //        findAction.change = YES;
        currentPage = 1;
        [self loadDatatarget];
        //        NSLog(@"loadData = 5");
    }
}
#pragma mark ----筛选工种获取
-(void)workProcess:(NSString*)_workType
{
    for (int j = 0; j<[self.childrenworkArray count]; j++) {
        if ([[[self.childrenworkArray objectAtIndex:j] objectForKey:@"workName"] isEqualToString:_workType]) {
            self.workDic = [self.childrenworkArray objectAtIndex:j];
        }
    }
    self.selectworkGuid = [self.workDic objectForKey:@"workGuid"];
    self.selectworkName = [self.workDic objectForKey:@"workName"];
    currentPage = 1;
    [self loadDatatarget];
}
#pragma mark ---- 筛选排序
-(void)sortProcess:(NSString *)_sort
{
    if ([_sort isEqualToString:@"最新"]) {
        self.orderByTerm = @"0";
    }else if ([_sort isEqualToString:@"接活次数"]){
        self.orderByTerm = @"1";
    }else if ([_sort isEqualToString:@"评价"]){
        self.orderByTerm = @"2";
    }else if ([_sort isEqualToString:@"按距离"]){
        self.orderByTerm = @"3";
    }
    currentPage = 1;
    [self loadDatatarget];
}
#pragma mark ----网络获取数据
-(void)loadDatatarget
{
    if(currentPage == 1){
        FirstType = @"0";
    }else{
        FirstType = @"";
    }
    NSMutableDictionary* dic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                              selectworkGuid,@"workGuid",
                              [NSString stringWithFormat:@"%d",self.currentPage],@"currentPage",
                              pageSize_Req,@"pageSize",
                              userAddress,@"userAddress",
                              range,@"range",
                              orderByTerm,@"orderByTerm",
                              longitude,@"lng",
                              latitude,@"lat",
                              FirstType,@"initType",nil];
    
    NSLog(@"currangePage = %@",[NSString stringWithFormat:@"%d",self.currentPage]);
    [[Ty_NetRequestService shareNetWork]formRequest:EmployeeUrl andParameterDic:dic
                                          andTarget:self andSeletor:@selector(ReceiveHomeFindInfo: dic:)];
}
-(void)ReceiveHomeFindInfo:(NSString*)_isSuccess dic:(NSMutableDictionary* )_dic
{
    if ([_isSuccess isEqualToString:REQUESTSUCCESS]) {
        if ([[_dic objectForKey:@"code"] intValue] == 200) {
            
            if (currentPage == 1) {
                [shopArray removeAllObjects];
                [personalArray removeAllObjects];
            }
            for (int i = 0; i<[[_dic objectForKey:@"rows"] count]; i++) {
                NSDictionary* dic = [[NSDictionary alloc]init];
                dic = [[_dic objectForKey:@"rows"] objectAtIndex:i];
                Ty_Model_ServiceObject* service = [[Ty_Model_ServiceObject alloc]init];
                service.userType = [dic objectForKey:@"userType"];
                
                
                service.sex = [dic objectForKey:@"userSex"];
                service.userRealName = [dic objectForKey:@"userRealName"];
                service.userName = [dic objectForKey:@"userName"];
                if ([service.userType isEqualToString:@"0"]) {
                    service.companiesGuid = [dic objectForKey:@"userGuid"];
                    service.respectiveCompanies = [dic objectForKey:@"intermediaryName"];
                    service.intermediary_Region = [dic objectForKey:@"area"];
                }else if ([service.userType isEqualToString:@"1"]){
                    service.respectiveCompanies = [dic objectForKey:@"company"];
                    service.userGuid = [dic objectForKey:@"userGuid"];
                }else{
                    service.userGuid = [dic objectForKey:@"userGuid"];
                }
                
                
                service.distanceString = [dic objectForKey:@"distance"];
                service.headPhoto = [dic objectForKey:@"userPhoto"];
                service.headPhotoGaoQing = [dic objectForKey:@"userBigPhoto"];
                if ([[dic objectForKey:@"workSize"]isEqualToString:@"null"]||[[dic objectForKey:@"workSize"]isEqualToString:@""]) {
                    service.serviceNumber = @"0";
                }else{
                    service.serviceNumber = [dic objectForKey:@"workSize"];
                }
                service.evaluate = [dic objectForKey:@"userEvaluate"];
//                for (int i = 0; i<[[dic objectForKey:@"userPost"] count]; i++) {
//                    Ty_Model_WorkListInfo* worktype = [[Ty_Model_WorkListInfo alloc]init];
//                    worktype.workName = [[[dic objectForKey:@"userPost"]objectAtIndex:i]objectForKey:@"postName"];
//                    worktype.postSalary = [[[dic objectForKey:@"userPost"]objectAtIndex:i]objectForKey:@"postSalary"];
//                    worktype.specialty = [[[dic objectForKey:@"userPost"]objectAtIndex:i]objectForKey:@"k_specialty"];
//                    [service.workTypeArray addObject:worktype];
//                }
                if ([[dic objectForKey:@"userPost"] count]>0) {
                    service.price=[[[dic objectForKey:@"userPost"]objectAtIndex:0]objectForKey:@"postSalary"];
                }
                
                
//                service.workTypeArray = [dic objectForKey:@"userPost"];
                if ([service.userType isEqualToString:@"0"]) {
                    service.empCount = [dic objectForKey:@"empCount"];
                    [shopArray addObject:service];
                }else{
                    [personalArray addObject:service];
                }
                service = nil;
                dic = nil;
            }
            
            NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:@"200",@"code",[NSString stringWithFormat:@"%@",[_dic objectForKey:@"queryType"]],@"queryType",nil];
            PostNetDelegate(d,@"Ty_HomeFindVC");
            d = nil;
        }else if ([[_dic objectForKey:@"code"] intValue] == 203){
            if (currentPage == 1) {
                [shopArray removeAllObjects];
                [personalArray removeAllObjects];
            }
            NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:@"203",@"code", nil];
            PostNetDelegate(d,@"Ty_HomeFindVC");
            d = nil;
        }else if ([[_dic objectForKey:@"code"] intValue] == 201){
            NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:@"201",@"code", nil];
            PostNetDelegate(d,@"Ty_HomeFindVC");
            d = nil;
        }else{
            NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:[_dic objectForKey:@"msg"],@"code", nil];
            PostNetDelegate(d,@"Ty_HomeFindVC");
            d = nil;
        }
    }else{
        NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:REQUESTFAIL,@"code", nil];
        PostNetDelegate(d,@"Ty_HomeFindVC");
        d = nil;
    }

}
#pragma mark ----Cell点击方法
-(UIViewController*)didSelectIndexPath:(NSIndexPath*)indexPath
{
    if (indexPath.section == 0) {
        Ty_Home_UserDetailVC* userDetailVC = [[Ty_Home_UserDetailVC alloc] init];
        [userDetailVC Home_UserDetail:Ty_Home_UserDetailTypeDefault];
        userDetailVC.userDetailBusine.userService = [shopArray objectAtIndex:indexPath.row];
        userDetailVC.userDetailBusine._selectWorkName = selectworkName;
        userDetailVC.userDetailBusine._selectWorkGuid = selectworkGuid;
        return userDetailVC;
    }else{
        Ty_Home_UserDetailVC* userDetailVC = [[Ty_Home_UserDetailVC alloc] init];
        [userDetailVC Home_UserDetail:Ty_Home_UserDetailTypeDefault];
        userDetailVC.userDetailBusine.userService = [personalArray objectAtIndex:indexPath.row];
        userDetailVC.userDetailBusine._selectWorkName = selectworkName;
        userDetailVC.userDetailBusine._selectWorkGuid = selectworkGuid;
        return userDetailVC;
    }
}
#pragma mark ----发布需求
-(UIViewController*)Click_pub_Requirements
{
    Ty_Pub_RequirementsVC* ty_pub_Requirements = [[Ty_Pub_RequirementsVC alloc]init];
    ty_pub_Requirements.pub_RequirementsBusine.xuqiuInfo.workName = self.selectworkName;
    ty_pub_Requirements.pub_RequirementsBusine.xuqiuInfo.workGuid = self.selectworkGuid;
    ty_pub_Requirements.title = @"发抢单";
    return ty_pub_Requirements;
}

#pragma mark ----登录
-(UIViewController*)Click_LoginVC
{
    My_LoginViewController* loginVC = [[My_LoginViewController alloc]init];
    return loginVC;
}
@end
