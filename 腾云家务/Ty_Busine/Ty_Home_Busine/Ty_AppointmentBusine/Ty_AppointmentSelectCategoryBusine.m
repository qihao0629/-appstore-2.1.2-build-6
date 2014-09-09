//
//  Ty_AppointmentSelectCategoryBusine.m
//  腾云家务
//
//  Created by 齐 浩 on 14-7-5.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_AppointmentSelectCategoryBusine.h"
#import "Ty_Model_WorkListInfo.h"
@implementation Ty_AppointmentSelectCategoryBusine
@synthesize xuqiuInfo,userService;
@synthesize workPlist,arrContent,arrContent2;
@synthesize home_user_detailType;

- (instancetype)init
{
    self = [super init];
    if (self) {
        userService = [[Ty_Model_ServiceObject alloc]init];
        xuqiuInfo = [[Ty_Model_XuQiuInfo alloc]init];
        home_user_detailType = Ty_Home_UserDetailTypeDefault;
        workPlist = [[NSMutableArray alloc]init];
        arrContent = [[NSMutableArray alloc]init];
        arrContent2 = [[NSMutableArray alloc]init];
    }
    return self;
}
-(void)sendCategory
{
    NSMutableDictionary* dic = [[NSMutableDictionary alloc]init];
    if (xuqiuInfo.selectUserArray.count>0) {
        [dic setObject:[xuqiuInfo.selectUserArray[0] userGuid] forKey:@"userGuid"];
    }else{
        if ([userService.userType isEqualToString:@"0"]) {
            [dic setObject:userService.companiesGuid forKey:@"userGuid"];
        }else{
            [dic setObject:userService.userGuid forKey:@"userGuid"];
        }
    }
    [[Ty_NetRequestService shareNetWork]formRequest:AddRequirementWorkTypeUrl andParameterDic:dic andTarget:self andSeletor:@selector(ReceiveCategory:dic:)];
}
-(void)ReceiveCategory:(NSString*)_isSuccess dic:(NSMutableDictionary*)_dic
{
    if ([_isSuccess isEqualToString:REQUESTSUCCESS]) {
        if ([[_dic objectForKey:@"code"] intValue] == 200) {
            
            
            
            if (home_user_detailType == Ty_Home_UserDetailTypeCoupon && ![xuqiuInfo.usedCouponInfo.couponSuitWorkType isEqualToString:@"1"]) {
                NSMutableArray * mainArray = [[NSMutableArray alloc] init];//记录总得工种
                for (int i = 0; i< [[_dic objectForKey:@"rows"] count]; i++) {
                    NSMutableDictionary * mainDic = [[NSMutableDictionary alloc] init]; //子工种字典
                    [mainDic setObject:[[[_dic objectForKey:@"rows"] objectAtIndex:i] objectForKey:@"workGuid"] forKey:@"workGuid"];
                    [mainDic setObject:[[[_dic objectForKey:@"rows"] objectAtIndex:i] objectForKey:@"workName"] forKey:@"workName"];
                    
                    NSMutableArray * childArray = [[NSMutableArray alloc] init];
                    
                    for (int j = 0; j<[[[[_dic objectForKey:@"rows"] objectAtIndex:i] objectForKey:@"ChildrenWork"] count]; j++) {
                        for (int k = 0; k<[xuqiuInfo.usedCouponInfo.suitWorkArray count]; k++) {
                            if ([[[[[[_dic objectForKey:@"rows"] objectAtIndex:i]objectForKey:@"ChildrenWork"] objectAtIndex:j] objectForKey:@"workGuid"] isEqualToString:[xuqiuInfo.usedCouponInfo.suitWorkArray[k] workGuid]]) {
                                NSMutableDictionary * childDic = [[NSMutableDictionary alloc] init];
                                [childDic setObject:[[[[[_dic objectForKey:@"rows"] objectAtIndex:i]objectForKey:@"ChildrenWork"] objectAtIndex:j] objectForKey:@"workGuid"] forKey:@"workGuid"];
                                [childDic setObject:[[[[[_dic objectForKey:@"rows"] objectAtIndex:i]objectForKey:@"ChildrenWork"] objectAtIndex:j] objectForKey:@"workName"] forKey:@"workName"];
                                [childDic setObject:[[[[[_dic objectForKey:@"rows"] objectAtIndex:i]objectForKey:@"ChildrenWork"] objectAtIndex:j] objectForKey:@"postSalary"] forKey:@"postSalary"];
                                [childArray addObject:childDic];
                            }
                        }
                    }
                    if (childArray.count>0) {
                        [mainDic setObject:childArray forKey:@"ChildrenWork"];
                        [mainArray addObject:mainDic];
                    }
                }
                [workPlist setArray:mainArray];
            }else{
                [workPlist setArray:[_dic objectForKey:@"rows"]];
            }
            if ([workPlist count]>0) {
                for (int i = 0 ; i<[workPlist count]; i++) {
                    Ty_Model_WorkListInfo* workType = [[Ty_Model_WorkListInfo alloc]init];
                    workType.workGuid = [[workPlist objectAtIndex:i] objectForKey:@"workGuid"];
                    workType.workName = [[workPlist objectAtIndex:i] objectForKey:@"workName"];
                    [arrContent addObject:workType];
                }
                arrContent2 = [[workPlist objectAtIndex:0] objectForKey:@"ChildrenWork"];
                NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:@"200",@"code",nil];
                PostNetDelegate(d,@"Ty_AppointmentSelectCategoryVC");
            }else{
                NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:@"203",@"code",nil];
                PostNetDelegate(d,@"Ty_AppointmentSelectCategoryVC");
            }
           
        }else if([[_dic objectForKey:@"code"] intValue] == 203){
            
        }
    }else{
        NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:REQUESTFAIL,@"code",nil];
        PostNetDelegate(d,@"Ty_AppointmentSelectCategoryVC");
    }
}
@end
