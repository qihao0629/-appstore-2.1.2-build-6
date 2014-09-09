//
//  My_CouponShopViewController.h
//  腾云家务
//
//  Created by 艾飞 on 14/6/26.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "TYBaseView.h"
#import "My_CouponDetailedModel.h"
#import "RefreshView.h"

@interface My_CouponShopViewController : TYBaseView<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    My_CouponDetailedModel * my_ShopModel;
    
    BOOL isSingend;
    BOOL _isRefreshing;
    RefreshView *_refreshView;
    NSInteger reqint;

}
@property (nonatomic,strong)NSString * couponGuid;
@end
