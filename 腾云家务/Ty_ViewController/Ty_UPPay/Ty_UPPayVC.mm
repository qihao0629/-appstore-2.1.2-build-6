//
//  Ty_UPPayVC.m
//  腾云家务
//
//  Created by liu on 14-6-26.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_UPPayVC.h"
#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import "UPPayPlugin.h"
#import "Ty_OrderVC_MasterPublish.h"
#import "Ty_OrderVC_MasterOrder.h"




@implementation Ty_UPPayVC

@synthesize xuqiuInfo = _xuqiuInfo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nil bundle:nil])
    {
        _isChargeBack = NO;
    }
    return self;
}



#pragma mark -- pay action
- (void)payAction
{
    if (_payView.payMoneyTextField.text.length > 0)
    {
        if ([_payView.payMoneyTextField.text intValue] == 0)
        {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"请输入大于0金额~" message:@"" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
            alertView = nil;
        }
        else
        {
            //去掉键盘
            [_payView.payMoneyTextField resignFirstResponder];
            
            
            //向服务器发送请求，请求交易流水号
             [[Ty_NetRequestService shareNetWork] formRequest:URL_UPPay andParameterDic:[NSMutableDictionary  dictionaryWithObjectsAndKeys:_xuqiuInfo.requirementGuid,@"requirementGuid",_payView.payMoneyTextField.text,@"requirementPayMoney", nil] andTarget:self andSeletor:@selector(getSerialNumber:data:)];
            
            [self showProgressHUD:@"正在请求，请稍后~"];
        }
        
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"请输入金额~" message:@"" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        alertView = nil;
    }
    
    
    
}

- (void)getSerialNumber:(NSString *)requestStatus data:(NSMutableDictionary *)dic
{
    
    if ([[dic objectForKey:@"code"]intValue] == 200 ) //请求成功，获取到流水号
    {
        _payView.hidden = YES;
        [self hideProgressHUD];
        NSString *tn = [dic objectForKey:@"tn"];
    
     //   NSLog(@"%@",[self.naviGationController.viewControllers objectAtIndex:0]);
        _isChargeBack = YES;
        
        
        [UPPayPlugin startPay:tn mode:UPPayMode viewController:self  delegate:self];
        
    }
    else//么有获取到流水号
    {
       // [self showProgressHUD:[dic objectForKey:@"msg"]];
        [self hideProgressHUD];
        [self showToastMakeToast:[dic objectForKey:@"msg"] duration:2 position:@"center"];
      //  [self performSelector:@selector(hideProgress) withObject:nil afterDelay:1];
    }
}

- (void)hideProgress
{
    [self hideProgressHUD];
}

#pragma mark -- textfield delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark ---- payDelegate
- (void)UPPayPluginResult:(NSString *)result
{
    NSLog(@"%@",result);
    
    if ([result isEqualToString:@"success"])
    {
        self.title = @"支付成功";
        _paySuccessView.messageLabel.text = [NSString stringWithFormat:@"您已成功支付%@元！",_payView.payMoneyTextField.text];
        _paySuccessView.hidden = NO;
        _payView.hidden = YES;
        
    }
    else
    {
        self.title = @"待付款";
        _paySuccessView.hidden = YES;
        _payView.hidden = NO;
        
        if ([result isEqualToString:@"cancel"])
        {
            [self showToastMakeToast:@"您已取消支付~" duration:2 position:@"center"];
        }
        else if ([result isEqualToString:@"fail"])
        {
            [self showToastMakeToast:@"支付失败~" duration:2 position:@"center"];
        }
        else
        {
            [self showToastMakeToast:result duration:2 position:@"center"];
        }
        
        
//        [self showProgressHUD:result];
//        
//        [self performSelector:@selector(hideProgress) withObject:nil afterDelay:2];
    }
    
    
}

#pragma mark -- key board notification
- (void)keyboardWillShow:(NSNotification *)notification
{
    [self.view addGestureRecognizer:_tapGestureRecognizer];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    [self.view removeGestureRecognizer:_tapGestureRecognizer];
}

- (void)tapGestureAction
{
    [_payView.payMoneyTextField resignFirstResponder];
}

- (void)payDirectAction
{
    if (_payView.payMoneyTextField.text.length > 0)
    {
        if ([_payView.payMoneyTextField.text intValue] != 0)
        {
            /*
            [[Ty_NetRequestService shareNetWork] formRequest:URL_UPPayDirect andParameterDic:[NSMutableDictionary dictionaryWithObjectsAndKeys:_xuqiuInfo.requirementGuid,@"requirementGuid",_payView.payMoneyTextField.text,@"requirementDealMoney", nil] andTarget:self andSeletor:@selector(payDirect:data:)];
            
            [self showProgressHUD:@"正在请求，请稍后~"];
             */
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"您已选择线下支付" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alertView show];
            alertView = nil;
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"请输入大于0金额~" message:@"" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
            alertView = nil;
        }
        
        
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"请输入金额~" message:@"" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        alertView = nil;
    }
    
}

