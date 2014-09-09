//
//  Ty_Order_Master_OrderCell.h
//  腾云家务
//
//  Created by lgs on 14-6-30.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

/**
 *
 雇主直接预约服务商的自定义cell
 *
 **/
#import <UIKit/UIKit.h>
#import "CustomStar.h"

@interface Ty_Order_Master_OrderCell : UITableViewCell
@property(nonatomic,strong) UIView * leftHeadView;
@property(nonatomic,strong) UIImageView * headImageView;
@property(nonatomic,strong) UILabel * workerNameLabel;//名字
@property(nonatomic,strong) UILabel * workerTypeLabel;//属于哪个公司
@property(nonatomic,strong) UIView * greenView;//绿色的背景
@property(nonatomic,strong) UILabel * priceLabel;//报价
@property(nonatomic,strong) UILabel * unitLabel;//单位
@property(nonatomic,strong)CustomStar* customStar;//星级
@property(nonatomic,strong) UILabel * serviceTimeLabel;//服务次数
@property(nonatomic,strong) UIButton * evaluateButton;//评价按钮
@property(nonatomic,strong) UILabel * buttonTitleLabel;
@property(nonatomic,strong) UIView * reminderView;//提示的view
@property(nonatomic,strong) UILabel * reminderLabel1;
@property(nonatomic,strong) UILabel * reminderLabel2;
@property(nonatomic,strong) UIButton * servicePhoneButton;//打电话的按钮
@property(nonatomic,strong) UIButton * employeePhoneButton;//员工电话按钮
@property(nonatomic,strong) UILabel * employeePhoneNumberLabel;//数字
-(void)setHight;

@end
