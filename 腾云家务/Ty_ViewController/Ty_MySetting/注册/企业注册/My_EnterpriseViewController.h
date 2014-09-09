//
//  My_EnterpriseViewController.h
//  腾云家务
//
//  Created by 艾飞 on 14-5-29.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "TYBaseView.h"

@interface My_EnterpriseViewController : TYBaseView<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{

    UITableView * _tableView;
}

@property (nonatomic,strong) NSString * userName;
@end
