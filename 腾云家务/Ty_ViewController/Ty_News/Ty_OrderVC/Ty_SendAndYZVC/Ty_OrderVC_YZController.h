//
//  Ty_OrderVC_YZController.h
//  腾云家务
//
//  Created by lgs on 14-7-5.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "TYBaseView.h"
#import "Ty_News_Busine_Network.h"

@interface Ty_OrderVC_YZController : TYBaseView<UITextFieldDelegate,
UITextViewDelegate>
{
    UIView * clickTempView;
    UIButton * sureButton;
    UILabel * sureButtonLabel;
    
    UITextField * quoteTextField;//报价
    UITextField * introduceTextField;//说明
    UILabel * workNameLabel;
    UILabel * showMoneyLabel;
    
    UILabel * promptLabel;//提示
    UILabel * promptValue;//价格

    BOOL isKeyBoardExit;
    int quoteOrReason;//最上面的控件为0
    UIButton * AciontButton;
    
    Ty_News_Busine_Network * yzBusine;
    NSString * YZTipString;
    UILabel * YZTipLabel;
    int min;//最低报价
    int max;//最高报价
}
@property(nonatomic,retain)NSString * requirementGuidStr;
@property(nonatomic,strong)NSString * workName;//工种名字，获取工种的单位
@property(nonatomic,strong)Ty_Model_XuQiuInfo * YZxuQiu;//应征的xuQiu

@end
