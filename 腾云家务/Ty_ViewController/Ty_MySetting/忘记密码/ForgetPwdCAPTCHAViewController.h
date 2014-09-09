//
//  ForgetPwdCAPTCHAViewController.h
//  腾云家务
//
//  Created by 艾飞 on 13-11-29.
//  Copyright (c) 2013年 齐 浩. All rights reserved.
//

#import "TYBaseView.h"

@interface ForgetPwdCAPTCHAViewController : TYBaseView<UITextFieldDelegate>
{
    UITextField * _textField;
    UIButton * butAffiche;
    
    int timer_i;
}
@property (nonatomic,copy)NSString * str_phone;
@end
