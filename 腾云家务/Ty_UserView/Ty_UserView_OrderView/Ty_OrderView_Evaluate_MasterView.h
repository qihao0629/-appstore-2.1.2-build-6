//
//  Ty_OrderView_Evaluate_MasterView.h
//  腾云家务
//
//  Created by lgs on 14-6-23.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Ty_OrderView_Evaluate_MasterView : UIView
{
    UIView * masterEvaluateView;
    UIView * masterAddToView;
    UILabel * masterOppositeLabel;
        
    UIView * masterTotalEvaluateView;
    UILabel * masterTotalEvaluateLabel;
    UIImageView * masterTotalEvaluateImageView;
    
}
@property(nonatomic,strong) NSDictionary * evaluateInformationDic;
@property(nonatomic,strong) UILabel * whoseEvaluateLabel;
@property(nonatomic,assign) int  identity;//0雇主
-(void)loadMasterEvaluateView;

@end
