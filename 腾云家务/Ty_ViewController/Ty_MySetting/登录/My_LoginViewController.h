//
//  My_LoginViewController.h
//  腾云家务
//
//  Created by 艾飞 on 14-5-28.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface My_LoginViewController : TYBaseView<UITextFieldDelegate>
{
    UITableView * _tableView;
    UITextField * _textFieldUser;
    
    UITextField * _textFieldPwd;
    UIButton * button_login;
}
@property(nonatomic,strong)NSString * loginType;
@end
