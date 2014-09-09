//
//  My_AddEducationCell.m
//  腾云家务
//
//  Created by AF on 14-8-28.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "My_AddEducationCell.h"

@implementation My_AddEducationCell
@synthesize imageView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

    
        imageView = [[UIImageView alloc]init];
        imageView.frame = CGRectMake(280, 10, 22, 22);
        imageView.image = [UIImage imageNamed:@"checkPersonYes.png"];
        imageView.hidden = YES;
        [self.contentView addSubview:imageView];
    
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
