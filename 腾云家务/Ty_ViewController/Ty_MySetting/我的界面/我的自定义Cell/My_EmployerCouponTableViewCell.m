//
//  My_EmployerCouponTableViewCell.m
//  腾云家务
//
//  Created by 艾飞 on 14/6/16.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "My_EmployerCouponTableViewCell.h"

@implementation My_EmployerCouponTableViewCell
@synthesize imageViewCoupon,imageViewCouponExpired;
@synthesize labelDayCoupon,labelNumberCoupon;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [[UIColor colorWithRed:172.0/255.0 green:172.0/255.0 blue:172.0/255.0 alpha:1.0f]CGColor];

        imageViewCoupon = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 290, 90)];
        [self.contentView addSubview:imageViewCoupon];
        
        labelNumberCoupon = [[UILabel alloc]initWithFrame:CGRectMake(5, 95, 145, 25)];
        labelNumberCoupon.textAlignment = NSTextAlignmentLeft;
        labelNumberCoupon.text = @"序列号:123456";
        labelNumberCoupon.textColor = [UIColor colorWithRed:128.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0f];
        labelNumberCoupon.font = [UIFont systemFontOfSize:14.0f];
        [self.contentView addSubview:labelNumberCoupon];
        
        labelDayCoupon = [[UILabel alloc]initWithFrame:CGRectMake(150, 95, 145, 25)];
        labelDayCoupon.textAlignment = NSTextAlignmentRight;
        labelDayCoupon.text = @"有效期至2014-6-30";
        labelDayCoupon.font = [UIFont systemFontOfSize:14.0f];
        labelDayCoupon.textColor = [UIColor colorWithRed:128.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0f];
        [self.contentView addSubview:labelDayCoupon];
        
        imageViewCouponExpired = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 120)];
        [self.contentView addSubview:imageViewCouponExpired];
        
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
