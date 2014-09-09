//
//  My_RegisteredViewController.m
//  腾云家务
//
//  Created by 艾飞 on 14-5-29.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "My_RegisteredViewController.h"
#import "My_Registered_busine.h"
#import "My_EnterpriseViewController.h"
#import "My_PersonageViewController.h"
#import "Ty_WebViewVC.h"
#import "My_RegSucceedViewController.h"
@interface My_RegisteredViewController ()

@end

@implementation My_RegisteredViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        selectCity = [[Ty_Home_SelectCityVC alloc]init];
        selectCity.delegate = self;
        [self addNotificationForName:@"Ty_HomeVC"];
        regCity = @"";

    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [self setNavigationBarHidden:NO animated:NO];
    
}
int timer_i;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    if ([self.userType isEqualToString:@"0"]) {
        
        self.title = @"商户注册";
        
    }else{
        
        self.title = @"个人注册";
        
    }
    UIView *viewClick = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-49 - 44 -20)];
    [self.view addSubview:viewClick];
    UITapGestureRecognizer *clickview = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickview:)];
    [viewClick addGestureRecognizer:clickview];
    
	// Do any additional setup after loading the view.
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(10, 20, 300, 44)];
    [_textField setBorderStyle:UITextBorderStyleRoundedRect]; //外框类型
    _textField.background = [UIImage imageNamed:@"login_textfield.png"];
    _textField.placeholder = @" 请输入手机号"; //默认显示的字
    _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _textField.autocorrectionType = UITextAutocorrectionTypeNo;
    _textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
    _textField.keyboardType = UIKeyboardTypeNumberPad;
    _textField.delegate = self;
    [self.view addSubview:_textField];
    
    _textPwd = [[UITextField alloc]initWithFrame:CGRectMake(10, 35 + 44, 300, 44)];
    [_textPwd setBorderStyle:UITextBorderStyleRoundedRect]; //外框类型
    _textPwd.background = [UIImage imageNamed:@"login_textfield.png"];
    _textPwd.placeholder = @" 请输入密码"; //默认显示的字
    _textPwd.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _textPwd.autocorrectionType = UITextAutocorrectionTypeNo;
    _textPwd.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _textPwd.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
    _textPwd.keyboardType = UIKeyboardTypeASCIICapable;
    _textPwd.delegate = self;
    [self.view addSubview:_textPwd];
    
    
    _textFieldyq = [[UITextField alloc]initWithFrame:CGRectMake(10, 35 + 44 + 15 + 44  , 200, 44)];
    [_textFieldyq setBorderStyle:UITextBorderStyleRoundedRect]; //外框类型
    _textFieldyq.background = [UIImage imageNamed:@"login_textfield.png"];
    _textFieldyq.placeholder = @" 请输入验证码"; //默认显示的字
    _textFieldyq.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _textFieldyq.autocorrectionType = UITextAutocorrectionTypeNo;
    _textFieldyq.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _textFieldyq.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
    _textFieldyq.keyboardType = UIKeyboardTypeNumberPad;
    _textFieldyq.delegate = self;
    _textFieldyq.enabled = NO;
    [self.view addSubview:_textFieldyq];
    
    //    login_yanzhengma@2x
    butAffiche = [UIButton buttonWithType:UIButtonTypeCustom];
    butAffiche.tag = 1102;
    butAffiche.frame = CGRectMake(220, 35 + 44  + 15 + 44, 90, 44);
    [butAffiche setBackgroundImage:[UIImage imageNamed:@"login_yanzhengma.png"] forState:UIControlStateNormal];
    [butAffiche setTitle:@"获取验证码" forState:UIControlStateNormal];
    butAffiche.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [butAffiche addTarget:self action:@selector(button_yanzheng:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:butAffiche];
    
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [button setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"tongyi_xz.png"]]];
    [button setBackgroundImage:[UIImage imageNamed:@"tongyi_xz.png"] forState:UIControlStateNormal];
    button.frame = CGRectMake(10 , 82+55 + 15 + 44, 15, 15);
    [button addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UILabel * labletk = [[UILabel alloc]initWithFrame:CGRectMake(30, 70 + 10 + 55 + 15 + 44, 100, 20)];
    labletk.backgroundColor = [UIColor clearColor];
    labletk.font = [UIFont systemFontOfSize:13.0f];
    labletk.textAlignment = NSTextAlignmentLeft;
    labletk.text = @"已经阅读并同意";
    [self.view addSubview:labletk];
    
    UILabel * labletk_1 = [[UILabel alloc]initWithFrame:CGRectMake(120, 70 + 10 + 55 + 15 +44, 130, 20)];
    labletk_1.backgroundColor = [UIColor clearColor];
    labletk_1.font = [UIFont systemFontOfSize:13.0f];
    labletk_1.textAlignment = NSTextAlignmentLeft;
    labletk_1.userInteractionEnabled=YES;
    labletk_1.textColor = [UIColor colorWithRed:52.0/255.0 green:126.0/255.0 blue:202.0/255.0 alpha:1.0f];
    labletk_1.text = @"使用条款和隐私政策";
    [self.view addSubview:labletk_1];
    
    UITapGestureRecognizer * tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickRules)];
    [labletk_1 addGestureRecognizer:tapGesture];
    
    UIButton * button_next = [UIButton buttonWithType:UIButtonTypeCustom];
    button_next.frame  = CGRectMake(10, 165 + 15 + 44 + 10, 300, 44);
    [button_next setTitle:@"立即注册" forState:UIControlStateNormal];
    [button_next setBackgroundImage:[UIImage imageNamed:@"login.png"] forState:UIControlStateNormal];
    [button_next addTarget:self action:@selector(button_next_click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button_next];
    
    UIImageView * imageLocation = [[UIImageView alloc]initWithFrame:CGRectMake(10, 165 + 15 + 44 + 10 + 44 + 20, 16, 20)];
    imageLocation.image = JWImageName(@"my_regdingwei");
    [self.view addSubview:imageLocation];
    
    labelLocationText = [[UILabel alloc]initWithFrame:CGRectMake(30, 298, 230, 20)];
    labelLocationText.backgroundColor = [UIColor clearColor];
    labelLocationText.textAlignment = NSTextAlignmentLeft;
    labelLocationText.font = [UIFont boldSystemFontOfSize:16.0f];
    labelLocationText.textColor = ColorRedText;
    labelLocationText.text = @"定位城市:";
    [self.view addSubview:labelLocationText];
    
    buttonLocation = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonLocation.frame = CGRectMake(30 + [self widthForString:labelLocationText.text fontSize:16.0f andHeight:20], 293, 120, 30);
    [buttonLocation setTitle:@"(点击选择更改)" forState:UIControlStateNormal];
    [buttonLocation setTitleColor:ColorRedText forState:UIControlStateNormal];
    [buttonLocation addTarget:self action:@selector(buttonLocation:) forControlEvents:UIControlEventTouchUpInside];
    buttonLocation.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    [self.view addSubview:buttonLocation];
    
    UILabel * labelBut = [[UILabel alloc]initWithFrame:CGRectMake(20, 25, 90, 1)];
    labelBut.backgroundColor = ColorRedText;
    [buttonLocation addSubview:labelBut];
    
    
    [self addNotificationForName:@"YanZhengMa"];
    
    [self addNotificationForName:@"MyNewReqistered"];
}

