//
//  Ty_UserDetail_userCell.m
//  腾云家务
//
//  Created by 齐 浩 on 14-3-4.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_UserDetail_userCell.h"

@implementation Ty_UserDetail_userCell
@synthesize headImage,nameLabel,priceLabel,yuyueButton,renzhengImage;
@synthesize customStar;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        [self setFrame:CGRectMake(0, 0, 300, 60)];
        
        headImage = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 45, 45)];
        [headImage setImage:JWImageName(@"Contact_image")];
        headImage.layer.borderColor = [Color_200 CGColor];
        headImage.layer.borderWidth = 1.0;
        
        nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 5, 60, 15)];
        [nameLabel setBackgroundColor:[UIColor clearColor]];
        [nameLabel setFont:FONT15_BOLDSYSTEM];
        [nameLabel setText:@"李阿姨"];
        
        customStar = [[CustomStar alloc]initWithFrame:CGRectMake(60, 25, 65, 12) Number:5];
        customStar.userInteractionEnabled = NO;
        
        self.renzhengImage = [[UIImageView alloc]initWithFrame:CGRectMake(nameLabel.frame.origin.x+nameLabel.frame.size.width+5, 5, 20, 17)];
        //        self.HeadImage.layer.cornerRadius = 5;
        [self.renzhengImage setImage:JWImageName(@"renzheng")];
//        self.renzhengImage.hidden = YES;
        
        priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(140, 5, 150, 16)];
        [priceLabel setBackgroundColor:[UIColor clearColor]];
        [priceLabel setTextColor:Color_orange];
        [priceLabel setTextAlignment:NSTextAlignmentRight];
        [priceLabel setFont:FONT14_SYSTEM];
        [priceLabel setText:@""];

        
        yuyueButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [yuyueButton setTitle:@"预约此人" forState:UIControlStateNormal];
        [yuyueButton setBackgroundImage:JWImageName(@"home_orangeButton") forState:UIControlStateNormal];
        [yuyueButton.titleLabel setFont:FONT16_BOLDSYSTEM];
        [yuyueButton setFrame:CGRectMake(208, 24, 82, 26)];
        yuyueButton.layer.masksToBounds = YES;
//        yuyueButton.layer.borderWidth = 0.5;
//        yuyueButton.layer.borderColor = [[UIColor redColor]CGColor];
        yuyueButton.layer.cornerRadius = 6;
        [self.contentView addSubview:headImage];
        [self.contentView addSubview:nameLabel];
        [self.contentView addSubview:customStar];
        [self.contentView addSubview:renzhengImage];
        [self.contentView addSubview:priceLabel];
        [self.contentView addSubview:yuyueButton];

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
