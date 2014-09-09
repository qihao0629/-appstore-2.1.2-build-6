//
//  ForgetPwdViewController.m
//  腾云家务
//
//  Created by 艾飞 on 13-11-29.
//  Copyright (c) 2013年 齐 浩. All rights reserved.
//

#import "ForgetPwdViewController.h"
#import "ForgetPwdCAPTCHAViewController.h"
#import "My_ForgetPwd_busine.h"
@interface ForgetPwdViewController ()

@end

@implementation ForgetPwdViewController

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
    self.title = @"忘记密码";
    UIView *viewClick = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-49 -20 -44)];
    [self.view addSubview:viewClick];
    UITapGestureRecognizer *clickview = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickview:)];
    [viewClick addGestureRecognizer:clickview];
    
	// Do any additional setup after loading the view.
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(10, 35, 300, 44)];
    [_textField setBorderStyle:UITextBorderStyleRoundedRect]; //外框类型
    _textField.background = [UIImage imageNamed:@"login_textfield.png"];
    _textField.placeholder = @" 请输入您注册的电话号码"; //默认显示的字
    _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _textField.autocorrectionType = UITextAutocorrectionTypeNo;
    _textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
    _textField.keyboardType = UIKeyboardTypeNumberPad;
    _textField.delegate = self;
    [self.view addSubview:_textField];
    
    UIButton * button_next = [UIButton buttonWithType:UIButtonTypeCustom];
    button_next.frame = CGRectMake(200, 98, 100, 44);
    [button_next setTitle:@"下一步" forState:UIControlStateNormal];
    [button_next setBackgroundImage:[UIImage imageNamed:@"next.png"] forState:UIControlStateNormal];
    [button_next addTarget:self action:@selector(button_next_click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button_next];
    
    [self addNotificationForName:@"MyYanzhengPhone"];
    
}


#pragma maik - 下一步
-(void)button_next_click{
    
    if (_textField.text.length != 11) {
        
        [self alertViewTitle:@"提示" message:@"请输入正确的电话号码"];
        
    }else{
        
        ResignFirstResponder;
        My_ForgetPwd_busine * my_forPwd = [[My_ForgetPwd_busine alloc] init];
        my_forPwd.delegate = self;
        [my_forPwd MyYanzhengUserPhone:_textField.text];
        [self showLoadingInView:self.view];
        
    }
    
}


#pragma mark - 通知回调_
-(void)netRequestReceived:(NSNotification *)_notification{
    [self hideLoadingView];
    if ([[_notification object] isKindOfClass:[NSString class]] && [[_notification object] isEqualToString:@"fail"]) {
        
        [self alertViewTitle:@"提示" message:@"网络连接暂时不可用，请稍后再试"];
        
        
    }else {
        
        if ([[[_notification object] objectForKey:@"code"]intValue] == 200) {
            
            ForgetPwdCAPTCHAViewController * forgetpwdCa= [[ForgetPwdCAPTCHAViewController alloc]init];
            forgetpwdCa.str_phone = _textField.text;
            [self.naviGationController pushViewController:forgetpwdCa animated:YES];
            
            
        }else{
            
            [self alertViewTitle:@"提示" message:[[_notification object] objectForKey:@"msg"]];
            
        }
        
    }
    
    
}

#pragma mark - 点击空白
-(void)clickview:(UITapGestureRecognizer *)tap {
    ResignFirstResponder;
}
#pragma mark - uitextfied delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    ResignFirstResponder;
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (range.location >= 11) {
        return NO;
    }
    return YES;
}

#pragma mark -

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
