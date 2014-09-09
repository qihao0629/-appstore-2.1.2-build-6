//
//  My_ShopInformationViewController.h
//  腾云家务
//
//  Created by 艾飞 on 14/7/1.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//
//我的商户信息
#import "TYBaseView.h"

@interface My_ShopInformationViewController : TYBaseView<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIButton * but_add_ok;
    UITableView * _tableView;
}

@property (nonatomic,strong) NSString *  checkState;
@end
