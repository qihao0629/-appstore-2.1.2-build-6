//
//  My_EmployerTableViewCell.m
//  腾云家务
//
//  Created by 艾飞 on 14/6/9.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "My_EmployerTableViewCell.h"

@implementation My_EmployerTableViewCell
@synthesize button_have,button_wait;
@synthesize viewxian;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        button_wait = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button_wait.frame = CGRectMake(0, 0, 160, 70);
        if (!IOS7) {
            button_wait.frame = CGRectMake(0, 0, 150, 70);
            
        }
        [button_wait setBackgroundImage:JWImageName(@"i_setupqiangdan") forState:UIControlStateNormal];
        [button_wait setBackgroundImage:JWImageName(@"i_setupqiangdanclick") forState:UIControlStateHighlighted];
        button_wait.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
        button_wait.titleLabel.textColor = [UIColor colorWithRed:73.0/255.0 green:73.0/255.0 blue:73.0/255.0 alpha:1.0f];
        button_wait.titleEdgeInsets = UIEdgeInsetsMake(35, 0, 0, 0);
        [button_wait setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button_wait.hidden = YES;
        [self.contentView addSubview:button_wait];
        
        
        //竖线
        viewxian = [[UIView alloc]initWithFrame:CGRectMake(160, 5, 1, 60)];
        if (!IOS7) {
            viewxian.frame = CGRectMake(150, 5, 1, 60);
            
        }
        viewxian.hidden = YES;
        viewxian.backgroundColor = [UIColor colorWithRed:219.0/255.0 green:219.0/255.0 blue:219.0/255.0 alpha:1.0];
        [self.contentView addSubview:viewxian];
        
        
        //有应征的需求的button
        button_have = [UIButton buttonWithType:UIButtonTypeCustom];
        button_have.frame = CGRectMake(160, 0, 160, 70);
        if (!IOS7) {
            button_have.frame = CGRectMake(150, 0, 150, 70);
            
        }
        
        [button_have setBackgroundImage:JWImageName(@"i_setupyuyue") forState:UIControlStateNormal];
        [button_have setBackgroundImage:JWImageName(@"i_setupyuyueclick") forState:UIControlStateHighlighted];
        button_have.hidden = YES;
        button_have.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
        button_have.titleLabel.textColor = [UIColor colorWithRed:73.0/255.0 green:73.0/255.0 blue:73.0/255.0 alpha:1.0f];
        button_have.titleEdgeInsets = UIEdgeInsetsMake(35, 0, 0, 0);
        [button_have setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.contentView addSubview:button_have];
        
        
        
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
