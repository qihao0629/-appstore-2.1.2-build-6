//
//  My_SetUpHelpVC.m
//  腾云家务
//
//  Created by 齐 浩 on 14-7-17.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "My_SetUpHelpVC.h"
#import "Ty_NetRequestService.h"
#import "My_SetUpHelp_busine.h"
@interface My_SetUpHelpVC ()<UITextViewDelegate>
{
    UITextView* helpTextView;
    UILabel* helpLabel;
    My_SetUpHelp_busine* help_busine;
}
@end

@implementation My_SetUpHelpVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        help_busine = [[My_SetUpHelp_busine alloc]init];
        [self addNotificationForName:@"My_SetUpHelpVC"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"帮助与反馈";
    
    helpTextView=[[UITextView alloc]initWithFrame:CGRectMake(5, 5, self.view.frame.size.width-10, 100)];
    [helpTextView setFont:FONT14_SYSTEM];
    helpTextView.layer.borderColor=[text_grayColor CGColor];
    helpTextView.layer.borderWidth=0.5f;
    helpTextView.delegate=self;
    
    helpLabel=[[UILabel alloc]initWithFrame:CGRectMake(5, 6, helpTextView.frame.size.width-10, 35)];
    [helpLabel setBackgroundColor:[UIColor clearColor]];
    [helpLabel setText:@"感谢您对腾云家务的支持,您宝贵的意见就是我们的财富.(字数在100字以内)..."];
    [helpLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [helpLabel setNumberOfLines:0];
    [helpLabel setTextColor:text_grayColor];
    [helpLabel setFont:FONT14_SYSTEM];

    [helpTextView addSubview:helpLabel];
    
    
    UIButton* sendButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [sendButton setBackgroundImage:JWImageName(@"login") forState:UIControlStateNormal];
    [sendButton setTitle:@"提交" forState:UIControlStateNormal];
    [sendButton.titleLabel setFont:FONT15_BOLDSYSTEM];
    [sendButton setFrame:CGRectMake(10, 110, self.view.frame.size.width-20, 44)];
    [sendButton addTarget: self action:@selector(sendHelpAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:helpTextView];
    [self.view addSubview:sendButton];
    
    // Do any additional setup after loading the view.
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (range.location==0&&[text isEqualToString:@""]&&range.length<=1) {
        helpLabel.hidden=NO;
    }else{
        helpLabel.hidden=YES;
    }
    
    if (range.location>99&&range.length==0) {
        return NO;
    }else{
        return YES;
    }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    ResignFirstResponder;
}
-(void)sendHelpAction:(id)sender
{
    ResignFirstResponder
    if (helpTextView.text.length>100) {
//        [self showToastMakeToast:@"字数限制100字" duration:1.0f position:@"bottom"];
        [[[UIApplication sharedApplication] keyWindow] makeToast:@"字数限制100字" duration:1.0f position:@"bottom"];
    }else if(helpTextView.text.length==0){
//        [self showToastMakeToast:@"请输入反馈内容" duration:1.0f position:@"bottom"];
        [[[UIApplication sharedApplication] keyWindow] makeToast:@"请输入反馈内容" duration:1.0f position:@"bottom"];
    }else{
        [self showLoadingInView:self.view];
        [help_busine sendHelpcontent:helpTextView.text];
    }
}
-(void)netRequestReceived:(NSNotification *)_notification
{
    [self hideLoadingView];
    if ([[[_notification object] objectForKey:@"code"] isEqualToString:@"200"]) {
//        [self showToastMakeToast:@"提交成功" duration:1.0f position:@"bottom"];
        helpTextView.text=@"";
        [[[UIApplication sharedApplication] keyWindow] makeToast:@"提交成功" duration:1.0f position:@"bottom"];
        [self.naviGationController popViewControllerAnimated:YES];
    }else{
//        [self showToastMakeToast:@"反馈失败" duration:1.0f position:@"bottom"];
        [[[UIApplication sharedApplication] keyWindow] makeToast:@"反馈失败" duration:1.0f position:@"bottom"];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
