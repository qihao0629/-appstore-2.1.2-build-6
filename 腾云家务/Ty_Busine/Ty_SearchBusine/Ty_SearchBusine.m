
//
//  Ty_SearchBusine.m
//  腾云家务
//
//  Created by 齐 浩 on 14-7-9.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_SearchBusine.h"
#import "Ty_DbMethod.h"
#import "Ty_Home_UserDetailVC.h"
#import "Ty_Model_WorkListInfo.h"
@implementation Ty_SearchBusine
@synthesize searchText,markArray,searchBool,shopArray,personalArray,latitude,longitude;
@synthesize currentPage;
@synthesize _isRefreshing;
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        searchText=@"";
        searchBool=NO;
        currentPage=1;
        latitude = @"0";
        longitude = @"0";
        markArray=[[NSMutableArray alloc]init];
        shopArray=[[NSMutableArray alloc]init];
        personalArray=[[NSMutableArray alloc]init];
        [self OpenGPS];
        [self reloadMarkData];
    }
    return self;
}
- (void)OpenGPS {
    if ([CLLocationManager locationServicesEnabled]) { // 检查定位服务是否可用
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.distanceFilter=0.5;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [locationManager startUpdatingLocation]; // 开始定位
    }
    NSLog(@"GPS 启动");
}

// 定位成功时调用
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    mylocation = newLocation.coordinate;//手机GPS
    
    mylocation = [self zzTransGPS:mylocation];///火星GPS
    
    if (longitude==nil) {
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
}

-(CLLocationCoordinate2D)zzTransGPS:(CLLocationCoordinate2D)yGps
{
    int TenLat=0;
    int TenLog=0;
    TenLat = (int)(yGps.latitude*10);
    TenLog = (int)(yGps.longitude*10);
    NSString *sql = [[NSString alloc]initWithFormat:@"select offLat,offLog from gpsT where lat=%d and log = %d",TenLat,TenLog];
    NSLog(sql);
    sqlite3_stmt* stmtL = [m_sqlite NSRunSql:sql];
    int offLat=0;
    int offLog=0;
    while (sqlite3_step(stmtL)==SQLITE_ROW)
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
    longitude= [[NSString alloc]initWithFormat:@"%lf",_mylocation.longitude];
}
-(void)loadDatatarget
{
    NSMutableDictionary* dic=[[NSMutableDictionary alloc]initWithObjectsAndKeys:
                              [NSString stringWithFormat:@"%d",self.currentPage],@"currentPage",
                              pageSize_Req,@"pageSize",
                              [NSString stringWithFormat:@"%@  %@",USERPROVINCE,USERCITY],@"userAddress",
                              longitude,@"lng",
                              latitude,@"lat",
                              searchText,@"term",nil];
    
    NSLog(@"currangePage=%@",[NSString stringWithFormat:@"%d",self.currentPage]);
    [[Ty_NetRequestService shareNetWork]formRequest:SearchEmployeeUrl andParameterDic:dic
                                          andTarget:self andSeletor:@selector(ReceiveHomeFindInfo: dic:)];
}
-(void)ReceiveHomeFindInfo:(NSString*)_isSuccess dic:(NSMutableDictionary* )_dic
{
    if ([_isSuccess isEqualToString:REQUESTSUCCESS]) {
        if ([[_dic objectForKey:@"code"] intValue]==200) {
            
            if (currentPage==1) {
                [shopArray removeAllObjects];
                [personalArray removeAllObjects];
            }
            for (int i=0; i<[[_dic objectForKey:@"rows"] count]; i++) {
                NSDictionary* dic=[[NSDictionary alloc]init];
                dic=[[_dic objectForKey:@"rows"] objectAtIndex:i];
                Ty_Model_ServiceObject* service=[[Ty_Model_ServiceObject alloc]init];
                service.userType=[dic objectForKey:@"userType"];
                service.sex=[dic objectForKey:@"userSex"];
                service.userRealName=[dic objectForKey:@"userRealName"];
                service.userName=[dic objectForKey:@"userName"];
                if ([service.userType isEqualToString:@"0"]) {
                    service.companiesGuid=[dic objectForKey:@"userGuid"];
                    service.respectiveCompanies=[dic objectForKey:@"intermediaryName"];
                    service.intermediary_Region=[dic objectForKey:@"area"];
                }else if ([service.userType isEqualToString:@"1"]){
                    service.respectiveCompanies=[dic objectForKey:@"company"];
                    service.userGuid=[dic objectForKey:@"userGuid"];
                }else{
                    service.userGuid=[dic objectForKey:@"userGuid"];
                }
//                service.distanceString=[dic objectForKey:@"distance"];
                service.headPhoto=[dic objectForKey:@"userPhoto"];
                service.headPhotoGaoQing=[dic objectForKey:@"userBigPhoto"];
                if ([[dic objectForKey:@"workSize"]isEqualToString:@"null"]||[[dic objectForKey:@"workSize"]isEqualToString:@""]) {
                    service.serviceNumber=@"0";
                }else{
                    service.serviceNumber=[dic objectForKey:@"workSize"];
                }
                service.evaluate=[dic objectForKey:@"userEvaluate"];
                for (int i=0; i<[[dic objectForKey:@"userPost"] count]; i++) {
                    Ty_Model_WorkListInfo* worktype=[[Ty_Model_WorkListInfo alloc]init];
                    worktype.workName=[[[dic objectForKey:@"userPost"]objectAtIndex:i]objectForKey:@"postName"];
                    worktype.postSalary=[[[dic objectForKey:@"userPost"]objectAtIndex:i]objectForKey:@"postSalary"];
                    worktype.specialty=[[[dic objectForKey:@"userPost"]objectAtIndex:i]objectForKey:@"k_specialty"];
                    [service.workTypeArray addObject:worktype];
                }
                
                
                //                service.workTypeArray=[dic objectForKey:@"userPost"];
                if ([service.userType isEqualToString:@"0"]) {
                    service.empCount=[dic objectForKey:@"empCount"];
                    [shopArray addObject:service];
                }else{
                    [personalArray addObject:service];
                }
                service=nil;
                dic=nil;
            }
            
            NSDictionary*d=[[NSDictionary alloc]initWithObjectsAndKeys:@"200",@"code",nil];
            PostNetDelegate(d,@"Ty_HomeSearchVC");
            d=nil;
        }else if ([[_dic objectForKey:@"code"] intValue]==203){
            if (currentPage==1) {
                [shopArray removeAllObjects];
                [personalArray removeAllObjects];
            }
            NSDictionary*d=[[NSDictionary alloc]initWithObjectsAndKeys:@"203",@"code", nil];
            PostNetDelegate(d,@"Ty_HomeSearchVC");
            d=nil;
        }else if ([[_dic objectForKey:@"code"] intValue]==202){
            NSDictionary*d=[[NSDictionary alloc]initWithObjectsAndKeys:@"202",@"code", nil];
            PostNetDelegate(d,@"Ty_HomeSearchVC");
            d=nil;
        }
    }else{
        NSDictionary*d=[[NSDictionary alloc]initWithObjectsAndKeys:REQUESTFAIL,@"code", nil];
        PostNetDelegate(d,@"Ty_HomeSearchVC");
        d=nil;
    }
    
}

