//
//  WithdrawsCashSuccessVC.m
//  腾云家务
//
//  Created by liu on 14-7-2.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "WithdrawsCashSuccessVC.h"

@implementation WithdrawsCashSuccessVC

@synthesize titleMsgLabel = _titleMsgLabel;

@synthesize money = _money;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nil bundle:nil])
    {
        _money = @"";
    }
    
    return self;
}

- (void)popBtnPressed
{
    [self.naviGationController popViewControllerAnimated:YES];
}

#pragma mark -- view lifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"转出申请已提交";
    
    UILabel *titleMsgLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 50, 280, 20)];
    titleMsgLabel.backgroundColor = [UIColor clearColor];
    titleMsgLabel.textColor = [UIColor colorWithRed:255.0/255 green:165.0/255 blue:120.0/255 alpha:1.0];
    titleMsgLabel.font = [UIFont boldSystemFontOfSize:16];
    titleMsgLabel.text = [NSString stringWithFormat:@"您的转出申请已提交，金额为%@元",_money];
    titleMsgLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleMsgLabel];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(110, 90, 100, 100)];
    imageView.backgroundColor = [UIColor clearColor];
    imageView.image = [UIImage imageNamed:@"pub_qiangdanimage"];
    [self.view addSubview:imageView];
    
    UILabel *detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 210, 280, 20)];
    detailLabel.backgroundColor = [UIColor clearColor];
    detailLabel.textColor = [UIColor grayColor];
    detailLabel.font = [UIFont systemFontOfSize:14];
    detailLabel.text = [NSString stringWithFormat:@"款项将在%@工作日到账，请注意查收...",@"1~3"];
    detailLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:detailLabel];
    
    UIButton *popBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    popBtn.frame = CGRectMake(90, 270, 140, 35);
    [popBtn setBackgroundImage:[UIImage imageNamed:@"login_yanzhengma"] forState:UIControlStateNormal];
    [popBtn setTitle:@"返回我的账户" forState:UIControlStateNormal];
    [popBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    popBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    [popBtn addTarget:self action:@selector(popBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:popBtn];
    
}



@end
