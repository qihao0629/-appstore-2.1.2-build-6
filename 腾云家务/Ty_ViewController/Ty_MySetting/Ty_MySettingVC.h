//
//  Ty_MySettingVC.h
//  腾云家务
//
//  Created by 齐 浩 on 14-5-22.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "My_SettingUpadteModel.h"
@class My_LoginYesView;
@class My_LoginNoView;

@interface Ty_MySettingVC : TYBaseView
{
    My_LoginYesView * myLoginYes;
    
    My_LoginNoView * myLoginNo;
    
    My_SettingUpadteModel * my_setModel;
}

- (void)loginWhenNotLogin;

@end
