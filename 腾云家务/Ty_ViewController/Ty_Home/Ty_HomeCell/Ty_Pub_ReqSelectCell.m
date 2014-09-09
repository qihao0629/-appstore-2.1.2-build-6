//
//  ReserveTextLeftCustomCell.m
//  腾云家务
//
//  Created by lgs on 14-1-14.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_Pub_ReqSelectCell.h"

@implementation Ty_Pub_ReqSelectCell
@synthesize leftImageView;
@synthesize leftLabel;
@synthesize detailLabel;
@synthesize lineView;
//#define TextGray [UIColor colorWithRed:166.0/255.0 green:166.0/255.0 blue:166.0/255.0 alpha:1]
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setFrame:CGRectMake(0, 0, 300, 44)];
        self.leftImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xingxing"]];
        [self.leftImageView setFrame:CGRectMake(10, 18, 6, 7)];
        [self.leftImageView setBackgroundColor:[UIColor clearColor]];
        
        self.leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 64, 14)];
        [self.leftLabel setBackgroundColor:[UIColor clearColor]];
        [self.leftLabel setTextColor:text_ReqColor];
        [self.leftLabel setFont:FONT14_BOLDSYSTEM];
        [self.leftLabel setTextAlignment:NSTextAlignmentLeft];
        
        self.detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 15, 170, 14)];
        self.detailLabel.lineBreakMode = NSLineBreakByCharWrapping;
        self.detailLabel.numberOfLines = 0;
        [self.detailLabel setBackgroundColor:[UIColor clearColor]];
        [self.detailLabel setTextColor:text_grayColor];
        [self.detailLabel setFont:FONT14_BOLDSYSTEM];
        [self.detailLabel setTextAlignment:NSTextAlignmentLeft];
        
        [self.detailTextLabel setFont:FONT14_BOLDSYSTEM];
        
        self.lineView = [[UIView alloc]initWithFrame:CGRectMake(leftLabel.frame.origin.x + leftLabel.frame.size.width + 5, leftLabel.frame.origin.y, 1, 14)];
        [self.lineView setBackgroundColor:text_grayColor];

        [self.contentView addSubview:leftLabel];
        [self.contentView addSubview:detailLabel];
        [self.contentView addSubview:lineView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected anismated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setHigh
{
    CGSize detailSize;
    detailSize = [self.detailLabel.text sizeWithFont:FONT14_BOLDSYSTEM constrainedToSize:CGSizeMake(detailLabel.frame.size.width, detailLabel.frame.size.height * 10) lineBreakMode:NSLineBreakByCharWrapping];
    [self.leftImageView setFrame:CGRectMake(leftImageView.frame.origin.x, (30+ detailSize.height)/2.0 - 4 , leftImageView.frame.size.width, leftImageView.frame.size.height)];
    [self.leftLabel setFrame:CGRectMake(leftLabel.frame.origin.x, (30 +detailSize.height)/2.0 - 7, leftLabel.frame.size.width, leftLabel.frame.size.height)];
    [self.lineView setFrame:CGRectMake(lineView.frame.origin.x, (30 + detailSize.height)/2.0 - 7, 1, 14)];
    [self.detailLabel setFrame:CGRectMake(detailLabel.frame.origin.x, detailLabel.frame.origin.y, 170, detailSize.height)];
    if (detailSize.height <=14)
    {
        [self setFrame:CGRectMake(0, 0, 300, 44)];
    }
    else
    {
        [self setFrame:CGRectMake(0, 0, 300, 30 + (int)detailSize.height)];
    }
    
}
@end
