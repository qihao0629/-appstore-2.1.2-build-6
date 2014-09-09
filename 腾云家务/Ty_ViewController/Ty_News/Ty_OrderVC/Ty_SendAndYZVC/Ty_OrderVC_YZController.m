//
//  Ty_OrderVC_YZController.m
//  腾云家务
//
//  Created by lgs on 14-7-5.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_OrderVC_YZController.h"
#import "Ty_News_Busine_HandlePlist.h"
#import "Ty_OrderVC_YZFinish_Controller.h"
#import "AppDelegate.h"

#define WordColor [UIColor colorWithRed:166.0/255.0 green:166.0/255.0 blue:166.0/255.0 alpha:1]
#define QUOTEMAXLENGTH 8
#define phoneNumbers @"1234567890\n"


@interface Ty_OrderVC_YZController ()

@end

@implementation Ty_OrderVC_YZController
@synthesize requirementGuidStr;
@synthesize workName;
@synthesize YZxuQiu;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self addNotificationForName:@"Ty_OrderVC_YZController"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"我要应征";
    
    clickTempView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    UITapGestureRecognizer *clickview = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickBlankSpace:)];
    [clickTempView addGestureRecognizer:clickview];
    [clickTempView setBackgroundColor:view_BackGroudColor];
    
    [self.view addSubview:clickTempView];
    
    isKeyBoardExit = NO;
    quoteOrReason = 0;
    min = 0;
    max = 0;
    
    [self addKeyboardNotification];
    
    yzBusine = [[Ty_News_Busine_Network alloc]init];
    yzBusine.delegate = self;
    
    
    [self loadUI];//加载界面
    [self loadSureYZButton];//加载确认应征按钮
    [self loadBackButton];//加载返回按钮
    
    [self showYZTipLabel];
}

#pragma mark 加载UI
-(void)loadUI
{
    workNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, 100, 15)];
    [workNameLabel setBackgroundColor:[UIColor clearColor]];
    workNameLabel.text = workName;
    workNameLabel.textAlignment = NSTextAlignmentLeft;
    [workNameLabel setFont:FONT15_BOLDSYSTEM];
    workNameLabel.textColor = [UIColor redColor];
    
    CGSize workNameSize =  [workNameLabel.text sizeWithFont:FONT15_BOLDSYSTEM constrainedToSize:CGSizeMake(185, 400) lineBreakMode:NSLineBreakByCharWrapping];
    [workNameLabel setFrame:CGRectMake(15, 20, workNameSize.width, 15)];
    
    UILabel * tempLabel1 =[[UILabel alloc]initWithFrame:CGRectMake(workNameLabel.frame.origin.x + workNameLabel.frame.size.width +10, 20, 100, 15)];
    [tempLabel1 setBackgroundColor:[UIColor clearColor]];
    tempLabel1.text = @"我的应征报价:";
    tempLabel1.textAlignment = NSTextAlignmentLeft;
    [tempLabel1 setFont:FONT15_BOLDSYSTEM];
    tempLabel1.textColor = [UIColor grayColor];
    
    UILabel * tempQuoteMoneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(47, 59, 45, 15)];
    [tempQuoteMoneyLabel setBackgroundColor:[UIColor clearColor]];
    tempQuoteMoneyLabel.text = @"报价:";
    [tempQuoteMoneyLabel setFont:FONT15_BOLDSYSTEM];
    tempQuoteMoneyLabel.textAlignment = NSTextAlignmentLeft;
    tempQuoteMoneyLabel.textColor = [UIColor orangeColor];
    
    quoteTextField = [[UITextField alloc]initWithFrame:CGRectMake(90, 53, 147, 30)];
    [quoteTextField setBackgroundColor:[UIColor whiteColor]];
    quoteTextField.delegate = self;
