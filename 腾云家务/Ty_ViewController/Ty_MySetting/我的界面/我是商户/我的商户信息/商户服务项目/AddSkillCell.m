//
//  AddSkillCell.m
//  腾云家务
//
//  Created by 艾飞 on 14-3-10.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "AddSkillCell.h"

@implementation AddSkillCell
@synthesize lableMoney;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code==
        
        lableMoney = [[UILabel alloc]initWithFrame:CGRectMake(90, 20, 200, 20)];
        lableMoney.font = [UIFont systemFontOfSize:15.0f];
        lableMoney.backgroundColor = [UIColor clearColor];
        lableMoney.textAlignment = NSTextAlignmentRight;
        lableMoney.textColor = [UIColor colorWithRed:224.0/255.0 green:29.0/255.0 blue:31.0/255.0 alpha:1.0];
        [self.contentView addSubview:lableMoney];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
