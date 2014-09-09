//
//  Ty_OrderVC_Master_Notivation_CustonCell.m
//  腾云家务
//
//  Created by lgs on 14-6-4.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_OrderVC_Master_Notivation_CustonCell.h"

@implementation Ty_OrderVC_Master_Notivation_CustonCell
@synthesize masterLeftDelegate;
@synthesize masterRightDelegate;
@synthesize notificationTypeLabel;
@synthesize requirementStateLabel;
@synthesize photoView;
@synthesize photoImageView;
@synthesize serverNameLabel;
@synthesize identityLabel;
@synthesize identityView;
@synthesize howMuchPeopleYZlabel;
@synthesize requirementNumberLabel;
@synthesize startTimeLabel;
@synthesize contactWithServerButton;
@synthesize contactLabel;
@synthesize quitRequirementButton;
@synthesize quitLabel;

@synthesize xuQiu;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setFrame:CGRectMake(10, 0, 300, 205)];
        
    }
    return self;
}
-(void) loadUIAndIndex:(int)_number
{
    UIImageView * firstImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 47)];
    [firstImageView setImage:JWImageName(@"i_setupcellbgtop")];
    firstImageView.userInteractionEnabled=YES;
    [firstImageView setHighlightedImage:[UIImage imageNamed:@""]];
    
    UIImageView * secondImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 47, 300, 98)];
    [secondImageView setImage:[UIImage imageNamed:@"i_setupcellbgtop"]];
    secondImageView.userInteractionEnabled=YES;
    [secondImageView setHighlightedImage:[UIImage imageNamed:@""]];

    UIImageView * thirdImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 47 + 98, 300, 205 - 47 -98)];
    [thirdImageView setImage:[UIImage imageNamed:@"i_setupcellbg"]];
    [thirdImageView setHighlightedImage:[UIImage imageNamed:@""]];
    thirdImageView.userInteractionEnabled=YES;

    [self.contentView addSubview:firstImageView];
    [self.contentView addSubview:secondImageView];
    [self.contentView addSubview:thirdImageView];
//    
//    [self.contentView sendSubviewToBack:firstImageView];
//    [self.contentView sendSubviewToBack:secondImageView];
//    [self.contentView sendSubviewToBack:thirdImageView];
    
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

