//
//  Ty_UPPayVC.h
//  腾云家务
//
//  Created by liu on 14-6-26.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UPPayPluginDelegate.h"
#import "Ty_UPPayView.h"
#import "Ty_UPPaySuccessView.h"
#import "Ty_Model_XuQiuInfo.h"

@interface Ty_UPPayVC :TYBaseView<UPPayPluginDelegate,UITextFieldDelegate,UIAlertViewDelegate>
{
    BOOL _isChargeBack;
    
    Ty_UPPayView *_payView;
    Ty_UPPaySuccessView *_paySuccessView;
    UITapGestureRecognizer *_tapGestureRecognizer;
    
    UIWebView *_callWebView;
}

//参数
@property (nonatomic,strong) Ty_Model_XuQiuInfo *xuqiuInfo;

@end
