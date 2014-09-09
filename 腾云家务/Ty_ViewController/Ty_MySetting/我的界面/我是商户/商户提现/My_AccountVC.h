//
//  My_AccountVC.h
//  腾云家务
//
//  Created by liu on 14-7-1.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface My_AccountVC : TYBaseView<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
}

/**
 *  账户金额
 */
@property (nonatomic,strong) NSString *accountMoney;

@end
