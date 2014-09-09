//
//  Ty_OrderVC_Evaluate_Master_Controller.m
//  腾云家务
//
//  Created by lgs on 14-7-4.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_OrderVC_Evaluate_Master_Controller.h"

#define GrayColor [UIColor colorWithRed:218.0/255.0 green:218.0/255.0 blue:218.0/255.0 alpha:1]
#define OtherRemarksLength 40

@interface Ty_OrderVC_Evaluate_Master_Controller ()

@end

@implementation Ty_OrderVC_Evaluate_Master_Controller
@synthesize tableview;
@synthesize masterObject;
@synthesize requirementGuidStr;
@synthesize evaluate_Master_Network_Busine;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self addNotificationForName:@"Ty_OrderVC_Evaluate_Master_Controller"];
    }
    return self;
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
    
    if ([masterObject.headPhoto isEqualToString:@""])
    {
        [headerPortraitImageView setImage:[UIImage imageNamed:@"Contact_image"]];
    }
    else
    {
        if ([masterObject.sex intValue] == 0)
        {//nan
            [headerPortraitImageView setImageWithURL:[NSURL URLWithString:masterObject.headPhoto] placeholderImage:[UIImage imageNamed:@"Contact_image1"]];
        }
        else
        {//nv
            [headerPortraitImageView setImageWithURL:[NSURL URLWithString:masterObject.headPhoto] placeholderImage:[UIImage imageNamed:@"Contact_image"]];
        }
    }
    [headView addSubview:headerPortraitImageView];

    //雇主姓名
    masterNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(68, 16, 250, 13)];
    [masterNameLabel setBackgroundColor:[UIColor clearColor]];
    [masterNameLabel setFont:FONT13_BOLDSYSTEM];
    [masterNameLabel setTextColor:[UIColor blackColor]];
    [masterNameLabel setTextAlignment:NSTextAlignmentLeft];
    masterNameLabel.text = masterObject.userRealName;
    
    //雇主星级
    masterStar=[[CustomStar alloc]initWithFrame:CGRectMake(68, 45, 73, 13) Number:5];
    [masterStar setCustomStarNumber:[masterObject.evaluate intValue]];
    [masterStar setUserInteractionEnabled:NO];
    
    [headView addSubview:masterNameLabel];
    [headView addSubview:masterStar];
    
    UIView * tempHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 70, 320, 24)];
    //    [tempHeaderView setBackgroundColor:[UIColor colorWithRed:199/255.0 green:199/255.0 blue:199/255.0 alpha:1]];
    UIImageView * tempImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"titleBar1"]];
    [tempImageView setFrame:CGRectMake(0, 0, 320, 24)];
    
    [tempHeaderView addSubview:tempImageView];
    UILabel * tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(6, 5, 110, 15)];
    tempLabel.text= @"评价对方";
    tempLabel.textAlignment = UITextAlignmentLeft;
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
    UIView * evaluateView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainFrame.size.width, 270)];
    [evaluateView setBackgroundColor:view_BackGroudColor];
    
    UILabel * totalLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 60, 12)];
    [totalLabel setBackgroundColor:[UIColor clearColor]];
    totalLabel.text = @"总体评价";
    totalLabel.textAlignment = UITextAlignmentLeft;
    [totalLabel setFont:FONT12_BOLDSYSTEM];
    totalLabel.textColor = [UIColor grayColor];
    
    totalEvaluateButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [totalEvaluateButton setFrame:CGRectMake(270, 0, 50, 33)];
    [totalEvaluateButton setImage:[UIImage imageNamed:@"goodEvaluate"] forState:UIControlStateNormal];
    [totalEvaluateButton addTarget:self action:@selector(totalEvaluate) forControlEvents:UIControlEventTouchUpInside];
    totalEvaluateButton.exclusiveTouch = YES;
    
    UIView * tempGrayColorView = [[UIView alloc]initWithFrame:CGRectMake(0, 29, MainFrame.size.width, 1)];
    [tempGrayColorView setBackgroundColor:GrayColor];
    
    
    addToEvaluateLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 39, 60, 12)];
    [addToEvaluateLabel setBackgroundColor:[UIColor clearColor]];
    addToEvaluateLabel.text = @"追加评论";
    addToEvaluateLabel.textAlignment = UITextAlignmentLeft;
    [addToEvaluateLabel setFont:FONT12_BOLDSYSTEM];
    addToEvaluateLabel.textColor = [UIColor grayColor];
    
    addToEvaluateTextView = [[UITextView alloc]initWithFrame:CGRectMake(10, 61, 300, 105)];
    [addToEvaluateTextView setBackgroundColor:[UIColor whiteColor]];
    addToEvaluateTextView.delegate = self;
    
    
    
    [evaluateView addSubview:totalLabel];
    [evaluateView addSubview:totalEvaluateButton];
    [evaluateView addSubview:tempGrayColorView];
    [evaluateView addSubview:addToEvaluateLabel];
    [evaluateView addSubview:addToEvaluateTextView];
    
    return evaluateView;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"评价雇主";
    
    evaluate_Master_Network_Busine = [[Ty_News_Busine_Network alloc]init];
    evaluate_Master_Network_Busine.delegate = self;

    evaluateArray = [[NSMutableArray alloc]init];
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64 - 49) style:UITableViewStylePlain];

    tableview.separatorStyle=UITableViewCellSeparatorStyleNone;//分割线
    tableview.tableHeaderView = [self loadHeaderView];
    tableview.tableFooterView = [self loadEvaluateView];
    [self addKeyboardNotification];

    totalEvaluateNumber = 0;
    
    [self.tableview setBackgroundColor:view_BackGroudColor];
    [self loadFootViewButton];
    
    [self.view addSubview:tableview];
}

