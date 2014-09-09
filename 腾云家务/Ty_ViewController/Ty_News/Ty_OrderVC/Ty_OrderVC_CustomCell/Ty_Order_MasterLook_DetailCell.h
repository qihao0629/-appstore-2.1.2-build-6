//
//  Ty_Order_MasterLook_DetailCell.h
//  腾云家务
//
//  Created by lgs on 14-7-8.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ty_Model_XuQiuInfo.h"
#import "CustomLabel.h"

@interface Ty_Order_MasterLook_DetailCell : UITableViewCell

@property (nonatomic,retain) Ty_Model_XuQiuInfo * masterLookDetailXuQiu;
@property (nonatomic,retain) UILabel * serviceAddressLabel;
@property (nonatomic,retain) UILabel * startTimeLabel;
@property (nonatomic,retain) UILabel * workCountLabel;
@property (nonatomic,retain) UILabel * unitPriceLabel;
@property (nonatomic,retain) CustomLabel * couponInfoLabel;//优惠券信息的label
@property (nonatomic,retain) CustomLabel * totalPriceLabel;
@property (nonatomic,retain) CustomLabel * realPriceLabel;
@property (nonatomic,retain) CustomLabel * payStageLabel;
@property (nonatomic,retain) UILabel * remarkLabel;//备注

-(void)loadUI;
-(void)loadValues;
-(void)setHight;
@end
