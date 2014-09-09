//
//  Ty_OrderVC_Evaluate_Worker_Controller.h
//  腾云家务
//
//  Created by lgs on 14-7-4.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "TYBaseView.h"
#import "CustomStar.h"
#import "Ty_News_Busine_Network.h"
#import "Ty_Model_ServiceObject.h"

@interface Ty_OrderVC_Evaluate_Worker_Controller : TYBaseView<UITextViewDelegate,
UIActionSheetDelegate,
CustomStarDelegate>
{
    UIImageView * headerPortraitImageView;
    UILabel * workerNameLabel;
    CustomStar * workerStar;
    
    UIButton * evaluateButton;
    
    UIView * evaluateView;
    UIView * certainEvaluateView;
    UITextView * addToEvaluateTextView;
    
    UIButton * totalEvaluateButton;
    
    UIButton * goodTotalButton;
    UIButton * middleTotalButton;
    UIButton * badTotalButton;
    
    CustomStar * qualityStar;
    CustomStar * mannerStar;
    CustomStar * speedStar;
    
    UILabel * totalLabel;
    UILabel * addToEvaluateLabel;
    
    BOOL isKeyBoardExit;
    BOOL isTotalEvaluate;
    UIView * totalEvaluateView;
    UIImageView * totalEvaluateImageView;
    
    UIButton * goodEvaluate;
    UIButton * middleEvaluate;
    UIButton * badEvaluate;
    
    int qualityStarCount;
    int mannerStarCount;
    int speedStarCount;
    
    
    int totalEvaluateNumber;
    
    NSMutableArray * evaluateArray;

}
@property(nonatomic,retain)UITableView * tableview;
@property(nonatomic,retain)NSString * requirementGuidStr;
@property(nonatomic,retain)Ty_News_Busine_Network * evaluate_Worker_NetWork;
@property(nonatomic,retain)Ty_Model_ServiceObject * workerObject;

@end
