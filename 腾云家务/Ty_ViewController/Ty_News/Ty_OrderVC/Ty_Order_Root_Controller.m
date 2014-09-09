//
//  Ty_Order_Root_Controller.m
//  腾云家务
//
//  Created by lgs on 14-8-19.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_Order_Root_Controller.h"
#import "My_LoginViewController.h"

@interface Ty_Order_Root_Controller ()

@end

@implementation Ty_Order_Root_Controller

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self addNotificationForName:@"Ty_Order_Root_Controller"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"订单";

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([MyLoginUserType intValue] == 0 || [MyLoginUserType intValue] == 1)
    {
        if (order_Worker == nil)
        {
            order_Worker = [[Ty_Order_Worker_Controller alloc]init];
        }
        
        if (order_Master)
        {
            [order_Master.view removeFromSuperview];
            order_Master = nil;
        }
        [self.view addSubview:order_Worker.view];
    }
    else
    {
        if (order_Master == nil)
        {
            order_Master= [[Ty_Order_Master_Controller alloc]init];
        }
        if (order_Worker)
        {
            [order_Worker.view removeFromSuperview];
            order_Worker = nil;
        }
        [self.view addSubview:order_Master.view];
    }
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
