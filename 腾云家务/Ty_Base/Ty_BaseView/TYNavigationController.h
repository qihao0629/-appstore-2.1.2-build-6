//
//  TYNavigationController.h
//  腾云家务
//
//  Created by 齐 浩 on 14-5-23.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
*自定义导航条
*待完善
*/
@interface TYNavigationController : UIImageView
{}
/**左边按钮*/
@property(nonatomic,strong)UIButton* leftBarButton;
/**右边按钮*/
@property(nonatomic,strong)UIButton* rightBarButton;
/**标题的View*/
@property(nonatomic,strong)UIView* titleView;
/**标题Label*/
@property(nonatomic,strong)UILabel* titleLabel;
/**所有栈中的viewcontroller*/
@property(nonatomic,strong)NSArray* viewControllers;
@property(nonatomic,strong)TYNavigationController* navigationBar;
@property(nonatomic,getter=isNavigationBarHidden) BOOL navigationBarHidden;
@property(nonatomic,readonly,retain) UIViewController *topViewController;




- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)isAnimation;
- (void)popViewControllerAnimated:(BOOL)isAnimation;
- (void)popToViewController:(UIViewController *)viewController animated:(BOOL)isAnimation;
- (void)popToRootViewControllerAnimated:(BOOL)isAnimation;
- (void)setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated;
@end
