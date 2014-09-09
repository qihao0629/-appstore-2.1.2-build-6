//
//  Ty_CustomDatePicker.h
//  腾云家务
//
//  Created by 齐 浩 on 14-7-23.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomDate.h"
@interface Ty_CustomDatePicker : UIActionSheet<UIPickerViewDataSource,UIPickerViewDelegate>
@property(strong, nonatomic) UILabel *titleLabel;
@property(strong, nonatomic) CustomDate *customDate;

- (id)initWithTitle:(NSString *)title delegate:(id /*<UIActionSheetDelegate>*/)delegate;


@end
