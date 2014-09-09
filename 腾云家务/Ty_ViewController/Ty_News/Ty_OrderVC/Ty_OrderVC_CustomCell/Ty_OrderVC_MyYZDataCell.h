//
//  Ty_OrderVC_MyYZDataCell.h
//  腾云家务
//
//  Created by lgs on 14-7-3.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomStar.h"
#import "CustomLabel.h"

@interface Ty_OrderVC_MyYZDataCell : UITableViewCell

@property(nonatomic,strong) UIView * leftHeadView;
@property(nonatomic,strong) UIImageView * headImageView;
@property(nonatomic,strong) UILabel * workerNameLabel;
@property(nonatomic,strong) UILabel * YZtimeLabel;
@property(nonatomic,strong) UILabel * priceLabel;
@property(nonatomic,strong) UILabel * unitLabel;
@property(nonatomic,strong)CustomStar* customStar;
@property(nonatomic,strong) UILabel * serviceTimeLabel;//服务次数
@property(nonatomic,strong) CustomLabel * reminderLabel1;
@property(nonatomic,strong) UILabel * YZRemarkLabel;
@property(nonatomic,strong) UIButton * evaluateButton;//评价按钮
@property(nonatomic,strong) UILabel * evaluateLabel;//

-(void)sethight;

@end
