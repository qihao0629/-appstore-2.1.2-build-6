//
//  Ty_OrderView_Evaluate_MasterView.m
//  腾云家务
//
//  Created by lgs on 14-6-23.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_OrderView_Evaluate_MasterView.h"
#define GrayColor [UIColor colorWithRed:218.0/255.0 green:218.0/255.0 blue:218.0/255.0 alpha:1]

@implementation Ty_OrderView_Evaluate_MasterView
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
-(void)loadMasterEvaluateView
{
    masterEvaluateView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, MainFrame.size.width , 295)];
    [masterEvaluateView setBackgroundColor:view_BackGroudColor];
    
    UIView * tempHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320 , 24)];
    //    [tempHeaderView setBackgroundColor:[UIColor colorWithRed:199/255.0 green:199/255.0 blue:199/255.0 alpha:1]];
    UIImageView * tempImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"titleBar1"]];
    [tempImageView setFrame:CGRectMake(0, 0, 320 , 24)];
    
    [tempHeaderView addSubview:tempImageView];
    whoseEvaluateLabel = [[UILabel alloc]initWithFrame:CGRectMake(6, 5, 110, 15)];
    whoseEvaluateLabel.text= @"对方的评价";
    whoseEvaluateLabel.textAlignment = UITextAlignmentLeft;
    [whoseEvaluateLabel setBackgroundColor:[UIColor clearColor]];
    whoseEvaluateLabel.textColor = [UIColor blackColor];
    [whoseEvaluateLabel setFont:FONT14_BOLDSYSTEM];
    whoseEvaluateLabel.textColor = [UIColor whiteColor];
    [tempHeaderView addSubview:whoseEvaluateLabel];
    [masterEvaluateView addSubview:tempHeaderView];
    
    UILabel * otherTotalLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10 + 24, 60, 12)];
    [otherTotalLabel setBackgroundColor:[UIColor clearColor]];
    otherTotalLabel.text = @"总体评价";
    otherTotalLabel.textAlignment = UITextAlignmentLeft;
    [otherTotalLabel setFont:FONT12_BOLDSYSTEM];
    otherTotalLabel.textColor = [UIColor grayColor];
    
    masterTotalEvaluateView = [[UIView alloc]initWithFrame:CGRectMake(261  , 24, 50, 33)];
    masterTotalEvaluateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, 27, 12)];
    [masterTotalEvaluateLabel setBackgroundColor:[UIColor clearColor]];
    masterTotalEvaluateLabel.textAlignment = UITextAlignmentLeft;
    [masterTotalEvaluateLabel setFont:FONT12_BOLDSYSTEM];
    masterTotalEvaluateLabel.textColor = [UIColor grayColor];
    masterTotalEvaluateImageView = [[UIImageView alloc]initWithFrame:CGRectMake(34, 7, 17, 17)];
    
    [masterTotalEvaluateView addSubview:masterTotalEvaluateLabel];
    [masterTotalEvaluateView addSubview:masterTotalEvaluateImageView];
    
    switch ([[evaluateInformationDic objectForKey:@"evaluateForEmployer"]intValue])
    {
        case 0:
            masterTotalEvaluateLabel.text = @"好评";
            [masterTotalEvaluateImageView setImage:[UIImage imageNamed:@"goodEvaluate"]];
            break;
        case 1:
            masterTotalEvaluateLabel.text = @"中评";
            [masterTotalEvaluateImageView setImage:[UIImage imageNamed:@"middleEvaluate"]];
            break;
        case 2:
            [masterTotalEvaluateImageView setImage:[UIImage imageNamed:@"badEvaluate"]];
            masterTotalEvaluateLabel.text = @"差评";
            break;
        default:
            masterTotalEvaluateLabel.text = @"好评";
            [masterTotalEvaluateImageView setImage:[UIImage imageNamed:@"goodEvaluate"]];
            break;
    }
    
    UIView * tempGrayColorView = [[UIView alloc]initWithFrame:CGRectMake(0, 28 + 24, MainFrame.size.width, 1)];
    [tempGrayColorView setBackgroundColor:GrayColor];
    
    UILabel * oppositeAddToLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 33 + 24, 60, 12)];
    [oppositeAddToLabel setBackgroundColor:[UIColor clearColor]];
    oppositeAddToLabel.text = @"追加评论";
    oppositeAddToLabel.textAlignment = UITextAlignmentLeft;
    [oppositeAddToLabel setFont:FONT12_BOLDSYSTEM];
    oppositeAddToLabel.textColor = [UIColor grayColor];
    
    masterAddToView = [[UIView alloc]init];
    [masterAddToView setBackgroundColor:[UIColor whiteColor]];
    //    [masterAddToView setBackgroundColor:CellBackColor];
    
    masterOppositeLabel = [[UILabel alloc]init];
    [masterOppositeLabel setBackgroundColor:[UIColor clearColor]];
    masterOppositeLabel.textAlignment = UITextAlignmentLeft;
    masterOppositeLabel.numberOfLines = 4;
    [masterOppositeLabel setFont:FONT12_SYSTEM];
    masterOppositeLabel.textColor = [UIColor blackColor];
    
    if ([[evaluateInformationDic objectForKey:@"evaluateForEmployerOther"] isEqualToString:@""]||[[evaluateInformationDic objectForKey:@"evaluateForEmployerOther"] isEqualToString:@"null"])
    {
        [masterAddToView setFrame:CGRectMake(10, 55 + 24, 300 , 22+12)];
        [masterOppositeLabel setFrame:CGRectMake(2, 5, 296 , 12)];
        if (identity == 1)
        {//0雇主，1雇工
            masterOppositeLabel.text = @"我未评价对方此项";
        }
        else
            masterOppositeLabel.text = @"对方未做此项评价";
        masterOppositeLabel.textColor = [UIColor grayColor];
    }
    else
    {
        CGSize size = [[evaluateInformationDic objectForKey:@"evaluateForEmployerOther"] sizeWithFont:FONT12_SYSTEM constrainedToSize:CGSizeMake(296 , 100) lineBreakMode:NSLineBreakByCharWrapping];
        
        [masterAddToView setFrame:CGRectMake(10,55+24, 300 , 10+size.height + 24)];
        
        masterOppositeLabel.text = [evaluateInformationDic objectForKey:@"evaluateForEmployerOther"];
        [masterOppositeLabel setFrame:CGRectMake(2, 5, 296 , size.height)];
    }
    [masterAddToView addSubview:masterOppositeLabel];
    
    [masterEvaluateView addSubview:otherTotalLabel];//总体评价
    [masterEvaluateView addSubview:masterTotalEvaluateView];//好中差
    [masterEvaluateView  addSubview:tempGrayColorView];//一像素的grayColor
    [masterEvaluateView addSubview:oppositeAddToLabel];//其他评论
    [masterEvaluateView addSubview:masterAddToView];//具体评论
    
    [masterEvaluateView setFrame:CGRectMake(0, 0, MainFrame.size.width, 80 + masterAddToView.frame.size.height + 10)];
    [self setFrame:CGRectMake(0, 0, MainFrame.size.width , 80 + masterAddToView.frame.size.height + 10)];
    [self addSubview:masterEvaluateView];
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
