//
//  AppDelegateViewController.m
//  Breakfast
//
//  Created by 艾飞 on 14/6/14.
//  Copyright (c) 2014年 艾飞. All rights reserved.
//

#import "AppDelegateViewController.h"

@interface AppDelegateViewController ()
{
    
    
}
@end

@implementation AppDelegateViewController
@synthesize appNavigation;
@synthesize my_home,my_order,my_coreder,my_mySetting,my_master_order,my_worker_order;
@synthesize _currentIndex;
@synthesize but_corder,but_home,but_my,but_order;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        _currentIndex = 0;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    my_home = [[Ty_HomeVC alloc]init];
//    home_nc = [[UINavigationController alloc]initWithRootViewController:my_home];
    
    my_coreder = [[Ty_NewsVC alloc]init];
//    coreder_nc = [[UINavigationController alloc]initWithRootViewController:my_coreder];
    
//    my_huodong = [[Ty_HuodongVC alloc]init];
    
    my_order = [[Ty_Order_Root_Controller alloc]init];
    my_master_order = [[Ty_Order_Master_Controller alloc]init];
    my_worker_order = [[Ty_Order_Worker_Controller alloc]init];
//    set_nc = [[UINavigationController alloc]initWithRootViewController:my_setup];

    my_mySetting = [[Ty_MySettingVC alloc]init];
//    my_nc = [[UINavigationController alloc]initWithRootViewController:my_mySetting];

    [self addChildViewController:my_home];
    [self addChildViewController:my_coreder];
    [self addChildViewController:my_order];
    [self addChildViewController:my_worker_order];
    [self addChildViewController:my_master_order];
    [self addChildViewController:my_mySetting];

    if (IOS7) {
        viewbg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }else{
        viewbg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-20)];
    }
    
    [self.view addSubview:viewbg];
    
    [viewbg addSubview:my_home.view];
    
    appNavigation = my_home;
    
    but_home = [UIButton buttonWithType:UIButtonTypeCustom];
    but_home.frame = CGRectMake(0, TYFRAMEHEIGHT(viewbg) - 49, SCREEN_WIDTH/4, 49);
    [but_home setImage:JWImageName(@"service_2") forState:UIControlStateNormal];
    [but_home setImage:JWImageName(@"service_2") forState:UIControlStateHighlighted];
    [but_home addTarget:self action:@selector(but_homeClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but_home];
    
    but_corder = [UIButton buttonWithType:UIButtonTypeCustom];
    [but_corder setImage:JWImageName(@"private_letter_1") forState:UIControlStateNormal];
    [but_corder setImage:JWImageName(@"private_letter_1") forState:UIControlStateHighlighted];
    but_corder.frame = CGRectMake(SCREEN_WIDTH/4, TYFRAMEHEIGHT(viewbg) - 49, SCREEN_WIDTH/4, 49);
    [but_corder addTarget:self action:@selector(but_corderClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but_corder];
    
    but_order = [UIButton buttonWithType:UIButtonTypeCustom];
    [but_order setImage:JWImageName(@"order_list_1") forState:UIControlStateNormal];
    [but_order setImage:JWImageName(@"order_list_1") forState:UIControlStateHighlighted];
    but_order.frame = CGRectMake(SCREEN_WIDTH/4 * 2, TYFRAMEHEIGHT(viewbg) - 49, SCREEN_WIDTH/4, 49);
    [but_order addTarget:self action:@selector(but_huodongClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but_order];
    
    but_my = [UIButton buttonWithType:UIButtonTypeCustom];
    [but_my setImage:JWImageName(@"management_1") forState:UIControlStateNormal];
    [but_my setImage:JWImageName(@"management_1") forState:UIControlStateHighlighted];
    but_my.frame = CGRectMake(SCREEN_WIDTH/4 * 3, TYFRAMEHEIGHT(viewbg) - 49, SCREEN_WIDTH/4, 49);
    [but_my addTarget:self action:@selector(but_myClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but_my];
    
    
    //私信角标
    _iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4 - 45, -5, 35, 35)];
    _iconImageView.hidden = YES;
    [but_corder addSubview:_iconImageView];
    
    _numLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 35, 35)];
    _numLabel.backgroundColor = [UIColor clearColor];
    _numLabel.textColor = [UIColor whiteColor];
    _numLabel.textAlignment = NSTextAlignmentCenter;
    _numLabel.font = [UIFont systemFontOfSize:13];
    [_iconImageView addSubview:_numLabel];
    
    _orderIconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4 - 45 + 7, 0, 20, 20)];
    _orderIconImageView.hidden = YES;
    [but_order addSubview:_orderIconImageView];
}

-(void)but_homeClick:(UIButton *)but{
    
     NSLog(@"%@",appNavigation);
    if (appNavigation == my_home) {
        
        return;
    }
    [self transitionFromViewController:appNavigation toViewController:my_home duration:0 options:UIViewAnimationOptionLayoutSubviews  animations:^{
        
        
    } completion:^(BOOL finished) {
        NSLog(@"点击:home");
        if (finished) {
            
            appNavigation = my_home;
            [but_home setImage:JWImageName(@"service_2") forState:UIControlStateNormal];
            [but_corder setImage:JWImageName(@"private_letter_1") forState:UIControlStateNormal];
            [but_order setImage:JWImageName(@"order_list_1") forState:UIControlStateNormal];
            [but_my setImage:JWImageName(@"management_1") forState:UIControlStateNormal];
            
            _currentIndex = 0;
            
           
        }else{
            
            
        }

        
    }];

}