#pragma mark -- alertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        //线下支付
        [[Ty_NetRequestService shareNetWork] formRequest:URL_UPPayDirect andParameterDic:[NSMutableDictionary dictionaryWithObjectsAndKeys:_xuqiuInfo.requirementGuid,@"requirementGuid",_payView.payMoneyTextField.text,@"requirementDealMoney", nil] andTarget:self andSeletor:@selector(payDirect:data:)];
        
        [self showProgressHUD:@"正在请求，请稍后~"];
    }
}
- (void)makePhoneCall
{
    
    NSURL *callUrl = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",_xuqiuInfo.serverObject.companyPhoneNumber]];
    [_callWebView loadRequest:[NSURLRequest requestWithURL:callUrl]];
}

- (void)requirementDetailAction
{
    NSLog(@"%@",self.naviGationController.viewControllers);
    if ([[self.naviGationController.viewControllers objectAtIndex:self.naviGationController.viewControllers.count - 1]isKindOfClass:[self class]])
    {
        NSInteger num = self.naviGationController.viewControllers.count - 2;
        if (num > 0)
        {
            NSArray* array = [self.naviGationController.viewControllers subarrayWithRange:NSMakeRange(num, 2)];
            [self removeViewControllersFromWindow:array];
        }
        
        
    }
    
    if ([[_xuqiuInfo requirement_Type] isEqualToString:@"0"] == YES)
    {
        //直接发布
        
        
        Ty_OrderVC_MasterPublish * masterPublishVC = [[Ty_OrderVC_MasterPublish alloc]init];
        masterPublishVC.requirementGuid = _xuqiuInfo.requirementGuid;
        
        [self.naviGationController pushViewController:masterPublishVC animated:YES];
    }
    else
    {
        Ty_OrderVC_MasterOrder * masterOrderVC = [[Ty_OrderVC_MasterOrder alloc]init];
        masterOrderVC.requirementGuid = _xuqiuInfo.requirementGuid;
        
        [self.naviGationController pushViewController:masterOrderVC animated:YES];
    }
}

- (void)payDirect:(NSString *)requestStatus data:(NSMutableDictionary *)dic
{
    
    if ([[dic objectForKey:@"code"]intValue] == 200 ) //请求成功，获取到流水号
    {
        _payView.hidden = YES;
        _paySuccessView.messageLabel.text = [NSString stringWithFormat:@"您已成功支付%@元！",_payView.payMoneyTextField.text];
        [self hideProgressHUD];
        self.title = @"支付成功";
        _paySuccessView.hidden = NO;
        _payView.hidden = YES;
        //[self showToastMakeToast:[dic objectForKey:@"msg"] duration:2 position:@"center"];
        
    }
    else//么有获取到流水号
    {
        self.title = @"待付款";
        _paySuccessView.hidden = YES;
        _payView.hidden = NO;
        // [self showProgressHUD:[dic objectForKey:@"msg"]];
        [self hideProgressHUD];
        [self showToastMakeToast:[dic objectForKey:@"msg"] duration:2 position:@"center"];
        
    }
}

- (void)backClick
{
    if (!_paySuccessView.hidden)
    {
        [self.naviGationController popToRootViewControllerAnimated:YES];
    }
    else
    {
        [super backClick];
    }
}


#pragma mark --- view lifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.title = @"待付款";
    
    //初始化支付的详细页面
    _payView = [[Ty_UPPayView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height - 44 - 44 - 20 )];
    _payView.payMoneyTextField.delegate = self;
    [_payView.payBtn addTarget:self action:@selector(payAction) forControlEvents:UIControlEventTouchUpInside];
    [_payView.payDirectBtn addTarget:self action:@selector(payDirectAction) forControlEvents:UIControlEventTouchUpInside];
    [_payView setContent:_xuqiuInfo];
    [_payView.phoneNumBtn addTarget:self action:@selector(makePhoneCall) forControlEvents:UIControlEventTouchUpInside];
    [_payView.phoneTitleBtn addTarget:self action:@selector(makePhoneCall) forControlEvents:UIControlEventTouchUpInside];
    [_payView.phoneBtn addTarget:self action:@selector(makePhoneCall) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_payView];
    //_payView.hidden = YES;
    
    //初始化支付成功页面
    _paySuccessView = [[Ty_UPPaySuccessView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height - 44 - 44 - 20 )];
    [self.view addSubview:_paySuccessView];
    _paySuccessView.hidden = YES;
   // _paySuccessView.hidden = NO;
    [_paySuccessView.reqDetailBtn addTarget:self action:@selector(requirementDetailAction) forControlEvents:UIControlEventTouchUpInside];
    
    _tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureAction)];

    _callWebView = [[UIWebView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_callWebView];
 
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    if (_isChargeBack )
    {
        self.view.center = CGPointMake(self.view.center.x, self.view.center.y + 64);
        _isChargeBack = NO;
    }
  //  NSLog(@"%@",[[UIDevice currentDevice] systemVersion]);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


@end
