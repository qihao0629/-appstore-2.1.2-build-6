//
//  EmploymentNextViewController.m
//  腾云家务
//
//  Created by 艾飞 on 13-12-19.
//  Copyright (c) 2013年 齐 浩. All rights reserved.
//

#import "EmploymentNextViewController.h"

@interface EmploymentNextViewController ()

@end

@implementation EmploymentNextViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"店铺介绍";
    
    button_ok.hidden = NO;
    
    UIView *viewClick = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-49 - 44 - 20)];
    [self.view addSubview:viewClick];
    UITapGestureRecognizer *clickview = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickview:)];
    [viewClick addGestureRecognizer:clickview];

    
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(10, 20, 300,150)];
    _textView.backgroundColor = [UIColor whiteColor];
    _textView.font = [UIFont systemFontOfSize:14.0f];
    _textView.text = _str_OtherInfo;
    _textView.delegate = self;

    [self.view addSubview:_textView];
    
    UILabel * lable_ts = [[UILabel alloc]initWithFrame:CGRectMake(10, 200, 300, 40)];
    lable_ts.font = FONT14_SYSTEM;
    lable_ts.text = @"输入店铺介绍，可以让用户更清晰的了解您的店铺信息情况!";
    lable_ts.backgroundColor = [UIColor clearColor];
    lable_ts.numberOfLines = 0 ;
    lable_ts.textColor = [UIColor colorWithRed:136.0/255.0 green:136.0/255.0 blue:136.0/255.0 alpha:1.0];
    [self.view addSubview:lable_ts];
    
}

#pragma mark - 完成
-(void)button_okClick{
    NSString *text = [ _textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSMutableDictionary * dicDefaults = [[NSMutableDictionary alloc]init];
    [dicDefaults setDictionary:MyShopInforDefaults];
    [dicDefaults setObject:text forKey:@"detailIntermediaryOtherInfo"];
    [[NSUserDefaults standardUserDefaults]setObject:dicDefaults forKey:@"MyShopInformation"];
    [self.naviGationController popViewControllerAnimated:YES];
}

#pragma mark - 点击空白
-(void)clickview:(UITapGestureRecognizer *)tap {
    [_textView resignFirstResponder];
}

#pragma mark - UITextView
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
