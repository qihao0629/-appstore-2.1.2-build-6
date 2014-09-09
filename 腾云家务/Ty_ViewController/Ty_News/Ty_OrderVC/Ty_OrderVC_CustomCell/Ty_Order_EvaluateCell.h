//
//  Ty_Order_EvaluateCell.h
//  腾云家务
//
//  Created by lgs on 14-6-23.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ty_OrderView_Evaluate_WorkerView.h"
#import "Ty_OrderView_Evaluate_MasterView.h"

@interface Ty_Order_EvaluateCell : UITableViewCell
{
    //显示评价
    UIView * evaluateView;
    
    UIView * bothEvaluateView;
    
}
@property(nonatomic,strong)NSDictionary * evaluateInformationDic;
@property(nonatomic,assign)int evaluateStage;
@property (nonatomic,strong) NSString * userType;//0雇主，1雇工
@property(nonatomic,strong)Ty_OrderView_Evaluate_WorkerView * evaluateWorkerView;
@property(nonatomic,strong)Ty_OrderView_Evaluate_MasterView * evaluateMasterView;

-(void)loadValue;

@end
