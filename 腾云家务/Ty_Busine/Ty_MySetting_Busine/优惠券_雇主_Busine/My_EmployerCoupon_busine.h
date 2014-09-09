//
//  My_EmployerCoupon_busine.h
//  腾云家务
//
//  Created by 艾飞 on 14/6/17.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//
//优惠券_雇主
#import <Foundation/Foundation.h>
#import "My_CouponDetailedModel.h"

@interface My_EmployerCoupon_busine : TY_BaseBusine
@property(nonatomic,strong)NSMutableArray * array_EmployeCoupon;//优惠券列表_雇主
/**优惠券列表*/
-(void)My_EmployerCouponReq_busine:(NSString *)ucState currentPage:(NSString *)currentPage;

/**优惠券详细*/
-(void)My_CouponDetailedReq_busineCouponGuid:(NSString *)couponGuid couponNo:(NSString *)couponNo ucState:(NSString *)ucState;
/**优惠券所有商户*/
-(void)My_CouponShopReq_busineCouponGuid:(NSString *)couponGuid currentPage:(NSString *)currentPage;

@property (nonatomic,strong)My_CouponDetailedModel * my_couponModel_req;
@end
