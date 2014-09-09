//
//  Ty_OrderVC_Master_Notivation_CustonCell.h
//  腾云家务
//
//  Created by lgs on 14-6-4.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ty_Model_XuQiuInfo.h"

@protocol MasterLeftButton <NSObject>

-(void)masterLeftButtonAction:(id)sender;

@end

@protocol masterRightButton <NSObject>

-(void)masterRightButtonAction:(id)sender;

@end

@interface Ty_OrderVC_Master_Notivation_CustonCell : UITableViewCell
{
//    UIView * upGrayLineView;//上面那个灰色的线
//    UIView * downGrayLineView;//下面那个灰色的线
}
@property (nonatomic,strong) id<MasterLeftButton> masterLeftDelegate;
@property (nonatomic,strong) id<masterRightButton> masterRightDelegate;
@property (nonatomic,strong) UILabel * notificationTypeLabel;//此通知的类型 “预约” “强抢单”
@property (nonatomic,strong) UILabel * requirementStateLabel;//此需求的状态
@property (nonatomic,strong) UIView * photoView;//图像的view
@property (nonatomic,strong) UIImageView * photoImageView;//图像的imageView;
@property (nonatomic,strong) UILabel * serverNameLabel;//服务对象的名字 或者“未定”
@property (nonatomic,strong) UIView * identityView;//商户还是个人或者是属于那个公司的
@property (nonatomic,strong) UILabel * identityLabel;//同上
@property (nonatomic,strong) UILabel * howMuchPeopleYZlabel;//多少人应征
@property (nonatomic,strong) UILabel * requirementNumberLabel;//预约的编号
@property (nonatomic,strong) UILabel * startTimeLabel;//服务时间
@property (nonatomic,strong) UIButton * contactWithServerButton;//联系商户button
@property (nonatomic,strong) UILabel * contactLabel;//联系商户的label
@property (nonatomic,strong) UIButton * quitRequirementButton;//取消预约或者取消抢单
@property (nonatomic,strong) UILabel * quitLabel;//可能是“预约” “抢单”

@property (nonatomic,retain) Ty_Model_XuQiuInfo * xuQiu;
/*
 实例化这些label,button
 */
-(void)loadUIAndIndex:(int)_number;

/*
 给这些label,button赋值
 并且判断，那个按钮要显示不显示的
 */
-(void)loadValues;
@end
