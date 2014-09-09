//
//  PersonageCell.m
//  腾云家务
//
//  Created by 艾飞 on 13-10-30.
//  Copyright (c) 2013年 齐 浩. All rights reserved.
//

#import "PersonageCell.h"

@implementation PersonageCell
@synthesize imageViewHead;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        imageViewHead = [[UIImageView alloc]initWithFrame:CGRectMake(222, 10, 65, 65)];
        if (!IOS7) {
            imageViewHead.frame = CGRectMake(212, 10, 65, 66);
        }
        [self.contentView addSubview:imageViewHead];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
