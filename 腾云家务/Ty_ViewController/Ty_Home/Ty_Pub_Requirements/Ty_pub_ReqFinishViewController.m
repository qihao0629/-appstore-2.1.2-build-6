//
//  Reserve_FinishViewController.m
//  腾云家务
//
//  Created by 齐 浩 on 14-4-10.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_pub_ReqFinishViewController.h"
#import "AppDelegate.h"
#import "Ty_OrderVC_MasterOrder.h"
#import "Ty_OrderVC_MasterPublish.h"
@interface Ty_pub_ReqFinishViewController ()

@end

@implementation Ty_pub_ReqFinishViewController
@synthesize finishImage,finishLabel,AciontButton,contentsLabel,xuqiuInfo;
@synthesize backButton;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        xuqiuInfo = [[Ty_Model_XuQiuInfo alloc]init];
        
        self.imageView_background.hidden = YES;
        finishLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, 320, 15)];
        [finishLabel setBackgroundColor:[UIColor clearColor]];
        [finishLabel setTextColor:Color_orange];
        [finishLabel setTextAlignment:NSTextAlignmentCenter];
        [finishLabel setFont:FONT15_BOLDSYSTEM];
        
        finishImage = [[UIImageView alloc]initWithFrame:CGRectMake(125, 75, 70, 70)];
        
        
        contentsLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 155, 320, 14)];
        [contentsLabel setBackgroundColor:[UIColor clearColor]];
        [contentsLabel setTextColor:Color_173];
        [contentsLabel setTextAlignment:NSTextAlignmentCenter];
        [contentsLabel setFont:FONT13_BOLDSYSTEM];
        
        AciontButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [AciontButton setFrame:CGRectMake(50, 200, 220, 40)];
        [AciontButton setBackgroundImage:JWImageName(@"login") forState:UIControlStateNormal];
        [AciontButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [AciontButton addTarget:self action:@selector(goRequirement) forControlEvents:UIControlEventTouchUpInside];
        [AciontButton.titleLabel setFont:FONT14_BOLDSYSTEM];
        
//        [self.imageView_background setFrame:CGRectMake(0, self.view.frame.size.height-49, 320, 49)];
        backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setFrame:CGRectMake(50, 260, 220, 40)];
        [backButton setBackgroundImage:JWImageName(@"login") forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [backButton.titleLabel setFont:FONT14_BOLDSYSTEM];
        [backButton setTitle:@"返回首页" forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:finishLabel];
        [self.view addSubview:finishImage];
        [self.view addSubview:contentsLabel];
        [self.view addSubview:AciontButton];
        [self.view addSubview:backButton];

    }
    return self;
}
-(void)goRequirement
{
    if ([xuqiuInfo.requirement_Type isEqualToString:@"0"])
    {
        Ty_OrderVC_MasterPublish * order_MasterPublish = [[Ty_OrderVC_MasterPublish alloc]init];
        order_MasterPublish.requirementGuid = xuqiuInfo.requirementGuid;
        
        TYBaseView* viewController = [[appDelegate appTabBarController] appNavigation];
        
        [viewController.naviGationController pushViewController:order_MasterPublish animated:YES];
        
        NSRange range;
        range.length = self.naviGationController.viewControllers.count-2;
        range.location = 1;
        NSArray* array = [self.naviGationController.viewControllers subarrayWithRange:range];
        [self removeViewControllersFromWindow:array];
        
//        UITabBarController* tabView = self.naviGationController.viewControllers[0];
//        [self.naviGationController popToRootViewControllerAnimated:NO];
//        TYBaseView* baseView = tabView.viewControllers[0];
//        [baseView.naviGationController pushViewController:order_MasterPublish animated:YES]jj;
    }
    else if ([xuqiuInfo.requirement_Type isEqualToString:@"1"])
    {
        Ty_OrderVC_MasterOrder* order_MasterOrder = [[Ty_OrderVC_MasterOrder alloc]init];
        order_MasterOrder.requirementGuid = xuqiuInfo.requirementGuid;
//        UITabBarController* tabView = self.naviGationController.viewControllers[0];
//        [self.naviGationController popToRootViewControllerAnimated:NO];
//        TYBaseView* baseView = tabView.viewControllers[0];
        TYBaseView* viewController = [[appDelegate appTabBarController] appNavigation];
        [viewController.naviGationController pushViewController:order_MasterOrder animated:YES];
        
        NSRange range;
        range.length = self.naviGationController.viewControllers.count-2;
        range.location = 1;
        NSArray* array = [self.naviGationController.viewControllers subarrayWithRange:range];
        [self removeViewControllersFromWindow:array];

        
    }
}
-(AppDelegate* )getAppdelegate
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}
-(void)back
{
    [self.naviGationController popToRootViewControllerAnimated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
   
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
