//
//  My_LoginViewController.m
//  腾云家务
//
//  Created by 艾飞 on 14-5-28.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "My_LoginViewController.h"
#import "My_login_busine.h"//登录业务
#import "My_RegisteredViewController.h"//注册
#import "XmppManager.h"
#import "ForgetPwdViewController.h"//忘记密码
@interface My_LoginViewController ()

@end

@implementation My_LoginViewController

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
    self.title = @"登录";
    
//    [self setSlidingBack:NO];
    
    UIView *viewClick = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-49 - 44 -20)];
    viewClick.backgroundColor = view_BackGroudColor;
    [self.view addSubview:viewClick];
    UITapGestureRecognizer *clickview = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickview:)];
    [viewClick addGestureRecognizer:clickview];
    
    UIImageView * imageView_user = [[UIImageView alloc]initWithFrame:CGRectMake(30, 50, 260, 95)];
    imageView_user.image = [UIImage imageNamed:@"login_background.png"];
    [imageView_user setUserInteractionEnabled:YES];
    [self.view addSubview:imageView_user];
    
    _textFieldUser = [[UITextField alloc]initWithFrame:CGRectMake(45, 0, 205, 46)];
    //    _textField.background = [UIImage imageNamed:@"输入条.png"];
    [_textFieldUser setBorderStyle:UITextBorderStyleNone]; //外框类型
    _textFieldUser.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _textFieldUser.autocorrectionType = UITextAutocorrectionTypeNo;
    _textFieldUser.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _textFieldUser.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
    _textFieldUser.placeholder = @"请输入电话号码/用户名"; //默认显示的字
//    _textFieldUser.returnKeyType = UIReturnKeyJoin;
    _textFieldUser.delegate = self;
    _textFieldUser.tag = 2401;
    [imageView_user addSubview:_textFieldUser];
    
    
    _textFieldPwd = [[UITextField alloc]initWithFrame:CGRectMake(45, 48, 205, 46)];
    //    _textField.background = [UIImage imageNamed:@"输入条.png"];
    [_textFieldPwd setBorderStyle:UITextBorderStyleNone]; //外框类型
    _textFieldPwd.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _textFieldPwd.autocorrectionType = UITextAutocorrectionTypeNo;
    _textFieldPwd.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _textFieldPwd.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
    _textFieldPwd.placeholder = @"请输入密码"; //默认显示的字
