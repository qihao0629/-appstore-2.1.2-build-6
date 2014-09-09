//
//  PersonageNextViewController.h
//  腾云家务
//
//  Created by 艾飞 on 13-10-30.
//  Copyright (c) 2013年 齐 浩. All rights reserved.
//

#import "TYBaseView.h"

@interface PersonageNextViewController : TYBaseView<UITextFieldDelegate>
{
    UITextField * _textField;
}
@property (nonatomic,strong)NSString * strName;

@end
