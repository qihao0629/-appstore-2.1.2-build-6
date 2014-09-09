//
//  Ty_Order_Master_OrderCell.m
//  腾云家务
//
//  Created by lgs on 14-6-30.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_Order_Master_OrderCell.h"

@implementation Ty_Order_Master_OrderCell

@synthesize headImageView;
@synthesize leftHeadView;
@synthesize workerNameLabel;
@synthesize workerTypeLabel;
@synthesize greenView;
@synthesize customStar;
@synthesize priceLabel;
@synthesize unitLabel;
@synthesize evaluateButton;
@synthesize reminderView;
@synthesize serviceTimeLabel;
@synthesize buttonTitleLabel;
@synthesize reminderLabel1;
@synthesize reminderLabel2;
@synthesize servicePhoneButton;
@synthesize employeePhoneButton;
@synthesize employeePhoneNumberLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setFrame:CGRectMake(0, 0, 320, 148)];
        self.leftHeadView = [[UIView alloc]initWithFrame:CGRectMake(15, 16, 60, 60)];
        [self.leftHeadView setBackgroundColor:[UIColor whiteColor]];
        self.leftHeadView.layer.borderWidth= 1;
        self.leftHeadView.layer.borderColor =[[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1] CGColor];
        
        self.headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(1, 1, 58, 58)];
        
        [self.leftHeadView addSubview:headImageView];
        
        self.workerNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(88, 18, 104, 13)];
        [self.workerNameLabel setBackgroundColor:[UIColor clearColor]];
        [self.workerNameLabel setFont:FONT13_BOLDSYSTEM];
        [self.workerNameLabel setTextColor:[UIColor blackColor]];
        [self.workerNameLabel setTextAlignment:NSTextAlignmentLeft];
        
        self.greenView = [[UIView alloc]initWithFrame:CGRectMake(workerNameLabel.frame.origin.x + workerNameLabel.frame.size.width + 5, 17, 56, 15)];
        [self.greenView setBackgroundColor:[UIColor colorWithRed:0 green:208/255.0 blue:66/255.0 alpha:1]];
        self.greenView.layer.masksToBounds = YES;
        self.greenView.layer.cornerRadius = 3;
        
        self.workerTypeLabel =[[UILabel alloc]initWithFrame:CGRectMake(5, 2, 56, 10)];
        [self.workerTypeLabel setBackgroundColor:[UIColor clearColor]];
        [self.workerTypeLabel setFont:FONT10_BOLDSYSTEM];
        [self.workerTypeLabel setTextColor:[UIColor whiteColor]];
        [self.workerTypeLabel setTextAlignment:NSTextAlignmentLeft];
        [self.greenView addSubview:self.workerTypeLabel];
        
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
        
        self.customStar = [[CustomStar alloc]initWithFrame:CGRectMake(88, 47, 66, 13) Number:5];
        [self.customStar setUserInteractionEnabled:NO];
        
        self.serviceTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(170, 50, 80, 11)];
        [self.serviceTimeLabel setBackgroundColor:[UIColor clearColor]];
        self.serviceTimeLabel.font = FONT10_BOLDSYSTEM;
        [self.serviceTimeLabel setTextColor:[UIColor grayColor]];
        [self.serviceTimeLabel setTextAlignment:NSTextAlignmentLeft];
        
        self.evaluateButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.evaluateButton setFrame:CGRectMake(235, 55, 77, 30)];
        
        buttonTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 77, 30)];
        [buttonTitleLabel setBackgroundColor:[UIColor clearColor]];
        buttonTitleLabel.font = FONT15_BOLDSYSTEM;
        buttonTitleLabel.textColor = [UIColor whiteColor];
        buttonTitleLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.evaluateButton addSubview:buttonTitleLabel];
        
        self.employeePhoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.employeePhoneButton setFrame:CGRectMake(15, 84, 160, 26)];
        
        UIView * redLineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 20, 190, 1)];
        [redLineView1 setBackgroundColor:[UIColor redColor]];
        
        employeePhoneNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 3, 190, 15)];
        [employeePhoneNumberLabel setBackgroundColor:[UIColor clearColor]];
        employeePhoneNumberLabel.font = FONT15_SYSTEM;
        employeePhoneNumberLabel.textColor = [UIColor redColor];
        [employeePhoneNumberLabel setTextAlignment:NSTextAlignmentLeft];
        
        [self.employeePhoneButton addSubview:redLineView1];
        [self.employeePhoneButton addSubview:employeePhoneNumberLabel];
        
        
        reminderView = [[UIView alloc]initWithFrame:CGRectMake(0, 98, 320, 50)];
        [reminderView setBackgroundColor:[UIColor clearColor]];
        
        reminderLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 285, 14)];
        [reminderLabel1 setBackgroundColor:[UIColor clearColor]];
        reminderLabel1.font = FONT14_SYSTEM;
        reminderLabel1.text= @"如果服务商没有及时和您取得联系，请拨打";
        reminderLabel1.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0  blue:119/255.0  alpha:1];
        reminderLabel1.textAlignment =NSTextAlignmentLeft;
        
        reminderLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(15, 17, 285, 14)];
        [reminderLabel2 setBackgroundColor:[UIColor clearColor]];
        reminderLabel2.font = FONT14_SYSTEM;
        reminderLabel2.text= @"我们的";
        reminderLabel2.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0  blue:119/255.0  alpha:1];
        reminderLabel2.textAlignment =NSTextAlignmentLeft;
        
        servicePhoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [servicePhoneButton setFrame:CGRectMake(67, 13, 192, 26)];
        
        UIView * redLineView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, 213, 1)];
        [redLineView setBackgroundColor:[UIColor redColor]];
        
        UILabel * servicePhoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 3, 220, 15)];
        [servicePhoneLabel setBackgroundColor:[UIColor clearColor]];
        servicePhoneLabel.font = FONT15_SYSTEM;
        servicePhoneLabel.text= @"腾云家务客服:400-004-9121";
        
        servicePhoneLabel.textColor = [UIColor redColor];
        servicePhoneLabel.textAlignment =NSTextAlignmentLeft;
        
        UIImageView * phoneImageVie =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"redPhoneIcon"]];
        [phoneImageVie setFrame:CGRectMake(199, 2, 14, 18)];
        
        [servicePhoneButton addSubview:redLineView];
        [servicePhoneButton addSubview:servicePhoneLabel];
        [servicePhoneButton addSubview:phoneImageVie];
        
        [reminderView addSubview:reminderLabel1];
        [reminderView addSubview:reminderLabel2];
        [reminderView addSubview:servicePhoneButton];
        
        
        [self.contentView addSubview:leftHeadView];
        [self.contentView addSubview:greenView];
        [self.contentView addSubview:workerNameLabel];
        [self.contentView addSubview:self.customStar];
        [self.contentView addSubview:priceLabel];
        [self.contentView addSubview:unitLabel];
        [self.contentView addSubview:serviceTimeLabel];
        [self.contentView addSubview:evaluateButton];
        [self.contentView addSubview:reminderView];
        
        self.layer.borderWidth = 1;
        self.layer.borderColor = [[UIColor colorWithRed:188/255.0 green:188/255.0 blue:188/255.0 alpha:1] CGColor];
    }
    return self;
}
-(void)setHight
{
    CGSize  size =   [workerNameLabel.text sizeWithFont:FONT13_BOLDSYSTEM constrainedToSize:CGSizeMake(MAXFLOAT, 13)];
    
    if (size.width > 104)
    {
        [workerNameLabel setFrame:CGRectMake(workerNameLabel.frame.origin.x, workerNameLabel.frame.origin.y,104, 13)];
    }
    else
    {
        [workerNameLabel setFrame:CGRectMake(workerNameLabel.frame.origin.x, workerNameLabel.frame.origin.y, size.width, 13)];
    }
    
    CGSize  priceSize = [priceLabel.text sizeWithFont:FONT17_BOLDSYSTEM constrainedToSize:CGSizeMake(MAXFLOAT, 17)];
    CGSize workerTypeSize = [workerTypeLabel.text sizeWithFont:FONT10_BOLDSYSTEM constrainedToSize:CGSizeMake(MAXFLOAT, 10)];
    
//    [self.workerTypeLabel setFrame:CGRectMake(workerTypeLabel.frame.origin.x, workerTypeLabel.frame.origin.y, [workerTypeLabel.text length] * 10 , workerTypeLabel.frame.size.height)];

    
    if (workerNameLabel.frame.origin.x + workerNameLabel.frame.size.width + 10 + workerTypeSize.width > (277-priceSize.width))
    {
        [self.greenView setFrame:CGRectMake(workerNameLabel.frame.origin.x + workerNameLabel.frame.size.width + 5, 17,(277-priceSize.width) - (workerNameLabel.frame.origin.x + workerNameLabel.frame.size.width) - 5, 15)];
        
        [self.workerTypeLabel setFrame:CGRectMake(workerTypeLabel.frame.origin.x, workerTypeLabel.frame.origin.y, self.greenView.frame.size.width - 10 , workerTypeLabel.frame.size.height)];
    }
    else
    {
        [self.greenView setFrame:CGRectMake(workerNameLabel.frame.origin.x + workerNameLabel.frame.size.width + 5, 17, 10 + workerTypeSize.width, 15)];
        [self.workerTypeLabel setFrame:CGRectMake(workerTypeLabel.frame.origin.x, workerTypeLabel.frame.origin.y, workerTypeSize.width , workerTypeLabel.frame.size.height)];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
