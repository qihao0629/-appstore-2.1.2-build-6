//
//  My_EmployerCoupon_busine.m
//  腾云家务
//
//  Created by 艾飞 on 14/6/17.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "My_EmployerCoupon_busine.h"
#import "Ty_Model_WorkListInfo.h"
@implementation My_EmployerCoupon_busine
@synthesize array_EmployeCoupon;
@synthesize my_couponModel_req;
- (instancetype)init
{
    self = [super init];
    if (self) {

        array_EmployeCoupon = [[NSMutableArray  alloc]init];
    }
    return self;
}

#pragma mark - 优惠券_雇主
-(void)My_EmployerCouponReq_busine:(NSString *)ucState currentPage:(NSString *)currentPage{
    
    NSMutableDictionary * dic_req = [[NSMutableDictionary alloc]init];
    [dic_req setObject:MyLoginUserGuid forKey:@"userGuid"];
    [dic_req setObject:ucState forKey:@"ucState"];
    [dic_req setObject:pageSize_Req forKey:@"pageSize"];
    [dic_req setObject:currentPage forKey:@"currentPage"];

    [[Ty_NetRequestService shareNetWork]formRequest:My_EmployerCoupon_Req andParameterDic:dic_req andTarget:self andSeletor:@selector(RegisteredCode:reqDic:)];
    
}

-(void)RegisteredCode:(NSString *)reqCode reqDic:(NSDictionary*)_dic{
    
    if ([reqCode isEqualToString:REQUESTSUCCESS]) {
        
        if ([[_dic objectForKey:@"code"]intValue] == 200) {
            

            PostNetDelegate(_dic,@"MyCouponReq");
            
        }else{
            
            PostNetDelegate(_dic,@"MyCouponReq");
            
        }
        
    }else if([reqCode isEqualToString:REQUESTFAIL]){
        
        PostNetDelegate(reqCode,@"MyCouponReq");
        
    }
    
}

#pragma mark - 优惠券_详细信息
-(void)My_CouponDetailedReq_busineCouponGuid:(NSString *)couponGuid couponNo:(NSString *)couponNo ucState:(NSString *)ucState{

    NSMutableDictionary * dic_req = [[NSMutableDictionary alloc]init];
    [dic_req setObject:couponGuid forKey:@"couponGuid"];
    [dic_req setObject:couponNo forKey:@"couponNo"];
    [dic_req setObject:ucState forKey:@"ucState"];
    [dic_req setObject:MyLoginUserGuid forKey:@"userGuid"];

    [[Ty_NetRequestService shareNetWork]formRequest:My_CouponDetailed_Req andParameterDic:dic_req andTarget:self andSeletor:@selector(RegisteredDetailedCode:reqDic:)];
    
}

