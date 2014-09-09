//
//  Ty_UserView_OrderView_RequirementDetail_TopView.m
//  腾云家务
//
//  Created by lgs on 14-5-29.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_UserView_OrderView_RequirementDetail_TopView.h"
#import "Ty_News_Busine_HandlePlist.h"

@implementation Ty_UserView_OrderView_RequirementDetail_TopView

@synthesize topViewXuQiu;
@synthesize semgentButton;
@synthesize masterOrWorker;
@synthesize requirementStateLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setFrame:CGRectMake(0, 0, 320, 156)];
        // Initialization code
    }
    return self;
}

-(void) loadCustomView
{
    requirementNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(13, 12, 220, 12)];
    requirementNumberLabel.font = FONT12_BOLDSYSTEM;
    requirementNumberLabel.textColor = [UIColor grayColor];
    requirementNumberLabel.textAlignment = UITextAlignmentLeft;
    requirementNumberLabel.backgroundColor = [UIColor clearColor];
    
    headPhotoView = [[UIView alloc]initWithFrame:CGRectMake(12, 42, 69, 69)];
    [headPhotoView setBackgroundColor:[UIColor whiteColor]];
    headPhotoView.layer.borderWidth = 1;
    headPhotoView.layer.borderColor =[[UIColor whiteColor] CGColor];
    headPhotoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(2, 2, 65, 65)];
    
    [headPhotoView addSubview:headPhotoImageView];
    
    findWorkNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(105, 46, 100, 15)];
    findWorkNameLabel.font = FONT15_BOLDSYSTEM;
    findWorkNameLabel.textColor = [UIColor blackColor];
    findWorkNameLabel.textAlignment = UITextAlignmentLeft;
    findWorkNameLabel.backgroundColor = [UIColor clearColor];
    
    servieceTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(105, 71, 220, 12)];
    servieceTimeLabel.font = FONT12_BOLDSYSTEM;
    servieceTimeLabel.textColor = [UIColor grayColor];
    servieceTimeLabel.textAlignment = UITextAlignmentLeft;
    servieceTimeLabel.backgroundColor = [UIColor clearColor];
    
    
    timeLimitLabel = [[UILabel alloc]initWithFrame:CGRectMake(105, 89, 220, 12)];
    timeLimitLabel.font = FONT12_BOLDSYSTEM;
    timeLimitLabel.textColor = [UIColor grayColor];
    timeLimitLabel.textAlignment = UITextAlignmentLeft;
    timeLimitLabel.backgroundColor = [UIColor clearColor];
    
    requirementStateLabel = [[UILabel alloc]initWithFrame:CGRectMake(205,46,100,25)];
    requirementStateLabel.textColor = [UIColor colorWithRed:224/255.0 green:28/255.0 blue:32/255.0 alpha:1];
    requirementStateLabel.textAlignment = UITextAlignmentRight;
    requirementStateLabel.backgroundColor = [UIColor clearColor];
    requirementStateLabel.font = FONT15_BOLDSYSTEM;
    
    semgentButton=[[Ty_UserView_Order_SemgentButton alloc]initWithFrame:CGRectMake(0, 120, 320, 36)];
    semgentButton.backgroundColor = [UIColor clearColor];
    semgentButton.firstButton.hidden = YES;
    semgentButton.secondButton.hidden = YES;
    semgentButton.thridButton.hidden = YES;
    
    [self addSubview:headPhotoView];
    [self addSubview:findWorkNameLabel];
    [self addSubview:requirementStateLabel];
    [self addSubview:requirementNumberLabel];
    [self addSubview:timeLimitLabel];
    [self addSubview:servieceTimeLabel];
    [self addSubview:semgentButton];
}

