//
//  Ty_OrderVC_Worker_Notificaton_CustomCell.h
//  腾云家务
//
//  Created by lgs on 14-6-4.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ty_Model_XuQiuInfo.h"

@protocol WorkerLeftButton <NSObject>

-(void)workerLeftButtonAction:(id)sender;

@end

@protocol WorkerRightButton <NSObject>

-(void)workerRightButtonAction:(id)sender;

@end

@interface Ty_OrderVC_Worker_Notificaton_CustomCell : UITableViewCell
{
    UIView * upGrayLineView;//上面那个灰色的线
    UIView * downGrayLineView;//下面那个灰色的线
}
@property (nonatomic,strong) id<WorkerLeftButton>workerLeftButtonDelegate;
@property (nonatomic,strong) id<WorkerRightButton>workerRightButtonDelegate;
@property (nonatomic,strong) UILabel * notificationTypeLabel;//此通知的类型 “预约” “强抢单”
@property (nonatomic,strong) UILabel * requirementStateLabel;//此需求的状态
@property (nonatomic,strong) UIView * photoView;//图像的view
@property (nonatomic,strong) UIImageView * photoImageView;//图像的imageView;
@property (nonatomic,strong) UILabel * requirementNumberLabel;//预约的编号
@property (nonatomic,strong) UILabel * secondLabel;//预约人名字
@property (nonatomic,strong) UILabel * thirdLabel;//服务时间
@property (nonatomic,strong) UILabel * fourthLabel;//工作总量
@property (nonatomic,strong) UIButton * contactWithMasterButton;//联系雇主button
@property (nonatomic,strong) UILabel * contactLabel;//联系商户的label
@property (nonatomic,strong) UIButton * rightButton;//确认接单 或者确认应征
@property (nonatomic,strong) UILabel * rightButtonLabel;//同上

@property (nonatomic,retain) Ty_Model_XuQiuInfo * xuQiu;
/*
 实例化这些label,button
 */
-(void)loadUIAndIndex:(int)_Num;

/*
 给这些label,button赋值
 并且判断，那个按钮要显示不显示的
 */
-(void)loadValues;

@end
