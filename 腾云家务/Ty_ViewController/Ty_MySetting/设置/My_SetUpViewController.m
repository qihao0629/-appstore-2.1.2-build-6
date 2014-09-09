//
//  My_SetUpViewController.m
//  腾云家务
//
//  Created by 艾飞 on 14/6/6.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "My_SetUpViewController.h"

#import "My_LogOut_busine.h"
#import "Ty_WebViewVC.h"
#import "My_SetUpHelpVC.h"
#import "ViewController.h"
@interface My_SetUpViewController ()<UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate,viewControllerDelegate>
{
    UITableView * _tableView;
    ViewController* rootView;
}
@end

@implementation My_SetUpViewController

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
    
    self.title = @"关于软件";
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,SCREEN_HEIGHT - 20- 44 -49) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //    _tableView.scrollEnabled = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView = nil;
    
    UIView * tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, TYFRAMEWIDTH(_tableView), 140)];
    
    UIImageView * imageLogo = [[UIImageView alloc]initWithFrame:CGRectMake((TYFRAMEWIDTH(_tableView)-62)/2, 24, 62, 62)];
    imageLogo.image = JWImageName(@"Icon");
    [tableHeaderView addSubview:imageLogo];
    
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    
    UILabel * lableV = [[UILabel alloc]initWithFrame:CGRectMake(0, 24+62+10, TYFRAMEWIDTH(_tableView), 30)];
    lableV.text =[NSString stringWithFormat:@"腾云家务:V%@",currentVersion];
    lableV.backgroundColor = [UIColor clearColor];
    lableV.textAlignment = UITextAlignmentCenter;
    lableV.textColor = [UIColor colorWithRed:90.0/255.0 green:90.0/255.0 blue:90.0/255.0 alpha:1.0];
    lableV.font = [UIFont systemFontOfSize:18.0f];
    [tableHeaderView addSubview:lableV];
    
    _tableView.tableHeaderView = tableHeaderView;
    
    if (IFLOGINYES) {
        UIView* logouView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, TYFRAMEWIDTH(_tableView), 54)];
        buttonlogout = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonlogout.frame  = CGRectMake(15, 5, 290, 44);
        [buttonlogout setTitle:@"退出登录" forState:UIControlStateNormal];
        [buttonlogout setBackgroundImage:[UIImage imageNamed:@"login.png"] forState:UIControlStateNormal];
        [buttonlogout addTarget:self action:@selector(buttonlogput:) forControlEvents:UIControlEventTouchUpInside];
        [logouView addSubview:buttonlogout];
        _tableView.tableFooterView=logouView;
    }
    [self.view addSubview:_tableView];
    [self addNotificationForName:@"MyLogOut"];
}
#pragma mark - UITableView Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * strCell = @"personageCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:strCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:strCell];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"去评分";
            break;
        case 1:
            cell.textLabel.text = @"欢迎页";
            
            break;
        case 2:
            cell.textLabel.text = @"功能介绍";
            
            break;
        case 3:
            cell.textLabel.text = @"帮助与反馈";
            
            break;
            //        case 4:
            //            cell.textLabel.text = @"检测新版本";
            //            break;
        default:
            break;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:EvaluateWebLink]];
            break;
        case 1:{
            [self setNavigationBarHidden:YES animated:NO];
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDelegate:nil];
            [UIView setAnimationDuration:2];
            rootView=[[ViewController alloc]init];
            [rootView.view setFrame:CGRectMake(0, -20, SCREEN_WIDTH, SCREEN_HEIGHT)];
            rootView.delegate=self;
            [self.view addSubview:rootView.view];
            [UIView commitAnimations];
            
            break;
        }
        case 2:{
            Ty_WebViewVC* webVC=[Ty_WebViewVC shareWebView:Ty_WebloadLocal];
            NSString *filePath = [[NSBundle mainBundle]pathForResource:@"index" ofType:@"html"];
            webVC.filePath=filePath;
            webVC.title=@"功能介绍";
            [self.naviGationController pushViewController:webVC animated:YES];
            break;
        }
        case 3:{
            My_SetUpHelpVC* helpVC=[[My_SetUpHelpVC alloc]init];
            [self.naviGationController pushViewController:helpVC animated:YES];
            break;
        }
            
        default:
            break;
    }
    
}
-(void)pop
{
    [self setNavigationBarHidden:NO animated:NO];
}
-(void)buttonlogput:(UIButton *)but{

    
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                    message:@"确定退出此账号？"
                                                   delegate:self
                                          cancelButtonTitle:@"取消"
                                          otherButtonTitles:@"确定",nil];

    [alert show];
    
    but.userInteractionEnabled = NO;
    
}

#pragma mark - UIAlertView Delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    [alertView dismissWithClickedButtonIndex:buttonIndex animated:NO];
    buttonlogout.userInteractionEnabled = YES;
    if (buttonIndex == 1) {
        My_LogOut_busine * my_logOutBusine = [[My_LogOut_busine alloc]init];
        my_logOutBusine.delegate = self;
        [my_logOutBusine my_LogOut_busine];//退出登录
        [self showLoadingInView:self.view];
        
    }
}

#pragma mark - 通知回调_退出登录
-(void)netRequestReceived:(NSNotification *)_notification{
    [self hideLoadingView];
    if ([[_notification object] isKindOfClass:[NSString class]] && [[_notification object] isEqualToString:@"fail"]) {
        
        [self alertViewTitle:@"退出失败" message:@"网络连接暂时不可用，请稍后再试"];
        
    }else {
        if ([[[_notification object] objectForKey:@"code"]intValue] == 200) {
            
   
            
            [self.naviGationController popToRootViewControllerAnimated:YES];
            
        }else{
            
            [self alertViewTitle:@"退出失败" message:[[_notification object] objectForKey:@"msg"]];
            
        }
        
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
