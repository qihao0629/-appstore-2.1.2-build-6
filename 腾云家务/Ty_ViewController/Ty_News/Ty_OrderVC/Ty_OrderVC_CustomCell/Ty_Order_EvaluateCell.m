//
//  Ty_Order_EvaluateCell.m
//  腾云家务
//
//  Created by lgs on 14-6-23.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_Order_EvaluateCell.h"

@implementation Ty_Order_EvaluateCell
@synthesize evaluateInformationDic;
@synthesize evaluateStage;
@synthesize userType;//0雇主，1雇工
@synthesize evaluateMasterView;
@synthesize evaluateWorkerView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        evaluateInformationDic = [[NSDictionary alloc]init];
        evaluateStage = 0;
        userType = @"0";
        evaluateMasterView = [[Ty_OrderView_Evaluate_MasterView alloc]init];
        evaluateWorkerView =  [[Ty_OrderView_Evaluate_WorkerView alloc]init];
    }
    return self;
}
-(void)loadValue
{
    if (evaluateStage == 1)
    {//雇主已评
        if ([userType intValue] == 0)
        {//我是雇主
            NSLog(@"显示我评价信息");
            evaluateWorkerView.identity = 0;
            evaluateWorkerView.evaluateInformationDic = evaluateInformationDic;
            [evaluateWorkerView loadWorkerEvaluateView];
            evaluateWorkerView.whoseEvaluateLabel.text = @"我的评价";
            [self addSubview:evaluateWorkerView];
            
            [self setFrame:evaluateWorkerView.frame];
        }
    }
    else if (evaluateStage  == 2)
    {//雇工已评
        if ([userType intValue] == 1)
        {
            NSLog(@"显示我评价信息");
            evaluateMasterView.identity = 1;
            evaluateMasterView.evaluateInformationDic = evaluateInformationDic;
            [evaluateMasterView loadMasterEvaluateView];
            evaluateMasterView.whoseEvaluateLabel.text = @"我的评价";
            
            [self addSubview:evaluateMasterView];
            
            [self setFrame:evaluateMasterView.frame];
        }
    }
    else if (evaluateStage == 3)
    {
        [self addSubview:[self loadTableFootViewBothEvaluate]];
        [self setFrame:bothEvaluateView.frame];
    }
}
-(UIView *)loadTableFootViewBothEvaluate
{
    bothEvaluateView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainFrame.size.width, 295)];
    
    
    if ([userType intValue] == 0)
    {//我当前身份是雇主
        //先显示对方的评价
        evaluateMasterView.identity = [userType intValue];
        evaluateMasterView.evaluateInformationDic = evaluateInformationDic;
        [evaluateMasterView loadMasterEvaluateView];
        evaluateMasterView.whoseEvaluateLabel.text = @"对方的评价";
        [bothEvaluateView addSubview:evaluateMasterView];
        
        [bothEvaluateView addSubview:[self loadEvaluateWorker]];
        
        [bothEvaluateView setFrame:CGRectMake(0, 0, MainFrame.size.width, evaluateMasterView.frame.size.height+evaluateWorkerView.frame.size.height)];
        return bothEvaluateView;
    }
    else
    {
        //我的评价
        evaluateMasterView.identity = [userType intValue];
        evaluateMasterView.evaluateInformationDic = evaluateInformationDic;
        [evaluateMasterView loadMasterEvaluateView];
        evaluateMasterView.whoseEvaluateLabel.text = @"我的评价";
        [bothEvaluateView addSubview:evaluateMasterView];
        
        [bothEvaluateView setFrame:CGRectMake(0, 0, MainFrame.size.width, evaluateMasterView.frame.size.height)];
        return bothEvaluateView;
    }
}
-(UIView *)loadEvaluateWorker
{
    //我的评价
    evaluateView = [[UIView alloc]initWithFrame:CGRectMake(0, bothEvaluateView.frame.origin.y + evaluateMasterView.frame.size.height, MainFrame.size.width, 295)];
    [evaluateView setBackgroundColor:view_BackGroudColor];
    evaluateWorkerView.identity = [userType intValue];
    evaluateWorkerView.evaluateInformationDic = evaluateInformationDic;
    [evaluateWorkerView loadWorkerEvaluateView];
    evaluateWorkerView.whoseEvaluateLabel.text = @"我的评价";
    [evaluateView addSubview:evaluateWorkerView];
    
    [evaluateView setFrame:CGRectMake(0, bothEvaluateView.frame.origin.y + evaluateMasterView.frame.size.height, MainFrame.size.width, evaluateWorkerView.frame.size.height)];
    return evaluateView;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
