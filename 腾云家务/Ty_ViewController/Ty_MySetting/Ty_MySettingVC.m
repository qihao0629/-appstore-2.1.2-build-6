//
//  Ty_MySettingVC.m
//  腾云家务
//
//  Created by 齐 浩 on 14-5-22.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_MySettingVC.h"
#import "My_LoginYesView.h"
#import "My_LoginNoView.h"
#import "My_LoginViewController.h"
#import "My_Stting_busine.h"

@interface Ty_MySettingVC ()

@end

@implementation Ty_MySettingVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    if (IFLOGINYES) {
        
        myLoginYes.hidden = NO;
        myLoginNo.hidden = YES;

        [myLoginYes updateLogin];
        if ([MyLoginUserType isEqualToString:@"0"]) {
            My_Stting_busine * my_setting = [[My_Stting_busine alloc] init];//查询商户状态
            my_setting.my_setUpadteModel = my_setModel;
            my_setting.delegate = self;
            [my_setting loadUpdateMySetting];
        }

        
    }else{
        
        myLoginNo.hidden = NO;
        myLoginYes.hidden = YES;
    }

    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    my_setModel = [[My_SettingUpadteModel alloc]init];
    self.title = @"我";
    
    myLoginYes = [[My_LoginYesView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    myLoginYes.hidden = YES;
    myLoginYes.ty_mySetting = self;
    myLoginYes.my_shop.my_setUpadteModel = my_setModel;
    [self.view addSubview:myLoginYes];
    
    myLoginNo = [[My_LoginNoView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    myLoginNo.ty_mySetting = self;
    myLoginNo.hidden = YES;
    [self.view addSubview:myLoginNo];
    
    [self addNotificationForName:@"MySettingUpdate"];
    
}
#pragma mark - 修改_回调
-(void)netRequestReceived:(NSNotification *)_notification{
    [self hideLoadingView];
    if ([[_notification object] isKindOfClass:[NSString class]] && [[_notification object] isEqualToString:@"fail"]) {
        
        [self alertViewTitle:@"提示" message:@"网络连接暂时不可用，请稍后再试"];
        
    }else {
        if ([[[_notification object] objectForKey:@"code"]intValue] == 200) {
            
            [myLoginYes.my_shop reloadData];
            
        }else {
            if ([[[_notification object] objectForKey:@"code"] intValue]!=205) {
                
                [self alertViewTitle:@"提示" message:[[_notification object] objectForKey:@"msg"]];
                
            }
        }
        
    }
    
}



#pragma mark -- denglu
- (void)loginWhenNotLogin
{
    
    My_LoginViewController *loginViewController = [[My_LoginViewController alloc]init];
    [self.naviGationController pushViewController:loginViewController animated:YES];
    
    loginViewController = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