#pragma mark - 定位更改
-(void)buttonLocation:(UIButton *)but{

    NSLog(@"点击了修改");
    UIImage* title_bg = [[UIImage alloc]init];
    if (IOS7) {
        title_bg = JWImageName(@"titleBar");
    }else{
        title_bg = JWImageName(@"titleBar1");
    }
    UINavigationController* selectCityNavigation  = [[UINavigationController alloc]initWithRootViewController:selectCity];
    selectCityNavigation.navigationBar.translucent = NO;
    [selectCityNavigation.navigationItem setHidesBackButton:YES];
    UIColor * cc = [UIColor whiteColor];
    NSDictionary * dict = [NSDictionary dictionaryWithObject:cc forKey:UITextAttributeTextColor];
    selectCityNavigation.navigationBar.titleTextAttributes = dict;
    [selectCityNavigation.navigationBar setBackgroundImage:title_bg forBarMetrics:UIBarMetricsDefault];
    
    [self presentViewController:selectCityNavigation animated:YES completion:nil];
}

-(void)Home_SelectCity:(TSLocation *)_home_selectData
{
  
   
    if (ISNULLSTR(_home_selectData.city)){
        
        _home_selectData.city = @"定位失败";
        labelLocationText.text = [NSString stringWithFormat:@"定位城市:%@",_home_selectData.city];
        regCity = _home_selectData.city;
        labelLocationText.frame = CGRectMake(30, 298, [self widthForString:labelLocationText.text fontSize:16.0f andHeight:20], 20);
        buttonLocation.frame = CGRectMake(30 + [self widthForString:labelLocationText.text fontSize:16.0f andHeight:20], 293, 120, 30);
    }else {
    
        labelLocationText.text = [NSString stringWithFormat:@"定位城市:%@",_home_selectData.city];
        regCity = _home_selectData.city;
        labelLocationText.frame = CGRectMake(30, 298, [self widthForString:labelLocationText.text fontSize:16.0f andHeight:20], 20);
        buttonLocation.frame = CGRectMake(30 + [self widthForString:labelLocationText.text fontSize:16.0f andHeight:20], 293, 120, 30);
    }

    
}

