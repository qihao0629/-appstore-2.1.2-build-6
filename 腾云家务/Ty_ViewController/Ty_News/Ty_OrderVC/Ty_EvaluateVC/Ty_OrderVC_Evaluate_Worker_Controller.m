//
//  Ty_OrderVC_Evaluate_Worker_Controller.m
//  腾云家务
//
//  Created by lgs on 14-7-4.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_OrderVC_Evaluate_Worker_Controller.h"
#define CellBackColor [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1]
#define OtherRemarksLength 40

@interface Ty_OrderVC_Evaluate_Worker_Controller ()

@end

@implementation Ty_OrderVC_Evaluate_Worker_Controller
@synthesize tableview;
@synthesize evaluate_Worker_NetWork;
@synthesize requirementGuidStr;
@synthesize workerObject;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self addNotificationForName:@"Ty_OrderVC_Evaluate_Worker_Controller"];
    }
    return self;
}
#pragma mark 加载总体评价
-(UIView *)loadTotalView
{
    UIView * totalView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainBounds.size.width, 70)];
    [totalView setBackgroundColor:[UIColor clearColor]];
    
    
    totalLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 60, 12)];
    [totalLabel setBackgroundColor:[UIColor clearColor]];
    totalLabel.text = @"总体评价";
    totalLabel.textAlignment = NSTextAlignmentLeft;
    [totalLabel setFont:FONT12_BOLDSYSTEM];
    totalLabel.textColor = [UIColor grayColor];
    
    [totalView addSubview:totalLabel];
    
    goodTotalButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [goodTotalButton setFrame:CGRectMake(50, 32, 33, 33)];
    goodTotalButton.tag = 1500;
    [goodTotalButton setImage:[UIImage imageNamed:@"tongyi_xz"] forState:UIControlStateNormal];
    [goodTotalButton addTarget:self action:@selector(goodMiddleBadButtonsPressed:) forControlEvents:UIControlEventTouchUpInside];
    goodTotalButton.exclusiveTouch = YES;
    UIImageView * goodImamgeView = [[UIImageView alloc]initWithFrame:CGRectMake(53 + 33, 40, 17, 17)];
    [goodImamgeView setImage:[UIImage imageNamed:@"goodEvaluate"]];

    [totalView addSubview:goodImamgeView];
    [totalView addSubview: goodTotalButton];
    
    
    middleTotalButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [middleTotalButton setFrame:CGRectMake(145, 32, 33, 33)];
    middleTotalButton.tag = 1501;
    [middleTotalButton setImage:[UIImage imageNamed:@"tongyi_fxz"] forState:UIControlStateNormal];
    [middleTotalButton addTarget:self action:@selector(goodMiddleBadButtonsPressed:) forControlEvents:UIControlEventTouchUpInside];
    middleTotalButton.exclusiveTouch = YES;
    
    UIImageView * middleImamgeView = [[UIImageView alloc]initWithFrame:CGRectMake(148 + 33, 40, 17, 17)];
    [middleImamgeView setImage:[UIImage imageNamed:@"middleEvaluate"]];

    [totalView addSubview:middleImamgeView];
    [totalView addSubview: middleTotalButton];
    

    
    badTotalButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [badTotalButton setFrame:CGRectMake(220,32, 33, 33)];
    badTotalButton.tag = 1502;
    [badTotalButton setImage:[UIImage imageNamed:@"tongyi_fxz"] forState:UIControlStateNormal];
    [badTotalButton addTarget:self action:@selector(goodMiddleBadButtonsPressed:) forControlEvents:UIControlEventTouchUpInside];
    badTotalButton.exclusiveTouch = YES;
    UIImageView * badImamgeView = [[UIImageView alloc]initWithFrame:CGRectMake(223 + 33, 40, 17, 17)];
    [badImamgeView setImage:[UIImage imageNamed:@"badEvaluate"]];

    [totalView addSubview:badImamgeView];
    [totalView addSubview: badTotalButton];

    return totalView;
}