//    _textFieldPwd.returnKeyType = UIReturnKeyJoin;
    _textFieldPwd.secureTextEntry = YES;
    _textFieldPwd.delegate = self;
    _textFieldPwd.tag = 2402;
    _textFieldPwd.keyboardType = UIKeyboardTypeASCIICapable;
    [imageView_user addSubview:_textFieldPwd];
    
    
    button_login = [UIButton buttonWithType:UIButtonTypeCustom];
    button_login.frame  = CGRectMake(30, 165, 260, 44);
    [button_login setTitle:@"登录" forState:UIControlStateNormal];
    [button_login setBackgroundImage:[UIImage imageNamed:@"login.png"] forState:UIControlStateNormal];
    [button_login addTarget:self action:@selector(button_login_click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button_login];
    

    UIButton * but_geren = [UIButton buttonWithType:UIButtonTypeCustom];
    but_geren.frame = CGRectMake(20, 285 , 130, 44);
    [but_geren setBackgroundImage:[UIImage imageNamed:@"set_upbuttongreen.png"] forState:UIControlStateNormal];
    [but_geren setTitle:@"个人注册" forState:UIControlStateNormal];
    [but_geren addTarget:self action:@selector(but_geren:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but_geren];
    
    UIButton * but_qiye = [UIButton buttonWithType:UIButtonTypeCustom];
    but_qiye.frame = CGRectMake(170, 285 , 130, 44);
    [but_qiye setBackgroundColor:[UIColor grayColor]];
    [but_qiye setUserInteractionEnabled:NO];
//    [but_qiye setBackgroundImage:[UIImage imageNamed:@"set_upbuttongreen.png"] forState:UIControlStateNormal];
    [but_qiye addTarget:self action:@selector(but_qiye:) forControlEvents:UIControlEventTouchUpInside];
    [but_qiye setTitle:@"商户注册" forState:UIControlStateNormal];
    [self.view addSubview:but_qiye];
    
    UILabel * labletishi = [[UILabel alloc]initWithFrame:CGRectMake(20, 295+44, 280, 20)];
    labletishi.backgroundColor = [UIColor clearColor];
    labletishi.text = @"*立即注册腾云家务找短工或成为服务者";
    labletishi.textAlignment = NSTextAlignmentLeft;
    labletishi.font = [UIFont systemFontOfSize:14.0];
    labletishi.textColor = [UIColor colorWithRed:167.0/255.0 green:167.0/255.0 blue:167.0/255.0 alpha:1.0];
    [self.view addSubview:labletishi];
    
    UIButton * button_forgetpwd = [UIButton buttonWithType:UIButtonTypeCustom];
    button_forgetpwd.frame  = CGRectMake(112, 220, 95, 30);
    [button_forgetpwd setTitle:@"?忘记密码" forState:UIControlStateNormal];
    [button_forgetpwd setTitleColor:[UIColor colorWithRed:161.0/255.0 green:160.0/255.0 blue:160.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [button_forgetpwd setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [button_forgetpwd addTarget:self action:@selector(button_forgetpwd_click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button_forgetpwd];
    
    [self addNotificationForName:@"MyLogIn"];

}

#pragma mark - 返回
-(void)backClick{

    [self.naviGationController popToRootViewControllerAnimated:YES];
}
#pragma mark - 通知回调_登录成功
-(void)netRequestReceived:(NSNotification *)_notification{
    [self hideLoadingView];
    button_login.userInteractionEnabled = YES;
    if ([[_notification object] isKindOfClass:[NSString class]] && [[_notification object] isEqualToString:@"fail"]) {
        
        [self alertViewTitle:@"登录失败" message:@"网络连接暂时不可用，请稍后再试"];


    }else {
        
        if ([[[_notification object] objectForKey:@"code"]intValue] == 200) {

#if TARGET_SHOP_OPEN
            
            if ([[[[[_notification object] objectForKey:@"rows"] objectAtIndex:0] objectForKey:@"userType"] isEqualToString:@"0"]) {
                
                [self alertViewTitle:@"即将开放" message:@"商户功能即将开放，给您带来的不便，请您谅解！"];
                
                return;
                
            }else{
                
                [self.naviGationController popToRootViewControllerAnimated:YES];
                
            }
#else
            
            [self.naviGationController popToRootViewControllerAnimated:YES];

            
#endif
         
        }else{
        
            [self alertViewTitle:@"登录失败" message:[[_notification object] objectForKey:@"msg"]];

        }
    
    }


}


#pragma mark - 个人注册
-(void)but_geren:(UIButton *)but{

    My_RegisteredViewController * my_reg = [[My_RegisteredViewController alloc]init];
    my_reg.title = @"个人注册";
    my_reg.userType = @"2";
    [self.naviGationController pushViewController:my_reg animated:YES];
    
}

#pragma mark - 商户注册

-(void)but_qiye:(UIButton *)but{
    
    My_RegisteredViewController * my_reg = [[My_RegisteredViewController alloc]init];
    my_reg.title = @"商户注册";
    my_reg.userType = @"0";
    [self.naviGationController pushViewController:my_reg animated:YES];
    
}
#pragma mark - 点击空白
-(void)clickview:(UITapGestureRecognizer *)tap {
    
    ResignFirstResponder;
 
}

#pragma mark - 忘记密码
-(void)button_forgetpwd_click{
    
    ForgetPwdViewController * forgetpwed = [[ForgetPwdViewController alloc]init];
    [self.naviGationController pushViewController:forgetpwed animated:YES];
}

#pragma mark -  登录
-(void)button_login_click:(UIButton *)but{
    
    if (ISNULLSTR(_textFieldUser.text)) {
        
        [self alertViewTitle:@"登录失败" message:@"用户名不可为空"];

    }else if(ISNULLSTR(_textFieldPwd.text)){
    
        [self alertViewTitle:@"登录失败" message:@"密码不可为空"];
        
    }else{
    
        but.userInteractionEnabled = NO;
        ResignFirstResponder;
        NSMutableDictionary * dic_login = [[NSMutableDictionary alloc]init];
        [dic_login setObject:_textFieldUser.text forKey:@"userName"];
        [dic_login setObject:_textFieldPwd.text forKey:@"userPassword"];
        
        My_login_busine * my_loginbusine = [[My_login_busine alloc]init];
        my_loginbusine.delegate = self;
        [my_loginbusine my_login_busine:dic_login];
        
        [self showLoadingInView:self.view];
    
    }

}

#pragma mark - UITextField delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];

    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField.tag == 2402) {
        if (range.location >= 16) {
            
            return NO;
        }
    }
    if (textField.tag == 2401) {
        if (range.location >= 11) {
            
            return NO;
        }
        
//        NSCharacterSet *cs;
//        cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
//        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
//        BOOL basicTest = [string isEqualToString:filtered];
//        if(!basicTest)
//        {
//            return NO;
//        }

    }

    return YES;
}

- (void)keyboardWillShow:(NSNotification *)notification{

}

/**键盘落下处理方法*/
- (void)keyboardWillHide:(NSNotification *)notification{

}

/**键盘弹出后处理方法*/
- (void)keyboardDidShow:(NSNotification *)notification{

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
