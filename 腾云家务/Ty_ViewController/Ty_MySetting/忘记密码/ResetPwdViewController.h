//
//  ResetPwdViewController.h
//  腾云家务
//
//  Created by 艾飞 on 13-11-29.
//  Copyright (c) 2013年 齐 浩. All rights reserved.
//
//重置密码
#import "TYBaseView.h"

@interface ResetPwdViewController : TYBaseView<UITextFieldDelegate,UIAlertViewDelegate>
{
    UITextField * _textField_pwd;
    UITextField * _textField_pwds;
}
@property (nonatomic,retain)NSString * userPhone;
@end
