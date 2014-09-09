//
//  CinCell.m
//  腾云家务
//
//  Created by 齐 浩 on 13-11-14.
//  Copyright (c) 2013年 齐 浩. All rights reserved.
//

#import "Ty_Pub_ReqCinCell.h"

@implementation Ty_Pub_ReqCinCell
@synthesize textfield;
@synthesize lineView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        // Initialization code
        
        [self.textLabel setBackgroundColor:[UIColor clearColor]];
        [self.textLabel setTextColor:text_ReqColor];
        [self.detailTextLabel setTextColor:text_grayColor];
        [self.detailTextLabel setFont:FONT14_BOLDSYSTEM];
        
//        detailLabel=[[UILabel alloc]initWithFrame:CGRectMake(190, 0, 110, 44)];
//        [detailLabel setBackgroundColor:[UIColor clearColor]];
//        [detailLabel setFont:FONT14_BOLDSYSTEM];
//        [detailLabel setTextAlignment:NSTextAlignmentLeft];
//        [detailLabel setTextColor:text_grayColor];
        
        
        textfield = [[UITextField alloc]initWithFrame:CGRectMake(100, 5, 90, 34)];
        [textfield setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [textfield setText:@""];
        [textfield setTextAlignment:NSTextAlignmentLeft];
        [textfield setTextColor:text_blackColor];
        [textfield setFont:FONT14_BOLDSYSTEM];
        self.lineView = [[UIView alloc]initWithFrame:CGRectMake(84, 15, 1, 14)];
        [self.lineView setBackgroundColor:text_grayColor];

        
        [self.contentView addSubview:textfield];
        [self.contentView addSubview:lineView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
