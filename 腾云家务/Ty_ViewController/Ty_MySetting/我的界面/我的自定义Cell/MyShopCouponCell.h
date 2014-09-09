//
//  MyShopCouponCell.h
//  腾云家务
//
//  Created by AF on 14-8-5.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//
//商户优惠券cell
#import <UIKit/UIKit.h>

@interface MyShopCouponCell : UITableViewCell
/**序列号*/
@property (nonatomic, strong) UILabel * labelNumber;
/**适用工种*/
@property (nonatomic, strong) UILabel * labelWork;
/**适用工种text*/
@property (nonatomic, strong) UILabel * labelWorkText;
/**使用条件*/
@property (nonatomic, strong) UILabel * labelConditions;
/**使用人*/
@property (nonatomic, strong) UILabel * labelUser;
/**价值*/
@property (nonatomic, strong) UILabel * labelMoney;
/**价值text*/
@property (nonatomic, strong) UILabel * labelMoneyText;


@end