#pragma mark 加载底部的按钮
-(void)loadFootViewButton
{
    evaluateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [evaluateButton setFrame:CGRectMake(110, 10, 100, 30)];
    [evaluateButton setBackgroundImage:[UIImage imageNamed:@"i_setupbutclik"] forState:UIControlStateNormal];
    [evaluateButton addTarget:self action:@selector(finishEvaluateButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    evaluateButton.exclusiveTouch = YES;
    evaluateButton.layer.cornerRadius = 10;
    evaluateButton.layer.masksToBounds = YES;
    
    UILabel * evaluateLabel= [[UILabel alloc]initWithFrame:CGRectMake(0, 8, 100, 15)];
    [evaluateLabel setBackgroundColor:[UIColor clearColor]];
    evaluateLabel.text = @"完成评价";
    evaluateLabel.textAlignment = UITextAlignmentCenter;
    [evaluateLabel setFont:FONT14_BOLDSYSTEM];
    evaluateLabel.textColor = [UIColor whiteColor];
    [evaluateButton addSubview:evaluateLabel];

    [self.imageView_background addSubview:evaluateButton];
}
#pragma mark 总体评价的方法
-(void)totalEvaluate
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
    goodTotalEvaluateLabel.textAlignment = UITextAlignmentCenter;
    [goodTotalEvaluateLabel setFont:FONT11_BOLDSYSTEM];
    goodTotalEvaluateLabel.textColor = [UIColor blackColor];
    [goodEvaluate addSubview:goodTotalEvaluateLabel];
    [goodEvaluate addTarget:self action:@selector(totalEvaluateButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
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
    middleTotalEvaluateLabel.textAlignment = UITextAlignmentCenter;
    [middleTotalEvaluateLabel setFont:FONT11_BOLDSYSTEM];
    middleTotalEvaluateLabel.textColor = [UIColor blackColor];
    [middleEvaluate addSubview:middleTotalEvaluateLabel];
    [middleEvaluate addTarget:self action:@selector(totalEvaluateButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
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
    badTotalEvaluateLabel.textAlignment = UITextAlignmentCenter;
    [badTotalEvaluateLabel setFont:FONT11_BOLDSYSTEM];
    badTotalEvaluateLabel.textColor = [UIColor blackColor];
    [badEvaluate addSubview:badTotalEvaluateLabel];
    [badEvaluate addTarget:self action:@selector(totalEvaluateButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [totalEvaluateView addSubview:goodEvaluate];
    [totalEvaluateView addSubview:middleEvaluate];
    [totalEvaluateView addSubview:badEvaluate];
    [self.tableview addSubview:totalEvaluateView];
}

#pragma mark 总体评价 确定某个评价后方法
-(void)totalEvaluateButtonPressed:(id)sender
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

#pragma mark 完成评价按钮点击触发的方法
-(void)finishEvaluateButtonPressed
{
    evaluateButton.userInteractionEnabled = NO;
    [evaluate_Master_Network_Busine workerEvaluateMasterWithRequirementGuid:requirementGuidStr andtotalEvaluate:totalEvaluateNumber andOtherEvaluate:addToEvaluateTextView.text];
    [self showLoadingInView:self.view];
}

#pragma mark textView delegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
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

#pragma mark 基类中网络回调的
-(void)netRequestReceived:(NSNotification *)_notification
{
    evaluateButton.userInteractionEnabled = YES;
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
    else
    {
        [self showToastMakeToast:@"评价失败，请您稍后重试" duration:1 position:@"center"];
    }
}
#pragma mark ActionSheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.naviGationController popToRootViewControllerAnimated:YES];
}

#pragma mark 返回按钮
-(void)backClick
{
    [addToEvaluateTextView resignFirstResponder];
    [self.naviGationController popViewControllerAnimated:YES];
}
#pragma mark - keyboard notification

- (void)addKeyboardNotification
{
    NSNotificationCenter* center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [center addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    //    [UIApplication sharedApplication].keyWindo
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    isKeyBoardExit = YES;
    
    NSDictionary* userInfo = [notification userInfo];
    CGRect keyboardFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    
    [UIView animateWithDuration:0.2f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        tableview.transform = CGAffineTransformMakeTranslation(0, -(keyboardFrame.size.height -124));
        [self.imageView_background setFrame:CGRectMake(0, self.tableview.frame.size.height-(keyboardFrame.size.height), MainFrame.size.width, 49)];
        
    } completion:^(BOOL finished) {
        
        
        
    }];
    [UIView commitAnimations];
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