-(void) loadValues
{
    requirementNumberLabel.text = [NSString stringWithFormat:@"订单号:%@",topViewXuQiu.requirementNumber];
    if ([topViewXuQiu.publishUserType intValue] == 0)
    {
        [headPhotoImageView setImageWithURL:[NSURL URLWithString:topViewXuQiu.publishUserPhoto] placeholderImage:[UIImage imageNamed: @"Contact_image2"]];
    }
    else
    {
        if ([topViewXuQiu.publishUserSex intValue] == 0)
        {//nan
            [headPhotoImageView setImageWithURL:[NSURL URLWithString:topViewXuQiu.publishUserPhoto] placeholderImage:[UIImage imageNamed: @"Contact_image1"]];
        }
        else
        {
            [headPhotoImageView setImageWithURL:[NSURL URLWithString:topViewXuQiu.publishUserPhoto] placeholderImage:[UIImage imageNamed: @"Contact_image"]];
        }
    }

    findWorkNameLabel.text = [NSString stringWithFormat:@"%@",topViewXuQiu.workName];
    servieceTimeLabel.text = [NSString stringWithFormat:@"服务时间:%@",topViewXuQiu.startTime];
    
    Ty_News_Busine_HandlePlist * tempBusine = [[Ty_News_Busine_HandlePlist alloc]init];
    
    NSString * unitString = [NSString stringWithString:[tempBusine findWorkUnitAndWorkName:topViewXuQiu.workName]];
    
    NSMutableString * servieceCount = [NSMutableString stringWithFormat:@"工作总量:%@",topViewXuQiu.workAmount];
    
    servieceCount = [NSMutableString stringWithString:[servieceCount stringByAppendingString:unitString]];
    timeLimitLabel.text = servieceCount;
    
    if ([topViewXuQiu.requirement_Stage intValue] == 0 || [topViewXuQiu.requirement_Stage intValue] == 6)
    {
        if (masterOrWorker == 0)
        {//雇主
            if ([topViewXuQiu.requirement_Stage intValue] == 0)
            {
                requirementStateLabel.text = @"[待应征]";
            }
            else
            {
                requirementStateLabel.text = @"[有应征]";
            }
        }
        else
        {
            if ([topViewXuQiu.candidateStatus intValue] == 0)
            {
                requirementStateLabel.text = @"[待应征]";
            }
            else
            {
                requirementStateLabel.text = @"[我已应征]";
            }
        }
    }
    else if ([topViewXuQiu.requirement_Stage intValue] == 1)
    {
        if (masterOrWorker == 0)
        {//雇主
            requirementStateLabel.text = @"[待服务商确认]";
        }
        else
        {
            requirementStateLabel.text = @"[待确认]";
        }
        
    }
    else if ([topViewXuQiu.requirement_Stage intValue] == 2)
    {
        if ([topViewXuQiu.serverObject.userGuid isEqualToString:@""])
        {
            requirementStateLabel.text = @"[交易关闭]";
        }
        else
        {
            if ([topViewXuQiu.requirementStageText isEqualToString:@""])
            {
                requirementStateLabel.text = @"[交易中]";
            }
            else
            {
                requirementStateLabel.text = [NSString stringWithFormat:@"[%@]",topViewXuQiu.requirementStageText];
            }
        }
    }
    else if ([topViewXuQiu.requirement_Stage intValue] == 3)
    {
        if ([topViewXuQiu.serverObject.userGuid isEqualToString:@""])
        {
            requirementStateLabel.text = @"[交易关闭]";
        }
        else
        {
            requirementStateLabel.text = @"[已完成]";
        }
    }
    else if ([topViewXuQiu.requirement_Stage intValue] == 4)
    {
        requirementStateLabel.text = @"[交易关闭]";
        [timeLimitLabel removeFromSuperview];
    }
    else if ([topViewXuQiu.requirement_Stage intValue] == 7)
    {
        if ([topViewXuQiu.serverObject.companiesGuid isEqualToString:@""])
        {
            requirementStateLabel.text = @"[交易关闭]";
        }
        else
        {
            requirementStateLabel.text = @"[待派工]";
        }
    }

}
@end
