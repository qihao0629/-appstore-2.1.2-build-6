//
//  Ty_UseDetail_SelectTypeInfoCell.m
//  腾云家务
//
//  Created by 齐 浩 on 14-4-22.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_UseDetail_SelectTypeInfoCell.h"

@implementation Ty_UseDetail_SelectTypeInfoCell
@synthesize fristLabel,secondLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        fristLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 270, 15)];
        [fristLabel setTextColor:[UIColor grayColor]];
        [fristLabel setBackgroundColor:[UIColor clearColor]];
        [fristLabel setFont:FONT12_SYSTEM];
        
        secondLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, fristLabel.frame.origin.y+fristLabel.frame.size.height+10, 270, 15)];
        [secondLabel setTextColor:[UIColor grayColor]];
        [secondLabel setBackgroundColor:[UIColor clearColor]];
        [secondLabel setFont:FONT12_SYSTEM];
        
        [self.contentView addSubview:fristLabel];
        [self.contentView addSubview:secondLabel];
        
        [self setFrame:CGRectMake(0, 0, 300, 60)];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
