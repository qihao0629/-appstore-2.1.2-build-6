//
//  AppDelegate.h
//  腾云家务
//
//  Created by 齐 浩 on 14-5-21.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AGViewDelegate.h"
#import "LeveyTabBarController.h"
#import "AppDelegateViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,LeveyTabBarControllerDelegate,UIAlertViewDelegate>
{
    NSInteger _currentIndex;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,readonly) AGViewDelegate *viewDelegate;
@property (strong, nonatomic) LeveyTabBarController* tabBarController;
@property (strong, nonatomic) AppDelegateViewController* appTabBarController;
@end
