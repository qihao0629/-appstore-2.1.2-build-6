//
//  My_ShopinformationVC.h
//  腾云家务
//
//  Created by AF on 14-8-19.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//
//商户，用户基本信息
#import "TYBaseView.h"

@interface My_ShopinformationVC : TYBaseView<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UITableView * _tableView;
    UIImageView * imageHView;
    
    NSString * savePath;
}
@end
