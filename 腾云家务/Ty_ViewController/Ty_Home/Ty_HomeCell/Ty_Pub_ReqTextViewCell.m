//
//  Ty_Pub_ReqTextViewCell.m
//  腾云家务
//
//  Created by 齐 浩 on 14-7-25.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_Pub_ReqTextViewCell.h"

@implementation Ty_Pub_ReqTextViewCell
@synthesize leftImageView;
@synthesize leftLabel;
@synthesize detailTextView;
@synthesize lineView;
@synthesize helpLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setFrame:CGRectMake(0, 0, 300, 52)];
        self.leftImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xingxing"]];
        [self.leftImageView setFrame:CGRectMake(10, 18, 6, 7)];
        [self.leftImageView setBackgroundColor:[UIColor clearColor]];
        
        self.leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 19, 64, 14)];
        [self.leftLabel setBackgroundColor:[UIColor clearColor]];
        [self.leftLabel setTextColor:text_ReqColor];
        [self.leftLabel setFont:FONT14_BOLDSYSTEM];
        [self.leftLabel setTextAlignment:NSTextAlignmentLeft];
        
        self.detailTextView = [[UITextView alloc]initWithFrame:CGRectMake(95, 10, 190, 32)];
        [self.detailTextView setBackgroundColor:[UIColor clearColor]];
        [self.detailTextView setTextColor:text_blackColor];
        [self.detailTextView setText:@""];
        [self.detailTextView setFont:FONT14_BOLDSYSTEM];
        [self.detailTextView setTextAlignment:NSTextAlignmentLeft];
        
        helpLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, detailTextView.frame.size.width-10, 32)];
        [helpLabel setBackgroundColor:[UIColor clearColor]];
        [helpLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [helpLabel setNumberOfLines:0];
        [helpLabel setTextColor:text_morenGrayColor];
        [helpLabel setTag:1000];
        [helpLabel setFont:FONT14_BOLDSYSTEM];
        
        [detailTextView addSubview:helpLabel];
        
        self.lineView = [[UIView alloc]initWithFrame:CGRectMake(leftLabel.frame.origin.x + leftLabel.frame.size.width + 5, leftLabel.frame.origin.y, 1, 14)];
        [self.lineView setBackgroundColor:text_grayColor];
        
        [self.contentView addSubview:leftLabel];
        [self.contentView addSubview:detailTextView];
        [self.contentView addSubview:lineView];

    }
    return self;
}
-(void)setHeight
{
    CGSize textViewSize = [detailTextView.text sizeWithFont:FONT14_BOLDSYSTEM constrainedToSize:CGSizeMake(detailTextView.frame.size.width, detailTextView.frame.size.height*5) lineBreakMode:NSLineBreakByCharWrapping];
    
    if (textViewSize.height > detailTextView.frame.size.height) {
        [detailTextView setFrame:CGRectMake(detailTextView.frame.origin.x, detailTextView.frame.origin.y, detailTextView.frame.size.width, textViewSize.height+10)];
        [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, detailTextView.frame.size.height+20)];
    }

}
//-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
//{
//    if ([UIMenuController sharedMenuController]) {
//        [UIMenuController sharedMenuController].menuVisible = NO;
//    }
//    return NO;
//}

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