#pragma mark 总体评价按钮的点击
-(void)goodMiddleBadButtonsPressed:(UIButton *)sender
{
    switch (sender.tag - 1500)
    {
        case 0:
            if (totalEvaluateNumber != 0)
            {
                UIButton * tempButton = (UIButton *)[self.view viewWithTag:totalEvaluateNumber + 1500];
                [tempButton setImage:[UIImage imageNamed:@"tongyi_fxz" ] forState:UIControlStateNormal];
                totalEvaluateNumber = 0;
                [sender setImage:[UIImage imageNamed:@"tongyi_xz"] forState:UIControlStateNormal];
            }
            break;
        case 1:
            if (totalEvaluateNumber != 1)
            {
                UIButton * tempButton = (UIButton *)[self.view viewWithTag:totalEvaluateNumber + 1500];
                [tempButton setImage:[UIImage imageNamed:@"tongyi_fxz" ] forState:UIControlStateNormal];
                totalEvaluateNumber = 1;
                [sender setImage:[UIImage imageNamed:@"tongyi_xz"] forState:UIControlStateNormal];
            }
            break;
        case 2:
            if (totalEvaluateNumber != 2)
            {
                UIButton * tempButton = (UIButton *)[self.view viewWithTag:totalEvaluateNumber + 1500];
                [tempButton setImage:[UIImage imageNamed:@"tongyi_fxz" ] forState:UIControlStateNormal];
                totalEvaluateNumber = 2;
                [sender setImage:[UIImage imageNamed:@"tongyi_xz"] forState:UIControlStateNormal];
            }
            break;

        default:
            break;
    }
    
}
#pragma mark 加载雇主的相关信息
-(UIView *)loadHeaderView
{
    UIView * headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainFrame.size.width, 94)];
    
    [headView setBackgroundColor:[UIColor clearColor]];
    
    headerPortraitImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 50, 50)];
    headerPortraitImageView.layer.masksToBounds = YES;
    headerPortraitImageView.layer.borderWidth = 2;
    headerPortraitImageView.layer.borderColor = [[UIColor grayColor]CGColor];
    
    if ([workerObject.companyPhoto isEqualToString:@""])
    {
        [headerPortraitImageView setImage:[UIImage imageNamed:@"Contact_image2"]];
    }
    else
    {
        [headerPortraitImageView setImageWithURL:[NSURL URLWithString:workerObject.headPhoto] placeholderImage:[UIImage imageNamed:@"Contact_image2"]];
    }
    [headView addSubview:headerPortraitImageView];
    
    //雇主姓名
    workerNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(68, 16, 250, 13)];
    [workerNameLabel setBackgroundColor:[UIColor clearColor]];
    [workerNameLabel setFont:FONT13_BOLDSYSTEM];
    [workerNameLabel setTextColor:[UIColor blackColor]];
    [workerNameLabel setTextAlignment:NSTextAlignmentLeft];
    workerNameLabel.text = workerObject.respectiveCompanies;
    
    //雇主星级
    workerStar=[[CustomStar alloc]initWithFrame:CGRectMake(68, 45, 73, 13) Number:5];
    [workerStar setCustomStarNumber:[workerObject.evaluate intValue]];
    [workerStar setUserInteractionEnabled:NO];
    
    [headView addSubview:workerNameLabel];
    [headView addSubview:workerStar];
    
    UIView * tempHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 70, 320, 24)];
    //    [tempHeaderView setBackgroundColor:[UIColor colorWithRed:199/255.0 green:199/255.0 blue:199/255.0 alpha:1]];
    UIImageView * tempImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"titleBar1"]];
    [tempImageView setFrame:CGRectMake(0, 0, 320, 24)];
    
    [tempHeaderView addSubview:tempImageView];
    UILabel * tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(6, 5, 110, 15)];
    tempLabel.text= @"评价对方";
    tempLabel.textAlignment = NSTextAlignmentLeft;
    [tempLabel setBackgroundColor:[UIColor clearColor]];
    tempLabel.textColor = [UIColor blackColor];
    [tempLabel setFont:FONT14_BOLDSYSTEM];
    tempLabel.textColor = [UIColor whiteColor];
    [tempHeaderView addSubview:tempLabel];
    
    [headView addSubview:tempHeaderView];
    
    return headView;
}
#pragma mark 加载评价view
-(UIView *)loadEvaluateView
{
    evaluateView = [[UIView alloc]initWithFrame:CGRectMake(0, 70, MainFrame.size.width, 250)];
    [evaluateView setBackgroundColor:CellBackColor];

    
    certainEvaluateView = [[UIView alloc]initWithFrame:CGRectMake(10, 3, 300, 113)];
    [certainEvaluateView setBackgroundColor:[UIColor whiteColor]];
    
    UILabel * tempQualityLabel = [[UILabel alloc]initWithFrame:CGRectMake(21, 16, 25, 12)];
    [tempQualityLabel setBackgroundColor:[UIColor clearColor]];
    tempQualityLabel.text = @"质量";
    tempQualityLabel.textAlignment = NSTextAlignmentLeft;
    [tempQualityLabel setFont:FONT12_BOLDSYSTEM];
    tempQualityLabel.textColor = [UIColor blackColor];
    
    qualityStar = [[CustomStar alloc]initWithFrame:CGRectMake(46 + 50, 10, 175, 23) Number:5];
    qualityStar.tag = 2500;
    qualityStar.delegate = self;
    qualityStar.userInteractionEnabled = YES;
    
    UILabel * tempMannerLabel = [[UILabel alloc]initWithFrame:CGRectMake(21, 51, 25, 12)];
    [tempMannerLabel setBackgroundColor:[UIColor clearColor]];
    tempMannerLabel.text = @"态度";
    tempMannerLabel.textAlignment = NSTextAlignmentLeft;
    [tempMannerLabel setFont:FONT12_BOLDSYSTEM];
    tempMannerLabel.textColor = [UIColor blackColor];
    
    mannerStar = [[CustomStar alloc]initWithFrame:CGRectMake(46 + 50, 45, 175, 23) Number:5];
    mannerStar.tag = 2501;
    mannerStar.delegate = self;
    mannerStar.userInteractionEnabled = YES;

    UILabel * tempSpeenLabel= [[UILabel alloc]initWithFrame:CGRectMake(21, 85, 25, 12)];
    [tempSpeenLabel setBackgroundColor:[UIColor clearColor]];
    tempSpeenLabel.text = @"速度";
    tempSpeenLabel.textAlignment = NSTextAlignmentLeft;
    [tempSpeenLabel setFont:FONT12_BOLDSYSTEM];
    tempSpeenLabel.textColor = [UIColor blackColor];
    
    speedStar = [[CustomStar alloc]initWithFrame:CGRectMake(46 + 50, 79, 175, 23) Number:5];
    speedStar.tag = 2502;
    speedStar.delegate = self;
    speedStar.userInteractionEnabled = YES;
    
    [certainEvaluateView addSubview:qualityStar];
    [certainEvaluateView addSubview:tempQualityLabel];
    [certainEvaluateView addSubview:mannerStar];
    [certainEvaluateView addSubview:tempMannerLabel];
    [certainEvaluateView addSubview:speedStar];
    [certainEvaluateView addSubview:tempSpeenLabel];
    
    addToEvaluateLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 163, 60, 12)];
    [addToEvaluateLabel setBackgroundColor:[UIColor clearColor]];
    addToEvaluateLabel.text = @"追加评论";
    addToEvaluateLabel.textAlignment = NSTextAlignmentLeft;
    [addToEvaluateLabel setFont:FONT12_BOLDSYSTEM];
    addToEvaluateLabel.textColor = [UIColor grayColor];
    
    addToEvaluateTextView = [[UITextView alloc]initWithFrame:CGRectMake(10, 185, 300, 105 - 20)];
    [addToEvaluateTextView setBackgroundColor:[UIColor whiteColor]];
    addToEvaluateTextView.delegate = self;
    
    
    
