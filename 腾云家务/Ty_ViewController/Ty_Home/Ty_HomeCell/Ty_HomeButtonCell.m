//
//  HomeButtonCell.m
//  腾云家务
//
//  Created by 齐 浩 on 14-1-14.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_HomeButtonCell.h"

@implementation Ty_HomeButtonCell
@synthesize leftpartButton,rightpartButton;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setBackgroundColor:view_BackGroudColor];
        
        leftpartButton = [[Home_Button alloc]initWithFrame:CGRectMake(0,0,160,73)];
        [leftpartButton.workTypeLabel setTextColor:[UIColor blackColor]];
        
        rightpartButton = [[Home_Button alloc]initWithFrame:CGRectMake(160,0,160,73)];
        [rightpartButton.workTypeLabel setTextColor:[UIColor blackColor]];
        
        [self.contentView addSubview:leftpartButton];
        [self.contentView addSubview:rightpartButton];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
