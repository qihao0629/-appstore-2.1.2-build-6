//
//  PersonageNextViewController.m
//  腾云家务
//
//  Created by 艾飞 on 13-10-30.
//  Copyright (c) 2013年 齐 浩. All rights reserved.
//

#import "PersonageNextViewController.h"
#import "My_Employerinformation_Busine.h"
@interface PersonageNextViewController ()

@end

@implementation PersonageNextViewController
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
    
    self.title = @"修改姓名";
    
    UIView *viewClick = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-49 - 20 - 44 )];
    [self.view addSubview:viewClick];
    UITapGestureRecognizer *clickview = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickview:)];
    [viewClick addGestureRecognizer:clickview];

    
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(10, 35, 300, 44)];
    //    _textField.background = [UIImage imageNamed:@"输入条.png"];
    [_textField setBorderStyle:UITextBorderStyleRoundedRect]; //外框类型
    _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _textField.autocorrectionType = UITextAutocorrectionTypeNo;
    _textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
    //    _textField.keyboardType = UIKeyboardTypeNumberPad;
    _textField.delegate = self;
    _textField.placeholder = @" 请输入姓名";
    _textField.text = self.strName;
    [self.view addSubview:_textField];
    
    UIButton * button_next = [UIButton buttonWithType:UIButtonTypeCustom];
    button_next.frame = CGRectMake(200, 98, 100, 44);
    [button_next setTitle:@"保存" forState:UIControlStateNormal];
    [button_next setBackgroundImage:[UIImage imageNamed:@"next.png"] forState:UIControlStateNormal];
    [button_next addTarget:self action:@selector(button_next_click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button_next];

    [self addNotificationForName:@"MyEmployerInform"];
}

#pragma maik - 完成
-(void)button_next_click{
    
    if (ISNULLSTR(_textField.text)) {
        [self alertViewTitle:@"修改失败" message:@"姓名不可为空"];
        return;
    }
    if (_textField.text.length > 5) {
        [self alertViewTitle:@"修改失败" message:@"请输入正确的姓名"];
        return;
    }
    
    NSMutableDictionary * _dic = [[NSMutableDictionary alloc]init];
    [_dic setObject:_textField.text forKey:@"userRealName"];
    
    My_Employerinformation_Busine * my_infor_busine = [[My_Employerinformation_Busine alloc]init];
    my_infor_busine.delegate = self;
    [my_infor_busine My_Employerinformation_Req:_dic];
    [self showLoadingInView:self.view];
}

#pragma mark - 修改_回调
-(void)netRequestReceived:(NSNotification *)_notification{
    [self hideLoadingView];
    if ([[_notification object] isKindOfClass:[NSString class]] && [[_notification object] isEqualToString:@"fail"]) {
        
        [self alertViewTitle:@"提示" message:@"网络连接暂时不可用，请稍后再试"];
        
    }else {
        if ([[[_notification object] objectForKey:@"code"]intValue] == 200) {
            
            
            [self.naviGationController popViewControllerAnimated:YES];
            
        }else{
            
            [self alertViewTitle:@"提示" message:[[_notification object] objectForKey:@"msg"]];
            
        }
        
    }
    
}

#pragma mark - 点击空白
-(void)clickview:(UITapGestureRecognizer *)tap {
    
    ResignFirstResponder;
    
}

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