//    [evaluateView addSubview:totalLabel];
//    [evaluateView addSubview:totalEvaluateButton];
    [evaluateView addSubview:certainEvaluateView];
    [evaluateView addSubview:addToEvaluateLabel];
    [evaluateView addSubview:addToEvaluateTextView];
    
    return evaluateView;
}
#pragma mark 加载底部的按钮
-(void)loadFootViewButton
{
    evaluateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [evaluateButton setFrame:CGRectMake(110, 10, 100, 30)];
    [evaluateButton setBackgroundImage:[UIImage imageNamed:@"i_setupbutclik"] forState:UIControlStateNormal];
    [evaluateButton addTarget:self action:@selector(evaluateWorkerFinished) forControlEvents:UIControlEventTouchUpInside];
    evaluateButton.exclusiveTouch = YES;
    evaluateButton.layer.cornerRadius = 10;
    evaluateButton.layer.masksToBounds = YES;
    
    UILabel * evaluateLabel= [[UILabel alloc]initWithFrame:CGRectMake(0, 8, 100, 15)];
    [evaluateLabel setBackgroundColor:[UIColor clearColor]];
    evaluateLabel.text = @"完成评价";
    evaluateLabel.textAlignment = NSTextAlignmentCenter;
    [evaluateLabel setFont:FONT14_BOLDSYSTEM];
    evaluateLabel.textColor = [UIColor whiteColor];
    [evaluateButton addSubview:evaluateLabel];
    
    [self.imageView_background addSubview:evaluateButton];
}

