//
//  CustomDatePicker.h
//  腾云家务
//
//  Created by 齐 浩 on 13-10-11.
//  Copyright (c) 2013年 齐 浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomDate.h"
@interface CustomDatePicker : UIActionSheet

//@property(nonatomic,retain)NSDateFormatter* dateformatter;
@property(strong, nonatomic) UILabel *titleLabel;
@property(strong, nonatomic) UIDatePicker *datePicker;
@property(strong, nonatomic) CustomDate *dateNow;
@property(strong,nonatomic) UIView* showView;

- (id)initWithTitle:(NSString *)title delegate:(id /*<UIActionSheetDelegate>*/)delegate;
-(void)setDatePickerMode:(UIDatePickerMode*)_datepickerMode;
-(void)cancel:(id)sender;
@end