//    quoteTextField.placeholder = @"  请输入您的报价";
    quoteTextField.text = @"";
    quoteTextField.clearButtonMode = UITextFieldViewModeNever;
    [quoteTextField setFont:FONT14_BOLDSYSTEM];
    [quoteTextField setTextAlignment:NSTextAlignmentLeft];
    [quoteTextField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    quoteTextField.textColor =[UIColor grayColor];
    [quoteTextField setKeyboardType:UIKeyboardTypeNumberPad];

    //添加单位
    Ty_News_Busine_HandlePlist * tempBusine = [[Ty_News_Busine_HandlePlist alloc]init];
    NSString * unitString = [NSString stringWithString:[tempBusine findWorkUnitAndWorkName:workName]];
    
    showMoneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(245, 61,60, 15)];
    [showMoneyLabel setBackgroundColor:[UIColor clearColor]];
    showMoneyLabel.text = [NSString stringWithFormat:@"元/%@",unitString];
    [showMoneyLabel setFont:FONT15_BOLDSYSTEM];
    showMoneyLabel.textAlignment = NSTextAlignmentLeft;
    showMoneyLabel.textColor = [UIColor grayColor];
    
    UILabel * tempReasonLabel = [[UILabel alloc]initWithFrame:CGRectMake(47, 161, 45, 15)];
    [tempReasonLabel setBackgroundColor:[UIColor clearColor]];
    tempReasonLabel.text = @"说明:";
    [tempReasonLabel setFont:FONT15_BOLDSYSTEM];
    tempReasonLabel.textAlignment = NSTextAlignmentLeft;
    tempReasonLabel.textColor = [UIColor orangeColor];
    
    
    introduceTextField = [[UITextField alloc]initWithFrame:CGRectMake(90, 155, 200, 30)];
    [introduceTextField setBackgroundColor:[UIColor whiteColor]];
    introduceTextField.delegate = self;
    introduceTextField.clearButtonMode = UITextFieldViewModeNever;
    [introduceTextField setFont:FONT14_BOLDSYSTEM];
    introduceTextField.placeholder = @"  简单说明服务特点";
    introduceTextField.text = @"";
    [introduceTextField setTextAlignment:NSTextAlignmentLeft];
    [introduceTextField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    introduceTextField.textColor =[UIColor grayColor];

    [clickTempView addSubview:workNameLabel];
    [clickTempView addSubview:tempLabel1];
    [clickTempView addSubview:tempQuoteMoneyLabel];
    [clickTempView addSubview:quoteTextField];
    [clickTempView addSubview:showMoneyLabel];
    [clickTempView addSubview:tempReasonLabel];
    [clickTempView addSubview:introduceTextField];
}
#pragma mark 加载确认应征按钮
-(void)loadSureYZButton
{
    sureButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [sureButton setFrame:CGRectMake(90, 212, 141, 44)];
    [sureButton setBackgroundImage:[UIImage imageNamed:@"i_setupbutclik"] forState:UIControlStateNormal];
    [sureButton addTarget:self action:@selector(sureToYZ) forControlEvents:UIControlEventTouchUpInside];
    sureButton.exclusiveTouch = YES;
    sureButton.layer.cornerRadius = 10;
    sureButton.layer.masksToBounds = YES;
    
    sureButtonLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, 141, 14)];
    [sureButtonLabel setBackgroundColor:[UIColor clearColor]];
    sureButtonLabel.text = @"确认应征";
    sureButtonLabel.textAlignment = NSTextAlignmentCenter;
    [sureButtonLabel setFont:FONT14_BOLDSYSTEM];
    sureButtonLabel.textColor = [UIColor whiteColor];
    [sureButton addSubview:sureButtonLabel];
    
    [clickTempView addSubview:sureButton];
}
-(void)sureToYZ
{
    if ([quoteTextField.text isEqualToString:@""])
    {
        [self alertViewTitle:@"提示" message:@"请输入您的报价"];
        return;
    }
    else if ([quoteTextField.text intValue] < min && min !=0)
    {
        [self showToastMakeToast:YZTipString duration:1.0 position:@"center"];
        return;
    }
    else if ([quoteTextField.text intValue] > max && max != 0)
    {
        [self showToastMakeToast:YZTipString duration:1.0 position:@"center"];
        return;
    }
    
    [quoteTextField resignFirstResponder];
    [introduceTextField resignFirstResponder];
    [self showProgressHUD:@"正在应征"];
    [yzBusine workerYZRequirementWithRequirementGuid:requirementGuidStr andRemark:introduceTextField.text andPrice:quoteTextField.text];
}
#pragma mark 加载返回按钮
-(void)loadBackButton
{
    self.naviGationController.userInteractionEnabled = YES;
    [self.naviGationController.leftBarButton setImage:[UIImage imageNamed:@"Message_back"] forState:UIControlStateNormal];
    [self.naviGationController.leftBarButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    self.naviGationController.leftBarButton.showsTouchWhenHighlighted = YES;
}
#pragma mark 返回上个界面
-(void)backClick
{
    [quoteTextField resignFirstResponder];
    [introduceTextField resignFirstResponder];
    [self.naviGationController popViewControllerAnimated:YES];
}
#pragma mark - 点击空白
-(void)clickBlankSpace:(UITapGestureRecognizer *)tap {
    [quoteTextField resignFirstResponder];
    [introduceTextField resignFirstResponder];
}

#pragma mark textField delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{//string就是此时输入的那个字符 textField就是此时正在输入的那个输入框 返回YES就是可以改变输入框的值 NO相反
    NSCharacterSet * cs;
    if ([string isEqualToString:@"\n"])//按会车可以改变
    {
        return NO;
    }
    if (range.location == 0)
    {
        if ([string isEqualToString:@"0"])
        {
            return 0;
        }
    }
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];//得到输入框的内容
    if (quoteTextField == textField)
    {
        if ([toBeString length] > QUOTEMAXLENGTH)
        {
            textField.text = [toBeString substringToIndex:QUOTEMAXLENGTH];
            return NO;
        }
        cs = [[NSCharacterSet characterSetWithCharactersInString:phoneNumbers]invertedSet];
        NSString * filtered = [[string componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@""];
        BOOL canChange = [string isEqualToString:filtered];
        if (canChange == YES)
        {
            quoteTextField.text = textField.text;
            return YES;;
        }
        else
            return NO;
        
    }
    else
    {
        if ([toBeString length] > 20)
        {
            textField.text = [toBeString substringToIndex:20];
            return NO;
        }
        else
            return YES;
    }
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (quoteTextField == textField)
    {
        quoteOrReason = 0;//这个是报价
    }
    else
        quoteOrReason = 1;
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    
    [textField resignFirstResponder];
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
    isKeyBoardExit = YES;
    
    NSDictionary* userInfo = [notification userInfo];
    CGRect keyboardFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    if (quoteOrReason == 0)
    {
        [UIView animateWithDuration:0.2f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            self.view.transform = CGAffineTransformMakeTranslation(0, 0);
            
            //    self.view.transform = CGAffineTransformMakeTranslation(0, /*- 100 + tableView_.contentOffset.y*/offset_Y);
            
        } completion:^(BOOL finished) {
        }];
    }
    else if(quoteOrReason == 1)
    {
        [UIView animateWithDuration:0.2f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            self.view.transform =CGAffineTransformMakeTranslation(0, -keyboardFrame.size.height + 120);
//            [self.imageView_background setFrame:CGRectMake(0, self.view.frame.size.height -49 -keyboardFrame.size.height +100, MainFrame.size.width, 49)];
            
        } completion:^(BOOL finished) {
        }];
    }
    [UIView commitAnimations];
    // }
}