-(void)RegisteredDetailedCode:(NSString *)reqCode reqDic:(NSDictionary*)_dic{
    
    if ([reqCode isEqualToString:REQUESTSUCCESS]) {
        
        if ([[_dic objectForKey:@"code"]intValue] == 200) {
            
            my_couponModel_req.couponGuid = [[[_dic objectForKey:@"rows"] objectAtIndex:0]objectForKey:@"couponGuid"];
            my_couponModel_req.couponTitle = [[[_dic objectForKey:@"rows"] objectAtIndex:0] objectForKey:@"couponTitle"];
            my_couponModel_req.couponNo = [[[_dic objectForKey:@"rows"] objectAtIndex:0] objectForKey:@"couponNo"];
            my_couponModel_req.ucEndTime = [[[_dic objectForKey:@"rows"] objectAtIndex:0] objectForKey:@"ucEndTime"];
            my_couponModel_req.suitCompany = [[[_dic objectForKey:@"rows"] objectAtIndex:0] objectForKey:@"suitCompany"];
            my_couponModel_req.ucUseTime = [[[_dic objectForKey:@"rows"] objectAtIndex:0] objectForKey:@"ucUseTime"];
            my_couponModel_req.couponDetail = [[[_dic objectForKey:@"rows"] objectAtIndex:0] objectForKey:@"couponDetail"];
            my_couponModel_req.couponCutPrice = [[[_dic objectForKey:@"rows"] objectAtIndex:0] objectForKey:@"couponCutPrice"];
            my_couponModel_req.couponSuitCompanyType = [[[_dic objectForKey:@"rows"] objectAtIndex:0] objectForKey:@"couponSuitCompanyType"];
            my_couponModel_req.couponSuitWorkType = [[[_dic objectForKey:@"rows"] objectAtIndex:0] objectForKey:@"couponSuitWorkType"];

            for (int i = 0; i < [[[[_dic objectForKey:@"rows"] objectAtIndex:0] objectForKey:@"suitWork"] count]; i++) {
                if (ISNULLSTR(my_couponModel_req.suitWork)) {
                    my_couponModel_req.suitWork = [NSString stringWithFormat:@"%@",[[[[[_dic objectForKey:@"rows"] objectAtIndex:0] objectForKey:@"suitWork"] objectAtIndex:i] objectForKey:@"workName"]];
                }else{
                    my_couponModel_req.suitWork = [NSString stringWithFormat:@"%@/%@",my_couponModel_req.suitWork,[[[[[_dic objectForKey:@"rows"] objectAtIndex:0] objectForKey:@"suitWork"] objectAtIndex:i] objectForKey:@"workName"]];
                }
                Ty_Model_WorkListInfo * workList = [[Ty_Model_WorkListInfo alloc] init];
                workList.workGuid = [[[[[_dic objectForKey:@"rows"] objectAtIndex:0] objectForKey:@"suitWork"] objectAtIndex:i] objectForKey:@"workGuid"];
                workList.workName = [[[[[_dic objectForKey:@"rows"] objectAtIndex:0] objectForKey:@"suitWork"] objectAtIndex:i] objectForKey:@"workName"];
                [my_couponModel_req.suitWorkArray addObject:workList];
                workList = nil;

            }
            
            NSDictionary * dic_req = @{@"code":[_dic objectForKey:@"code"],
                                       };
            PostNetDelegate(dic_req,@"MyCouponDetaileReq");

        }else{
            
            PostNetDelegate(_dic,@"MyCouponDetaileReq");
            
        }
        
    }else if([reqCode isEqualToString:REQUESTFAIL]){
        
        PostNetDelegate(reqCode,@"MyCouponDetaileReq");
        
    }
    
}



#pragma mark - 优惠券——所有商户
-(void)My_CouponShopReq_busineCouponGuid:(NSString *)couponGuid currentPage:(NSString *)currentPage{
    
    NSMutableDictionary * dic_req = [[NSMutableDictionary alloc]init];
    [dic_req setObject:couponGuid forKey:@"couponGuid"];
    [dic_req setObject:pageSize_Req forKey:@"pageSize"];
    [dic_req setObject:currentPage forKey:@"currentPage"];
    
    [[Ty_NetRequestService shareNetWork]formRequest:My_CouponShopList_Req andParameterDic:dic_req andTarget:self andSeletor:@selector(MyCouponShopListCode:reqDic:)];
    
}

-(void)MyCouponShopListCode:(NSString *)reqCode reqDic:(NSDictionary*)_dic{
    
    if ([reqCode isEqualToString:REQUESTSUCCESS]) {
        
        if ([[_dic objectForKey:@"code"]intValue] == 200) {
            
            
            PostNetDelegate(_dic,@"MyCouponShopListReq");
            
        }else{
            PostNetDelegate(_dic,@"MyCouponShopListReq");
            
        }
        
    }else if([reqCode isEqualToString:REQUESTFAIL]){
        
        PostNetDelegate(reqCode,@"MyCouponShopListReq");
        
    }
    
}


@end
