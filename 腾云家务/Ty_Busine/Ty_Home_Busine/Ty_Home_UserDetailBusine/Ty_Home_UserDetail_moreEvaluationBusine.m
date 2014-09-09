//
//  Ty_Home_UserDetail_moreEvaluationBusine.m
//  腾云家务
//
//  Created by 齐 浩 on 14-6-23.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_Home_UserDetail_moreEvaluationBusine.h"

@implementation Ty_Home_UserDetail_moreEvaluationBusine
@synthesize userService,currentPage,_isRefreshing;
- (instancetype)init
{
    self = [super init];
    if (self) {
        userService = [[Ty_Model_ServiceObject alloc]init];
        currentPage = 1;
    }
    return self;
}
-(void)loadEvaluationData
{
    NSMutableDictionary* dic;
    if ([userService.userType isEqualToString:@"0"]) {
        dic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:userService.companiesGuid,@"userGuid",pageSize_Req,@"pageSize",[NSString stringWithFormat:@"%d",currentPage],@"currentPage",nil];
    }else{
        dic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:userService.userGuid,@"userGuid",pageSize_Req,@"pageSize",[NSString stringWithFormat:@"%d",currentPage],@"currentPage",nil];
    }
    [[Ty_NetRequestService shareNetWork] formRequest:Ty_UserDetail_EvaluateUrl andParameterDic:dic andTarget:self andSeletor:@selector(ReceiveEvaluations:dic:)];
}
#pragma mark ----历史评价信息联网获取回调
-(void)ReceiveEvaluations:(NSString*)_isSuccess dic:(NSMutableDictionary* )_dic
{
    if ([_isSuccess isEqualToString:REQUESTSUCCESS]) {
        if ([[_dic objectForKey:@"code"]intValue] == 200) {
            currentPage++;
            for (int i = 0; i<[[_dic objectForKey:@"rows"] count]; i++) {
                NSDictionary* dic = [[NSDictionary alloc]init];
                dic = [[_dic objectForKey:@"rows"] objectAtIndex:i];
                
                Ty_Model_ServiceObject* evaluate = [[Ty_Model_ServiceObject alloc]init];
                evaluate.headPhoto = [dic objectForKey:@"userPhoto"];
                evaluate.evaluate = [dic objectForKey:@"userEvaluateMaster"];
                evaluate.quality = [dic objectForKey:@"evaluateServeQuality"];
                evaluate.attitude = [dic objectForKey:@"evaluateServeAttitude"];
                evaluate.speedStr = [dic objectForKey:@"evaluateServeSpeed"];
                evaluate.pingjiaString = [dic objectForKey:@"evaluateForEmployeeOther"];
                [userService.evaluationArray addObject:evaluate];
            }
            NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:@"200",@"code",@"评价信息",@"type",nil];
            PostNetDelegate(d,@"Ty_Home_UserDetail_moreEvaluationVC");
        }else if ([[_dic objectForKey:@"code"]intValue] == 203){
            NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:@"203",@"code",@"评价信息",@"type",nil];
            PostNetDelegate(d,@"Ty_Home_UserDetail_moreEvaluationVC");
        }else{
            NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:REQUESTFAIL,@"code",@"评价信息",@"type",nil];
            PostNetDelegate(d,@"Ty_Home_UserDetail_moreEvaluationVC");
        }
        
    }else{
        NSDictionary*d = [[NSDictionary alloc]initWithObjectsAndKeys:REQUESTFAIL,@"code",@"评价信息",@"type",nil];
        PostNetDelegate(d,@"Ty_Home_UserDetail_moreEvaluationVC");

    }
}
@end
