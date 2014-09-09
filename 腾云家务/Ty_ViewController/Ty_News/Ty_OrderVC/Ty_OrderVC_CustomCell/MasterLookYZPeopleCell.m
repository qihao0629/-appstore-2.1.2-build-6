//
//  MasterLookYZPeopleCell.m
//  腾云家务
//
//  Created by lgs on 14-6-20.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "MasterLookYZPeopleCell.h"

@implementation MasterLookYZPeopleCell
@synthesize masterDeterminePersonButton;
@synthesize headImageView;
@synthesize leftHeadView;
@synthesize workerNameLabel;
@synthesize workerTypeLabel;
@synthesize greenView;
@synthesize YZtimeLabel;
@synthesize priceLabel;
@synthesize unitLabel;
@synthesize privateLetterButton;
@synthesize serviceTimeLabel;
@synthesize determineButton;
@synthesize buttonTitleLabel;
@synthesize redIcon;
@synthesize newsLabel;
@synthesize serviceObject;
@synthesize remarkLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setFrame:CGRectMake(0, 0, 320, 95)];
    }
    return self;
}
-(void)loadCustom
{
    self.leftHeadView = [[UIView alloc]initWithFrame:CGRectMake(15, 16, 60, 60)];
    [self.leftHeadView setBackgroundColor:[UIColor whiteColor]];
    self.leftHeadView.layer.borderWidth= 1;
    self.leftHeadView.layer.borderColor =[[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1] CGColor];
    
    self.headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(1, 1, 58, 58)];
    
    [self.leftHeadView addSubview:headImageView];
    
    self.workerNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(88, 20, 104, 13)];
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
    
    self.unitLabel =[[UILabel alloc]initWithFrame:CGRectMake(277, 25,30, 12)];
    [self.unitLabel setBackgroundColor:[UIColor clearColor]];
    [self.unitLabel setFont:FONT12_BOLDSYSTEM];
    self.unitLabel.textColor = [UIColor colorWithRed:254/255.0 green:139/255.0 blue:49/255.0 alpha:1];
    [self.unitLabel setTextAlignment:NSTextAlignmentRight];
    
    
    self.priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(277 - 68, 21,68, 17)];
    [self.priceLabel setBackgroundColor:[UIColor clearColor]];
    [self.priceLabel setFont:FONT17_BOLDSYSTEM];
    self.priceLabel.textColor = [UIColor colorWithRed:254/255.0 green:139/255.0 blue:49/255.0 alpha:1];
    [self.priceLabel setTextAlignment:NSTextAlignmentRight];
    
    self.privateLetterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.privateLetterButton setFrame:CGRectMake(88, 33, 32, 62)];
    [self.privateLetterButton setImage:[UIImage imageNamed:@"message_red"] forState:UIControlStateNormal];
    self.privateLetterButton.userInteractionEnabled = YES;
    
    
    //红点
    redIcon=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Privateletter_unread.png"]];
    redIcon.hidden = YES;
    redIcon.frame = CGRectMake(25, 18, 15, 15);
    newsLabel = [[UILabel alloc]initWithFrame:redIcon.bounds];
    newsLabel.backgroundColor = [UIColor clearColor];
    newsLabel.textColor = [UIColor whiteColor];
    newsLabel.textAlignment = NSTextAlignmentCenter;
    newsLabel.font = FONT8_SYSTEM;
    [redIcon addSubview:newsLabel];
    [redIcon bringSubviewToFront:newsLabel];
    
    [self.privateLetterButton addSubview:self.redIcon];
    self.determineButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.determineButton setFrame:CGRectMake(235, 55, 77, 30)];
    [self.determineButton setImage:[UIImage imageNamed:@"determine"] forState:UIControlStateNormal];
    
    [self.determineButton addTarget:self action:@selector(masterDetermineButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    buttonTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 77, 30)];
    [buttonTitleLabel setBackgroundColor:[UIColor clearColor]];
    buttonTitleLabel.text = @"选定";
    buttonTitleLabel.font = FONT15_BOLDSYSTEM;
    buttonTitleLabel.textColor = [UIColor whiteColor];
    buttonTitleLabel.textAlignment = UITextAlignmentCenter;
    
    [self.determineButton addSubview:buttonTitleLabel];
    
    remarkLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 75 + 5, 100, 12)];
    [remarkLabel setBackgroundColor:[UIColor clearColor]];
    remarkLabel.font = FONT12_BOLDSYSTEM;
    remarkLabel.textColor = [UIColor grayColor];
    remarkLabel.textAlignment = NSTextAlignmentLeft;


    [self.contentView addSubview:leftHeadView];
    [self.contentView addSubview:greenView];
    [self.contentView addSubview:workerNameLabel];
    [self.contentView addSubview:priceLabel];
    [self.contentView addSubview:unitLabel];
    [self.contentView addSubview:privateLetterButton];
    [self.contentView addSubview:determineButton];
    [self.contentView addSubview:remarkLabel];
}
-(void)loadValues
{
    if ([serviceObject.userType intValue] == 0)
    {
        [self.headImageView setImageWithURL:[NSURL URLWithString:serviceObject.companyPhoto] placeholderImage:[UIImage imageNamed:@"Contact_image2"]];
        self.workerNameLabel.text = serviceObject.respectiveCompanies;
        self.workerTypeLabel.text = @"商户";
        
        NSString * tempStr = [NSString stringWithFormat:@"￥%@",serviceObject.YZQuote];
        self.priceLabel.text = tempStr;
        self.determineButton.hidden = NO;
        self.determineButton.userInteractionEnabled = YES;
    }
    

    //备注
    if ([serviceObject.YZRemark isEqualToString:@""])
    {
        remarkLabel.text = @"备注:无";
    }
    else
    {
        remarkLabel.text = [NSString stringWithFormat:@"备注:%@",serviceObject.YZRemark];
    }
    
    //单位
    //私信按钮
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

#pragma mark 确定人按钮点击方法
-(void)masterDetermineButtonPressed:(id)sender
{
    if (masterDeterminePersonButton)
    {
        if ([masterDeterminePersonButton respondsToSelector:@selector(masterDeterminePersonButtonPressed:)])
        {
            [masterDeterminePersonButton masterDeterminePersonButtonPressed:sender];
        }
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