//    upGrayLineView = [[UIView alloc]initWithFrame:CGRectMake(0, 47, 300, 1)];
//    [upGrayLineView setBackgroundColor:[UIColor grayColor]];
    
    photoView = [[UIView alloc]initWithFrame:CGRectMake(13, firstImageView.frame.origin.y + firstImageView.frame.size.height + 17, 63, 63)];
    photoView.backgroundColor =[UIColor clearColor];
    photoView.layer.borderColor= [[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1] CGColor];
    photoView.layer.borderWidth = 1;
    photoView.layer.masksToBounds = YES;
    photoView.layer.cornerRadius = 10;
    
    photoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 63, 63)];
    photoImageView.backgroundColor = [UIColor clearColor];
    [photoView addSubview:photoImageView];
    
    serverNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(96, firstImageView.frame.origin.y + firstImageView.frame.size.height + 15, 120, 14)];
    [self.serverNameLabel setBackgroundColor:[UIColor clearColor]];
    [self.serverNameLabel setFont:FONT14_SYSTEM];
    [self.serverNameLabel setTextColor:[UIColor blackColor]];
    [self.serverNameLabel setTextAlignment:NSTextAlignmentLeft];
    
    identityView = [[UIView alloc]initWithFrame:CGRectMake(serverNameLabel.frame.origin.x + serverNameLabel.frame.size.width + 10, firstImageView.frame.origin.y + firstImageView.frame.size.height + 13, 26, 16)];
    [identityView setBackgroundColor:[UIColor colorWithRed:89/255.0 green:164/255.0 blue:58/255.0 alpha:1]];
    identityView.layer.masksToBounds = YES;
    identityView.layer.borderWidth = 2;
    
    identityLabel =[[UILabel alloc]initWithFrame:CGRectMake(3, 3, 26, 10)];
    [self.identityLabel setBackgroundColor:[UIColor clearColor]];
    [self.identityLabel setFont:FONT10_SYSTEM];
    [self.identityLabel setTextColor:[UIColor whiteColor]];
    [self.identityLabel setTextAlignment:NSTextAlignmentCenter];
    [identityView addSubview:identityLabel];
    
    howMuchPeopleYZlabel =[[UILabel alloc]initWithFrame:CGRectMake(serverNameLabel.frame.origin.x + serverNameLabel.frame.size.width + 10,firstImageView.frame.origin.y + firstImageView.frame.size.height +15, 100, 14)];
    [self.howMuchPeopleYZlabel setBackgroundColor:[UIColor clearColor]];
    [self.howMuchPeopleYZlabel setFont:FONT14_SYSTEM];
    [self.howMuchPeopleYZlabel setTextColor:[UIColor blackColor]];
    [self.howMuchPeopleYZlabel setTextAlignment:NSTextAlignmentLeft];
    
    requirementNumberLabel =[[UILabel alloc]initWithFrame:CGRectMake(96,firstImageView.frame.origin.y + firstImageView.frame.size.height +45, 200, 13)];
    [self.requirementNumberLabel setBackgroundColor:[UIColor clearColor]];
    [self.requirementNumberLabel setFont:FONT13_SYSTEM];
    [self.requirementNumberLabel setTextColor:[UIColor grayColor]];
    [self.requirementNumberLabel setTextAlignment:NSTextAlignmentLeft];
    
    startTimeLabel =[[UILabel alloc]initWithFrame:CGRectMake(96,firstImageView.frame.origin.y + firstImageView.frame.size.height +64, 200, 13)];
    [self.startTimeLabel setBackgroundColor:[UIColor clearColor]];
    [self.startTimeLabel setFont:FONT13_SYSTEM];
    [self.startTimeLabel setTextColor:[UIColor grayColor]];
    [self.startTimeLabel setTextAlignment:NSTextAlignmentLeft];
    
    
    contactWithServerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [contactWithServerButton setFrame:CGRectMake(4, secondImageView.frame.origin.y + secondImageView.frame.size.height + 8, 141, 44)];
    [contactWithServerButton setImage:[UIImage imageNamed:@"contactButton"] forState:UIControlStateNormal];
    contactWithServerButton.exclusiveTouch = YES;
    [contactWithServerButton addTarget:self action:@selector(contactWithServerButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    contactWithServerButton.tag = 1000 + _number;
    
    contactLabel =[[UILabel alloc]initWithFrame:CGRectMake(40,15, 62, 15)];
    [self.contactLabel setBackgroundColor:[UIColor clearColor]];
    [self.contactLabel setFont:FONT15_SYSTEM];
    [self.contactLabel setTextColor:[UIColor whiteColor]];
    [self.contactLabel setTextAlignment:NSTextAlignmentCenter];
    [contactWithServerButton addSubview:contactLabel];
    
    
    quitRequirementButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [quitRequirementButton setFrame:CGRectMake(154, secondImageView.frame.origin.y + secondImageView.frame.size.height + 8, 141, 44)];
    [quitRequirementButton setImage:[UIImage imageNamed:@"quitOrderButton"] forState:UIControlStateNormal];
    quitRequirementButton.exclusiveTouch = YES;
    [quitRequirementButton addTarget:self action:@selector(quirRequirementButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    quitRequirementButton.tag = 2000 + _number;
    
    quitLabel =[[UILabel alloc]initWithFrame:CGRectMake(40,15, 62, 15)];
    [self.quitLabel setBackgroundColor:[UIColor clearColor]];
    [self.quitLabel setFont:FONT15_SYSTEM];
    [self.quitLabel setTextColor:[UIColor whiteColor]];
    [self.quitLabel setTextAlignment:NSTextAlignmentCenter];
    [quitRequirementButton addSubview:quitLabel];
    
    [self.contentView addSubview:notificationTypeLabel];
    [self.contentView addSubview:requirementStateLabel];
    [self.contentView addSubview:photoView];
    [self.contentView addSubview:serverNameLabel];
    [self.contentView addSubview:requirementNumberLabel];
    [self.contentView addSubview:startTimeLabel];
    [self.contentView addSubview:quitRequirementButton];
    
    
    self.layer.borderWidth = 1;
    self.layer.borderColor = [[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1] CGColor];
}
-(void)loadValues
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
                break;
            case 3:
                requirementStateLabel.text = @"已关闭";
                break;
            case 6:
                if ([xuQiu.candidateStatus intValue] == 0)
                {
                    requirementStateLabel.text = @"带服务方应征";
                }
                else
                {
                    requirementStateLabel.text = @"我已应征";
                }
                break;
            default:
                requirementStateLabel.text = @"数据出错";
                break;
        }
        requirementNumberLabel.text = [NSString stringWithFormat:@"抢单单号%@",xuQiu.requirementNumber];
        startTimeLabel.text = [NSString stringWithFormat:@"服务时间%@",xuQiu.startTime];
        if ([xuQiu.requirement_Stage intValue] == 2 || [xuQiu.requirement_Stage intValue] == 3)
        {//确定了人选的
            serverNameLabel.text = xuQiu.serverObject.userRealName;
            switch ([xuQiu.serverObject.userType intValue])
            {
                case 0:
                    identityLabel.text = @"商户";
                    break;
                case 1:
                    identityLabel.text = [xuQiu.serverObject.respectiveCompanies substringToIndex:4];
                    break;
                case 2:
                    identityLabel.text = @"个人";
                    break;
                default:
                    break;
                
                CGSize  nameSize =   [serverNameLabel.text sizeWithFont:FONT14_SYSTEM constrainedToSize:CGSizeMake(MAXFLOAT, 14)];
                [serverNameLabel setFrame:CGRectMake(serverNameLabel.frame.origin.x, serverNameLabel.frame.origin.y, nameSize.width, 14)];
                    
                CGSize companySize = [identityLabel.text sizeWithFont:FONT10_SYSTEM constrainedToSize:CGSizeMake(MAXFLOAT, 10)];
                
                [identityLabel setFrame:CGRectMake(3, 3, companySize.width, 10)];
                
                [identityView setFrame:CGRectMake(serverNameLabel.frame.origin.x + serverNameLabel.frame.size.width + 10,serverNameLabel.frame.origin.y -1, identityLabel.frame.size.width + 6, 16)];
                    
                [self.contentView addSubview:identityView];
            }
        }
        else
        {
            serverNameLabel.text = @"服务方未定";
            CGSize  size =   [serverNameLabel.text sizeWithFont:FONT14_SYSTEM constrainedToSize:CGSizeMake(MAXFLOAT, 14)];
            [serverNameLabel setFrame:CGRectMake(serverNameLabel.frame.origin.x, serverNameLabel.frame.origin.y, size.width, 14)];
            
            [howMuchPeopleYZlabel setFrame:CGRectMake(serverNameLabel.frame.origin.x + serverNameLabel.frame.size.width + 2, serverNameLabel.frame.origin.y, 100, 14)];
            howMuchPeopleYZlabel.text = [NSString stringWithFormat:@"(%@人应征)",xuQiu.employeeCount];
            [self.contentView addSubview:howMuchPeopleYZlabel];
            contactWithServerButton.hidden = YES;
        }
        contactLabel.text = @"联系商户";
        quitLabel.text = @"取消抢单";
    }
    else
    {
        notificationTypeLabel.text = [NSString stringWithFormat:@"%@预约",xuQiu.workName];
        switch ([xuQiu.requirement_Stage intValue])
        {
            case 1:
                requirementStateLabel.text = @"待服务方确认";
                break;
            case 2:
                requirementStateLabel.text = @"交易中";
                break;
            case 3:
                requirementStateLabel.text = @"已关闭";
                break;
            default:
                requirementStateLabel.text = @"数据出错";
                break;
        }
        requirementNumberLabel.text = [NSString stringWithFormat:@"预约单号%@",xuQiu.requirementNumber];
        startTimeLabel.text = [NSString stringWithFormat:@"服务时间%@",xuQiu.startTime];
        serverNameLabel.text = xuQiu.serverObject.userRealName;
        switch ([xuQiu.serverObject.userType intValue])
        {
            case 0:
                identityLabel.text = @"商户";
                break;
            case 1:
                identityLabel.text = [xuQiu.serverObject.respectiveCompanies substringToIndex:4];
                break;
            case 2:
                identityLabel.text = @"个人";
                break;
            default:
                break;
                
                [self.contentView addSubview:identityView];
        }
        contactLabel.text = @"联系商户";
        quitLabel.text = @"取消预约";

    }
    //头像
    if ([xuQiu.requirement_Stage intValue] == 1 || [xuQiu.requirement_Stage intValue] == 2 || [xuQiu.requirement_Stage intValue] == 3)
    {
        //中介
        if ([xuQiu.serverObject.userType intValue] == 0)
        {
            [photoImageView setImageWithURL:[NSURL URLWithString:xuQiu.serverObject.companyPhoto] placeholderImage:[UIImage imageNamed:@"Contact_image2"]];
            
        }
        else
        {
            //0 是nan  1是nv
            if ([xuQiu.serverObject.sex intValue] == 0)
            {
                [photoImageView setImageWithURL:[NSURL URLWithString:xuQiu.serverObject.headPhoto] placeholderImage:[UIImage imageNamed:@"Contact_image1"]];
            }
            else
            {
                [photoImageView setImageWithURL:[NSURL URLWithString:xuQiu.serverObject.headPhoto] placeholderImage:[UIImage imageNamed:@"Contact_image"]];
            }
        }
    }
    else
    {
        [photoImageView setImage:[UIImage imageNamed:@"Contact_image"]];
    }
    //确定的人选 或者未确定
}
/**两个按钮触发的方法*/
-(void)contactWithServerButtonPressed:(UIButton *)sender
{
    if (masterLeftDelegate)
    {
        if ([masterLeftDelegate respondsToSelector:@selector(masterLeftButtonAction:)])
        {
            [masterLeftDelegate masterLeftButtonAction:sender];
        }
    }
}
-(void)quirRequirementButtonPressed:(UIButton *)sender
{
    if (masterRightDelegate)
    {
        if ([masterRightDelegate respondsToSelector:@selector(masterRightButtonAction:)])
        {
            [masterRightDelegate masterRightButtonAction:sender];
        }
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
