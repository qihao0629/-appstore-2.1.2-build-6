//
//  Ty_HuodongTableViewCell.m
//  腾云家务
//
//  Created by Xu Zhao on 14-6-3.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_HuodongTableViewCell.h"

@implementation Ty_HuodongTableViewCell
@synthesize imageH,imageHV;
@synthesize labTitle;
@synthesize labTime;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.frame = CGRectMake(16, 16, 300, 120);
        
        imageH = [[UIImage alloc]init];
        imageHV=[[UIImageView alloc]initWithFrame:CGRectMake(6+4, 6, 278, 87)];
        //imageHV.contentMode =  UIViewContentModeCenter;
        [self.contentView addSubview:imageHV];
        
        labTitle = [[UILabel alloc]initWithFrame:CGRectMake(5, 95, 200, 30)];
        [labTitle setTextColor:[UIColor grayColor]];
        [labTitle setHighlightedTextColor:[UIColor whiteColor]];
        [labTitle setFont:FONT13_BOLDSYSTEM];
        [labTitle setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:labTitle];
        
        labTime = [[UILabel alloc]initWithFrame:CGRectMake(210, 95, 80, 30)];
        [labTime setTextColor:[UIColor grayColor]];
        [labTime setHighlightedTextColor:[UIColor whiteColor]];
        [labTime setFont:FONT14_BOLDSYSTEM];
        [labTime setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:labTime];
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
