//
//  Ty_OrderVC_MyYZDataCell.m
//  腾云家务
//
//  Created by lgs on 14-7-3.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_OrderVC_MyYZDataCell.h"
#define grayWordColor [UIColor colorWithRed:119/255.0 green:119/255.0  blue:119/255.0  alpha:1]

@implementation Ty_OrderVC_MyYZDataCell
@synthesize headImageView;
@synthesize leftHeadView;
@synthesize workerNameLabel;
@synthesize customStar;
@synthesize YZtimeLabel;
@synthesize priceLabel;
@synthesize unitLabel;
@synthesize serviceTimeLabel;
@synthesize reminderLabel1;
@synthesize YZRemarkLabel;
@synthesize evaluateButton;
@synthesize evaluateLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setFrame:CGRectMake(0, 0, 320, 140)];
        self.leftHeadView = [[UIView alloc]initWithFrame:CGRectMake(15, 16, 60, 60)];
        [self.leftHeadView setBackgroundColor:[UIColor whiteColor]];
        self.leftHeadView.layer.borderWidth= 1;
        self.leftHeadView.layer.borderColor =[[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1] CGColor];
        
        self.headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(1, 1, 58, 58)];
        
        [self.leftHeadView addSubview:headImageView];
        
        self.workerNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(88, 18, 108, 13)];
        [self.workerNameLabel setBackgroundColor:[UIColor clearColor]];
        [self.workerNameLabel setFont:FONT13_BOLDSYSTEM];
        [self.workerNameLabel setTextColor:[UIColor blackColor]];
        [self.workerNameLabel setTextAlignment:NSTextAlignmentLeft];
        
        
        
        self.YZtimeLabel  =[[UILabel alloc]initWithFrame:CGRectMake(88, 65,150, 11)];
        [self.YZtimeLabel setBackgroundColor:[UIColor clearColor]];
        [self.YZtimeLabel setFont:FONT10_SYSTEM];
        [self.YZtimeLabel setTextColor:[UIColor blackColor]];
        [self.YZtimeLabel setTextAlignment:NSTextAlignmentLeft];
        
        self.unitLabel =[[UILabel alloc]initWithFrame:CGRectMake(277, 25,30, 13)];
        [self.unitLabel setBackgroundColor:[UIColor clearColor]];
        [self.unitLabel setFont:FONT12_BOLDSYSTEM];
        self.unitLabel.textColor = [UIColor colorWithRed:254/255.0 green:139/255.0 blue:49/255.0 alpha:1];
        [self.unitLabel setTextAlignment:NSTextAlignmentLeft];
        
        
        self.priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(277 - 68, 21,68, 17)];
        [self.priceLabel setBackgroundColor:[UIColor clearColor]];
        [self.priceLabel setFont:FONT17_BOLDSYSTEM];
        self.priceLabel.textColor = [UIColor colorWithRed:254/255.0 green:139/255.0 blue:49/255.0 alpha:1];
        [self.priceLabel setTextAlignment:NSTextAlignmentRight];
        
        self.customStar = [[CustomStar alloc]initWithFrame:CGRectMake(88, 42, 66, 13) Number:5];
        [self.customStar setUserInteractionEnabled:NO];
        
        self.serviceTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(88, 60 + 5, 80, 11)];
        [self.serviceTimeLabel setBackgroundColor:[UIColor clearColor]];
        self.serviceTimeLabel.font = FONT10_BOLDSYSTEM;
        [self.serviceTimeLabel setTextColor:[UIColor grayColor]];
        [self.serviceTimeLabel setTextAlignment:NSTextAlignmentLeft];
        
        self.evaluateButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.evaluateButton setFrame:CGRectMake(262, 41, 45, 25)];
        
        evaluateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 45, 25)];
        [evaluateLabel setBackgroundColor:[UIColor clearColor]];
        evaluateLabel.font = FONT14_BOLDSYSTEM;
        evaluateLabel.textColor = [UIColor whiteColor];
        evaluateLabel.textAlignment = NSTextAlignmentCenter;
        [self.evaluateButton addSubview:evaluateLabel];

        
        YZRemarkLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 76 + 5, 100, 11)];
        [self.YZRemarkLabel setBackgroundColor:[UIColor clearColor]];
        self.YZRemarkLabel.font = FONT10_BOLDSYSTEM;
        [self.YZRemarkLabel setTextColor:[UIColor grayColor]];
        [self.YZRemarkLabel setTextAlignment:NSTextAlignmentLeft];
        
        reminderLabel1 = [[CustomLabel alloc]initWithFrame:CGRectMake(13, 120, 297, 13)];
//        [reminderLabel1 initWithStratString:@"目前已有" startColor:grayWordColor startFont:FONT13_SYSTEM centerString:@"0" centerColor: [UIColor orangeColor] centerFont:FONT13_SYSTEM endString:@"人应征，您需要等待雇主的最后选择!" endColor:grayWordColor endFont:FONT13_SYSTEM];
        [reminderLabel1 setBackgroundColor:[UIColor clearColor]];
        
        reminderLabel1.textAlignment =NSTextAlignmentLeft;
        
        
        
        [self.contentView addSubview:leftHeadView];
        [self.contentView addSubview:workerNameLabel];
        [self.contentView addSubview:YZtimeLabel];
        [self.contentView addSubview:YZRemarkLabel];
        [self.contentView addSubview:evaluateButton];
        [self.contentView addSubview:self.customStar];
        [self.contentView addSubview:priceLabel];
        [self.contentView addSubview:unitLabel];
//        [self.contentView addSubview:serviceTimeLabel];
        [self.contentView addSubview:reminderLabel1];
        
        
        self.layer.borderWidth = 1;
        self.layer.borderColor = [[UIColor colorWithRed:188/255.0 green:188/255.0 blue:188/255.0 alpha:1] CGColor];    }
    return self;
}

-(void)sethight
{
    

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
