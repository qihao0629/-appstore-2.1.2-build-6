//
//  EmploymentNextViewController.h
//  腾云家务
//
//  Created by 艾飞 on 13-12-19.
//  Copyright (c) 2013年 齐 浩. All rights reserved.
//
//商户介绍描述
#import "TYBaseView.h"
@interface EmploymentNextViewController : TYBaseView<UITextViewDelegate>
{
    UITextView * _textView;

}

@property(nonatomic,copy)NSString * str_OtherInfo;
@end
