//
//  Ty_Order_DetailCell.m
//  腾云家务
//
//  Created by lgs on 14-6-23.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_Order_DetailCell.h"
#import "Ty_News_Busine_HandlePlist.h"

static float hideInfoHigh;
#define couponGreenColor [UIColor colorWithRed:0 green:208/255.0 blue:66/255.0 alpha:1]

@implementation Ty_Order_DetailCell
@synthesize phoneCall;
@synthesize detailXuQiu;
@synthesize serviceAreaLabel, serviceAreaValue;
@synthesize detailAddressLabel, detailAddressValue;
@synthesize connactNameLabel,connactNameValue;
@synthesize connactIphoneNumberLabel,connactIphoneNumberValue;
@synthesize otherAskLabel,otherAskValue;
@synthesize requirementGuid;
@synthesize unitPriceLabel,unitPriceValue;
@synthesize couponInfoLabel,couponInfoValue;
@synthesize totalPriceLabel,totalPriceValue;
@synthesize realPriceLabel,realPriceValue;
@synthesize payStageLabel,payStageVlaue;
@synthesize phoneCallButton;

#define BianColor [UIColor colorWithRed:218.0/255.0 green:218.0/255.0 blue:218.0/255.0 alpha:1]

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        hideInfoHigh = 0;
       // [self loadUI];
    }
    return self;
}
-(void)loadUI
{
    serviceAreaLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,10, 80, 15)];
    [serviceAreaLabel setBackgroundColor:[UIColor clearColor]];
    [serviceAreaLabel setFont:FONT14_BOLDSYSTEM];
    [serviceAreaLabel setTextColor:[UIColor grayColor]];
    serviceAreaLabel.text = @"所在区域:";
    
    serviceAreaValue =[[UILabel alloc]initWithFrame:CGRectMake(85, serviceAreaLabel.frame.origin.y, 200, 15)];
    serviceAreaValue.numberOfLines=0;
    serviceAreaValue.lineBreakMode = NSLineBreakByCharWrapping;
    [serviceAreaValue setBackgroundColor:[UIColor clearColor]];
    [serviceAreaValue setTextColor:[UIColor grayColor]];
    [serviceAreaValue setFont:FONT14_BOLDSYSTEM];
    
    connactNameLabel =[[UILabel alloc]initWithFrame:CGRectMake(10, serviceAreaValue.frame.origin.y + serviceAreaValue.frame.size.height + 10, 80, 15)];
    [connactNameLabel setBackgroundColor:[UIColor clearColor]];
    [connactNameLabel setFont:FONT14_BOLDSYSTEM];
    [connactNameLabel setTextColor:[UIColor grayColor]];
    connactNameLabel.text = @"联 系 人:";
    
    connactNameValue =[[UILabel alloc]initWithFrame:CGRectMake(85, connactNameLabel.frame.origin.y, 200, 15)];
    [connactNameValue setBackgroundColor:[UIColor clearColor]];
    [connactNameValue setTextColor:[UIColor grayColor]];
    [connactNameValue setFont:FONT14_BOLDSYSTEM];
    
    couponInfoLabel =  [[UILabel alloc]initWithFrame:CGRectMake(10, connactNameLabel.frame.origin.y + connactNameLabel.frame.size.height + 10, 80, 15)];
    [couponInfoLabel setBackgroundColor:[UIColor clearColor]];
    [couponInfoLabel setFont:FONT14_BOLDSYSTEM];
    [couponInfoLabel setTextColor:[UIColor grayColor]];
    couponInfoLabel.text = @"优 惠 券:";
    
    couponInfoValue = [[UILabel alloc]initWithFrame:CGRectMake(85, couponInfoLabel.frame.origin.y, 200, 15)];
    [couponInfoValue setBackgroundColor:[UIColor clearColor]];
    [couponInfoValue setFont:FONT14_BOLDSYSTEM];
    [couponInfoValue setTextColor:couponGreenColor];

    
    otherAskLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, couponInfoLabel.frame.origin.y + couponInfoLabel.frame.size.height + 10, 80, 15)];
    [otherAskLabel setBackgroundColor:[UIColor clearColor]];
    [otherAskLabel setFont:FONT14_BOLDSYSTEM];
    [otherAskLabel setTextColor:[UIColor grayColor]];
    otherAskLabel.text = @"特殊要求:";
    
    otherAskValue = [[UILabel alloc]initWithFrame:CGRectMake(85, otherAskLabel.frame.origin.y, 200, 15)];
    otherAskValue.numberOfLines=0;
    otherAskValue.lineBreakMode = NSLineBreakByCharWrapping;
    [otherAskValue setBackgroundColor:[UIColor clearColor]];
    [otherAskValue setFont:FONT14_BOLDSYSTEM];
    [otherAskValue setTextColor:[UIColor grayColor]];
    
    [self.contentView addSubview:serviceAreaLabel];
    [self.contentView addSubview:serviceAreaValue];
    [self.contentView addSubview:connactNameLabel];
    [self.contentView addSubview:connactNameValue];
    [self.contentView addSubview:couponInfoLabel];
    [self.contentView addSubview:couponInfoValue];
    [self.contentView addSubview:otherAskLabel];
    [self.contentView addSubview:otherAskValue];
    
    
    self.layer.masksToBounds = YES;
    //给图层添加一个有色边框
    self.layer.borderWidth = 1;
    self.layer.borderColor = [BianColor CGColor];
}