#pragma mark 总体评价的方法
-(void)totalEvaluateWorker
{
    totalEvaluateButton.userInteractionEnabled = NO;
    isTotalEvaluate = YES;
    
    totalEvaluateView = [[UIView alloc]initWithFrame:CGRectMake(182, 60, 102, 102)];
    
    totalEvaluateImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"totalEvaluate"]];
    [totalEvaluateImageView setFrame:CGRectMake(0, 0, 102, 102)];
    [totalEvaluateView addSubview:totalEvaluateImageView];
    
    goodEvaluate = [UIButton buttonWithType:UIButtonTypeCustom];
    [goodEvaluate setFrame:CGRectMake(0, 0, 94, 34)];
    [goodEvaluate setBackgroundColor:[UIColor clearColor]];
    goodEvaluate.tag = 1500;
    goodEvaluate.exclusiveTouch = YES;
    UIImageView * goodEvaluateImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"goodEvaluate"]];
    [goodEvaluateImageView setFrame:CGRectMake(20, 8, 17, 17)];
    [goodEvaluate addSubview:goodEvaluateImageView];
    UILabel * goodTotalEvaluateLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 11, 25, 11)];
    [goodTotalEvaluateLabel setBackgroundColor:[UIColor clearColor]];
    goodTotalEvaluateLabel.text = @"好评";
    goodTotalEvaluateLabel.textAlignment = NSTextAlignmentCenter;
    [goodTotalEvaluateLabel setFont:FONT11_BOLDSYSTEM];
    goodTotalEvaluateLabel.textColor = [UIColor blackColor];
    [goodEvaluate addSubview:goodTotalEvaluateLabel];
    [goodEvaluate addTarget:self action:@selector(totalEvaluateWorkerButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    middleEvaluate = [UIButton buttonWithType:UIButtonTypeCustom];
    [middleEvaluate setFrame:CGRectMake(0, 34, 94, 34)];
    [middleEvaluate setBackgroundColor:[UIColor clearColor]];
    middleEvaluate.tag = 1501;
    middleEvaluate.exclusiveTouch = YES;
    UIImageView * middleEvaluateImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"middleEvaluate"]];
    [middleEvaluateImageView setFrame:CGRectMake(20, 8, 17, 17)];
    [middleEvaluate addSubview:middleEvaluateImageView];
    UILabel * middleTotalEvaluateLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 11, 25, 11)];
    [middleTotalEvaluateLabel setBackgroundColor:[UIColor clearColor]];
    middleTotalEvaluateLabel.text = @"中评";
    middleTotalEvaluateLabel.textAlignment = NSTextAlignmentCenter;
    [middleTotalEvaluateLabel setFont:FONT11_BOLDSYSTEM];
    middleTotalEvaluateLabel.textColor = [UIColor blackColor];
    [middleEvaluate addSubview:middleTotalEvaluateLabel];
    [middleEvaluate addTarget:self action:@selector(totalEvaluateWorkerButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    badEvaluate = [UIButton buttonWithType:UIButtonTypeCustom];
    [badEvaluate setFrame:CGRectMake(0,68, 94, 34)];
    [badEvaluate setBackgroundColor:[UIColor clearColor]];
    badEvaluate.tag = 1502;
    badEvaluate.exclusiveTouch = YES;
    UIImageView * badEvaluateImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"badEvaluate"]];
    [badEvaluateImageView setFrame:CGRectMake(20, 8, 17, 17)];
    [badEvaluate addSubview:badEvaluateImageView];
    UILabel * badTotalEvaluateLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 11, 25, 11)];
    [badTotalEvaluateLabel setBackgroundColor:[UIColor clearColor]];
    badTotalEvaluateLabel.text = @"差评";
    badTotalEvaluateLabel.textAlignment = NSTextAlignmentCenter;
    [badTotalEvaluateLabel setFont:FONT11_BOLDSYSTEM];
    badTotalEvaluateLabel.textColor = [UIColor blackColor];
    [badEvaluate addSubview:badTotalEvaluateLabel];
    [badEvaluate addTarget:self action:@selector(totalEvaluateWorkerButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [totalEvaluateView addSubview:goodEvaluate];
    [totalEvaluateView addSubview:middleEvaluate];
    [totalEvaluateView addSubview:badEvaluate];
    [self.tableview addSubview:totalEvaluateView];
}

#pragma mark 总体评价 确定某个评价后方法
-(void)totalEvaluateWorkerButtonPressed:(id)sender
{
    isTotalEvaluate = NO;
    totalEvaluateButton.userInteractionEnabled = YES;
    int tag  = ((UIButton*)sender).tag -1500;
    if (tag == 0)
    {//好
        if (totalEvaluateNumber != 0)
        {
            totalEvaluateNumber = 0;
            [totalEvaluateButton setImage:[UIImage imageNamed:@"goodEvaluate"] forState:UIControlStateNormal];
        }
    }
    else if (tag == 1)
    {//中评
        if (totalEvaluateNumber != 1)
        {
            totalEvaluateNumber = 1;
            [totalEvaluateButton setImage:[UIImage imageNamed:@"middleEvaluate"] forState:UIControlStateNormal];
        }
    }
    else
    {
        if (totalEvaluateNumber != 2)
        {
            totalEvaluateNumber = 2;
            [totalEvaluateButton setImage:[UIImage imageNamed:@"badEvaluate"] forState:UIControlStateNormal];
        }
    }
    
    [totalEvaluateView removeFromSuperview];
}

#pragma mark 完成评价按钮点击
-(void)evaluateWorkerFinished
{
    if (qualityStarCount==-1||mannerStarCount == -1||speedStarCount == -1)
    {
        UIAlertView *tempAlertView;
        if (qualityStarCount == -1)
        {
            tempAlertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"亲，您还没有评价服务方的质量" delegate:nil cancelButtonTitle:@"马上评价" otherButtonTitles:nil, nil];
            [tempAlertView show];
        }
        else if (mannerStarCount == -1)
        {
            tempAlertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"亲，您还没有评价服务方的态度" delegate:nil cancelButtonTitle:@"马上评价" otherButtonTitles:nil, nil];
            [tempAlertView show];
        }
        else
        {
            tempAlertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"亲，您还没有评价服务方的速度" delegate:nil cancelButtonTitle:@"马上评价" otherButtonTitles:nil, nil];
            [tempAlertView show];
        }
        return;
    }
    Ty_Model_XuQiuInfo * tempXuqiu = [[Ty_Model_XuQiuInfo alloc]init];
    tempXuqiu.totalPJ_For_Employee = [NSString stringWithFormat:@"%d",totalEvaluateNumber];
    tempXuqiu.servicePJ_For_Employee =[NSString stringWithFormat:@"%d",qualityStarCount];
    tempXuqiu.speedPJ_For_Employee = [NSString stringWithFormat:@"%d",speedStarCount];;
    tempXuqiu.attitudePJ_For_Employee = [NSString stringWithFormat:@"%d",mannerStarCount];
    
    if ([addToEvaluateTextView.text  isEqualToString:@"null"] || [addToEvaluateTextView.text isEqualToString:@"(null)"])
    {
        tempXuqiu.detailPJ_For_Employee = @"";
    }
    else
        tempXuqiu.detailPJ_For_Employee = addToEvaluateTextView.text;
    
    [addToEvaluateTextView resignFirstResponder];
    
    [self showLoadingInView:self.view];
    [evaluate_Worker_NetWork masterEvaluateWorkerWithRequirementGuid:requirementGuidStr andUserGuid:workerObject.companiesGuid andXuQiu:tempXuqiu];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"评价服务商";
    
    evaluate_Worker_NetWork = [[Ty_News_Busine_Network alloc]init];
    evaluate_Worker_NetWork.delegate = self;

    evaluateArray = [[NSMutableArray alloc]init];
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64 - 49) style:UITableViewStylePlain];
    
    tableview.separatorStyle=UITableViewCellSeparatorStyleNone;//分割线
    tableview.tableHeaderView = [self loadTotalView];
    tableview.tableFooterView = [self loadEvaluateView];
    [self addKeyboardNotification];
    
    qualityStarCount = -1;
    mannerStarCount = -1;
    speedStarCount = -1;
    totalEvaluateNumber = 0;

    [self.tableview setBackgroundColor:view_BackGroudColor];
    [self loadFootViewButton];
    
    [self.view addSubview:tableview];
}
#pragma mark 返回的方法
-(void)backClick
{
    [addToEvaluateTextView resignFirstResponder];
    [self.naviGationController popViewControllerAnimated:YES];
}
#pragma mark ActionSheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.naviGationController popToRootViewControllerAnimated:YES];
}
#pragma mark textView delegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    NSString * toBeString = [textView.text stringByReplacingCharactersInRange:range withString:text];//得到输入框的内容
    if ([toBeString length] > OtherRemarksLength)
    {
        textView.text = [toBeString substringToIndex:OtherRemarksLength];
        return NO;
    }
    return YES;
}
#pragma mark - keyboard notification

