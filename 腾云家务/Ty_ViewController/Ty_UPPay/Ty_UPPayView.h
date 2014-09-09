//
//  Ty_UPPayView.h
//  腾云家务
//
//  Created by liu on 14-7-1.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ty_Model_XuQiuInfo.h"



@interface Ty_UPPayView : UIView
{
    UIImageView *_lineImageView;
    
    UIView *_tmpView;
    
    UIImageView *_headerImageView;
    UIImageView *_footerImageView;
    UILabel *_payTitleLabel;
    
    UILabel *_remindLabel0;
    UILabel *_remindLabel1;
    UILabel *_remindLabel2;
}

/**中介名称*/
@property (nonatomic,strong) UILabel *serviceNameLabel;

/**中介头像*/
@property (nonatomic,strong) UIImageView *serviceImageView;

/**中介电话*/
@property (nonatomic,strong) UILabel *servicePhoneLabel;

@property (nonatomic,strong) UITextField *payMoneyTextField;

@property (nonatomic,strong) UILabel *totalMoneyLabel;

@property (nonatomic,strong) UIButton *payBtn;

@property (nonatomic,strong) UIButton *payDirectBtn;

@property (nonatomic,strong) UIButton *phoneBtn;

@property (nonatomic,strong) UIButton *phoneTitleBtn;

@property (nonatomic,strong) UIButton *phoneNumBtn;

@property (nonatomic,strong) UILabel *totalLabel;

@property (nonatomic,strong) UILabel *moneyTypeLabel;



- (void)setContent:(Ty_Model_XuQiuInfo *)xuqiuInfo;


@end
