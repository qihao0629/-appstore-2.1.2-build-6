//
//  MasterNoBodyYZCell.m
//  腾云家务
//
//  Created by lgs on 14-3-13.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_Order_NoBodyYZCell.h"
#define BianColor [UIColor colorWithRed:218.0/255.0 green:218.0/255.0 blue:218.0/255.0 alpha:1]

@implementation Ty_Order_NoBodyYZCell
//@synthesize loadView;
//@synthesize loadWebView;
@synthesize firstRemindLabel;
@synthesize secondRemindLabel;
@synthesize thirdRemindLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        firstRemindLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 100 - 72, 300, 13)];
        [firstRemindLabel setBackgroundColor:[UIColor clearColor]];
        firstRemindLabel.text =@"正在等待服务商抢单，请稍等哦!";
        firstRemindLabel.font = FONT13_BOLDSYSTEM;
        firstRemindLabel.textAlignment = UITextAlignmentCenter;
        firstRemindLabel.textColor = [UIColor blackColor];
        
        secondRemindLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 132 - 72, 300, 10)];
        [secondRemindLabel setBackgroundColor:[UIColor clearColor]];
        secondRemindLabel.text =@"如果您急需用工，也可以与我们联系";
        secondRemindLabel.font = FONT10_SYSTEM;
        secondRemindLabel.textAlignment = UITextAlignmentCenter;
        secondRemindLabel.textColor = [UIColor grayColor];
        
        thirdRemindLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 147 - 72, 300, 10)];
        [thirdRemindLabel setBackgroundColor:[UIColor clearColor]];
        thirdRemindLabel.text =@"腾云家务客服:400-004-9121";
        thirdRemindLabel.font = FONT10_SYSTEM;
        thirdRemindLabel.textAlignment = UITextAlignmentCenter;
        thirdRemindLabel.textColor = [UIColor grayColor];
        
        [self.contentView addSubview:firstRemindLabel];
        [self.contentView addSubview:secondRemindLabel];
        [self.contentView addSubview:thirdRemindLabel];
        
        self.layer.masksToBounds = YES;
        //给图层添加一个有色边框
        self.layer.borderWidth = 1;
        self.layer.borderColor = [BianColor CGColor];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