-(void)loadDetailInformation
{
    detailAddressLabel =[[UILabel alloc]initWithFrame:CGRectMake(10, detailAddressValue.frame.origin.y + detailAddressValue.frame.size.height + 5, 80, 15)];
    [detailAddressLabel setBackgroundColor:[UIColor clearColor]];
    [detailAddressLabel setFont:FONT14_BOLDSYSTEM];
    [detailAddressLabel setTextColor:[UIColor grayColor]];
    detailAddressLabel.text = @"详细地址:";
    
    detailAddressValue =[[UILabel alloc]initWithFrame:CGRectMake(85, detailAddressLabel.frame.origin.y, 200, 15)];
    detailAddressValue.numberOfLines=0;
    detailAddressValue.lineBreakMode = NSLineBreakByCharWrapping;
    [detailAddressValue setBackgroundColor:[UIColor clearColor]];
    [detailAddressValue setTextColor:[UIColor grayColor]];
    [detailAddressValue setFont:FONT14_BOLDSYSTEM];
    detailAddressValue.text = [NSString stringWithFormat:@"%@",detailXuQiu.addressDetail];
    
    [connactNameLabel setFrame:CGRectMake(10, detailAddressValue.frame.origin.y + detailAddressValue.frame.size.height + 10, 80, 15)];
    
    connactIphoneNumberLabel =[[UILabel alloc]initWithFrame:CGRectMake(10, connactNameValue.frame.origin.y + connactNameValue.frame.size.height + 5, 80, 15)];
    [connactIphoneNumberLabel setBackgroundColor:[UIColor clearColor]];
    [connactIphoneNumberLabel setFont:FONT14_BOLDSYSTEM];
    [connactIphoneNumberLabel setTextColor:[UIColor grayColor]];
    connactIphoneNumberLabel.text = @"联系电话:";
    
    phoneCallButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [phoneCallButton setFrame:CGRectMake(85 -5, connactIphoneNumberLabel.frame.origin.y, 130, 26)];
    
    UIView * redLineView = [[UIView alloc]initWithFrame:CGRectMake(5, 18, 105, 1)];
    [redLineView setBackgroundColor:[UIColor redColor]];
    
    connactIphoneNumberValue =[[UILabel alloc]initWithFrame:CGRectMake(5, 1, 200, 14)];
    [connactIphoneNumberValue setBackgroundColor:[UIColor clearColor]];
    [connactIphoneNumberValue setTextColor:[UIColor redColor]];
    [connactIphoneNumberValue setFont:FONT14_BOLDSYSTEM];
    connactIphoneNumberValue.text = detailXuQiu.contactPhone;
    connactIphoneNumberValue.textAlignment = NSTextAlignmentLeft;
    
    UIImageView * phoneImageVie =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"redPhoneIcon"]];
    [phoneImageVie setFrame:CGRectMake(94, 1, 14, 18)];
    
    [phoneCallButton addSubview:redLineView];
    [phoneCallButton addSubview:connactIphoneNumberValue];
    [phoneCallButton addSubview:phoneImageVie];
    [phoneCallButton addTarget:self action:@selector(contactPhoneCallPressed) forControlEvents:UIControlEventTouchUpInside];
    
    //单价
    unitPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, connactIphoneNumberLabel.frame.origin.y + connactIphoneNumberLabel.frame.size.height + 10, 80, 15)];
    [unitPriceLabel setBackgroundColor:[UIColor clearColor]];
    [unitPriceLabel setFont:FONT14_BOLDSYSTEM];
    [unitPriceLabel setTextColor:[UIColor grayColor]];
    unitPriceLabel.text = @"单    价:";
    
    unitPriceValue =[[UILabel alloc]initWithFrame:CGRectMake(85, unitPriceLabel.frame.origin.y, 200, 15)];
    [unitPriceValue setBackgroundColor:[UIColor clearColor]];
    [unitPriceValue setTextColor:[UIColor clearColor]];
    [unitPriceValue setFont:FONT14_BOLDSYSTEM];
    
    //优惠券
    [couponInfoLabel setFrame:CGRectMake(10, unitPriceLabel.frame.origin.y + unitPriceLabel.frame.size.height + 5, 80, 15)];
    [couponInfoValue setFrame:CGRectMake(85, couponInfoLabel.frame.origin.y, 206, 26)];
    
    //应付金额
    totalPriceLabel =  [[UILabel alloc]initWithFrame:CGRectMake(10, couponInfoLabel.frame.origin.y + couponInfoLabel.frame.size.height + 5, 80, 15)];
    [totalPriceLabel setBackgroundColor:[UIColor clearColor]];
    [totalPriceLabel setFont:FONT14_BOLDSYSTEM];
    [totalPriceLabel setTextColor:[UIColor grayColor]];
    totalPriceLabel.text = @"应付金额:";
    
    totalPriceValue =[[UILabel alloc]initWithFrame:CGRectMake(85, totalPriceLabel.frame.origin.y, 200, 15)];
    [totalPriceValue setBackgroundColor:[UIColor clearColor]];
    [totalPriceValue setTextColor:[UIColor redColor]];
    [totalPriceValue setFont:FONT14_BOLDSYSTEM];
    
    Ty_News_Busine_HandlePlist * tempBusine = [[Ty_News_Busine_HandlePlist alloc]init];
    
    NSString * unitString = [NSString stringWithString:[tempBusine findWorkUnitAndWorkName:detailXuQiu.workName]];
    
    //实际支付
    realPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, totalPriceLabel.frame.origin.y + totalPriceLabel.frame.size.height + 5, 80, 15)];
    [realPriceLabel setBackgroundColor:[UIColor clearColor]];
    [realPriceLabel setFont:FONT14_BOLDSYSTEM];
    [realPriceLabel setTextColor:[UIColor grayColor]];
    realPriceLabel.text = @"实际支付:";
    
    realPriceValue =[[UILabel alloc]initWithFrame:CGRectMake(85, realPriceLabel.frame.origin.y, 200, 15)];
    [realPriceValue setBackgroundColor:[UIColor clearColor]];
    [realPriceValue setTextColor:[UIColor redColor]];
    [realPriceValue setFont:FONT14_BOLDSYSTEM];

    if ([detailXuQiu.requirement_Stage intValue] != 2 && [detailXuQiu.requirement_Stage intValue] != 3)
    {
        unitPriceValue.text = @"待定";
        totalPriceValue.text = @"待定";
        realPriceValue.text = @"待定";
    }
    else
    {
        unitPriceValue.text =[NSString stringWithFormat:@"%.2f元/%@",[[detailXuQiu priceUnit]floatValue],unitString];
        float tempFloat = [[detailXuQiu priceUnit]floatValue] *[[detailXuQiu workAmount]intValue];
        
        
        if (![detailXuQiu.usedCouponInfo.couponRequiremnetGuid isEqualToString:@""])
        {
            tempFloat = tempFloat - [detailXuQiu.usedCouponInfo.couponCutPrice floatValue];
        }
        if (tempFloat < 0)
        {
            tempFloat = 0.0;
        }
        totalPriceValue.text = [NSString stringWithFormat:@"%.2f元%@",tempFloat,unitString];

        
        realPriceValue.text = [NSString stringWithFormat:@"%.2f元",[detailXuQiu.realMoney floatValue]];
    }

    //支付状态
    payStageLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, realPriceLabel.frame.origin.y + realPriceLabel.frame.size.height + 5, 80, 15)];
    [payStageLabel setBackgroundColor:[UIColor clearColor]];
    [payStageLabel setFont:FONT14_BOLDSYSTEM];
    [payStageLabel setTextColor:[UIColor grayColor]];
    payStageLabel.text = @"支付状态:";
    
    payStageVlaue =[[UILabel alloc]initWithFrame:CGRectMake(85, payStageLabel.frame.origin.y, 200, 15)];
    [payStageVlaue setBackgroundColor:[UIColor clearColor]];
    [payStageVlaue setTextColor:[UIColor redColor]];
    [payStageVlaue setFont:FONT14_BOLDSYSTEM];

    
    if ([detailXuQiu.requirement_Stage intValue] == 2 || [detailXuQiu.requirement_Stage intValue] == 3)
    {
        if ([detailXuQiu.isApply intValue] == 3)
        {
            if ([detailXuQiu.usedCouponInfo.couponRequiremnetGuid isEqualToString:@""])
            {
                payStageVlaue.text = @"暂未支付";
            }
            else
            {
                payStageVlaue.text = [NSString stringWithFormat:@"已使用优惠券(%@元)",detailXuQiu.usedCouponInfo.couponCutPrice];
            }
        }
        else if ([detailXuQiu.isApply intValue] == 2)
        {
            payStageVlaue.text = @"已支付-线下";
        }
        else
        {
            payStageVlaue.text = @"已支付-线上";
        }
    }
    else
    {
        if ([detailXuQiu.usedCouponInfo.couponRequiremnetGuid isEqualToString:@""])
        {
            payStageVlaue.text = @"暂未支付";
        }
        else
        {
            payStageVlaue.text = [NSString stringWithFormat:@"已使用优惠券(%@元)",detailXuQiu.usedCouponInfo.couponCutPrice];
        }
    }
    
    CGSize detailAddressSize = [detailAddressValue.text sizeWithFont:FONT14_BOLDSYSTEM constrainedToSize:CGSizeMake(detailAddressValue.frame.size.width, detailAddressValue.frame.size.height * 3) lineBreakMode:NSLineBreakByCharWrapping];
    if (detailAddressSize.height > detailAddressValue.frame.size.height)
    {
        hideInfoHigh = detailAddressSize.height +5 + 80;
    }
    else
    {
        hideInfoHigh = 22 + 5 + 80;
    }
    
    
    
    [self.contentView addSubview:detailAddressLabel];
    [self.contentView addSubview:detailAddressValue];
    [self.contentView addSubview:connactIphoneNumberLabel];
    [self.contentView addSubview:phoneCallButton];
    [self.contentView addSubview:unitPriceLabel];
    [self.contentView addSubview:unitPriceValue];
    [self.contentView addSubview:totalPriceLabel];
    [self.contentView addSubview:totalPriceValue];
    [self.contentView addSubview:realPriceLabel];
    [self.contentView addSubview:realPriceValue];
    [self.contentView addSubview:payStageLabel];
    [self.contentView addSubview:payStageVlaue];
}

