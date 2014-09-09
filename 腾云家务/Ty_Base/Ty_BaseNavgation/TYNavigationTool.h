//
//  TYNavigaionTool.h
//  腾云家务
//
//  Created by 齐 浩 on 14-5-22.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TYNavigationTool : NSObject<UIGestureRecognizerDelegate>{
    UIViewController * topViewController;
    NSMutableArray * viewControllerArray;
    
}


+ (TYNavigationTool *)shareNav;

-(void)pushViewController:(UIViewController *)vc withAnimation:(BOOL)isAnimation;
-(void)popViewControllerWithAnimation:(BOOL)isAnimation;
- (void)popToViewController:(UIViewController *)viewController animated:(BOOL)isAnimation;
- (void)popToRootViewControllerAnimated:(BOOL)isAnimation;

- (void)removeViewControllersFromWindow:(NSArray* )viewControllers;

-(void)viewMoving:(UIPanGestureRecognizer *)ges;
-(NSMutableArray*)viewControllerArray;

-(void)setSlidingBack:(BOOL)_isOpen View:(UIView*)_view;

@end
static TYNavigationTool * navTool;