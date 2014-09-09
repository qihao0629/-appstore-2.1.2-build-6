//
//  MyAddServicesCell.m
//  腾云家务
//
//  Created by 艾飞 on 14-4-18.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "MyAddServicesCell.h"

@implementation MyAddServicesCell
@synthesize PerfImageView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _lableName = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 70, 15)];
        _lableName.textAlignment = UITextAlignmentLeft;
        _lableName.backgroundColor = [UIColor clearColor];
        _lableName.font = [UIFont boldSystemFontOfSize:15.0f];
        [self.contentView addSubview:_lableName];
        
        _textContent = [[UITextField alloc]initWithFrame:CGRectMake(90, 12, 190, 20)];
        _textContent.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _textContent.autocorrectionType = UITextAutocorrectionTypeNo;
        _textContent.autocapitalizationType = UITextAutocapitalizationTypeNone;
//        _textContent.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
        _textContent.font = [UIFont systemFontOfSize:15.0];
        [self.contentView addSubview:_textContent];
        
        _lablexian = [[UILabel alloc]initWithFrame:CGRectMake(150, 15, 20, 15)];
        _lablexian.textAlignment = UITextAlignmentCenter;
        _lablexian.backgroundColor = [UIColor clearColor];
        _lablexian.text = @"一";
        _lablexian.hidden = YES;
        _lablexian.font = [UIFont systemFontOfSize:15.0f];
        [self.contentView addSubview:_lablexian];
        
        
        _textContentMax = [[UITextField alloc]initWithFrame:CGRectMake(170, 12, 60, 20)];
        _textContentMax.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _textContentMax.autocorrectionType = UITextAutocorrectionTypeNo;
        _textContentMax.autocapitalizationType = UITextAutocapitalizationTypeNone;
//        _textContentMax.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
        _textContentMax.font = [UIFont systemFontOfSize:15.0];
        _textContentMax.hidden = YES;
        _textContentMax.textAlignment = UITextAlignmentCenter;
        [self.contentView addSubview:_textContentMax];
        
        
        //显示价格
        _lableMoney = [[UILabel  alloc]initWithFrame:CGRectMake(225, 12, 60, 20)];
        _lableMoney.backgroundColor = [UIColor clearColor];
        _lableMoney.textAlignment = UITextAlignmentRight;
        _lableMoney.font = [UIFont systemFontOfSize:15.0f];
        _lableMoney.hidden = YES;
        _lableMoney.textColor = [UIColor colorWithRed:224.0/255.0 green:29.0/255.0 blue:31.0/255.0 alpha:1.0];
        [self.contentView addSubview:_lableMoney];
        
        
        PerfImageView = [[UIImageView alloc]initWithFrame:CGRectMake(217, 6, 50, 32)];
        PerfImageView.hidden = YES;
        if (!IOS7) {
            PerfImageView.frame = CGRectMake(207, 6, 50, 32);
        }
        [self.contentView addSubview:PerfImageView];

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
