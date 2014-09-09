//
//  My_RegisteredViewController.h
//  腾云家务
//
//  Created by 艾飞 on 14-5-29.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "TYBaseView.h"
#import "Ty_Home_SelectCityVC.h"
@interface My_RegisteredViewController : TYBaseView<UITextFieldDelegate,Ty_Home_SelectCityVCDelegate>
{
    UITextField * _textField;
    UITextField * _textFieldyq;
    UITextField * _textPwd;
    UIButton * button;
    UIButton * butAffiche;
    
    Ty_Home_SelectCityVC* selectCity;
    
    UILabel * labelLocationText;
    UIButton * buttonLocation;
    NSString * regCity;
}
@property(nonatomic,strong)NSString * userType;

@end
