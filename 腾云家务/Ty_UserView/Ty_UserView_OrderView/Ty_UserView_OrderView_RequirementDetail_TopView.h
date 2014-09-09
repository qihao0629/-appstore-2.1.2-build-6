//
//  Ty_UserView_OrderView_RequirementDetail_TopView.h
//  腾云家务
//
//  Created by lgs on 14-5-29.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ty_UserView_Order_SemgentButton.h"
#import "Ty_Model_XuQiuInfo.h"

@interface Ty_UserView_OrderView_RequirementDetail_TopView : UIView
{
    UIView * headPhotoView;//需求详情上面的雇主的头像view
    UIImageView * headPhotoImageView;//需求详情上面的雇主的头像imageView
    UILabel * findWorkNameLabel;//雇主需要什么服务
    UILabel * requirementNumberLabel;//需求的编号
    UILabel * timeLimitLabel;//工作量
    UILabel * servieceTimeLabel;//服务的开始时间
//    SqliteFuction * sql;
}
@property(nonatomic,strong) UILabel * requirementStateLabel;//这条需求的状态
@property(nonatomic,strong) Ty_Model_XuQiuInfo * topViewXuQiu;//需求详情的字典
@property(nonatomic,strong) Ty_UserView_Order_SemgentButton * semgentButton;//qh写的自定义view
@property(nonatomic,assign) BOOL masterOrWorker;//当前用户的身份，雇主为0，雇工为1

/*
 方法，实例化这些label，
 */
-(void)loadCustomView;
/*
 方法，给这些label等赋值
 */
-(void)loadValues;
@end