-(void)but_corderClick:(UIButton *)but{
    
     NSLog(@"%@",appNavigation);
    if (appNavigation == my_coreder) {
        return;
    }
    
    if (IFLOGINYES)
    {
        [self transitionFromViewController:appNavigation toViewController:my_coreder duration:0 options:UIViewAnimationOptionLayoutSubviews  animations:^{
            
            
        } completion:^(BOOL finished) {
            NSLog(@"点击:news");
            if (finished) {
                
                appNavigation = my_coreder;
                [but_home setImage:JWImageName(@"service_1") forState:UIControlStateNormal];
                [but_corder setImage:JWImageName(@"private_letter_2") forState:UIControlStateNormal];
                [but_order setImage:JWImageName(@"order_list_1") forState:UIControlStateNormal];
                [but_my setImage:JWImageName(@"management_1") forState:UIControlStateNormal];
                
                _currentIndex = 1;
                
            }else{
                
                
            }
            
        }];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"未登录,是否去登录？" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去登录", nil];
        [alertView show];
        alertView = nil;
    }
}

-(void)but_huodongClick:(UIButton *)but{

     NSLog(@"%@",appNavigation);
    if (appNavigation == my_master_order || appNavigation == my_worker_order) {
        return;
    }
    if (IFLOGINYES)
    {
        if ([MyLoginUserType intValue] == 0 || [MyLoginUserType intValue] == 1)
        {
            [self transitionFromViewController:appNavigation toViewController:my_worker_order duration:0 options:UIViewAnimationOptionLayoutSubviews  animations:^{
                
            } completion:^(BOOL finished) {
                NSLog(@"点击:订单");
                if (finished) {
                    appNavigation = my_worker_order;
                    
                    [but_home setImage:JWImageName(@"service_1") forState:UIControlStateNormal];
                    [but_corder setImage:JWImageName(@"private_letter_1") forState:UIControlStateNormal];
                    [but_order setImage:JWImageName(@"order_list_2") forState:UIControlStateNormal];
                    [but_my setImage:JWImageName(@"management_1") forState:UIControlStateNormal];
                    
                    _currentIndex = 2;
                    
                }else{
                    
                    
                }
            }];
        }
        else
        {
            [self transitionFromViewController:appNavigation toViewController:my_master_order duration:0 options:UIViewAnimationOptionLayoutSubviews  animations:^{
                
            } completion:^(BOOL finished) {
                NSLog(@"点击:订单");
                if (finished) {
                    appNavigation = my_master_order;
                    
                    [but_home setImage:JWImageName(@"service_1") forState:UIControlStateNormal];
                    [but_corder setImage:JWImageName(@"private_letter_1") forState:UIControlStateNormal];
                    [but_order setImage:JWImageName(@"order_list_2") forState:UIControlStateNormal];
                    [but_my setImage:JWImageName(@"management_1") forState:UIControlStateNormal];
                    
                    _currentIndex = 2;
                    
                }else{
                    
                    
                }
            }];
        }
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"未登录,是否去登录？" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去登录", nil];
        [alertView show];
        alertView = nil;
    }
}

-(void)but_myClick:(UIButton *)but{
    
    NSLog(@"%@",appNavigation);

    if (appNavigation == my_mySetting) {
        return;
    }
    [self transitionFromViewController:appNavigation toViewController:my_mySetting duration:0 options:UIViewAnimationOptionLayoutSubviews  animations:^{
        
        
    } completion:^(BOOL finished) {
        NSLog(@"点击:setting");
        if (finished) {
            
            appNavigation = my_mySetting;
            [but_home setImage:JWImageName(@"service_1") forState:UIControlStateNormal];
            [but_corder setImage:JWImageName(@"private_letter_1") forState:UIControlStateNormal];
            [but_order setImage:JWImageName(@"order_list_1") forState:UIControlStateNormal];
            [but_my setImage:JWImageName(@"management_2") forState:UIControlStateNormal];
       
            _currentIndex = 3;
        
        }else{
            
            
        }
    }];

}
#pragma mark -- 设置角标
- (void)setTabBarIcon:(NSInteger)num atIndex:(NSInteger)index
{
    if (IFLOGINYES)
    {
        if (index == 1)
        {
            if (num != 0)
            {
                _iconImageView.hidden = NO;
                _iconImageView.image = [UIImage imageNamed:@"Message_UnreadImage"];
                
                _numLabel.text = [NSString stringWithFormat:@"%d",num];
            }
            else
            {
                _iconImageView.hidden = YES;
            }
        }
    }
}

#pragma mark --订单家红点
-(void)setOrderTabBarIcon:(NSInteger)num
{
    if (IFLOGINYES)
    {
        if (num != 0 )
        {
            _orderIconImageView.hidden = NO;
            _orderIconImageView.image = [UIImage imageNamed:@"Message_UnreadImage"];
        }
        else
        {
            _orderIconImageView.hidden = YES;
        }
    }
}
#pragma mark -- alertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [alertView dismissWithClickedButtonIndex:buttonIndex animated:NO];
        switch (_currentIndex)
        {
            case 0:
                [my_home loginWhenNotLogin];
                break;
            case 1:
                break;
            case 2:
                break;
            case 3:
                [my_mySetting loginWhenNotLogin];
                break;
                
            default:
                break;
        }
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [appNavigation viewWillAppear:animated];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
