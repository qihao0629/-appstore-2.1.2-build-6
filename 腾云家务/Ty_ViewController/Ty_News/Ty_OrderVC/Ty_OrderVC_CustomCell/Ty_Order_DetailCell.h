//
//  Ty_Order_DetailCell.h
//  腾云家务
//
//  Created by lgs on 14-6-23.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ty_Model_XuQiuInfo.h"

@protocol Detail_PhoneCall <NSObject>

@optional

-(void)phoneCallPressed;

@end

@interface Ty_Order_DetailCell : UITableViewCell
{
    NSMutableString * requirementStr;
}
@property (nonatomic,assign) id<Detail_PhoneCall>phoneCall;
@property (nonatomic,strong) Ty_Model_XuQiuInfo * detailXuQiu;
@property(nonatomic,strong) NSString * requirementGuid;

@property(nonatomic,strong) UILabel * serviceAreaLabel;
@property(nonatomic,strong) UILabel * serviceAreaValue;
@property(nonatomic,strong) UILabel * detailAddressLabel;
@property(nonatomic,strong) UILabel * detailAddressValue;
@property(nonatomic,strong) UILabel * connactNameLabel;
@property(nonatomic,strong) UILabel * connactNameValue;
@property(nonatomic,strong) UILabel * connactIphoneNumberLabel;
@property(nonatomic,strong) UILabel * connactIphoneNumberValue;
@property(nonatomic,strong) UILabel * otherAskLabel;
@property(nonatomic,strong) UILabel * otherAskValue;

@property (nonatomic,strong) UILabel * unitPriceLabel;
@property (nonatomic,strong) UILabel * unitPriceValue;
@property (nonatomic,strong) UILabel * couponInfoLabel;//优惠券信息的label
@property (nonatomic,strong) UILabel * couponInfoValue;
@property (nonatomic,strong) UILabel * totalPriceLabel;
@property (nonatomic,strong) UILabel * totalPriceValue;
@property (nonatomic,strong) UILabel * realPriceLabel;//实际支付价格
@property (nonatomic,strong) UILabel * realPriceValue;
@property (nonatomic,strong) UILabel * payStageLabel;
@property (nonatomic,strong) UILabel * payStageVlaue;

@property(nonatomic,strong) UIButton * phoneCallButton;

-(void)loadUI;//加载UI
-(void)setHeight;
-(void)loadDetailInformation;
-(void)loadValues;//加载数据
@end
