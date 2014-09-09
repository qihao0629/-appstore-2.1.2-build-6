//
//  My_RegSucceedViewController.m
//  腾云家务
//
//  Created by 艾飞 on 14/6/7.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "My_RegSucceedViewController.h"
#import "My_login_busine.h"
@interface My_RegSucceedViewController ()

@end

@implementation My_RegSucceedViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.imageView_background.hidden = YES;
    [self setSlidingBack:NO];
    
    UILabel * lableText = [[UILabel alloc]initWithFrame:CGRectMake(40, 40, 240, 30)];
    lableText.backgroundColor = [UIColor clearColor];
    lableText.textAlignment = NSTextAlignmentCenter;
    lableText.font = [UIFont boldSystemFontOfSize:20.0f];
    lableText.text = @"恭喜您,注册成功!";
    lableText.textColor = [UIColor colorWithRed:255.0/255.0 green:127.0/255.0 blue:13.0/255.0 alpha:1.0f];
    [self.view addSubview:lableText];
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(110, 100, 100, 100)];
    imageView.image = [UIImage imageNamed:@"login_ok.png"];
    [self.view addSubview:imageView];
    
    UILabel * lableText1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 220, 280, 30)];
    lableText1.backgroundColor = [UIColor clearColor];
    lableText1.textAlignment = NSTextAlignmentCenter;
    lableText1.font = [UIFont boldSystemFontOfSize:16.0f];
    lableText1.text = @"开启腾云家务感受不一样的服务体验";
    lableText1.textColor = [UIColor colorWithRed:167.0/255.0 green:167.0/255.0 blue:167.0/255.0 alpha:1.0f];
    [self.view addSubview:lableText1];
    
    button_login = [UIButton buttonWithType:UIButtonTypeCustom];
    button_login.frame  = CGRectMake(30, 260, 260, 44);
    [button_login setTitle:@"开启腾云家务" forState:UIControlStateNormal];
    [button_login setBackgroundImage:[UIImage imageNamed:@"login.png"] forState:UIControlStateNormal];
    [button_login addTarget:self action:@selector(button_login_click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button_login];
    

    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(MyLogInSucceed:) name:@"MyLogInSucceed" object:nil];

}
#pragma mark - 登录_回调
-(void)MyLogInSucceed:(NSNotification *)_notification{
    [self hideLoadingView];
    button_login.userInteractionEnabled = NO;
    if ([[_notification object] isKindOfClass:[NSString class]] && [[_notification object] isEqualToString:@"fail"]) {
        
        [self alertViewTitle:@"提示" message:@"网络连接暂时不可用，请稍后再试"];
        
    }else {
        if ([[[_notification object] objectForKey:@"code"]intValue] == 200) {
            
            //登录成功
            [self.naviGationController popToRootViewControllerAnimated:YES];
            
        }else{
            
            [self alertViewTitle:@"提示" message:[[_notification object] objectForKey:@"msg"]];

        }
        
    }

}

#pragma mark - 开启腾云家务
-(void)button_login_click:(UIButton *)but{
 
    but.userInteractionEnabled = YES;
    NSMutableDictionary * dic_login = [[NSMutableDictionary alloc]init];
    [dic_login setObject:_userName forKey:@"userName"];
    [dic_login setObject:_userPwd forKey:@"userPassword"];
    My_login_busine * my_loginBusine = [[My_login_busine alloc]init];
    my_loginBusine.delegate = self;
    [my_loginBusine my_loginSucceed_busine:dic_login];
    [self showLoadingInView:self.view];
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
