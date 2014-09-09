//
//  Ty_Appointment_AddUserCell.m
//  腾云家务
//
//  Created by 齐 浩 on 13-12-17.
//  Copyright (c) 2013年 齐 浩. All rights reserved.
//

#import "Ty_Appointment_AddUserCell.h"

@implementation Ty_Appointment_AddUserCell
@synthesize addUsers,shopLabel,shopNameLabel,userLabel,leftImageView,tishiLabel;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setFrame:CGRectMake(0, 0, 320, 149)];
        
        
        self.leftImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xingxing"]];
        [self.leftImageView setFrame:CGRectMake(10, 18, 6, 7)];
        [self.leftImageView setBackgroundColor:[UIColor clearColor]];
        
        self.shopLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 64, 14)];
        [self.shopLabel setBackgroundColor:[UIColor clearColor]];
        [self.shopLabel setTextColor:text_ReqColor];
        [self.shopLabel setFont:FONT14_BOLDSYSTEM];
        [self.shopLabel setTextAlignment:NSTextAlignmentLeft];
        
        self.shopNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 15, 170, 14)];
        self.shopNameLabel.lineBreakMode = NSLineBreakByCharWrapping;
        self.shopNameLabel.numberOfLines = 0;
        [self.shopNameLabel setBackgroundColor:[UIColor clearColor] ];
        [self.shopNameLabel setTextColor:text_grayColor];
        [self.shopNameLabel setFont:FONT14_BOLDSYSTEM];
        [self.shopNameLabel setTextAlignment:NSTextAlignmentLeft];
        
        self.userLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 59, 64, 14)];
        [self.userLabel setBackgroundColor:[UIColor clearColor]];
        [self.userLabel setTextColor:text_ReqColor];
        [self.userLabel setFont:FONT14_BOLDSYSTEM];
        [self.userLabel setTextAlignment:NSTextAlignmentLeft];
        
        UIView* lineView  = [[UIView alloc]initWithFrame:CGRectMake(shopLabel.frame.origin.x + shopLabel.frame.size.width + 5, shopLabel.frame.origin.y, 1, 14)];
        [lineView setBackgroundColor:text_grayColor];
        
        UIView* lineView2 = [[UIView alloc]initWithFrame:CGRectMake(userLabel.frame.origin.x + userLabel.frame.size.width + 5, userLabel.frame.origin.y, 1, 14)];
        [lineView2 setBackgroundColor:text_grayColor];
        
        addUsers = [[AddUserView alloc]initWithFrame:CGRectMake(90,44, 60, 105)];

        self.tishiLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, 59, 150, 44)];
        [self.tishiLabel setBackgroundColor:[UIColor clearColor]];
        self.tishiLabel.lineBreakMode = NSLineBreakByCharWrapping;
        self.tishiLabel.numberOfLines = 0;
        [self.tishiLabel setTextColor:Color_orange];
        [self.tishiLabel setFont:FONT13_BOLDSYSTEM];
        [self.tishiLabel setTextAlignment:NSTextAlignmentLeft];
        [self.tishiLabel setText:@"如不点击添加雇工，服务商将为您推荐合适人员"];
        
        [self.contentView addSubview:shopLabel];
        [self.contentView addSubview:lineView];
        [self.contentView addSubview:shopNameLabel];
        [self.contentView addSubview:userLabel];
        [self.contentView addSubview:lineView2];
        [self.contentView addSubview:addUsers];
        [self.contentView addSubview:tishiLabel];
        
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