-(void)loadValues
{
    if ([detailXuQiu.region isEqualToString:@""])
    {
        if ([detailXuQiu.province isEqualToString:@""] && [detailXuQiu.city isEqualToString:@""] && [detailXuQiu.area isEqualToString:@""])
        {//活动的bug，没有传省市区
            serviceAreaValue.text = [NSString stringWithFormat:@"%@",detailXuQiu.addressDetail];
        }
        else
        {
            serviceAreaValue.text = [NSString stringWithFormat:@"%@  %@  %@",detailXuQiu.province,detailXuQiu.city,detailXuQiu.area];
        }
    }
    else
    {
        serviceAreaValue.text = [NSString stringWithFormat:@"%@  %@  %@  %@",detailXuQiu.province,detailXuQiu.city,detailXuQiu.area,detailXuQiu.region];
    }
 
    connactNameValue.text = detailXuQiu.contact;
    
    //优惠券的相关信息
    if ([detailXuQiu.usedCouponInfo.couponRequiremnetGuid isEqualToString:@""])
    {
        couponInfoValue.text = @"该订单没有使用优惠券";
    }
    else
    {
        NSString * moneyString = [NSString stringWithFormat:@"-%@元",detailXuQiu.usedCouponInfo.couponCutPrice];
        NSString * couponNumberString = [NSString stringWithFormat:@" (序列号:%@)",detailXuQiu.usedCouponInfo.couponNo];
        
        couponInfoValue.text = [NSString stringWithFormat:@"%@ %@",moneyString,couponNumberString];
    }
    
    if ([detailXuQiu.userTypeBaseOnRequirement intValue] == 0)
    {//当前我是雇主
        [self loadDetailInformation];
    }
    else
    {
        if ([detailXuQiu.requirement_Type isEqualToString:@"1"])
        {
            [self loadDetailInformation];
        }
        else
        {
            if ([detailXuQiu.requirement_Stage intValue] == 2 || [detailXuQiu.requirement_Stage intValue] == 3 || [detailXuQiu.requirement_Stage intValue] == 7)
            {
                if ([detailXuQiu.serverObject.userType intValue] == 1 || [detailXuQiu.serverObject.userType intValue] == 0)
                {
                    if ([detailXuQiu.serverObject.companiesGuid isEqualToString:MyLoginUserGuid])
                    {
                        [self loadDetailInformation];
                    }
                    else
                        hideInfoHigh = 0;
                }
                else
                {
                    if ([detailXuQiu.serverObject.userGuid isEqualToString:MyLoginUserGuid])
                    {
                        [self loadDetailInformation];
                    }
                    else
                        hideInfoHigh = 0;
                }
            }
        }
    }
}

