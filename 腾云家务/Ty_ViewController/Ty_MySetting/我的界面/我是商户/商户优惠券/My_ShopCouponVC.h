//
//  My_ShopCouponVC.h
//  腾云家务
//
//  Created by AF on 14-7-17.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "TYBaseView.h"

@interface My_ShopCouponVC : TYBaseView<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UITextField * _textCoupon;
    UITableView * _tableView;
    UIView * viewCouopn;
    UIButton * butLeft;
    UIButton * butRight;
}
@end
