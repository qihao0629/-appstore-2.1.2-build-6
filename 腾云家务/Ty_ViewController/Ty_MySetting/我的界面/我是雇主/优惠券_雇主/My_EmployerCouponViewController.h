//
//  My_EmployerCouponViewController.h
//  腾云家务
//
//  Created by 艾飞 on 14/6/16.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//
//优惠券_雇主
#import "Ty_BaseLoading.h"
#import "My_CouponDetailedModel.h"
#import "RefreshView.h"
@interface My_EmployerCouponViewController : TYBaseView<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    NSMutableArray * array_coupon;
    int but_select;
    
    BOOL isSingend;
    BOOL _isRefreshing;
    RefreshView *_refreshView;
    NSInteger reqint;

}
@property (nonatomic,strong) My_CouponDetailedModel * my_coupon_model;
@end
