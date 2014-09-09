//
//  My_EnteroriseCell.m
//  腾云家务
//
//  Created by 艾飞 on 14/7/1.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "My_EnteroriseCell.h"

@implementation My_EnteroriseCell
@synthesize _textField;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        _textField = [[UITextField alloc]initWithFrame:CGRectMake(80, 13, 210, 20)];
        [_textField setBorderStyle:UITextBorderStyleNone]; //外框类型
        _textField.backgroundColor = [UIColor clearColor];
        _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _textField.autocorrectionType = UITextAutocorrectionTypeNo;
        _textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
        _textField.textColor = [UIColor colorWithRed:150.0/255.0 green:150.0/255.0 blue:150.0/255.0 alpha:1.0];
        _textField.textAlignment = NSTextAlignmentRight;
        _textField.text = @"";
        [self.contentView addSubview:_textField];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