- (void)addKeyboardNotification
{
    NSNotificationCenter* center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [center addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];    
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    
    
    //    [tableView_ addGestureRecognizer:recognizer];
    //    [tableView_ addGestureRecognizer:panGesture];
    isKeyBoardExit = YES;
    
    
    NSDictionary* userInfo = [notification userInfo];
    CGRect keyboardFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    
    [UIView animateWithDuration:0.2f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        //        tableview.transform = CGAffineTransformMakeTranslation(0, - (-keyboardFrame.size.height + 94+270));
        tableview.transform = CGAffineTransformMakeTranslation(0, -keyboardFrame.size.height);
        [self.imageView_background setFrame:CGRectMake(0, self.tableview.frame.size.height - keyboardFrame.size.height, MainFrame.size.width, 49)];
        
        
    } completion:^(BOOL finished) {
        
        
        
    }];
    [UIView commitAnimations];
    // }
}


- (void)keyboardWillHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.2f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        tableview.transform = CGAffineTransformMakeTranslation(0, 0);
        [self.imageView_background setFrame:CGRectMake(0, self.tableview.frame.size.height, MainFrame.size.width, 49)];
        
    } completion:^(BOOL finished) {
        
    }];
    [UIView commitAnimations];
    
    
    isKeyBoardExit = NO;
    //    [tableView_ removeGestureRecognizer:recognizer];
    //    [tableView_ removeGestureRecognizer:panGesture];
    
}
#pragma mark 星星的代理 delegate
-(void)CustomStarDelegateAction:(int)_selectNumber and:(id)_sender
{
    switch ((((UIButton *)_sender)).superview.tag -2500)
    {
        case 0:
            qualityStarCount = _selectNumber/100;
            break;
        case 1:
            mannerStarCount = _selectNumber/100;
            break;
        case 2:
            speedStarCount = _selectNumber/100;
            break;
        default:
            break;
    }
}
#pragma mark 基类网络的代理
-(void)netRequestReceived:(NSNotification *)_notification
{
    [self hideLoadingView];
    int number = [[[_notification object] objectForKey:@"number"]intValue];
    if (number == 0)
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"评价成功"
                                                                delegate:self
                                                       cancelButtonTitle:@"确定"
                                                  destructiveButtonTitle:nil
                                                       otherButtonTitles:nil];
        actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        [actionSheet showInView:self.view];
    }
    else if(number == 1)
    {
        [self showToastMakeToast:@"评价失败，请稍后再试" duration:1 position:@"center"];
    }
    else
    {
        [self alertViewTitle:@"提示" message:@"网络请求失败,请稍后再试"];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
