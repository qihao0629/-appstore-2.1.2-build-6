//
//  Ty_HomeBusine.m
//  腾云家务
//
//  Created by 齐 浩 on 14-6-3.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_HomeBusine.h"
#import "Ty_HomeMainObject.h"
#import "Ty_HomeFindVC.h"
#import "Ty_HomeBannerObject.h"
#import "Ty_HomeSearchVC.h"
#import "My_LoginViewController.h"
#import "Ty_HomeWorkTypeButton.h"
#import "CeshiViewController.h"
#import "Ty_Pub_RequirementsVC.h"

@implementation Ty_HomeBusine
@synthesize requestBool;
@synthesize MainArray,NumArray,HomeButtonArray,worktypeArr,workPlist,MainArr,bannerArr;
@synthesize workFristGuid,workFristName;
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self queryWorkTree];
        HomeButtonArray = [[NSMutableArray alloc]init];
        worktypeArr = [[NSMutableArray alloc]init];
        MainArr = [[NSMutableArray alloc]init];
        bannerArr = [[NSMutableArray alloc]init];
        requestBool = NO;
        
        Ty_HomeMainObject* homeMainObj1 = [[Ty_HomeMainObject alloc]init];
        homeMainObj1.workName = @"日常保洁";
        homeMainObj1.workGuid = @"f80aff2bf0cc523ed14c9011f80f8873";
        homeMainObj1.firstworkName = @"保洁";
        homeMainObj1.firstworkGuid = @"c804498d09366848e4a24bdd335c2708";
        
        Ty_HomeMainObject* homeMainObj2 = [[Ty_HomeMainObject alloc]init];
        homeMainObj2.workName = @"临时钟点工";
        homeMainObj2.workGuid = @"2f3e007c0648b212307f9d2ab0b01e7c";
        homeMainObj2.firstworkName = @"钟点工";
        homeMainObj2.firstworkGuid = @"77880f3011ae63dbbec9a0774d7d805a";
        
        Ty_HomeMainObject* homeMainObj3 = [[Ty_HomeMainObject alloc]init];
        homeMainObj3.workName = @"住家保姆";
        homeMainObj3.workGuid = @"6449c2f803f180048fda9b4c28d7fe64";
        homeMainObj3.firstworkName = @"保姆";
        homeMainObj3.firstworkGuid = @"eacb2431ec8a955cea407d2c879bf3e4";
        
        Ty_HomeMainObject* homeMainObj4 = [[Ty_HomeMainObject alloc]init];
        homeMainObj4.workName = @"月嫂";
        homeMainObj4.workGuid = @"977298334f58bd9fa7897cf1369f1a7d";
        homeMainObj4.firstworkName = @"育婴育儿";
        homeMainObj4.firstworkGuid = @"000682fc729a398873233d8db60c595d";
        
        NSArray* array1 = [[NSArray alloc]initWithObjects:homeMainObj1,homeMainObj2,homeMainObj3,homeMainObj4, nil];
        
        Ty_HomeMainObject* homeMainObj5 = [[Ty_HomeMainObject alloc]init];
        homeMainObj5.workName = @"空调清洗";
        homeMainObj5.workGuid = @"248cbde70fb7ea4a506b66dea28af8f8";
        homeMainObj5.firstworkName = @"保洁";
        homeMainObj5.firstworkGuid = @"c804498d09366848e4a24bdd335c2708";
        
        Ty_HomeMainObject* homeMainObj6 = [[Ty_HomeMainObject alloc]init];
        homeMainObj6.workName = @"油烟机清洗";
        homeMainObj6.workGuid = @"32ad71cf3e2f5772a9b7548c139cf004";
        homeMainObj6.firstworkName = @"保洁";
        homeMainObj6.firstworkGuid = @"c804498d09366848e4a24bdd335c2708";
        
        Ty_HomeMainObject* homeMainObj7 = [[Ty_HomeMainObject alloc]init];
        homeMainObj7.workName = @"开荒保洁";
        homeMainObj7.workGuid = @"3a2fadfff18553d49d78af45b8f7d016";
        homeMainObj7.firstworkName = @"保洁";
        homeMainObj7.firstworkGuid = @"c804498d09366848e4a24bdd335c2708";
        
        Ty_HomeMainObject* homeMainObj8 = [[Ty_HomeMainObject alloc]init];
        homeMainObj8.workName = @"老人看护";
        homeMainObj8.workGuid = @"0035ea54d8fc9126fe8662a6ad96ddd5";
        homeMainObj8.firstworkName = @"保姆";
        homeMainObj8.firstworkGuid = @"eacb2431ec8a955cea407d2c879bf3e4";
        
        NSArray* array2 = [[NSArray alloc]initWithObjects:homeMainObj5,homeMainObj6,homeMainObj7,homeMainObj8,nil];
        
        [MainArr addObject:array1];
        [MainArr addObject:array2];
        
    }
    return self;
}
#pragma mark ----搜索
-(UIViewController*)searchClick:(id)sender
{
    if ([sender isMemberOfClass:[UIButton class]]) {
        Ty_HomeSearchVC* search = [[Ty_HomeSearchVC alloc]init];
        return search;
    }else{
        Ty_HomeSearchVC* search = [[Ty_HomeSearchVC alloc]init];
        search.searchBusine.searchText = sender;
        return search;
    }
}
#pragma mark ----点击红色工种方法
-(UIViewController *)click_homeWorkButton:(Ty_HomeWorkButton *)sender
{
    Ty_HomeFindVC * findService = [[Ty_HomeFindVC alloc]init];
    findService.findBusine.workFristGuid = sender.firstworkGuid;
    findService.findBusine.workFristName = sender.firstworkName;
    findService.findBusine.selectworkGuid = sender.workGuid;
    findService.findBusine.selectworkName = sender.workName;
    return findService;
}
#pragma mark ----进入二级列表
-(UIViewController*)Click_WorkTypeList:(id)sender
{
    Ty_HomeWorkTypeButton* homeButton = (Ty_HomeWorkTypeButton*)sender;
    
    if ([homeButton.kaifangYesOrNO isEqualToString:@"0"]) {
        Ty_HomeFindVC * findService = [[Ty_HomeFindVC alloc]init];
        findService.findBusine.workFristGuid = workFristGuid;
        findService.findBusine.workFristName = workFristName;
        findService.findBusine.selectworkGuid = homeButton.guid;
        findService.findBusine.selectworkName = homeButton.titleLabel.text;
        return findService;
    }else{
        CeshiViewController* tishiView = [[CeshiViewController alloc]init];
        return tishiView;
    }
}
#pragma mark ----发布需求
-(UIViewController*)Click_pub_Requirements
{
    Ty_Pub_RequirementsVC* ty_pub_Requirements = [[Ty_Pub_RequirementsVC alloc]init];
    ty_pub_Requirements.title = @"发抢单";
    return ty_pub_Requirements;
}

