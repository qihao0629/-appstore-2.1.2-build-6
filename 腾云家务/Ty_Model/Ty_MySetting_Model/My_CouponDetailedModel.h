//
//  My_CouponDetailedModel.h
//  腾云家务
//
//  Created by 艾飞 on 14/6/18.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface My_CouponDetailedModel : NSObject
{
    My_CouponDetailedModel * copy;
}
/**优惠券列表*/
@property (nonatomic,strong)NSMutableArray * array_Coupon;
/**优惠券商户列表*/
@property (nonatomic,strong)NSMutableArray * array_CouponShop;

/**下单用到*/
@property (nonatomic,assign)BOOL selectBool;//是否选中

/**优惠券详细*/
//lgs加了，订单的guid，类型type 默认0，满多少pullprice
/**这条优惠券使用的订单的guid*/
@property (nonatomic,strong)NSString * couponRequiremnetGuid;

@property (nonatomic,strong)NSString * couponGuid;//优惠券Guid

@property (nonatomic,strong)NSString * couponType;//优惠券的类型

@property (nonatomic,strong)NSString * couponTitle;//优惠券标题

@property (nonatomic,strong)NSString * couponPhoto;//优惠券图片

@property (nonatomic,strong)NSString * couponDetail;//优惠券使用说明

@property (nonatomic,strong)NSString * couponNo;//优惠券序列号

@property (nonatomic,strong)NSString * ucEndTime;//优惠券有效期

@property (nonatomic,strong)NSString * ucUseTime;//优惠券使用日期

@property (nonatomic,strong)NSString  * suitWork;//优惠券适用工种

@property (nonatomic,strong)NSString * couponSuitWorkType;//优惠券使用工种type，1 全部

@property (nonatomic,strong)NSArray * suitCompany;//优惠券使用商家

@property (nonatomic,strong)NSString * couponSuitCompanyType;//优惠券适用商家 1 全部

@property (nonatomic,strong)NSString * couponPullPrice;//满多少

@property (nonatomic,strong)NSString * couponCutPrice;//抵消价格

@property (nonatomic,strong)NSMutableArray * suitWorkArray;//优惠券适用的工种数组

@end

