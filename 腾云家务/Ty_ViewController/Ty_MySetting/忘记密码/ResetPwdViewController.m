//
//  ResetPwdViewController.m
//  腾云家务
//
//  Created by 艾飞 on 13-11-29.
//  Copyright (c) 2013年 齐 浩. All rights reserved.
//

#import "ResetPwdViewController.h"
#import "My_ForgetPwd_busine.h"
@interface ResetPwdViewController ()

@end

@implementation ResetPwdViewController

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
    
    self.title = @"重置密码";
    
    button_ok.hidden = NO;
    
    UIView *viewClick = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-49 - 20- 44)];
    [self.view addSubview:viewClick];
    UITapGestureRecognizer *clickview = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickview:)];
    [viewClick addGestureRecognizer:clickview];
    UILabel * lable = [[UILabel alloc]initWithFrame:CGRectMake(10, 30, 300, 20)];
    lable.text = @"请输入新密码";
    lable.font = [UIFont systemFontOfSize:15.0f];
    lable.backgroundColor = [UIColor clearColor];
    lable.textColor = [UIColor colorWithRed:136.0/255.0 green:136.0/255.0 blue:136.0/255.0 alpha:1.0];
    [self.view addSubview:lable];
    
    _textField_pwd = [[UITextField alloc]initWithFrame:CGRectMake(10, 60, 300,44)];
    [_textField_pwd setBorderStyle:UITextBorderStyleRoundedRect]; //外框类型
    _textField_pwd.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _textField_pwd.autocorrectionType = UITextAutocorrectionTypeNo;
    _textField_pwd.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _textField_pwd.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
    //    _textField_pwd.placeholder = @"请输入密码"; //默认显示的字
    _textField_pwd.secureTextEntry = YES;
    _textField_pwd .delegate = self;
    [self.view addSubview:_textField_pwd];
    
    UILabel * lable1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 114, 300, 20)];
    lable1.text = @"确认新密码";
    lable1.font = [UIFont systemFontOfSize:15.0f];
    lable1.backgroundColor = [UIColor clearColor];
    lable1.textColor = [UIColor colorWithRed:136.0/255.0 green:136.0/255.0 blue:136.0/255.0 alpha:1.0];
    [self.view addSubview:lable1];
    
    _textField_pwds = [[UITextField alloc]initWithFrame:CGRectMake(10, 144, 300,44)];
    [_textField_pwds setBorderStyle:UITextBorderStyleRoundedRect]; //外框类型
    _textField_pwds.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _textField_pwds.autocorrectionType = UITextAutocorrectionTypeNo;
    _textField_pwds.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _textField_pwds.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
    //    _textField_Newpwd.placeholder = @"请输入密码"; //默认显示的字
    _textField_pwds.secureTextEntry = YES;
    _textField_pwds.delegate = self;
    [self.view addSubview:_textField_pwds];
    
    [self addNotificationForName:@"MyUpdateUserPwd"];
}
#pragma mark - 点击空白
-(void)clickview:(UITapGestureRecognizer *)tap {
    ResignFirstResponder;
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    ResignFirstResponder;
    return YES;
}


#pragma mark ----- 成功but 函数
-(void)button_okClick{

    if (ISNULLSTR(_textField_pwd.text)) {
        [self alertViewTitle:@"提示" message:@"密码不可为空"];
    }else     if (ISNULLSTR(_textField_pwds.text)) {
        [self alertViewTitle:@"提示" message:@"确认密码不可为空"];
    }else    if(![_textField_pwds.text isEqualToString:_textField_pwd.text]){
        [self alertViewTitle:@"提示" message:@"两次密码不相符"];
    }else if ([_textField_pwd.text length] > 16 || [_textField_pwd.text length] < 6){
        [self alertViewTitle:@"提示" message:@"密码不可小于6位大于16位"];
    }else{
        ResignFirstResponder;
        My_ForgetPwd_busine * my_forPwd = [[My_ForgetPwd_busine alloc] init];
        my_forPwd.delegate = self;
        [my_forPwd MyChongzhiPwdPhone:self.userPhone userPassword:_textField_pwd.text];
        
        [self showLoadingInView:self.view];

    }
    
    
}
#pragma mark - 通知回调_验证码验证
-(void)netRequestReceived:(NSNotification *)_notification{
    [self hideLoadingView];
    if ([[_notification object] isKindOfClass:[NSString class]] && [[_notification object] isEqualToString:@"fail"]) {
        
        [self alertViewTitle:nil message:@"网络连接暂时不可用，请稍后再试"];
        
    }else {
        
        if ([[[_notification object] objectForKey:@"code"]intValue] == 200) {
            
        
            
            UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                          message:@"密码重置成功！"
                                                         delegate:self
                                                cancelButtonTitle:Nil
                                                otherButtonTitles:@"确定",nil];
            alert.tag = 2401;
            [alert show];
            
        }else{
            
            [self alertViewTitle:@"重置失败" message:[[_notification object] objectForKey:@"msg"]];
            
        }
        
    }
    
}
#pragma mark - UIAlertView Delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 2401) {
        
        if (buttonIndex == 0) {
            
            [self.naviGationController popToRootViewControllerAnimated:YES];
            
        }
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
