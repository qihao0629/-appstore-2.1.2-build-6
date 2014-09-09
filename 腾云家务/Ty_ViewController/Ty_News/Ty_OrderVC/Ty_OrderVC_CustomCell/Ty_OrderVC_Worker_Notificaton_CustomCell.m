//
//  Ty_OrderVC_Worker_Notificaton_CustomCell.m
//  腾云家务
//
//  Created by lgs on 14-6-4.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_OrderVC_Worker_Notificaton_CustomCell.h"
#import "Ty_News_Busine_HandlePlist.h"

@implementation Ty_OrderVC_Worker_Notificaton_CustomCell
@synthesize workerLeftButtonDelegate;
@synthesize workerRightButtonDelegate;
@synthesize notificationTypeLabel;
@synthesize requirementStateLabel;
@synthesize photoView;
@synthesize photoImageView;
@synthesize requirementNumberLabel;
@synthesize secondLabel;
@synthesize thirdLabel;
@synthesize fourthLabel;
@synthesize contactWithMasterButton;
@synthesize contactLabel;
@synthesize rightButton;
@synthesize rightButtonLabel;

@synthesize xuQiu;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setFrame:CGRectMake(10, 0, 300, 205)];
    }
    return self;
}
/**实例化*/
-(void) loadUIAndIndex:(int)_Num
{
    UIImageView * firstImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 47)];
    [firstImageView setImage:[UIImage imageNamed:@"i_setupcellbgtop"]];
    
    UIImageView * secondImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 47, 300, 98)];
    [secondImageView setImage:[UIImage imageNamed:@"i_setupcellbgtop"]];
    
    UIImageView * thirdImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 47 + 98, 300, 205 - 47 -98)];
    [thirdImageView setImage:[UIImage imageNamed:@"i_setupcellbg"]];
    
    [self.contentView addSubview:firstImageView];
    [self.contentView addSubview:secondImageView];
    [self.contentView addSubview:thirdImageView];
    
    [self.contentView sendSubviewToBack:firstImageView];
    [self.contentView sendSubviewToBack:secondImageView];
    [self.contentView sendSubviewToBack:thirdImageView];
    
    notificationTypeLabel = [[UILabel alloc]initWithFrame:CGRectMake(17, 15, 120, 15)];
    [self.notificationTypeLabel setBackgroundColor:[UIColor clearColor]];
    [self.notificationTypeLabel setFont:FONT15_BOLDSYSTEM];
    [self.notificationTypeLabel setTextColor:[UIColor blackColor]];
    [self.notificationTypeLabel setTextAlignment:NSTextAlignmentLeft];
    
    requirementStateLabel = [[UILabel alloc]initWithFrame:CGRectMake(205, 18, 80, 13)];
    [self.requirementStateLabel setBackgroundColor:[UIColor clearColor]];
    [self.requirementStateLabel setFont:FONT13_SYSTEM];
    [self.requirementStateLabel setTextColor:[UIColor colorWithRed:253/255.0 green:117/255.0 blue:43/255.0 alpha:1]];
    [self.requirementStateLabel setTextAlignment:NSTextAlignmentRight];
    
    photoView = [[UIView alloc]initWithFrame:CGRectMake(13, firstImageView.frame.origin.y + firstImageView.frame.size.height + 17, 63, 63)];
    photoView.backgroundColor =[UIColor clearColor];
    photoView.layer.borderColor= [[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1] CGColor];
    photoView.layer.borderWidth = 1;
    photoView.layer.masksToBounds = YES;
    photoView.layer.cornerRadius = 10;
    
    photoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 63, 63)];
    photoImageView.backgroundColor = [UIColor clearColor];
    [photoView addSubview:photoImageView];
    
    requirementNumberLabel =[[UILabel alloc]initWithFrame:CGRectMake(96,firstImageView.frame.origin.y + firstImageView.frame.size.height +15, 200, 13)];
    [self.requirementNumberLabel setBackgroundColor:[UIColor clearColor]];
    [self.requirementNumberLabel setFont:FONT13_SYSTEM];
    [self.requirementNumberLabel setTextColor:[UIColor grayColor]];
    [self.requirementNumberLabel setTextAlignment:NSTextAlignmentLeft];
    
    secondLabel =[[UILabel alloc]initWithFrame:CGRectMake(96,firstImageView.frame.origin.y + firstImageView.frame.size.height +33, 200, 13)];
    [self.secondLabel setBackgroundColor:[UIColor clearColor]];
    [self.secondLabel setFont:FONT13_SYSTEM];
    [self.secondLabel setTextColor:[UIColor grayColor]];
    [self.secondLabel setTextAlignment:NSTextAlignmentLeft];

    thirdLabel =[[UILabel alloc]initWithFrame:CGRectMake(96,firstImageView.frame.origin.y + firstImageView.frame.size.height +52, 200, 13)];
    [self.thirdLabel setBackgroundColor:[UIColor clearColor]];
    [self.thirdLabel setFont:FONT13_SYSTEM];
    [self.thirdLabel setTextColor:[UIColor grayColor]];
    [self.thirdLabel setTextAlignment:NSTextAlignmentLeft];
    
    fourthLabel =[[UILabel alloc]initWithFrame:CGRectMake(96,firstImageView.frame.origin.y + firstImageView.frame.size.height +69, 200, 13)];
    [self.fourthLabel setBackgroundColor:[UIColor clearColor]];
    [self.fourthLabel setFont:FONT13_SYSTEM];
    [self.fourthLabel setTextColor:[UIColor grayColor]];
    [self.fourthLabel setTextAlignment:NSTextAlignmentLeft];
    
    contactWithMasterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [contactWithMasterButton setFrame:CGRectMake(4, secondImageView.frame.origin.y + secondImageView.frame.size.height + 8, 141, 44)];
    [contactWithMasterButton setImage:[UIImage imageNamed:@"contactButton"] forState:UIControlStateNormal];
    contactWithMasterButton.exclusiveTouch = YES;
    [contactWithMasterButton addTarget:self action:@selector(showAlertView) forControlEvents:UIControlEventTouchUpInside];
    contactWithMasterButton.tag = 1000 + _Num;
    
    contactLabel =[[UILabel alloc]initWithFrame:CGRectMake(40,15, 62, 15)];
    [self.contactLabel setBackgroundColor:[UIColor clearColor]];
    [self.contactLabel setFont:FONT15_SYSTEM];
    [self.contactLabel setTextColor:[UIColor whiteColor]];
    [self.contactLabel setTextAlignment:NSTextAlignmentCenter];
    [contactWithMasterButton addSubview:contactLabel];
    
    
    rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(154, secondImageView.frame.origin.y + secondImageView.frame.size.height + 8, 141, 44)];
    [rightButton setImage:[UIImage imageNamed:@"quitOrderButton"] forState:UIControlStateNormal];
    rightButton.exclusiveTouch = YES;
    [rightButton addTarget:self action:@selector(showAlertView) forControlEvents:UIControlEventTouchUpInside];
    rightButton.tag = 2000 + _Num;
    
    rightButtonLabel =[[UILabel alloc]initWithFrame:CGRectMake(40,15, 62, 15)];
    [self.rightButtonLabel setBackgroundColor:[UIColor clearColor]];
    [self.rightButtonLabel setFont:FONT15_SYSTEM];
    [self.rightButtonLabel setTextColor:[UIColor whiteColor]];
    [self.rightButtonLabel setTextAlignment:NSTextAlignmentCenter];
    [rightButton addSubview:rightButtonLabel];
    
    [self.contentView addSubview:notificationTypeLabel];
    [self.contentView addSubview:requirementStateLabel];
    [self.contentView addSubview:photoView];
    [self.contentView addSubview:requirementNumberLabel];
    [self.contentView addSubview:secondLabel];
    [self.contentView addSubview:thirdLabel];
    [self.contentView addSubview:fourthLabel];
    
    [self.contentView addSubview:contactWithMasterButton];
    [self.contentView addSubview:rightButton];
}
/**赋值*/
-(void) loadValues
{
    //****抢单  *****预约
    if ([xuQiu.requirement_Type intValue] == 0)
    {
        notificationTypeLabel.text = [NSString stringWithFormat:@"%@抢单",xuQiu.workName];
        switch ([xuQiu.requirement_Stage intValue])
        {
            case 0:
                requirementStateLabel.text = @"带服务方应征";
                break;
            case 1:
                requirementStateLabel.text = @"待服务方确认";
                break;
            case 2:
                requirementStateLabel.text = @"交易中";
                rightButtonLabel.text = @"达成交易";
                break;
            case 3:
                requirementStateLabel.text = @"已关闭";
                rightButtonLabel.text = @"达成交易";
                break;
            case 6:
                if ([xuQiu.candidateStatus intValue] == 0)
                {
                    requirementStateLabel.text = @"带服务方应征";
                    rightButtonLabel.text = @"确认应征";
                }
                else
                {
                    requirementStateLabel.text = @"我已应征";
                    rightButtonLabel.text = @"取消应征";
                }
                break;
            default:
                requirementStateLabel.text = @"数据出错";
                break;
        }
        requirementNumberLabel.text = [NSString stringWithFormat:@"抢单单号:%@",xuQiu.requirementNumber];
        secondLabel.text = [NSString stringWithFormat:@"服务时间:%@",xuQiu.startTime];
        Ty_News_Busine_HandlePlist * tempBusine = [[Ty_News_Busine_HandlePlist alloc]init];
        NSString * unitString = [tempBusine findWorkUnitAndWorkName:xuQiu.workName];
        
        thirdLabel.text = [NSString stringWithFormat:@"服务时长:%@%@",xuQiu.workAmount,unitString];
        tempBusine = nil;

        fourthLabel.text = @"更多条件:点击查看";
        
        contactWithMasterButton.hidden = YES;
    }
    else
    {
        notificationTypeLabel.text = [NSString stringWithFormat:@"%@预约",xuQiu.workName];
        switch ([xuQiu.requirement_Stage intValue])
        {
            case 1:
                requirementStateLabel.text = @"待服务方确认";
                rightButtonLabel.text = @"确认接单";
                break;
            case 2:
                requirementStateLabel.text = @"交易中";
                rightButtonLabel.text = @"已接单";
                break;
            case 3:
                requirementStateLabel.text = @"已关闭";
                rightButtonLabel.text = @"已接单";
                break;
            default:
                requirementStateLabel.text = @"数据出错";
                break;
        }
        requirementNumberLabel.text = [NSString stringWithFormat:@"预约单号%@",xuQiu.requirementNumber];
        secondLabel.text = [NSString stringWithFormat:@"预约人:%@",xuQiu.contact];
        thirdLabel.text = [NSString stringWithFormat:@"服务时间:%@",xuQiu.startTime];
        
        Ty_News_Busine_HandlePlist * tempBusine = [[Ty_News_Busine_HandlePlist alloc]init];
        NSString * unitString = [tempBusine findWorkUnitAndWorkName:xuQiu.workName];
        
        fourthLabel.text = [NSString stringWithFormat:@"服务时长:%@%@",xuQiu.workAmount,unitString];
        tempBusine = nil;
        
        contactLabel.text = @"联系雇主";
    }
    if ([xuQiu.publishUserType isEqualToString:@"0"])
    {
         [photoImageView setImageWithURL:[NSURL URLWithString:xuQiu.publishUserPhoto] placeholderImage:[UIImage imageNamed:@"Contact_image2"]];
    }
    else
    {
        if ([xuQiu.publishUserSex intValue] == 0)
        {//男
            [photoImageView setImageWithURL:[NSURL URLWithString:xuQiu.publishUserPhoto] placeholderImage:[UIImage imageNamed:@"Contact_image1"]];
        }
        else
        {
            [photoImageView setImageWithURL:[NSURL URLWithString:xuQiu.publishUserPhoto] placeholderImage:[UIImage imageNamed:@"Contact_image"]];
        }
    }
}
-(void)showAlertView
{
    UIAlertView * tempAlertView = [[UIAlertView alloc]initWithTitle:@"抱歉" message:@"未开放,敬请期待" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [tempAlertView show];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
