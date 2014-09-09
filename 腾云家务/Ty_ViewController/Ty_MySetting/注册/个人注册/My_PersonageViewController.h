//
//  My_PersonageViewController.h
//  腾云家务
//
//  Created by 艾飞 on 14-5-29.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "TYBaseView.h"

@interface My_PersonageViewController : TYBaseView<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UITextFieldDelegate>
{

    UITableView * _tableView;
    NSString * userSex_action;
}
@property (nonatomic,strong) NSString * userRealName;
@property (nonatomic,strong) NSString * userPhone;

@end
