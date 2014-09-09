//
//  CustomLabel.h
//  腾云家务
//
//  Created by 齐 浩 on 13-9-23.
//  Copyright (c) 2013年 齐 浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomLabel : UILabel

@property (nonatomic,strong) UILabel *startLabel;
@property (nonatomic,strong) UILabel *centerLabel;
@property (nonatomic,strong) UILabel *endLabel;
@property (nonatomic,strong) NSString* text;

- (void)initWithStratString:(NSString *)_startSting startColor:(UIColor*)_startColor startFont:(UIFont*)_startFont centerString:(NSString *)_centerString centerColor:(UIColor*)_centerColor centerFont:(UIFont*)_centerFont endString:(NSString *)_endString endColor:(UIColor*)_endColor endFont:(UIFont* )_endFont;
-(void)setstartLabelFrame:(int)_i;
-(void)setTextAlignment:(NSTextAlignment)textAlignment;
-(void)setVerticalAlignment:(UIControlContentVerticalAlignment)textVerticalAlignment;

@end
