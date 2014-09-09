//
//  RightTextFieldCell.m
//  腾云家务
//
//  Created by lgs on 14-1-14.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_Pub_ReqRightTextCell.h"

@implementation Ty_Pub_ReqRightTextCell
@synthesize leftImageView;
@synthesize leftLabel;
@synthesize detailTextField;
@synthesize lineView;
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
        
        self.detailTextField = [[UITextField alloc]initWithFrame:CGRectMake(100, 13, 170, 17)];
        [self.detailTextField setBackgroundColor:[UIColor clearColor]];
        [self.detailTextField setTextColor:text_blackColor];
        [self.detailTextField setText:@""];
        [self.detailTextField setFont:FONT14_BOLDSYSTEM];
        [self.detailTextField setTextAlignment:NSTextAlignmentLeft];
        
        self.lineView = [[UIView alloc]initWithFrame:CGRectMake(leftLabel.frame.origin.x + leftLabel.frame.size.width + 5, leftLabel.frame.origin.y, 1, 14)];
        [self.lineView setBackgroundColor:text_grayColor];
        
        [self.contentView addSubview:leftLabel];
        [self.contentView addSubview:detailTextField];
        [self.contentView addSubview:lineView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected anismated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