/*
 高度调整
 */
-(void)setHeight
{
    CGSize serviceAreaSize = [serviceAreaValue.text sizeWithFont:FONT14_BOLDSYSTEM constrainedToSize:CGSizeMake(serviceAreaValue.frame.size.width, serviceAreaValue.frame.size.height * 3) lineBreakMode:NSLineBreakByCharWrapping];
    
    
    if (serviceAreaSize.height > serviceAreaValue.frame.size.height)
        [serviceAreaValue setFrame:CGRectMake(85, serviceAreaLabel.frame.origin.y, 200, serviceAreaSize.height)];
    else
        [serviceAreaValue setFrame:CGRectMake(85, serviceAreaLabel.frame.origin.y, 200, 15)];
    
    
    if (hideInfoHigh != 0)
    {
        [detailAddressLabel setFrame:CGRectMake(10, serviceAreaValue.frame.origin.y + serviceAreaValue.frame.size.height + 5, 80, 15)];
        CGSize detailAddressSize = [detailAddressValue.text sizeWithFont:FONT14_BOLDSYSTEM constrainedToSize:CGSizeMake(detailAddressValue.frame.size.width, detailAddressValue.frame.size.height * 3) lineBreakMode:NSLineBreakByCharWrapping];
        if (detailAddressSize.height > detailAddressValue.frame.size.height)
            [detailAddressValue setFrame:CGRectMake(85, detailAddressLabel.frame.origin.y, 200, detailAddressSize.height)];
        else
            [detailAddressValue setFrame:CGRectMake(85, detailAddressLabel.frame.origin.y, 200, 15)];
        
        
        [connactNameLabel setFrame:CGRectMake(10, detailAddressValue.frame.origin.y + detailAddressValue.frame.size.height + 10, 80, 15)];
        [connactNameValue setFrame:CGRectMake(85, connactNameLabel.frame.origin.y , 200, 15)];
        
        [connactIphoneNumberLabel setFrame:CGRectMake(10, connactNameValue.frame.origin.y + connactNameValue.frame.size.height + 5 , 80, 14)];
        [phoneCallButton setFrame:CGRectMake(85 -5, connactIphoneNumberLabel.frame.origin.y, 200, 26)];
        
        //单价
        [unitPriceLabel setFrame:CGRectMake(10, connactIphoneNumberLabel.frame.origin.y + connactIphoneNumberLabel.frame.size.height + 10, 80, 15)];
        [unitPriceValue setFrame:CGRectMake(85, unitPriceLabel.frame.origin.y, 206, 15)];
        
        //优惠券
        [couponInfoLabel setFrame:CGRectMake(10, unitPriceLabel.frame.origin.y + unitPriceLabel.frame.size.height + 5, 80, 15)];
        [couponInfoValue setFrame:CGRectMake(85, couponInfoLabel.frame.origin.y, 206, 26)];
        
        //应付
        [totalPriceLabel setFrame:CGRectMake(10, couponInfoLabel.frame.origin.y + couponInfoLabel.frame.size.height + 5, 80, 15)];
        [totalPriceValue setFrame:CGRectMake(85, totalPriceLabel.frame.origin.y, 206, 26)];
        
        //实际支付
        [realPriceLabel setFrame:CGRectMake(10, totalPriceLabel.frame.origin.y + totalPriceLabel.frame.size.height + 5, 80, 15)];
        [realPriceValue setFrame:CGRectMake(85, realPriceLabel.frame.origin.y, 206, 26)];
        
        //支付状态
        [payStageLabel setFrame:CGRectMake(10, realPriceLabel.frame.origin.y + realPriceLabel.frame.size.height + 5, 80, 15)];
        [payStageVlaue setFrame:CGRectMake(85, payStageLabel.frame.origin.y, 206, 26)];

        
        [otherAskLabel setFrame:CGRectMake(10, payStageLabel.frame.origin.y + payStageLabel.frame.size.height + 10, 80, 15)];

    }
    else
    {
        [connactNameLabel setFrame:CGRectMake(10, serviceAreaValue.frame.origin.y + serviceAreaValue.frame.size.height + 10, 80, 15)];
        [connactNameValue setFrame:CGRectMake(85, connactNameLabel.frame.origin.y, 200, 15)];
        
        [couponInfoLabel setFrame:CGRectMake(10, connactNameLabel.frame.origin.y + connactNameLabel.frame.size.height + 10, 80, 15)];
        [couponInfoValue setFrame:CGRectMake(85, couponInfoLabel.frame.origin.y, 206, 26)];
        
        [otherAskLabel setFrame:CGRectMake(10, couponInfoValue.frame.origin.y + couponInfoValue.frame.size.height + 10 + hideInfoHigh, 80, 15)];
    }

    //特殊要求那段的处理
    [self otherStringCombine];
    otherAskValue.text = requirementStr;
    CGSize otherAskSize = [otherAskValue.text sizeWithFont:FONT14_BOLDSYSTEM constrainedToSize:CGSizeMake(otherAskValue.frame.size.width, otherAskValue.frame.size.height * 7) lineBreakMode:NSLineBreakByCharWrapping];
    if (otherAskSize.height >= otherAskValue.frame.size.height)
    {
        [otherAskValue setFrame:CGRectMake(85, otherAskLabel.frame.origin.y, 200, otherAskSize.height)];
    }
    else
        [otherAskValue setFrame:CGRectMake(85, otherAskLabel.frame.origin.y, 200, 15)];
    
    [self setFrame:CGRectMake(0, 0, MainFrame.size.width, otherAskValue.frame.origin.y + otherAskValue.frame.size.height +5)];
}

