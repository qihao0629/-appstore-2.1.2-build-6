//
//  Ty_Order_MasterLook_DetailCell.m
//  腾云家务
//
//  Created by lgs on 14-7-8.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_Order_MasterLook_DetailCell.h"
#import "Ty_News_Busine_HandlePlist.h"

#define couponGreenColor [UIColor colorWithRed:0 green:208/255.0 blue:66/255.0 alpha:1]

@implementation Ty_Order_MasterLook_DetailCell
@synthesize masterLookDetailXuQiu;
@synthesize serviceAddressLabel;
@synthesize startTimeLabel;
@synthesize workCountLabel;
@synthesize unitPriceLabel;
@synthesize couponInfoLabel;
@synthesize totalPriceLabel;
@synthesize realPriceLabel;
@synthesize payStageLabel;
@synthesize remarkLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    
    }
    return self;
}
-(void)loadUI
{
    serviceAddressLabel =  [[UILabel alloc]initWithFrame:CGRectMake(12,14, 300, 14)];
    [serviceAddressLabel setBackgroundColor:[UIColor clearColor]];
    [serviceAddressLabel setFont:FONT14_BOLDSYSTEM];
    [serviceAddressLabel setTextColor:[UIColor grayColor]];
    serviceAddressLabel.numberOfLines=0;
    serviceAddressLabel.lineBreakMode = NSLineBreakByCharWrapping;
    
    startTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, serviceAddressLabel.frame.origin.y + serviceAddressLabel.frame.size.height + 8, 300, 14)];
    [startTimeLabel setBackgroundColor:[UIColor clearColor]];
    [startTimeLabel setFont:FONT14_BOLDSYSTEM];
    [startTimeLabel setTextColor:[UIColor grayColor]];

    workCountLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, startTimeLabel.frame.origin.y + startTimeLabel.frame.size.height + 8, 300, 14)];
    [workCountLabel setBackgroundColor:[UIColor clearColor]];
    [workCountLabel setFont:FONT14_BOLDSYSTEM];
    [workCountLabel setTextColor:[UIColor grayColor]];

    unitPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, workCountLabel.frame.origin.y + workCountLabel.frame.size.height + 8, 300, 14)];
    [unitPriceLabel setBackgroundColor:[UIColor clearColor]];
    [unitPriceLabel setFont:FONT14_BOLDSYSTEM];
    [unitPriceLabel setTextColor:[UIColor grayColor]];
    
    couponInfoLabel = [[CustomLabel alloc]initWithFrame:CGRectMake(12, unitPriceLabel.frame.origin.y + unitPriceLabel.frame.size.height + 8, 300, 14)];

    totalPriceLabel = [[CustomLabel alloc]initWithFrame:CGRectMake(12, couponInfoLabel.frame.origin.y + couponInfoLabel.frame.size.height + 8, 300, 14)];

    realPriceLabel = [[CustomLabel alloc]initWithFrame:CGRectMake(12, totalPriceLabel.frame.origin.y + totalPriceLabel.frame.size.height + 8, 300, 14)];
    
    payStageLabel = [[CustomLabel alloc]initWithFrame:CGRectMake(12, totalPriceLabel.frame.origin.y + totalPriceLabel.frame.size.height + 8, 300, 14)];
    
    remarkLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, payStageLabel.frame.origin.y + payStageLabel.frame.size.height + 8, 300, 14)];
    [remarkLabel setBackgroundColor:[UIColor clearColor]];
    [remarkLabel setFont:FONT14_BOLDSYSTEM];
    [remarkLabel setTextColor:[UIColor grayColor]];
    remarkLabel.numberOfLines=0;
    remarkLabel.lineBreakMode = NSLineBreakByCharWrapping;


    [self.contentView addSubview:serviceAddressLabel];
    [self.contentView addSubview:startTimeLabel];
    [self.contentView addSubview:workCountLabel];
    [self.contentView addSubview:unitPriceLabel];
    [self.contentView addSubview:couponInfoLabel];
    [self.contentView addSubview:totalPriceLabel];
    [self.contentView addSubview:realPriceLabel];
    [self.contentView addSubview:payStageLabel];
    [self.contentView addSubview:remarkLabel];
}
-(void)loadValues
{
    if ([masterLookDetailXuQiu.region isEqualToString:@""])
    {
        if ([masterLookDetailXuQiu.province isEqualToString:@""] && [masterLookDetailXuQiu.city isEqualToString:@""] && [masterLookDetailXuQiu.area isEqualToString:@""])
        {//证明是活动预约的bug
            NSString * addressStr = [NSString stringWithFormat:@"服务地址:  %@",masterLookDetailXuQiu.addressDetail];
            serviceAddressLabel.text = addressStr;
        }
        else
        {
            NSString * addressStr = [NSString stringWithFormat:@"服务地址:  %@  %@  %@  %@",masterLookDetailXuQiu.province,masterLookDetailXuQiu.city,masterLookDetailXuQiu.area,masterLookDetailXuQiu.addressDetail];
            serviceAddressLabel.text = addressStr;
        }
    }
    else
    {
        NSString * addressStr = [NSString stringWithFormat:@"服务地址:  %@  %@  %@  %@  %@",masterLookDetailXuQiu.province,masterLookDetailXuQiu.city,masterLookDetailXuQiu.area,masterLookDetailXuQiu.region,masterLookDetailXuQiu.addressDetail];
        serviceAddressLabel.text = addressStr;
    }
    
    startTimeLabel.text = [NSString stringWithFormat:@"服务时间:  %@",masterLookDetailXuQiu.startTime];
    
    Ty_News_Busine_HandlePlist * tempBusine = [[Ty_News_Busine_HandlePlist alloc]init];
    NSString * unit = [NSString stringWithFormat:@"%@",[tempBusine findWorkUnitAndWorkName:masterLookDetailXuQiu.workName]];
    
    workCountLabel.text = [NSString stringWithFormat:@"服务量:  %@ %@",masterLookDetailXuQiu.workAmount,unit];
    
    if ([masterLookDetailXuQiu.requirement_Type intValue] == 0)
    {//抢单显示
        if ([masterLookDetailXuQiu.requirement_Stage intValue] != 2 && [masterLookDetailXuQiu.requirement_Stage intValue] != 3)
        {
            unitPriceLabel.text = @"单价:  待定";
            [totalPriceLabel initWithStratString:@"合计:  " startColor:[UIColor grayColor] startFont:FONT14_BOLDSYSTEM centerString:@"待定" centerColor:[UIColor redColor] centerFont:FONT14_BOLDSYSTEM endString:@"" endColor:[UIColor redColor]  endFont:FONT14_BOLDSYSTEM];
            [realPriceLabel initWithStratString:@"实际支付:  " startColor:[UIColor grayColor] startFont:FONT14_BOLDSYSTEM centerString:@"待定" centerColor:[UIColor redColor] centerFont:FONT14_BOLDSYSTEM endString:@"" endColor:[UIColor redColor]  endFont:FONT14_BOLDSYSTEM];
        }
        else
        {
            NSRange range = [[masterLookDetailXuQiu priceUnit] rangeOfString:@"-"];//判断字符串是否包含
            
            //if (range.location ==NSNotFound)//不包含
            if (range.length >0)//包含
            {
                unitPriceLabel.text =[NSString stringWithFormat:@"单价:  ￥%@",[masterLookDetailXuQiu priceUnit]];
                [totalPriceLabel initWithStratString:@"合计:  " startColor:[UIColor grayColor] startFont:FONT14_BOLDSYSTEM centerString:@"无法计算" centerColor:[UIColor redColor] centerFont:FONT14_BOLDSYSTEM endString:@"" endColor:[UIColor grayColor] endFont:FONT14_BOLDSYSTEM];
                [realPriceLabel initWithStratString:@"实际支付:  " startColor:[UIColor grayColor] startFont:FONT14_BOLDSYSTEM centerString:[NSString stringWithFormat:@"%.2f元",[masterLookDetailXuQiu.realMoney floatValue]] centerColor:[UIColor redColor] centerFont:FONT14_BOLDSYSTEM endString:@"" endColor:[UIColor redColor]  endFont:FONT14_BOLDSYSTEM];
            }
            else//不包含
            {
                unitPriceLabel.text =[NSString stringWithFormat:@"单价:  ￥%@",[masterLookDetailXuQiu priceUnit]];
                float tempFloat = [[masterLookDetailXuQiu priceUnit]floatValue] *[[masterLookDetailXuQiu workAmount]intValue];
                
                if (![masterLookDetailXuQiu.usedCouponInfo.couponRequiremnetGuid isEqualToString:@""])
                {
                    tempFloat = tempFloat - [masterLookDetailXuQiu.usedCouponInfo.couponCutPrice floatValue];
                }
                if (tempFloat < 0)
                {
                    tempFloat = 0.0;
                }
                [totalPriceLabel initWithStratString:@"合计:  " startColor:[UIColor grayColor] startFont:FONT14_BOLDSYSTEM centerString:[NSString stringWithFormat:@"￥%.2f",tempFloat] centerColor:[UIColor redColor] centerFont:FONT14_BOLDSYSTEM endString:@"" endColor:[UIColor grayColor] endFont:FONT14_BOLDSYSTEM];
                [realPriceLabel initWithStratString:@"实际支付:  " startColor:[UIColor grayColor] startFont:FONT14_BOLDSYSTEM centerString:[NSString stringWithFormat:@"%.2f元",[masterLookDetailXuQiu.realMoney floatValue]] centerColor:[UIColor redColor] centerFont:FONT14_BOLDSYSTEM endString:@"" endColor:[UIColor redColor]  endFont:FONT14_BOLDSYSTEM];
                
            }
        }
    }
    else
    {
        if ([masterLookDetailXuQiu.requirement_Stage intValue] != 2 && [masterLookDetailXuQiu.requirement_Stage intValue] != 3)
        {
            [realPriceLabel initWithStratString:@"实际支付:  " startColor:[UIColor grayColor] startFont:FONT14_BOLDSYSTEM centerString:@"待定" centerColor:[UIColor redColor] centerFont:FONT14_BOLDSYSTEM endString:@"" endColor:[UIColor redColor]  endFont:FONT14_BOLDSYSTEM];
 
        }
        else
        {
            [realPriceLabel initWithStratString:@"实际支付:  " startColor:[UIColor grayColor] startFont:FONT14_BOLDSYSTEM centerString:[NSString stringWithFormat:@"%.2f元",[masterLookDetailXuQiu.realMoney floatValue]] centerColor:[UIColor redColor] centerFont:FONT14_BOLDSYSTEM endString:@"" endColor:[UIColor redColor]  endFont:FONT14_BOLDSYSTEM];

        }
    }
    
    
    
    //优惠券的相关信息
    if ([masterLookDetailXuQiu.usedCouponInfo.couponRequiremnetGuid isEqualToString:@""])
    {
        [couponInfoLabel initWithStratString:@"优惠券:  " startColor:[UIColor grayColor] startFont:FONT14_BOLDSYSTEM centerString:@"该订单没有使用优惠券" centerColor:couponGreenColor centerFont:FONT14_BOLDSYSTEM endString:@"" endColor:couponGreenColor endFont:FONT14_BOLDSYSTEM];
    }
    else
    {
        NSString * moneyString = [NSString stringWithFormat:@"-%@元",masterLookDetailXuQiu.usedCouponInfo.couponCutPrice];
        NSString * couponNumberString = [NSString stringWithFormat:@" (序列号:%@)",masterLookDetailXuQiu.usedCouponInfo.couponNo];
        
        [couponInfoLabel initWithStratString:@"优惠券:  " startColor:[UIColor grayColor] startFont:FONT14_BOLDSYSTEM centerString:moneyString centerColor:couponGreenColor centerFont:FONT14_BOLDSYSTEM endString:couponNumberString endColor:couponGreenColor endFont:FONT14_BOLDSYSTEM];
    }
    
    if ([masterLookDetailXuQiu.requirement_Stage intValue] == 2 || [masterLookDetailXuQiu.requirement_Stage intValue] == 3)
    {
        if ([masterLookDetailXuQiu.isApply intValue] == 3)
        {
            [payStageLabel initWithStratString:@"支付状态:  " startColor:[UIColor grayColor] startFont:FONT14_BOLDSYSTEM centerString:@"暂未支付" centerColor:[UIColor redColor] centerFont:FONT14_BOLDSYSTEM endString:@"" endColor:[UIColor grayColor] endFont:FONT14_BOLDSYSTEM];
        }
        else if ([masterLookDetailXuQiu.isApply intValue] == 2)
        {
            [payStageLabel initWithStratString:@"支付状态:  " startColor:[UIColor grayColor] startFont:FONT14_BOLDSYSTEM centerString:@"已支付-线下" centerColor:[UIColor redColor] centerFont:FONT14_BOLDSYSTEM endString:@"" endColor:[UIColor grayColor] endFont:FONT14_BOLDSYSTEM];
        }
        else
        {
            [payStageLabel initWithStratString:@"支付状态:  " startColor:[UIColor grayColor] startFont:FONT14_BOLDSYSTEM centerString:@"已支付-线上" centerColor:[UIColor redColor] centerFont:FONT14_BOLDSYSTEM endString:@"" endColor:[UIColor grayColor] endFont:FONT14_BOLDSYSTEM];
        }
    }
    else
    {
        [payStageLabel initWithStratString:@"支付状态:  " startColor:[UIColor grayColor] startFont:FONT14_BOLDSYSTEM centerString:@"暂未支付" centerColor:[UIColor redColor] centerFont:FONT14_BOLDSYSTEM endString:@"" endColor:[UIColor grayColor] endFont:FONT14_BOLDSYSTEM];
    }
    if ([masterLookDetailXuQiu.ask_Other isEqualToString:@""] || [masterLookDetailXuQiu.ask_Other isEqualToString:@"不限"])
    {
        remarkLabel.text = @"备注:  无";
    }
    else
    {
        remarkLabel.text = [NSString stringWithFormat:@"备注:  %@",masterLookDetailXuQiu.ask_Other];
    }
}
-(void)setHight
{
    CGSize serviceAreaSize = [serviceAddressLabel.text sizeWithFont:FONT14_BOLDSYSTEM constrainedToSize:CGSizeMake(serviceAddressLabel.frame.size.width, serviceAddressLabel.frame.size.height * 3) lineBreakMode:NSLineBreakByCharWrapping];
    if (serviceAreaSize.height > serviceAddressLabel.frame.size.height)
        [serviceAddressLabel setFrame:CGRectMake(12, serviceAddressLabel.frame.origin.y, 300, serviceAreaSize.height)];
    else
        [serviceAddressLabel setFrame:CGRectMake(12, serviceAddressLabel.frame.origin.y, 300, 14)];
    
    [startTimeLabel setFrame:CGRectMake(12, serviceAddressLabel.frame.origin.y + serviceAddressLabel.frame.size.height + 8, 300, 14)];
    [workCountLabel setFrame:CGRectMake(12, startTimeLabel.frame.origin.y + startTimeLabel.frame.size.height + 8, 300, 14)];
    [unitPriceLabel setFrame:CGRectMake(12, workCountLabel.frame.origin.y + workCountLabel.frame.size.height + 8, 300, 14)];
    [couponInfoLabel setFrame:CGRectMake(12, unitPriceLabel.frame.origin.y + unitPriceLabel.frame.size.height + 8, 300, 14)];
    
    if ([masterLookDetailXuQiu.requirement_Type intValue] == 0)
    {
        if ([masterLookDetailXuQiu.isApply intValue] == 3)
        {//没有支付了
            if ([totalPriceLabel.text isEqualToString:@"待定"])
            {
                [totalPriceLabel removeFromSuperview];
                [realPriceLabel removeFromSuperview];
                [payStageLabel setFrame:CGRectMake(12, couponInfoLabel.frame.origin.y + couponInfoLabel.frame.size.height + 8, 300, 14)];
            }
            else
            {
                [realPriceLabel removeFromSuperview];
                [totalPriceLabel setFrame:CGRectMake(12, couponInfoLabel.frame.origin.y + couponInfoLabel.frame.size.height + 8, 300, 14)];
                [payStageLabel setFrame:CGRectMake(12, totalPriceLabel.frame.origin.y + totalPriceLabel.frame.size.height + 8, 300, 14)];
            }
        }
        else
        {//支付了
            if ([totalPriceLabel.text isEqualToString:@"待定"])
            {
                [totalPriceLabel removeFromSuperview];
                [realPriceLabel setFrame:CGRectMake(12, couponInfoLabel.frame.origin.y + couponInfoLabel.frame.size.height + 8, 300, 14)];
                [payStageLabel setFrame:CGRectMake(12, realPriceLabel.frame.origin.y + realPriceLabel.frame.size.height + 8, 300, 14)];
            }
            else
            {
                [totalPriceLabel setFrame:CGRectMake(12, couponInfoLabel.frame.origin.y + couponInfoLabel.frame.size.height + 8, 300, 14)];
                [realPriceLabel setFrame:CGRectMake(12, totalPriceLabel.frame.origin.y + totalPriceLabel.frame.size.height + 8, 300, 14)];
                [payStageLabel setFrame:CGRectMake(12, realPriceLabel.frame.origin.y + realPriceLabel.frame.size.height + 8, 300, 14)];
                
            }
        }
    }
    else
    {//预约
        if ([masterLookDetailXuQiu.isApply intValue] == 3)
        {//没有支付了
            [unitPriceLabel removeFromSuperview];
            [couponInfoLabel setFrame:CGRectMake(12, workCountLabel.frame.origin.y + workCountLabel.frame.size.height + 8, 300, 14)];
            [totalPriceLabel removeFromSuperview];
            [realPriceLabel removeFromSuperview];

            [payStageLabel setFrame:CGRectMake(12, couponInfoLabel.frame.origin.y + couponInfoLabel.frame.size.height + 8, 300, 14)];
        }
        else
        {//支付了
            [unitPriceLabel removeFromSuperview];
            [couponInfoLabel setFrame:CGRectMake(12, workCountLabel.frame.origin.y + workCountLabel.frame.size.height + 8, 300, 14)];
            [totalPriceLabel removeFromSuperview];
            
            [realPriceLabel setFrame:CGRectMake(12, couponInfoLabel.frame.origin.y + couponInfoLabel.frame.size.height + 8, 300, 14)];
            [payStageLabel setFrame:CGRectMake(12, realPriceLabel.frame.origin.y + realPriceLabel.frame.size.height + 8, 300, 14)];
        }
    }
    
    CGSize remarkSize = [remarkLabel.text sizeWithFont:FONT14_BOLDSYSTEM constrainedToSize:CGSizeMake(remarkLabel.frame.size.width, remarkLabel.frame.size.height * 10) lineBreakMode:NSLineBreakByCharWrapping];
    if (remarkSize.height > remarkLabel.frame.size.height)
        [remarkLabel setFrame:CGRectMake(12, payStageLabel.frame.origin.y + payStageLabel.frame.size.height + 8, 300, remarkSize.height)];
    else
        [remarkLabel setFrame:CGRectMake(12, payStageLabel.frame.origin.y + payStageLabel.frame.size.height + 8, 300, 14)];

    [self setFrame:CGRectMake(0, 0, MainFrame.size.width, remarkLabel.frame.origin.y + remarkLabel.frame.size.height + 12)];
    
    NSLog(@"setHight 的高度%f",self.frame.size.height);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