#pragma mark ----登录
-(UIViewController*)Click_LoginVC
{
    My_LoginViewController* loginVC = [[My_LoginViewController alloc]init];
    return loginVC;
}
#pragma mark ----获取首页网络数据
-(void)getNetHomeButton
{
    NSMutableDictionary* dic = [[NSMutableDictionary alloc]init];
    [dic setObject:[NSString stringWithFormat:@"%@  %@",USERPROVINCE,USERCITY] forKey:@"city"];
    
    [[Ty_NetRequestService shareNetWork] formRequest:WorkTypeUrl andParameterDic:dic andTarget:self andSeletor:@selector(ReceiveHomeInfo: dic:)];
    dic = nil;
}
-(void)ReceiveHomeInfo:(NSString*)_isSuccess dic:(NSMutableDictionary* )_dic
{
    if ([_isSuccess isEqualToString:REQUESTSUCCESS]) {
        if ([[_dic objectForKey:@"code"] intValue] == 200) {
            if ([[_dic objectForKey:@"rows"] count]>0) {
                for (int i = 0; i<[[_dic objectForKey:@"rows"] count]; i++) {
                    
                    Ty_HomeMainObject * home = [[Ty_HomeMainObject alloc]init];
                    home.postCount = [[[_dic objectForKey:@"rows"] objectAtIndex:i] objectForKey:@"postCount"];
                    home.workGuid = [[[_dic objectForKey:@"rows"] objectAtIndex:i] objectForKey:@"workGuid"];
                    home.workName = [[[_dic objectForKey:@"rows"] objectAtIndex:i] objectForKey:@"workName"];
                    if (HomeButtonArray.count>i) {
                        [HomeButtonArray replaceObjectAtIndex:i withObject:home];
                    }else {
                        [HomeButtonArray addObject:home];
                    }
                    home = nil;
                    NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:@"数据",@"type",[[_dic objectForKey:@"code"] stringValue],@"code", nil];
                    PostNetDelegate(d,@"Ty_HomeVC");
                    d = nil;
                }
            }

        }else{
            [self getNetHomeButton];
        }
    }else if([_isSuccess isEqualToString:REQUESTFAIL]){
        NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:@"数据",@"type",REQUESTFAIL,@"code", nil];
        PostNetDelegate(d,@"Ty_HomeVC");
        [self getNetHomeButton];
        d = nil;
    }
    _dic = nil;
}
-(void)getNetBanner
{
    [[Ty_NetRequestService shareNetWork] request:Home_BannerUrl andTarget:self andSeletor:@selector(ReceiveHomeBanner:dic:)];
}
-(void)ReceiveHomeBanner:(NSString* )_isSuccess dic:(NSMutableDictionary*)_dic
{
    if ([_isSuccess isEqualToString:REQUESTSUCCESS]) {
        if ([[_dic objectForKey:@"code"] intValue] == 200) {
            if ([[_dic objectForKey:@"rows"] count]>0) {
                for (int i = 0; i<[[_dic objectForKey:@"rows"] count]; i++) {
                    Ty_HomeBannerObject* banner = [[Ty_HomeBannerObject alloc]init];
                    banner.selectUrl = [[[_dic objectForKey:@"rows"] objectAtIndex:i] objectForKey:@"acHttpUrl"];
                    banner.photoUrl = [[[_dic objectForKey:@"rows"] objectAtIndex:i] objectForKey:@"acPhoto"];
                    [bannerArr addObject:banner];
                    banner = nil;
                }
                NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:@"banner",@"type",[[_dic objectForKey:@"code"] stringValue],@"code", nil];
                PostNetDelegate(d,@"Ty_HomeVC");
                d = nil;
            }
        }else{
            [self getNetBanner];
        }
    }else if([_isSuccess isEqualToString:REQUESTFAIL]){
        [self getNetBanner];
        NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:@"banner",@"type",REQUESTFAIL,@"code", nil];
        PostNetDelegate(d,@"Ty_HomeVC");
        d = nil;
    }
    _dic = nil;
}

