//
//  My_CouponDetailedViewController.h
//  腾云家务
//
//  Created by 艾飞 on 14/6/18.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//
//优惠券详细
#import "TYBaseView.h"
#import "My_CouponDetailedModel.h"
@interface My_CouponDetailedViewController : TYBaseView<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    NSMutableDictionary * dic_coupon;
    UILabel * labelTextDetail;
}
@property (nonatomic,strong) My_CouponDetailedModel * my_coupon_model;

@property (nonatomic,strong)NSString * couponGuid;
@property (nonatomic,strong)NSString * couponNo;
@property (nonatomic,strong)NSString * ucState;

@property (nonatomic,strong) NSString * coupon_type;

@end