#pragma mark - 通知回调_成功
-(void)netRequestReceived:(NSNotification *)_notification{
    [self hideLoadingView];
    if ([[_notification object] isKindOfClass:[NSString class]] && [[_notification object] isEqualToString:@"fail"]) {
        
        [self alertViewTitle:@"验证码获取失败" message:@"网络连接暂时不可用，请稍后再试"];
        
    }else {
        if ([[[_notification object] objectForKey:@"code"]intValue] == 200) {
            
            //验证码发送成功
        
            [self alertViewTitle:@"提示" message:[NSString stringWithFormat:@"腾云家务验证码:%@",[[_notification object] objectForKey:@"verifyCode"]]];
            _textFieldyq.text = [[_notification object] objectForKey:@"verifyCode"];
   

        }else  if ([[[_notification object] objectForKey:@"code"]intValue] == 24200) {
        
            //注册成功
            My_RegSucceedViewController * my_regSucceed = [[My_RegSucceedViewController alloc]init];
            my_regSucceed.title = @"注册成功";
            my_regSucceed.userName = _textField.text;
            my_regSucceed.userPwd = _textPwd.text;
            [self.naviGationController pushViewController:my_regSucceed animated:YES];
            
        }else{
            
            [self alertViewTitle:@"验证码获取失败" message:[[_notification object] objectForKey:@"msg"]];

        }
        
    }
    
    
}

#pragma mark - 获取验证码
-(void)button_yanzheng:(UIButton *)but{
    
    if (ISNULLSTR(_textField.text)) {
        
        [self alertViewTitle:@"获取验证码失败" message:@"电话号码不可为空"];
        
    }else if(_textField.text.length < 11){
        
        [self alertViewTitle:@"获取验证码失败" message:@"请输入正确的电话号码"];
        
    }else {
        ResignFirstResponder;
        NSMutableDictionary * dic_yanzhengma = [[NSMutableDictionary alloc]init];
        [dic_yanzhengma setObject:_textField.text forKey:@"userPhone"];
        My_Registered_busine * my_RegBusine = [[My_Registered_busine alloc]init];
        my_RegBusine.delegate = self;
        [my_RegBusine my_YanZhengMa_busine:dic_yanzhengma];
        [self showLoadingInView:self.view];
    }
    
}