#pragma mark ----获取所有工种
-(void)queryWorkTree{
    
    NSMutableDictionary* dic = [[NSMutableDictionary alloc]init];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"queryWorkTree"] == nil) {
        [[Ty_NetRequestService shareNetWork] formRequest:Home_QueryWorkTree andParameterDic:nil andTarget:self andSeletor:@selector(GetQueryWorkTree: dic:)];
    }else{
        [dic setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"queryWorkTree"] forKey:@"workUpdateTime"];
        [[Ty_NetRequestService shareNetWork] formRequest:Home_QueryWorkTree andParameterDic:dic andTarget:self andSeletor:@selector(GetQueryWorkTree:dic:)];
    }
    dic = nil;
}
-(void)GetQueryWorkTree:(NSString*)_isSuccess dic:(NSMutableDictionary* )_dic
{
    if ([_isSuccess isEqualToString:REQUESTSUCCESS]) {
        if ([[_dic objectForKey:@"code"] intValue] == 200) {
            self.requestBool = NO;
            [[NSUserDefaults standardUserDefaults]setObject:[_dic objectForKey:@"rows"] forKey:@"MyAddWorkTree"];
            
            [[NSUserDefaults standardUserDefaults] setObject:[_dic objectForKey:@"updateTime"]  forKey:@"queryWorkTree"];
            
            NSArray* _dicArray = [_dic objectForKey:@"rows"];
            NSMutableArray* RosArray = [[NSMutableArray alloc]init];
            int count = [_dicArray count]/2;
            
            for (int i = 0; i<count; i++) {
                NSMutableArray * arr = [[NSMutableArray alloc]init];
                for (int j = 2*i; j <= 2*i+1; j++) {
                    [arr addObject:[_dicArray objectAtIndex:j]];
                }
                [RosArray addObject:arr];
                arr = nil;
            }
            if ([_dicArray count]%2 != 0) {
                NSMutableArray * arr = [[NSMutableArray alloc]init];
                [arr addObject:[_dicArray lastObject]];
                [RosArray addObject:arr];
                arr = nil;
            }
            [RosArray writeToFile:[self HomeButtonfileForPath] atomically:YES];
            RosArray = nil;
            [[_dic objectForKey:@"rows"] writeToFile:WorkTypefileForPath atomically:YES];
            
            [self writeWorkTypeExists];
            [self writeWorkTypeUnit];
        }else if([[_dic objectForKey:@"code"] intValue] == 203){
            self.requestBool = NO;
        }else if ([[_dic objectForKey:@"code"] intValue] == 205){
            self.requestBool = YES;
        }
        MainArray  = [[NSMutableArray alloc]initWithContentsOfFile:[self HomeButtonfileForPath]];
       
        workPlist = [[NSArray alloc]initWithContentsOfFile:WorkTypefileForPath];
        NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:@"工种",@"type",[[_dic objectForKey:@"code"] stringValue],@"code", nil];
        PostNetDelegate(d,@"Ty_HomeVC");
        d = nil;
        [self getNetBanner];
        [self getNetHomeButton];
    }else if([_isSuccess isEqualToString:REQUESTFAIL]){
        NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:@"工种",@"type",REQUESTFAIL,@"code", nil];
        PostNetDelegate(d,@"Ty_HomeVC");
        d = nil;
    }
    NumArray = [[NSMutableArray alloc]init];
    for (int i = 0; i<MainArray.count; i++) {
        [NumArray addObject:[NSString stringWithFormat:@"%d",i+1]];
    }
    _dic = nil;
}
#pragma mark ----获取开放工种写入plist
-(void)writeWorkTypeExists
{
    NSArray* workArray = [[NSArray alloc]initWithContentsOfFile:WorkTypefileForPath];
    NSMutableArray* workTypeExists = [[NSMutableArray alloc]init];
    for (int i = 0 ; i< [workArray count]; i++) {
        NSDictionary* workDic = [workArray objectAtIndex:i];
        NSMutableDictionary* workDictionary = [[NSMutableDictionary alloc]init];
        if ([[workDic objectForKey:@"exists"] isEqualToString:@"0"]) {
            NSArray* childrenWork = [workDic objectForKey:@"ChildrenWrok"];
            NSMutableArray* childrenworkArray = [[NSMutableArray alloc]init];
            for (int j = 0 ; j<[childrenWork count]; j++) {
                NSDictionary *childrenDic = [childrenWork objectAtIndex:j];
                if ([[childrenDic objectForKey:@"exists"] isEqualToString:@"0"]) {
                    [childrenworkArray addObject:childrenDic];
                }
            }
            [workDictionary setObject:childrenworkArray forKey:@"ChildrenWrok"];
            [workDictionary setObject:[workDic objectForKey:@"exists"] forKey:@"exists"];
            [workDictionary setObject:[workDic objectForKey:@"workGuid"] forKey:@"workGuid"];
            [workDictionary setObject:[workDic objectForKey:@"workName"] forKey:@"workName"];
            [workDictionary setObject:[workDic objectForKey:@"workPhoto"] forKey:@"workPhoto"];
            [workTypeExists addObject:workDictionary];
        }
    }
    [workTypeExists writeToFile:AddWorkTypefileForPath atomically:YES];
}
#pragma mark ----所有工种单位写入plist
-(void)writeWorkTypeUnit
{
    NSArray* workArray = [[NSArray alloc]initWithContentsOfFile:WorkTypefileForPath];
    NSMutableDictionary* workTypeUnit = [[NSMutableDictionary alloc]init];
    for (int i = 0 ; i< [workArray count]; i++) {
        NSDictionary* workDic = [workArray objectAtIndex:i];
        NSArray* childrenWork = [workDic objectForKey:@"ChildrenWrok"];
        for (int j = 0 ; j<[childrenWork count]; j++) {
            NSDictionary *childrenDic = [childrenWork objectAtIndex:j];
            [workTypeUnit setObject:[childrenDic objectForKey:@"unit"]forKey:[childrenDic objectForKey:@"workName"]];
        }
    }
    [workTypeUnit writeToFile: WorkUnitTypefileForPath atomically:YES];
}

#pragma mark ----homeButton布局plist路径
-(NSString*)HomeButtonfileForPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    //得到完整的文件名
    NSString *filename = [plistPath1 stringByAppendingPathComponent:@"HomeButton.plist"];
    return filename;
}


@end