/*
 联系电话的点击
 */
-(void)contactPhoneCallPressed
{
    if (phoneCall)
    {
        if ([phoneCall respondsToSelector:@selector(phoneCallPressed)])
        {
            [phoneCall phoneCallPressed];
        }
    }
}
/*
 将其他要求合并
 */
-(NSString *)otherStringCombine
{
    requirementStr = [NSMutableString stringWithString:@""];

    if ([detailXuQiu.ask_Price isEqualToString:@"0"] || [detailXuQiu.ask_Price isEqualToString:@"-1"] || ISNULLSTR(detailXuQiu.ask_Price))
    {
        
    }
    else
    {
        requirementStr = [NSMutableString stringWithString:[requirementStr stringByAppendingString:@"价格:"]];
        requirementStr = [NSMutableString stringWithString:[requirementStr stringByAppendingString:detailXuQiu.ask_Price]];
        requirementStr = [NSMutableString stringWithString:[requirementStr stringByAppendingString:@" "]];
    }
    if ([detailXuQiu.ask_Age intValue] !=-1)
    {
        requirementStr = [NSMutableString stringWithString:[requirementStr stringByAppendingString:@"年龄:"]];
        requirementStr = [NSMutableString stringWithString:[requirementStr stringByAppendingString:[DIC_AGE objectForKey:detailXuQiu.ask_Age]]];
        requirementStr = [NSMutableString stringWithString:[requirementStr stringByAppendingString:@" "]];
    }
    if ([detailXuQiu.ask_Sex intValue] !=-1)
    {
        requirementStr = [NSMutableString stringWithString:[requirementStr stringByAppendingString:@"性别:"]];
        requirementStr = [NSMutableString stringWithString:[requirementStr stringByAppendingString:[DIC_SEX objectForKey:detailXuQiu.ask_Sex]]];
        requirementStr = [NSMutableString stringWithString:[requirementStr stringByAppendingString:@" "]];
    }
    if ([detailXuQiu.ask_Education intValue] !=-1)
    {
        requirementStr = [NSMutableString stringWithString:[requirementStr stringByAppendingString:@"学历:"]];
        requirementStr = [NSMutableString stringWithString:[requirementStr stringByAppendingString:[DIC_EDUCATION objectForKey:detailXuQiu.ask_Education]]];
        requirementStr = [NSMutableString stringWithString:[requirementStr stringByAppendingString:@" "]];
    }
    if (![detailXuQiu.ask_Ethnic isEqualToString:@"不限"])
    {
        requirementStr = [NSMutableString stringWithString:[requirementStr stringByAppendingString:@"民族:"]];
        requirementStr = [NSMutableString stringWithString:[requirementStr stringByAppendingString:detailXuQiu.ask_Ethnic]];
        requirementStr = [NSMutableString stringWithString:[requirementStr stringByAppendingString:@" "]];
    }
    if ([detailXuQiu.ask_WorkExperience intValue] !=-1)
    {
        requirementStr = [NSMutableString stringWithString:[requirementStr stringByAppendingString:@"工作经验:"]];
        requirementStr = [NSMutableString stringWithString:[requirementStr stringByAppendingString:[DIC_WORKEXPRIENCE objectForKey:detailXuQiu.ask_WorkExperience]]];
        requirementStr = [NSMutableString stringWithString:[requirementStr stringByAppendingString:@" "]];
    }
    if (![detailXuQiu.ask_Hometown isEqualToString:@"不限"])
    {
        requirementStr = [NSMutableString stringWithString:[requirementStr stringByAppendingString:@"籍贯:"]];
        requirementStr = [NSMutableString stringWithString:[requirementStr stringByAppendingString:detailXuQiu.ask_Hometown]];
        requirementStr = [NSMutableString stringWithString:[requirementStr stringByAppendingString:@" "]];
    }
    if (![detailXuQiu.ask_Other isEqualToString:@"不限"])
    {
        requirementStr = [NSMutableString stringWithString:[requirementStr stringByAppendingString:@"其他要求:"]];
        requirementStr = [NSMutableString stringWithString:[requirementStr stringByAppendingString:detailXuQiu.ask_Other]];
        requirementStr = [NSMutableString stringWithString:[requirementStr stringByAppendingString:@" "]];
    }
    if ([requirementStr isEqualToString:@""])
    {
        requirementStr = [NSMutableString stringWithString:@"无"];
    }
    return requirementStr;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
