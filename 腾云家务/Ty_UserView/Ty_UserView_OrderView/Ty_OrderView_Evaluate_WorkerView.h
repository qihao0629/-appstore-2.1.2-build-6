//
//  Ty_OrderView_Evaluate_WorkerView.h
//  腾云家务
//
//  Created by lgs on 14-6-23.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomStar.h"

@interface Ty_OrderView_Evaluate_WorkerView : UIView
{
    //显示评价
    UIView * workerEvaluateView;
    UIView * workerCertainEvaluateView;
    UIView * workerAddToEvaluateView;
    UILabel * workerEvaluateAddLabel;
    
    CustomStar * qualityStar;
    CustomStar * mannerStar;
    CustomStar * speedStar;
    UIView * workerTotalEvaluateView;
    UILabel * wokerTotalEvaluateLabel;
    UIImageView * workerTotalEvaluateImageView;
}
@property(nonatomic,strong) NSDictionary * evaluateInformationDic;
@property(nonatomic,strong) UILabel * whoseEvaluateLabel;
@property(nonatomic,assign) int  identity;
-(void)loadWorkerEvaluateView;

@end
