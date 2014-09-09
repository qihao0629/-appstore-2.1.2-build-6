//
//  Ty_OrderView_Evaluate_WorkerView.m
//  腾云家务
//
//  Created by lgs on 14-6-23.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_OrderView_Evaluate_WorkerView.h"

@implementation Ty_OrderView_Evaluate_WorkerView
@synthesize evaluateInformationDic;
@synthesize whoseEvaluateLabel;
@synthesize identity;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)loadWorkerEvaluateView
{
    workerEvaluateView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainFrame.size.width, 295)];
    [workerEvaluateView setBackgroundColor:view_BackGroudColor];
    
    UIView * tempHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 24)];
    //    [tempHeaderView setBackgroundColor:[UIColor colorWithRed:199/255.0 green:199/255.0 blue:199/255.0 alpha:1]];
    UIImageView * tempImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"titleBar1"]];
    [tempImageView setFrame:CGRectMake(0, 0, 320, 24)];
    
    [tempHeaderView addSubview:tempImageView];
    whoseEvaluateLabel = [[UILabel alloc]initWithFrame:CGRectMake(6, 5, 110, 15)];
    whoseEvaluateLabel.text= @"我的评价";
    whoseEvaluateLabel.textAlignment =NSTextAlignmentLeft;
    [whoseEvaluateLabel setBackgroundColor:[UIColor clearColor]];
    whoseEvaluateLabel.textColor = [UIColor blackColor];
    [whoseEvaluateLabel setFont:FONT14_BOLDSYSTEM];
    whoseEvaluateLabel.textColor = [UIColor whiteColor];
    [tempHeaderView addSubview:whoseEvaluateLabel];
    [workerEvaluateView addSubview:tempHeaderView];
    
    
    UILabel * totalLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10 + 24, 60, 12)];
    [totalLabel setBackgroundColor:[UIColor clearColor]];
    totalLabel.text = @"总体评价";
    totalLabel.textAlignment = NSTextAlignmentLeft;
    [totalLabel setFont:FONT12_BOLDSYSTEM];
    totalLabel.textColor = [UIColor grayColor];
    
    workerTotalEvaluateView = [[UIView alloc]initWithFrame:CGRectMake(261, 24, 50, 33)];
    wokerTotalEvaluateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, 27, 12)];
    [wokerTotalEvaluateLabel setBackgroundColor:[UIColor clearColor]];
    wokerTotalEvaluateLabel.textAlignment = NSTextAlignmentLeft;
    [wokerTotalEvaluateLabel setFont:FONT12_BOLDSYSTEM];
    wokerTotalEvaluateLabel.textColor = [UIColor grayColor];
    workerTotalEvaluateImageView = [[UIImageView alloc]initWithFrame:CGRectMake(34, 7, 17, 17)];
    
    switch ([[evaluateInformationDic objectForKey:@"evaluateForEmployee"]intValue])
    {
        case 0:
            wokerTotalEvaluateLabel.text = @"好评";
            [workerTotalEvaluateImageView setImage:[UIImage imageNamed:@"goodEvaluate"]];
            break;
        case 1:
            wokerTotalEvaluateLabel.text = @"中评";
            [workerTotalEvaluateImageView setImage:[UIImage imageNamed:@"middleEvaluate"]];
            break;
        case 2:
            [workerTotalEvaluateImageView setImage:[UIImage imageNamed:@"badEvaluate"]];
            wokerTotalEvaluateLabel.text = @"差评";
            break;
        default:
            wokerTotalEvaluateLabel.text = @"好评";
            [workerTotalEvaluateImageView setImage:[UIImage imageNamed:@"goodEvaluate"]];
            break;
    }
    [workerTotalEvaluateView addSubview:wokerTotalEvaluateLabel];
    [workerTotalEvaluateView addSubview:workerTotalEvaluateImageView];
    
    
    workerCertainEvaluateView = [[UIView alloc]initWithFrame:CGRectMake(10, 33 + 24, 300, 113)];
    [workerCertainEvaluateView setBackgroundColor:[UIColor whiteColor]];
    //    [workerCertainEvaluateView setBackgroundColor:CellBackColor];
    
    qualityStar = [[CustomStar alloc]initWithFrame:CGRectMake(21, 10 , 175, 23) Number:5];
    qualityStar.userInteractionEnabled = NO;
    [qualityStar setEvaluateStarNumber:[[evaluateInformationDic objectForKey:@"evaluateServeQuality"] intValue]];
    UILabel * tempQualityLabel = [[UILabel alloc]initWithFrame:CGRectMake(254, 16, 25, 12)];
    [tempQualityLabel setBackgroundColor:[UIColor clearColor]];
    tempQualityLabel.text = @"质量";
    tempQualityLabel.textAlignment = NSTextAlignmentLeft;
    [tempQualityLabel setFont:FONT12_SYSTEM];
    tempQualityLabel.textColor = [UIColor blackColor];
    
    mannerStar = [[CustomStar alloc]initWithFrame:CGRectMake(21, 45, 175, 23) Number:5];
    mannerStar.userInteractionEnabled = NO;
    [mannerStar  setEvaluateStarNumber:[[evaluateInformationDic objectForKey:@"evaluateServeAttitude"] intValue]];
    UILabel * tempMannerLabel = [[UILabel alloc]initWithFrame:CGRectMake(254, 51, 25, 12)];
    [tempMannerLabel setBackgroundColor:[UIColor clearColor]];
    tempMannerLabel.text = @"态度";
    tempMannerLabel.textAlignment = NSTextAlignmentLeft;
    [tempMannerLabel setFont:FONT12_SYSTEM];
    tempMannerLabel.textColor = [UIColor blackColor];
    
    speedStar = [[CustomStar alloc]initWithFrame:CGRectMake(21, 79, 175, 23) Number:5];
    speedStar.userInteractionEnabled = NO;
    [speedStar setEvaluateStarNumber:[[evaluateInformationDic objectForKey:@"evaluateServeSpeed"] intValue]];
    UILabel * tempSpeenLabel= [[UILabel alloc]initWithFrame:CGRectMake(254, 85, 25, 12)];
    [tempSpeenLabel setBackgroundColor:[UIColor clearColor]];
    tempSpeenLabel.text = @"速度";
    tempSpeenLabel.textAlignment = NSTextAlignmentLeft;
    [tempSpeenLabel setFont:FONT12_SYSTEM];
    tempSpeenLabel.textColor = [UIColor blackColor];
    
    [workerCertainEvaluateView addSubview:qualityStar];
    [workerCertainEvaluateView addSubview:tempQualityLabel];
    [workerCertainEvaluateView addSubview:mannerStar];
    [workerCertainEvaluateView addSubview:tempMannerLabel];
    [workerCertainEvaluateView addSubview:speedStar];
    [workerCertainEvaluateView addSubview:tempSpeenLabel];
    
    UILabel * addToEvaluateLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 163 + 24, 60, 12)];
    [addToEvaluateLabel setBackgroundColor:[UIColor clearColor]];
    addToEvaluateLabel.text = @"追加评论";
    addToEvaluateLabel.textAlignment = NSTextAlignmentLeft;
    [addToEvaluateLabel setFont:FONT12_SYSTEM];
    addToEvaluateLabel.textColor = [UIColor grayColor];
    
    workerAddToEvaluateView = [[UIView alloc]init];
    [workerAddToEvaluateView setBackgroundColor:[UIColor whiteColor]];
    //    [workerAddToEvaluateView setBackgroundColor:CellBackColor];
    
    workerEvaluateAddLabel = [[UILabel alloc]init];
    [workerEvaluateAddLabel setBackgroundColor:[UIColor clearColor]];
    workerEvaluateAddLabel.textAlignment = NSTextAlignmentLeft;
    workerEvaluateAddLabel.numberOfLines = 4;
    [workerEvaluateAddLabel setFont:FONT12_SYSTEM];
    workerEvaluateAddLabel.textColor = [UIColor blackColor];
    
    if ([[evaluateInformationDic objectForKey:@"evaluateForEmployeeOther"] isEqualToString:@""]||[[evaluateInformationDic objectForKey:@"evaluateForEmployeeOther"] isEqualToString:@"null"])
    {
        [workerAddToEvaluateView setFrame:CGRectMake(10, 185 + 24, 300, 22 + 12)];
        [workerEvaluateAddLabel setFrame:CGRectMake(2, 5, 296 , 12)];
        if (identity == 0)
        {//主，1工
            workerEvaluateAddLabel.text = @"我未评价对方此项";
        }
        else
            workerEvaluateAddLabel.text = @"对方未做此项评价";
        workerEvaluateAddLabel.textColor = [UIColor grayColor];
    }
    else
    {
        CGSize size = [[evaluateInformationDic objectForKey:@"evaluateForEmployeeOther"] sizeWithFont:FONT12_SYSTEM constrainedToSize:CGSizeMake(296, 100) lineBreakMode:NSLineBreakByCharWrapping];
        
        
        [workerAddToEvaluateView setFrame:CGRectMake(10, 185 +24, 300, 10+size.height+24)];
        
        [workerEvaluateAddLabel setFrame:CGRectMake(2, 5, 296, size.height)];
        workerEvaluateAddLabel.text = [evaluateInformationDic objectForKey:@"evaluateForEmployeeOther"];
    }
    [workerAddToEvaluateView addSubview:workerEvaluateAddLabel];
    [workerEvaluateView setFrame:CGRectMake(0, 0, MainFrame.size.width, 210 + workerAddToEvaluateView.frame.size.height + 10)];
    
    [workerEvaluateView addSubview:totalLabel];
    [workerEvaluateView addSubview:workerTotalEvaluateView];
    [workerEvaluateView addSubview:workerCertainEvaluateView];
    [workerEvaluateView addSubview:addToEvaluateLabel];
    [workerEvaluateView addSubview:workerAddToEvaluateView];
    
    [self setFrame:CGRectMake(0, 0, MainFrame.size.width, 210 + workerAddToEvaluateView.frame.size.height + 10)];
    [self addSubview:workerEvaluateView];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
