//
//  AppDelegateViewController.h
//  Breakfast
//
//  Created by 艾飞 on 14/6/14.
//  Copyright (c) 2014年 艾飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TYBaseView.h"


#import "AppDelegateViewController.h"
#import "Ty_HomeVC.h"//首页
//#import "Ty_HuodongVC.h"//活动
//#import "Ty_Order_Notification_Controller.h"//订单
#import "Ty_Order_Root_Controller.h"//订单root
#import "Ty_Order_Master_Controller.h"
#import "Ty_Order_Worker_Controller.h"
#import "Ty_NewsVC.h"//消息
#import "Ty_MySettingVC.h"//我的
@interface AppDelegateViewController : UIViewController<UIAlertViewDelegate>
{
    UINavigationController * home_nc;
    UINavigationController * order_nc;
    
    UINavigationController * coreder_nc;
    UINavigationController * set_nc;
//    UINavigationController * appNavigation;
    UINavigationController * my_nc;

    UIView * viewbg;
    
//    UIButton * but_huodong;
    UIButton * but_order;
    UIButton * but_home ;
    UIButton * but_corder;
    UIButton * but_my;
    
    NSInteger _currentIndex;
    
    UIImageView *_iconImageView;
    
    UIImageView * _orderIconImageView;
    
    UILabel *_numLabel;
}
@property(nonatomic,assign)NSInteger _currentIndex;
@property(nonatomic,strong)TYBaseView* appNavigation;
@property(nonatomic,strong)Ty_HomeVC * my_home;
@property(nonatomic,strong)Ty_NewsVC * my_coreder;
//@property(nonatomic,strong)Ty_HuodongVC * my_huodong;
@property(nonatomic,strong)Ty_Order_Root_Controller * my_order;
@property(nonatomic,strong)Ty_Order_Master_Controller * my_master_order;
@property(nonatomic,strong)Ty_Order_Worker_Controller * my_worker_order;
@property(nonatomic,strong)Ty_MySettingVC * my_mySetting;

//@property(nonatomic,strong)UIButton * but_huodong;
@property(nonatomic,strong)UIButton * but_home ;
@property(nonatomic,strong)UIButton * but_order;
@property(nonatomic,strong)UIButton * but_corder;
@property(nonatomic,strong)UIButton * but_my;
/**
 *  设置角标
 *
 *  @param num   未读条数
 *  @param index 当前tabBar
 */
- (void)setTabBarIcon:(NSInteger)num atIndex:(NSInteger)index;

/**
 *  订单加红点
 *
 *  @param num   未读条数
 */
-(void)setOrderTabBarIcon:(NSInteger)num;


-(void)viewWillAppear:(BOOL)animated;
@end
