//
//  My_EnterpriseViewController.m
//  腾云家务
//
//  Created by 艾飞 on 14-5-29.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "My_EnterpriseViewController.h"
#import "My_EnteroriseCell.h"
#import "My_Registered_busine.h"
#import "My_RegSucceedViewController.h"
@interface My_EnterpriseViewController ()

@end

@implementation My_EnterpriseViewController

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
    self.button_ok.hidden = NO;

    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, 150) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView = nil;
    [self.view addSubview:_tableView];

    [self addNotificationForName:@"MyRegisteredShop"];
}

#pragma mark - 通知回调
-(void)netRequestReceived:(NSNotification *)_notification{
    [self hideLoadingView];
    if ([[_notification object] isKindOfClass:[NSString class]] && [[_notification object] isEqualToString:@"fail"]) {
        
        [self alertViewTitle:@"提示" message:@"网络连接暂时不可用，请稍后再试"];
        
    }else {
        if ([[[_notification object] objectForKey:@"code"]intValue] == 200) {
            
            UITextField * textPwd = (UITextField *)[self.view viewWithTag:2401];
            
            //注册成功
            My_RegSucceedViewController * my_regSucceed = [[My_RegSucceedViewController alloc]init];
            my_regSucceed.title = @"注册成功";
            my_regSucceed.userName = _userName;
            my_regSucceed.userPwd = textPwd.text;
            [self.naviGationController pushViewController:my_regSucceed animated:YES];
            
        }else{
            
            [self alertViewTitle:@"提示" message:[[_notification object] objectForKey:@"msg"]];
            
        }
        
    }
    
}

#pragma mark - 完成
-(void)button_okClick{
    
    ResignFirstResponder;
    UITextField * textpwd = (UITextField *)[self.view viewWithTag:2401];
    UITextField * textpwds = (UITextField *)[self.view viewWithTag:2402];
    
    if ([textpwd.text length] < 6 || [textpwd.text length] > 16) {
        [self alertViewTitle:@"注册失败" message:@"密码不可少于6位或大于16位"];
        return;
    }
    
    if ([textpwd.text isEqualToString:textpwds.text]) {
        
        NSMutableDictionary * dic_Regis = [[NSMutableDictionary alloc]init];
        [dic_Regis setObject:[[Guid share]getGuid] forKey:@"userGuid"];
        [dic_Regis setObject:@"0" forKey:@"userType"];
        [dic_Regis setObject:textpwd.text forKey:@"userPassword"];
        [dic_Regis setObject:self.userName forKey:@"userName"];
        [dic_Regis setObject:self.userName forKey:@"userPhone"];
        My_Registered_busine * my_registered = [[My_Registered_busine alloc]init];
        [my_registered my_enterpriseRegisterd_busine:dic_Regis];
        [self showLoadingInView:self.view];

        
    }else{
    
        [self alertViewTitle:@"注册失败" message:@"两次密码不一致。"];
    }
    
}

#pragma mark - UITableView Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * strID = [NSString stringWithFormat:@"my_persongerCell%d%d",indexPath.section,indexPath.row];
    My_EnteroriseCell * cell = [tableView dequeueReusableCellWithIdentifier:strID];
    if (cell == nil) {
        cell = [[My_EnteroriseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID];
        
    }
    cell.textLabel.font = [UIFont boldSystemFontOfSize:16.0];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.selectionStyle =  UITableViewCellSelectionStyleNone;

    NSArray * arrayName = [[NSArray alloc]initWithObjects:@"用户名",@"密码",@"确认密码", nil];
    cell.textLabel.text = [arrayName objectAtIndex:indexPath.row];
    cell._textField.delegate = self;
    
    switch (indexPath.row) {
            
        case 0:
            
            [cell._textField setEnabled:NO];
            cell._textField.text = self.userName;
            
            break;
        case 1:
            
            cell._textField.placeholder = @"请输入密码";
            cell._textField.tag = 2401;
            cell._textField.secureTextEntry = YES;

            break;
        case 2:
            
            cell._textField.placeholder = @"请再次输入密码";
            cell._textField.tag = 2402;
            cell._textField.secureTextEntry = YES;
            
            break;
        default:
            break;
    }
    
    return cell;
    
}

#pragma mark - UITextField Delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    ResignFirstResponder;
    return YES;
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
