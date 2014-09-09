//
//  Ty_Pub_selectCouponBusine.m
//  腾云家务
//
//  Created by 齐 浩 on 14-8-12.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_Pub_selectCouponBusine.h"
@implementation Ty_Pub_selectCouponBusine
@synthesize serverObject;
@synthesize array_Coupon,my_coupon_model=_my_coupon_model,xuqiuInfo;
- (instancetype)init
{
    self = [super init];
    if (self) {
        _my_coupon_model = [[My_CouponDetailedModel alloc] init];
        array_Coupon = [[NSMutableArray alloc] init];
    }
    return self;
}
-(void)Pub_CouponRequest
{
    NSMutableDictionary* dic = [[NSMutableDictionary alloc]init];
    if (![serverObject.companiesGuid isEqualToString:@""] && serverObject.companiesGuid != nil) {
        [dic setObject:serverObject.companiesGuid forKey:@"detailGuid"];
    }
    [dic setObject:MyLoginUserGuid forKey:@"userGuid"];
    [dic setObject:xuqiuInfo.workGuid forKey:@"workGuid"];
    [[Ty_NetRequestService shareNetWork] formRequest:CouponSelectUrl andParameterDic:dic andTarget:self andSeletor:@selector(ReceiveCoupon:dic:)];
}
-(void)ReceiveCoupon:(NSString *)_isSuccess dic:(NSMutableDictionary *)_dic;
{
    if ([_isSuccess isEqualToString:REQUESTSUCCESS]) {
        if ([[_dic objectForKey:@"code"] intValue] == 200) {
            NSArray * rowsArray = [[NSArray alloc] initWithArray:[_dic objectForKey:@"rows"]];
            for (int i = 0; i < rowsArray.count; i++) {
                My_CouponDetailedModel * couponModel = [[My_CouponDetailedModel alloc] init];
                couponModel.ucEndTime = [rowsArray[i] objectForKey:@"ucEndTime"];
                couponModel.couponGuid = [rowsArray[i] objectForKey:@"couponGuid"];
                couponModel.couponPhoto = [rowsArray[i] objectForKey:@"couponPhoto"];
                couponModel.couponNo = [rowsArray[i] objectForKey:@"couponNo"];
                couponModel.couponTitle = [rowsArray[i] objectForKey:@"couponTitle"];
                couponModel.couponCutPrice = [rowsArray[i] objectForKey:@"couponCutPrice"];
                if ([couponModel.couponGuid isEqualToString:_my_coupon_model.couponGuid]) {
                    _my_coupon_model.selectBool = NO;
                    _my_coupon_model = couponModel;
                    _my_coupon_model.selectBool = YES;
                }
                [array_Coupon addObject:couponModel];
            }
            PostNetDelegate(@"200", @"Ty_Pub_selectCouponVC");
        }else if ([[_dic objectForKey:@"code"] intValue] == 203){
            PostNetDelegate(@"203", @"Ty_Pub_selectCouponVC");
        }else{
            PostNetDelegate(REQUESTFAIL, @"Ty_Pub_selectCouponVC");
        }
    }else{
        PostNetDelegate(REQUESTFAIL, @"Ty_Pub_selectCouponVC");
    }
}

@end
