//
//  Reserve_FootCell.m
//  腾云家务
//
//  Created by 齐 浩 on 14-4-23.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_Pub_ReqMemoCell.h"

@implementation Ty_Pub_ReqMemoCell
@synthesize memoLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setFrame:CGRectMake(0, 0, 300, 60)];
        
        [self.textLabel setTextColor:text_ReqColor];
        memoLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 270, 45)];
        memoLabel.lineBreakMode = NSLineBreakByCharWrapping;
        memoLabel.numberOfLines = 0;
        [memoLabel setBackgroundColor:[UIColor clearColor]];
        [memoLabel setTextColor:Color_orange];
        [memoLabel setFont:FONT14_BOLDSYSTEM];
        [memoLabel setTextAlignment:NSTextAlignmentLeft];
        
        [self.contentView addSubview:memoLabel];
    }
    return self;
}
- (void)setmemoHeight
{
    CGSize detailSize = [memoLabel.text sizeWithFont:FONT14_BOLDSYSTEM constrainedToSize:CGSizeMake(memoLabel.frame.size.width, memoLabel.frame.size.height) lineBreakMode:NSLineBreakByCharWrapping];
    [memoLabel setFrame:CGRectMake(memoLabel.frame.origin.x, memoLabel.frame.origin.y, detailSize.width, detailSize.height)];
    
    [self setFrame:CGRectMake(0, 0, 300, detailSize.height+20)];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
