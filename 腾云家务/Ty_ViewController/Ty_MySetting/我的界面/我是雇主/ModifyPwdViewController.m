//
//  ModifyPwdViewController.m
//  腾云家务
//
//  Created by 艾飞 on 13-11-28.
//  Copyright (c) 2013年 齐 浩. All rights reserved.
//

#import "ModifyPwdViewController.h"
#import <CommonCrypto/CommonDigest.h>
#import "My_Employerinformation_Busine.h"

@interface ModifyPwdViewController ()

@end

@implementation ModifyPwdViewController

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
    
    self.title = @"修改密码";
    
    self.button_ok.hidden = NO;
    UIView *viewClick = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-49-20-44)];
    [self.view addSubview:viewClick];
    UITapGestureRecognizer *clickview = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickview:)];
    [viewClick addGestureRecognizer:clickview];
    UILabel * lable = [[UILabel alloc]initWithFrame:CGRectMake(10, 30, 90, 20)];
    lable.text = @"旧   密   码  :";
    lable.font = [UIFont boldSystemFontOfSize:15.0f];
    lable.backgroundColor = [UIColor clearColor];
    lable.textColor = [UIColor colorWithRed:136.0/255.0 green:136.0/255.0 blue:136.0/255.0 alpha:1.0];
    [self.view addSubview:lable];
    
    _textField_pwd = [[UITextField alloc]initWithFrame:CGRectMake(100, 20, 200,44)];
    [_textField_pwd setBorderStyle:UITextBorderStyleRoundedRect]; //外框类型
    _textField_pwd.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _textField_pwd.autocorrectionType = UITextAutocorrectionTypeNo;
    _textField_pwd.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _textField_pwd.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
    _textField_pwd.placeholder = @"请输入旧密码"; //默认显示的字
    _textField_pwd.secureTextEntry = YES;
    _textField_pwd .delegate = self;
    [self.view addSubview:_textField_pwd];
    
    UILabel * lable1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 90, 90, 20)];
    lable1.text = @"新   密   码  :";
    lable1.font = [UIFont boldSystemFontOfSize:15.0f];
    lable1.backgroundColor = [UIColor clearColor];
    lable1.textColor = [UIColor colorWithRed:136.0/255.0 green:136.0/255.0 blue:136.0/255.0 alpha:1.0];
    [self.view addSubview:lable1];
    
    _textField_Newpwd = [[UITextField alloc]initWithFrame:CGRectMake(100, 80, 200,44)];
    [_textField_Newpwd setBorderStyle:UITextBorderStyleRoundedRect]; //外框类型
    _textField_Newpwd.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _textField_Newpwd.autocorrectionType = UITextAutocorrectionTypeNo;
    _textField_Newpwd.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _textField_Newpwd.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
    _textField_Newpwd.placeholder = @"请输入新密码"; //默认显示的字
    _textField_Newpwd.secureTextEntry = YES;
    _textField_Newpwd.delegate = self;
    [self.view addSubview:_textField_Newpwd];
    
    UILabel * lable2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 150, 90, 20)];
    lable2.text = @"确认新密码 :";
    lable2.font = [UIFont boldSystemFontOfSize:15.0f];
    lable2.backgroundColor = [UIColor clearColor];
    lable2.textColor = [UIColor colorWithRed:136.0/255.0 green:136.0/255.0 blue:136.0/255.0 alpha:1.0];
    [self.view addSubview:lable2];
    
    _textField_Newpwds = [[UITextField alloc]initWithFrame:CGRectMake(100, 140, 200,44)];
    [_textField_Newpwds setBorderStyle:UITextBorderStyleRoundedRect]; //外框类型
    _textField_Newpwds.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _textField_Newpwds.autocorrectionType = UITextAutocorrectionTypeNo;
    _textField_Newpwds.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _textField_Newpwds.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
    _textField_Newpwds.placeholder = @"请再次输入新密码"; //默认显示的字
    _textField_Newpwds.secureTextEntry = YES;
    _textField_Newpwds.delegate = self;
    [self.view addSubview:_textField_Newpwds];
    
    [self addNotificationForName:@"MyEmployerInformPwd"];
    
}
#pragma mark - 点击空白
-(void)clickview:(UITapGestureRecognizer *)tap {
    ResignFirstResponder;

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    ResignFirstResponder;
    return YES;
}
#pragma mark - 完成
-(void)button_okClick{

    if (ISNULLSTR(_textField_pwd.text)) {
        
        [self alertViewTitle:@"提示" message:@"旧密码不可为空"];
        
    }else if (ISNULLSTR(_textField_Newpwd.text)) {
        
        [self alertViewTitle:@"提示" message:@"新密码不可为空"];
        
    }else if (ISNULLSTR(_textField_pwd.text)) {
        
        [self alertViewTitle:@"提示" message:@"确认密码不可为空"];
        
    }else if(![_textField_Newpwd.text isEqualToString:_textField_Newpwds.text]){
        
        [self alertViewTitle:@"提示" message:@"确认密码和新密码不相符"];
        
    }else if ([_textField_pwd.text length] < 6 || [_textField_pwd.text length] > 16) {
        
        [self alertViewTitle:@"修改失败" message:@"密码不可少于6位或大于16位"];

    }else{

        NSMutableDictionary * _dic = [[NSMutableDictionary alloc]init];
        [_dic setObject:[self md5HexDigest:_textField_pwd.text] forKey:@"oldPassword"];
        [_dic setObject:[self md5HexDigest:_textField_Newpwd.text] forKey:@"newPassword"];

        My_Employerinformation_Busine * my_infor_busine = [[My_Employerinformation_Busine alloc]init];
        my_infor_busine.delegate = self;
        [my_infor_busine My_EmployerinformationUserPwd_Req:_dic];
        [self showLoadingInView:self.view];
    }
    
}

#pragma mark - 修改_回调
-(void)netRequestReceived:(NSNotification *)_notification{
    [self hideLoadingView];
    if ([[_notification object] isKindOfClass:[NSString class]] && [[_notification object] isEqualToString:@"fail"]) {
        
        [self alertViewTitle:@"提示" message:@"网络连接暂时不可用，请稍后再试"];
        
    }else {
        if ([[[_notification object] objectForKey:@"code"]intValue] == 200) {
            
            
            
            UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                          message:@"密码修改成功！"
                                                         delegate:self
                                                cancelButtonTitle:Nil
                                                otherButtonTitles:@"确定",nil];
            alert.tag = 2401;
            [alert show];
            
        }else{
            
            [self alertViewTitle:@"提示" message:[[_notification object] objectForKey:@"msg"]];
            
        }
        
    }
    
}

#pragma mark - UIAlertView Delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 2401) {
        
        if (buttonIndex == 0) {
            
            [self.naviGationController popViewControllerAnimated:YES];
            
        }
    }
    
}
#pragma mark - MD5
- (NSString *)md5HexDigest:(NSString*)password

{
    
    const char *original_str = [password UTF8String];
    
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(original_str, strlen(original_str), result);
    
    NSMutableString *hash = [NSMutableString string];
    
    for (int i = 0; i < 16; i++)
        
    {
        
        [hash appendFormat:@"%02X", result[i]];
        
    }
    
    NSString *mdfiveString = [hash uppercaseString];
    
    
    NSLog(@"Encryption Result = %@",mdfiveString);
    return mdfiveString;
}

#pragma mark - 键盘弹出
- (void)keyboardDidShow:(NSNotification *)notification{
    
   
}
- (void)keyboardWillShow:(NSNotification *)notification{


}

#pragma mark - 键盘落下
- (void)keyboardWillHide:(NSNotification *)notification{
    
  
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
