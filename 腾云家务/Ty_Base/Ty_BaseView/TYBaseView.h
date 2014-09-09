//
//  TYBaseView.h
//  腾云家务
//
//  Created by 齐 浩 on 14-5-23.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TYNavigationController.h"
#import "Ty_BaseLoading.h"
#import "Ty_BaseNetMessage.h"
@class MBProgressHUD;

@interface TYBaseView : UIViewController<Ty_BaseNetMessageDelegate,Ty_BaseBusineDelegate>
{
    NSString* titleString;/**标题*/
    Ty_BaseLoading* _loadingView;/**正在加载*/
    Ty_BaseNetMessage* _netMessageView;/**加载失败*/
    Ty_BaseNetMessage* _dataMessageView;/**提示信息*/
    MBProgressHUD* _progressHUD;/**加载*/
    UIImageView * imageView_background;
    UIButton * button_ok;
    UIButton * button_back;
    
}
/**下方导航*/
@property(nonatomic,readonly)BOOL slidingBackbool;
@property(nonatomic,strong)UIButton * button_ok;
@property(nonatomic,strong)UIButton * button_back;
@property(nonatomic,strong)UILabel * rightLabel;//下方导航条右边label
@property(nonatomic,strong)NSString* titleString;
@property(nonatomic,strong)UIImageView *imageView_background;

/**引用自定义导航*/
@property(nonatomic,strong)TYNavigationController* naviGationController;

/**设置自定义导航隐藏。默认NO*/
-(void)setNavigationBarHidden:(BOOL)_bool animated:(BOOL)isAnimation;

/**当view触发右滑时触发*/
-(void)viewWillbackAction;

/**pop出*/
-(void)backClick;

//-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)isAnimation;/**使用一个横向滑动过渡。将视图压到栈中*/
//-(void)popViewControllerWithAnimation:(BOOL)isAnimation;/**使用一个横向滑动过渡。将栈中的视图释放*/
//-(void)popToViewController:(UIViewController *)viewController animated:(BOOL)isAnimation;/**是一个横向滑动过渡。将战中指定视图释放*/
//-(void)popToRootViewControllerAnimated:(BOOL)isAnimation;/**使一个横向滑动过渡。将栈中视图释放到主视图*/

/**滑动返回开启与关闭，默认YES-开启*/
-(void)setSlidingBack:(BOOL)_isOpen;


/**网络回调*/
-(void)netRequestReceived:(NSNotification*)_notification;

/**显示等待加载*/
-(Ty_BaseLoading*) showLoadingInView:(UIView*)view;

/**隐藏等待加载*/
-(void) hideLoadingView;

/**显示加载失败*/
-(Ty_BaseNetMessage*)showNetMessageInView:(UIView*)view;

/**隐藏加载失败*/
-(void)hideNetMessageView;

/**显示提示信息*/
-(Ty_BaseNetMessage*)showMessageInView:(UIView*)view message:(NSString* )_message;

/**隐藏提示信息*/
-(void)hideMessageView;

/**显示加载*/
-(MBProgressHUD* ) showProgressHUD;

/**显示加载带文字*/
-(MBProgressHUD* ) showProgressHUD:(NSString*) labelText;

/**隐藏正在加载*/
-(void) hideProgressHUD ;

/**显示Toast*/
-(void)showToastMakeToast:(NSString* )_totast duration:(float)_duration position:(id)_position;

/**键盘弹出高度获取方法*/
- (void)keyboardWillShow:(NSNotification *)notification;

/**键盘落下处理方法*/
- (void)keyboardWillHide:(NSNotification *)notification;

/**键盘弹出后处理方法*/
- (void)keyboardDidShow:(NSNotification *)notification;

/**下导航 成功方法*/
-(void)button_okClick;

/**提示框*/
-(void)alertViewTitle:(NSString *)title message:(NSString *)message;

/**注册网络通知*/
-(void)addNotificationForName:(NSString* )_name;

/**移出NavigationTool中得ViewController*/
- (void)removeViewControllersFromWindow:(NSArray* )viewControllers;


@end