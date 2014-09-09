//
//  MyShopCell.m
//  腾云家务
//
//  Created by 艾飞 on 14-2-28.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "MyShopCell.h"

@implementation MyShopCell
@synthesize PerfImageView;
@synthesize imageShopHead;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        imageShopHead = [[UIImageView alloc]initWithFrame:CGRectMake(222, 10, 65, 65)];
//        if (!IOS7) {
//            imageShopHead.frame = CGRectMake(212, 10, 65, 66);
//        }
        imageShopHead.hidden = YES;
        [self.contentView addSubview:imageShopHead];

        
        _lableName = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 70, 15)];
        _lableName.textAlignment = NSTextAlignmentLeft;
        _lableName.backgroundColor = [UIColor clearColor];
        _lableName.font = [UIFont boldSystemFontOfSize:15.0f];
        [self.contentView addSubview:_lableName];
        
        _textContent = [[UITextField alloc]initWithFrame:CGRectMake(90, 12, 200, 20)];
        _textContent.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _textContent.autocorrectionType = UITextAutocorrectionTypeNo;
        _textContent.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _textContent.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
        _textContent.font = [UIFont systemFontOfSize:15.0];
        [self.contentView addSubview:_textContent];
        
        //显示价格
        _lableMoney = [[UILabel  alloc]initWithFrame:CGRectMake(205, 12, 60, 20)];
        _lableMoney.backgroundColor = [UIColor clearColor];
        _lableMoney.textAlignment = NSTextAlignmentRight;
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
