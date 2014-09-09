//
//  My_personageTableViewCell.m
//  腾云家务
//
//  Created by 艾飞 on 14-6-3.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "My_personageTableViewCell.h"

@implementation My_personageTableViewCell
@synthesize text_right;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        text_right = [[UITextField alloc]initWithFrame:CGRectMake(80, 13, 190, 20)];
        if (IOS7) {
            text_right.frame = CGRectMake(80, 13, 210, 20);
        }
        [text_right setBorderStyle:UITextBorderStyleNone]; //外框类型
        //        text_right.background = [UIImage imageNamed:@"login_textfield.png"];
        //        text_right.placeholder = @" 请输入电话号码"; //默认显示的字
//        [text_right setEnabled: NO];
        text_right.backgroundColor = [UIColor clearColor];
        text_right.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        text_right.autocorrectionType = UITextAutocorrectionTypeNo;
        text_right.autocapitalizationType = UITextAutocapitalizationTypeNone;
        text_right.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
        text_right.textColor = [UIColor colorWithRed:150.0/255.0 green:150.0/255.0 blue:150.0/255.0 alpha:1.0];
        text_right.textAlignment = UITextAlignmentRight;
        text_right.text = @"";
        [self.contentView addSubview:text_right];
        
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
