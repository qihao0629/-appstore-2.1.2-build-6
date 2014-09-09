//
//  Ty_OrderVC_NewEM_QuoteCell.m
//  腾云家务
//
//  Created by lgs on 14-7-15.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_OrderVC_NewEM_QuoteCell.h"

@implementation Ty_OrderVC_NewEM_QuoteCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _lableName = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 70, 15)];
        _lableName.textAlignment = UITextAlignmentLeft;
        _lableName.backgroundColor = [UIColor clearColor];
        _lableName.font = [UIFont boldSystemFontOfSize:15.0f];
        [self.contentView addSubview:_lableName];
        
        _textContent = [[UITextField alloc]initWithFrame:CGRectMake(90, 12, 140, 20)];
        _textContent.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _textContent.autocorrectionType = UITextAutocorrectionTypeNo;
        _textContent.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _textContent.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
        _textContent.font = [UIFont systemFontOfSize:15.0];
        [self.contentView addSubview:_textContent];
        
        //显示价格
        _lableMoney = [[UILabel  alloc]initWithFrame:CGRectMake(235, 12, 60, 20)];
        _lableMoney.backgroundColor = [UIColor clearColor];
        _lableMoney.textAlignment = UITextAlignmentRight;
        _lableMoney.font = [UIFont systemFontOfSize:15.0f];
        _lableMoney.hidden = YES;
        _lableMoney.textColor = [UIColor colorWithRed:224.0/255.0 green:29.0/255.0 blue:31.0/255.0 alpha:1.0];
        [self.contentView addSubview:_lableMoney];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
