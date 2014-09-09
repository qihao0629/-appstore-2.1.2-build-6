//
//  My_ShopCoupon_busine.h
//  腾云家务
//
//  Created by AF on 14-7-17.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "My_CouponDetailedModel.h"
@interface My_ShopCoupon_busine : TY_BaseBusine
{
    NSMutableArray * array_ShopCoupon;
}
@property (nonatomic,strong)My_CouponDetailedModel * my_shopCoupon_model;

/**收到的商户列表*/
-(void)My_shopCouponListCurrentPage:(NSString *)currentPage ;


@end
