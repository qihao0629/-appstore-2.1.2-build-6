//
//  Ty_OrderVC_Evaluate_Master_Controller.h
//  腾云家务
//
//  Created by lgs on 14-7-4.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "TYBaseView.h"
#import "CustomStar.h"
#import "Ty_Model_ServiceObject.h"
#import "Ty_News_Busine_Network.h"

@interface Ty_OrderVC_Evaluate_Master_Controller : TYBaseView<UITextViewDelegate,
UIActionSheetDelegate>
{
    UIImageView * headerPortraitImageView;//头像
    UILabel * masterNameLabel;//雇主的名字
    CustomStar * masterStar;//雇主的星级
    
    UITextView * addToEvaluateTextView;
    UIButton * totalEvaluateButton;
    UIButton * evaluateButton;//底部的评价按钮
    
    UILabel * addToEvaluateLabel;
    BOOL isKeyBoardExit;
    
    BOOL isTotalEvaluate;
    UIView * totalEvaluateView;
    UIImageView * totalEvaluateImageView;
    UIButton * goodEvaluate;
    UIButton * middleEvaluate;
    UIButton * badEvaluate;
    int totalEvaluateNumber;
    
    NSMutableArray * evaluateArray;
}
@property(nonatomic,retain)UITableView * tableview;
@property(nonatomic,strong)Ty_Model_ServiceObject * masterObject;
@property(nonatomic,retain)NSString * requirementGuidStr;
@property (nonatomic,strong) Ty_News_Busine_Network * evaluate_Master_Network_Busine;

@end
