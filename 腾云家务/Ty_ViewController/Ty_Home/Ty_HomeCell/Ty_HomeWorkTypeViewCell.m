//
//  HomeWorkTypeViewCell.m
//  腾云家务
//
//  Created by 齐 浩 on 14-4-28.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_HomeWorkTypeViewCell.h"

@implementation Ty_HomeWorkTypeViewCell
@synthesize homework;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        homework = [[Ty_HomeWorkTypeView alloc]init];
        
        [self.contentView addSubview:homework];
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
