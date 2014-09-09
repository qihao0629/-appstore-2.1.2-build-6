//
//  Ty_userDetail_defaultCell.m
//  腾云家务
//
//  Created by 齐 浩 on 14-4-22.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_userDetail_defaultCell.h"

@implementation Ty_userDetail_defaultCell
@synthesize priceLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        [self setFrame:CGRectMake(0, 0, 300, 33)];
        // Initialization code
        [self.textLabel setFont:FONT14_SYSTEM];
        [self.textLabel setTextColor:text_grayColor];
        priceLabel = [[CustomLabel alloc]initWithFrame:CGRectMake(70, 0, 215, 23)];
        [self.contentView addSubview: priceLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