- (void)keyboardWillHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.2f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        self.view.transform = CGAffineTransformMakeTranslation(0, 0);
        [self.imageView_background setFrame:CGRectMake(0, self.view.frame.size.height-49, MainFrame.size.width, 49)];
        
    } completion:^(BOOL finished) {
        
        
        
    }];
    [UIView commitAnimations];
    
    
    isKeyBoardExit = NO;
}
#pragma mark 网络加载回调
-(void)netRequestReceived:(NSNotification *)_notification
{
    [self hideProgressHUD];
    
    int number = [[[_notification object]objectForKey:@"number"]intValue];
    if (number == 0)
    {
        YZxuQiu.candidateStatus = @"1";
        
        Ty_OrderVC_YZFinish_Controller * yzFinishVC = [[Ty_OrderVC_YZFinish_Controller alloc]init];
        yzFinishVC.requirementGuid = requirementGuidStr;
        yzFinishVC.xuQiu = YZxuQiu;
        
        //因为现在订单跑到下面去了，所以不需要了
        /*
        TYBaseView* viewController=[[appDelegate appTabBarController] appNavigation];
        NSRange range;
        range.length=self.naviGationController.viewControllers.count -2;
        range.location=2;
        NSArray* array=[self.naviGationController.viewControllers subarrayWithRange:range];
        [self removeViewControllersFromWindow:array];
        */
        
        [self.naviGationController pushViewController:yzFinishVC animated:YES];
    }
    else if(number == 1)
    {
        [self showToastMakeToast:@"应征失败,请稍后再试" duration:1 position:@"center"];
    }
    else if(number == 100)
    {//标明fail
        [self showToastMakeToast:@"网络请求失败，请重试" duration:1 position:@"center"];

    }
}
#pragma mark 显示的应征报价
-(void)showYZTipLabel
{
    /*
    //保洁类
	int miniCleaning = 15;//日常保洁
	int maxcleaning = 50;//日常保洁
	int miniClean = 80;//空调清洗
	int maxClean = 200;//空调清洗
	//钟点工
	int miniPart_time = 10;//临时钟点工
	int maxPart_time = 40;//临时钟点工
	int miniSetDateEmploye = 1000;//定期钟点工
	int maxSetDateEmploye  = 5000;//定期钟点工
	//保姆
	int miniNurse = 3000;//住家保姆,看护老人
	int maxNurse = 9000;//住家保姆,看护老人
    //			final int miniLookAfter = 3000;//看护老人
    //			final int maxLookAfter = 9000;//看护老人
	//育婴育儿
	int miniYuesao = 5000;//月嫂
	int maxYuesao = 15000;//月嫂
	int miniYuersao = 3000;//育儿嫂
	int maxyuersao = 9000;//育儿嫂
	int miniearlyLearning = 150;//入户早教
	int maxEarlyLearning = 300;//入户早教
*/
    
    if ([workName isEqualToString:@"日常保洁"])
    {
        YZTipString = @"请把价格设定在15～50元范围之内!";
        min = 15;
        max = 50;
    }
    else if ([workName isEqualToString:@"空调清洗"])
    {
        YZTipString = @"请把价格设定在80～200元范围之内!";
        min = 80;
        max = 200;
    }
    else if ([workName isEqualToString:@"临时钟点工"])
    {
        YZTipString = @"请把价格设定在10～40元范围之内!";
        min = 10;
        max = 40;
    }
    else if ([workName isEqualToString:@"定期钟点工"])
    {
        YZTipString = @"请把价格设定在1000～5000元范围之内!";
        min = 1000;
        max = 5000;
    }
    else if ([workName isEqualToString:@"住家保姆"] ||[workName isEqualToString:@"看护老人"] )
    {
        YZTipString = @"请把价格设定在3000～9000元范围之内!";
        min = 3000;
        max = 9000;
    }
    else if([workName isEqualToString:@"月嫂"])
    {
        YZTipString = @"请把价格设定在5000～15000元范围之内!";
        min = 5000;
        max = 15000;
    }
    else if ([workName isEqualToString:@"育儿嫂"])
    {
        YZTipString = @"请把价格设定在3000～9000元范围之内!";
        min = 3000;
        max = 9000;
    }
    else if ([workName isEqualToString:@"入户早教"])
    {
        YZTipString = @"请把价格设定在150～300元范围之内!";
        min = 150;
        max = 300;
    }
    
    YZTipLabel =[[UILabel alloc]initWithFrame:CGRectMake(90, 113, 215, 14)];
    YZTipLabel.numberOfLines = 0;
    YZTipLabel.lineBreakMode = NSLineBreakByCharWrapping;
    [YZTipLabel setBackgroundColor:[UIColor clearColor]];
    YZTipLabel.text = YZTipString;
    [YZTipLabel setFont:FONT14_BOLDSYSTEM];
    YZTipLabel.textAlignment = NSTextAlignmentLeft;
    YZTipLabel.textColor = [UIColor redColor];
    
    CGSize serviceAreaSize = [YZTipLabel.text sizeWithFont:FONT14_BOLDSYSTEM constrainedToSize:CGSizeMake(YZTipLabel.frame.size.width, YZTipLabel.frame.size.height * 3) lineBreakMode:NSLineBreakByCharWrapping];
    if (serviceAreaSize.height > YZTipLabel.frame.size.height)
        [YZTipLabel setFrame:CGRectMake(90, YZTipLabel.frame.origin.y, 215, serviceAreaSize.height)];
    else
        [YZTipLabel setFrame:CGRectMake(90, YZTipLabel.frame.origin.y, 215, 14)];

    [clickTempView addSubview:YZTipLabel];
    
    UILabel * tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 83 + 9, 215, 14)];
    [tipLabel setBackgroundColor:[UIColor clearColor]];
    tipLabel.text = @"报价不包含中介费和管理费用";
    [tipLabel setFont:FONT14_SYSTEM];
    tipLabel.textAlignment = NSTextAlignmentLeft;
    tipLabel.textColor = [UIColor grayColor];

    [clickTempView addSubview:tipLabel];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