-(void)searchBegin:(NSString*)_text
{
    [self insertMarkMessage:_text];
    [self reloadMarkData];
    [self loadDatatarget];
}

-(void)reloadMarkData
{
    [markArray removeAllObjects];
    NSString* selectMarkString=[NSString stringWithFormat:@"select * from %@ order by %@ desc",SEARCHMARK,SEARCHMARK_ID];
    FMResultSet* resultSet=[[Ty_DbMethod shareDbService]selectData:selectMarkString];
    while (resultSet.next) {
        [markArray addObject:[resultSet stringForColumn:SEARCHMARK_MESSAGE]];
    }
}
-(void)removeMarkData
{
    NSString *removeMarkString=[NSString stringWithFormat:@"delete from %@",SEARCHMARK];
    [[Ty_DbMethod shareDbService] deleteData:removeMarkString];
}
-(void)insertMarkMessage:(NSString*)message
{
    if (![self isHave:message]) {
        NSString* insertMarkString=[NSString stringWithFormat:@"insert into %@(%@) values ('%@') ",SEARCHMARK,SEARCHMARK_MESSAGE,message];
        [[Ty_DbMethod shareDbService]insertData:insertMarkString];
    }
}

-(BOOL)isHave:(NSString* )message
{
    NSString* selectMarkString=[NSString stringWithFormat:@"select * from %@ where %@ = '%@'",SEARCHMARK,SEARCHMARK_MESSAGE,message];
    FMResultSet* resultSet=[[Ty_DbMethod shareDbService]selectData:selectMarkString];
    while (resultSet.next) {
        return YES;
    }
    return NO;
}
-(UIViewController*)didSelectIndexPath:(NSIndexPath*)indexPath
{
    if (indexPath.section==0) {
        Ty_Home_UserDetailVC* userDetailVC=[[Ty_Home_UserDetailVC alloc] init];
        [userDetailVC Home_UserDetail:Ty_Home_UserDetailTypeDefault];
        userDetailVC.userDetailBusine.userService=[shopArray objectAtIndex:indexPath.row];
        return userDetailVC;
    }else{
        Ty_Home_UserDetailVC* userDetailVC=[[Ty_Home_UserDetailVC alloc] init];
        [userDetailVC Home_UserDetail:Ty_Home_UserDetailTypeDefault];
        userDetailVC.userDetailBusine.userService=[personalArray objectAtIndex:indexPath.row];
        return userDetailVC;
    }
}

@end