#pragma mark - 同意条款
-(void)button:(UIButton *)but{
    
    if (but.selected) {
        
        [but setBackgroundImage:[UIImage imageNamed:@"tongyi_xz.png"] forState:UIControlStateNormal];
        
        but.selected = NO;
        
    }else{
        
        [but setBackgroundImage:[UIImage imageNamed:@"tongyi_fxz.png"] forState:UIControlStateNormal];
        but.selected = YES;
        
    }
    
}
#pragma - 使用条款
-(void)clickRules
{
    ResignFirstResponder;
    Ty_WebViewVC* rulesWeb=[Ty_WebViewVC shareWebView:Ty_WebloadLocal];
    rulesWeb.title=@"使用条款和隐私政策";
    rulesWeb.filePath=[[NSBundle mainBundle]pathForResource:@"policy" ofType:@"htm"];
    [self.naviGationController pushViewController:rulesWeb animated:YES];
}

#pragma mark - 注册成功
-(void)button_next_click{
    if (button.selected == NO) {
        if (ISNULLSTR(_textField.text)) {
            
            [self alertViewTitle:@"注册失败" message:@"电话号码不可为空"];
            
        }else if(_textField.text.length < 11){
            
            [self alertViewTitle:@"注册失败" message:@"请输入正确的电话号码"];
    
        }else if(ISNULLSTR(_textFieldyq.text)){
            
            [self alertViewTitle:@"注册失败" message:@"验证码不可为空"];
            
        }else if(ISNULLSTR(regCity)){
        
            [self alertViewTitle:@"注册失败" message:@"请选择城市"];

        }else if([regCity isEqualToString:@"定位失败"]){
            
            [self alertViewTitle:@"注册失败" message:@"请选择城市"];

        } else {
            
            ResignFirstResponder;
            
            NSMutableDictionary * dic_Registered = [[NSMutableDictionary alloc]init];
            [dic_Registered setObject:_textField.text forKey:@"userPhone"];
            [dic_Registered setObject:_textFieldyq.text forKey:@"relCode"];
            [dic_Registered setObject:_textPwd.text forKey:@"userPassword"];
            [dic_Registered setObject:_textField.text forKey:@"userName"];
            [dic_Registered setObject:[[Guid share] getGuid] forKey:@"userGuid"];
            [dic_Registered setObject:self.userType forKey:@"userType"];
            [dic_Registered setObject:regCity forKey:@"userRegisterCity"];
            
            My_Registered_busine * my_RegBusine = [[My_Registered_busine alloc]init];
            my_RegBusine.delegate = self;
            [my_RegBusine my_Registered_busine:dic_Registered];
            [self showLoadingInView:self.view];
            
        }
        

        
    }else{
        
        [self alertViewTitle:@"注册失败" message:@"请同意服务条款"];
    }
    
}
#pragma mark - 点击空白
-(void)clickview:(UITapGestureRecognizer *)tap {
   
    ResignFirstResponder;
}
#pragma mark - uitextfied delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == _textField) {
        if (range.location >= 11) {
            return NO;
        }
        return YES;
    }else if(textField == _textFieldyq){
        
        if (range.location >= 6) {
            return NO;
        }
        return YES;
    }else{
        
        if(range.location >= 16){
            return NO;
        }
        return YES;
        
    }
}

- (void)keyboardWillShow:(NSNotification *)notification{
    
}

/**键盘落下处理方法*/
- (void)keyboardWillHide:(NSNotification *)notification{
    
}


#pragma mark - 字符串宽度
- (float) widthForString:(NSString *)value fontSize:(float)fontSize andHeight:(float)height
{
    CGSize sizeToFit = [value sizeWithFont:[UIFont boldSystemFontOfSize:fontSize] constrainedToSize:CGSizeMake(CGFLOAT_MAX, height) lineBreakMode:UILineBreakModeWordWrap];//此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
    return sizeToFit.width;
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
