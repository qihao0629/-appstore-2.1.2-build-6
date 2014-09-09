//
//  ForgetPwdCAPTCHAViewController.m
//  腾云家务
//
//  Created by 艾飞 on 13-11-29.
//  Copyright (c) 2013年 齐 浩. All rights reserved.
//

#import "ForgetPwdCAPTCHAViewController.h"
#import "ResetPwdViewController.h"
#import "My_Registered_busine.h"
#import "My_ForgetPwd_busine.H"
@interface ForgetPwdCAPTCHAViewController ()

@end

@implementation ForgetPwdCAPTCHAViewController
@synthesize str_phone;
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
    self.title = @"验证码";
    UIView *viewClick = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height- 49 - 20 - 44)];
    [self.view addSubview:viewClick];
    UITapGestureRecognizer *clickview = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickview:)];
    [viewClick addGestureRecognizer:clickview];
    
    NSString *string1 = [str_phone substringWithRange:NSMakeRange(0, 3)];
    NSString * string2 = [str_phone substringFromIndex:7];
    
    UILabel * lable_phone = [[UILabel alloc]initWithFrame:CGRectMake(10, 35, 300, 50)];
    lable_phone.textColor = [UIColor colorWithRed:136.0/255.0 green:136.0/255.0 blue:136.0/255.0 alpha:1.0];
    lable_phone.text = [NSString stringWithFormat:@"验证码以短信形式发送至您的手机(%@****%@),请查收",string1,string2];
    lable_phone.numberOfLines = 0;
    lable_phone.font = [UIFont systemFontOfSize:14.0f];
    lable_phone.backgroundColor = [UIColor clearColor];
    [self.view addSubview:lable_phone];
    
        //重新获取验证码
    butAffiche = [UIButton buttonWithType:UIButtonTypeCustom];
    butAffiche.frame = CGRectMake(10, 140, 150, 40);
    //    [butAffiche setBackgroundColor:[UIColor grayColor]];
    [butAffiche setTitleColor:[UIColor colorWithRed:0.0/255.0 green:175.0/255.0 blue:232.0/255.0 alpha:1.0]forState:UIControlStateNormal];
    [butAffiche setTitle:@"重新获取验证码(60)" forState:UIControlStateNormal];
    butAffiche.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [butAffiche addTarget:self action:@selector(butAfficheClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:butAffiche];
    
    timer_i = 60;
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(function:) userInfo:nil repeats:YES];

    _textField = [[UITextField alloc]initWithFrame:CGRectMake(10, 85, 300, 44)];
    //    _textField.background = [UIImage imageNamed:@"输入条.png"];
    [_textField setBorderStyle:UITextBorderStyleRoundedRect]; //外框类型
    _textField.placeholder = @" 请输入验证码"; //默认显示的字
    _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _textField.autocorrectionType = UITextAutocorrectionTypeNo;
    _textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
    _textField.keyboardType = UIKeyboardTypeNumberPad;
    _textField.delegate = self;
    [self.view addSubview:_textField];
    
    UIButton * button_next = [UIButton buttonWithType:UIButtonTypeCustom];
    button_next.frame = CGRectMake(200, 150, 100, 44);
    [button_next setTitle:@"下一步" forState:UIControlStateNormal];
    [button_next setBackgroundImage:[UIImage imageNamed:@"next.png"] forState:UIControlStateNormal];
    [button_next addTarget:self action:@selector(button_nexts_click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button_next];
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(MyNetRequestReceivedCheck:) name:@"MyNetRequestReceivedCheck" object:nil];
    [self addNotificationForName:@"MyYanzhengPhone"];
    
}
//获取验证码

-(void)butAfficheClick:(UIButton *)but{
    My_ForgetPwd_busine * my_forPwd = [[My_ForgetPwd_busine alloc] init];
    my_forPwd.delegate = self;
    [my_forPwd MyYanzhengUserPhone:str_phone];
    [self showLoadingInView:self.view];
    NSLog(@"验证码");
}


#pragma mark - 通知回调_
-(void)netRequestReceived:(NSNotification *)_notification{
    [self hideLoadingView];
    if ([[_notification object] isKindOfClass:[NSString class]] && [[_notification object] isEqualToString:@"fail"]) {
        
        [self alertViewTitle:@"提示" message:@"网络连接暂时不可用，请稍后再试"];
        
    }else {
        
        if ([[[_notification object] objectForKey:@"code"]intValue] == 200) {
            
            [self alertViewTitle:@"提示" message:@"验证码发送成功，请查收"];
            
            timer_i = 60;
            [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(function:) userInfo:nil repeats:YES];
            
        }else{
            
            [self alertViewTitle:@"提示" message:[[_notification object] objectForKey:@"msg"]];
            
        }
    }
}


#pragma mark - 定时器
-(void)function:(NSTimer *)mytimer{
    
    if (timer_i >= 0) {
        
        [butAffiche setUserInteractionEnabled:NO];
        timer_i = timer_i - 1 ;
        NSString * str_timer = [NSString stringWithFormat:@"%d",timer_i];
        [butAffiche setTitle:[NSString stringWithFormat:@"重新获取验证码(%@)",str_timer] forState:UIControlStateNormal];
        
        if (timer_i == 0) {
            
            [mytimer invalidate];
            mytimer = nil;
            [butAffiche setTitle:@"点击重新获取验证码" forState:UIControlStateNormal];
            [butAffiche setUserInteractionEnabled:YES];
            
        }

    }else{
    

    }
    
}

#pragma maik - 下一步
-(void)button_nexts_click{
    
    if (!ISNULLSTR(_textField.text)) {
        ResignFirstResponder;
        NSMutableDictionary  * _dic = [[NSMutableDictionary alloc]init];
        [_dic setObject:_textField.text forKey:@"verifyCode"];
        [_dic setObject:str_phone forKey:@"userPhone"];
        
        My_Registered_busine * my_reg = [[My_Registered_busine alloc]init];
        my_reg.delegate = self;
        [my_reg my_CheckYanZhengMa_busine:_dic];
        
        [self showLoadingInView:self.view];

    }else{
        
        [self alertViewTitle:@"提示" message:@"验证码不可为空"];
        
    }
    
}
#pragma mark - 通知回调_验证码验证
-(void)MyNetRequestReceivedCheck:(NSNotification *)_notification{
    [self hideLoadingView];
    if ([[_notification object] isKindOfClass:[NSString class]] && [[_notification object] isEqualToString:@"fail"]) {
        
        [self alertViewTitle:@"提示" message:@"网络连接暂时不可用，请稍后再试"];
        
    }else {
        
        if ([[[_notification object] objectForKey:@"code"]intValue] == 200) {
            
            
            ResetPwdViewController * reset = [[ResetPwdViewController alloc]init];
            reset.userPhone = str_phone;
            [self.naviGationController pushViewController:reset animated:YES];
            
            
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



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
