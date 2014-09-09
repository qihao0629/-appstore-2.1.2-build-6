//
//  ModifyPwdViewController.h
//  腾云家务
//
//  Created by 艾飞 on 13-11-28.
//  Copyright (c) 2013年 齐 浩. All rights reserved.
//
//修改密码
#import "TYBaseView.h"

@interface ModifyPwdViewController : TYBaseView< UITextFieldDelegate,UIAlertViewDelegate>

{
    UITextField * _textField_pwd;
    UITextField * _textField_Newpwd;
    UITextField * _textField_Newpwds;

}
@end
