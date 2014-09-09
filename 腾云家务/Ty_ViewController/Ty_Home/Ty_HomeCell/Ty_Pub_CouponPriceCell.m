//
//  Ty_Pub_CouponPriceCell.m
//  腾云家务
//
//  Created by 齐 浩 on 14-8-14.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_Pub_CouponPriceCell.h"

@implementation Ty_Pub_CouponPriceCell
@synthesize leftImageView;
@synthesize leftLabel;
@synthesize detailfristLabel;
@synthesize detailsecondLabel;
@synthesize lineView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setFrame:CGRectMake(0, 0, 300, 44)];
        self.leftImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xingxing"]];
        [self.leftImageView setFrame:CGRectMake(10, 18, 6, 7)];
        [self.leftImageView setBackgroundColor:[UIColor clearColor]];
        
        self.leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 64, 14)];
        [self.leftLabel setBackgroundColor:[UIColor clearColor]];
        [self.leftLabel setTextColor:text_ReqColor];
        [self.leftLabel setFont:FONT14_BOLDSYSTEM];
        [self.leftLabel setTextAlignment:NSTextAlignmentLeft];
        
        self.detailfristLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 6, 185, 14)];
        [self.detailfristLabel setBackgroundColor:[UIColor clearColor]];
        [self.detailfristLabel setTextColor:text_grayColor];
        [self.detailfristLabel setFont:FONT14_BOLDSYSTEM];
        [self.detailfristLabel setTextAlignment:NSTextAlignmentRight];
        
        self.detailsecondLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 22, 185, 14)];
        [self.detailsecondLabel setBackgroundColor:[UIColor clearColor]];
        [self.detailsecondLabel setTextColor:text_grayColor];
        [self.detailsecondLabel setFont:FONT14_BOLDSYSTEM];
        [self.detailsecondLabel setTextAlignment:NSTextAlignmentRight];
        
        [self.detailTextLabel setFont:FONT14_BOLDSYSTEM];
        
        self.lineView = [[UIView alloc]initWithFrame:CGRectMake(leftLabel.frame.origin.x + leftLabel.frame.size.width + 5, leftLabel.frame.origin.y, 1, 14)];
        [self.lineView setBackgroundColor:text_grayColor];
        
        [self.contentView addSubview:leftLabel];
        [self.contentView addSubview:detailfristLabel];
        [self.contentView addSubview:detailsecondLabel];
        [self.contentView addSubview:lineView];
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
