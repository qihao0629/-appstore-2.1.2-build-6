//
//  Ty_BaseNetMessage.m
//  腾云家务
//
//  Created by 齐 浩 on 14-5-26.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_BaseNetMessage.h"

@interface Ty_BaseNetMessage ()

@end

@implementation Ty_BaseNetMessage
@synthesize delegate;
@synthesize label,button;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setFrame:CGRectMake(0, 0, 320, SCREEN_HEIGHT-64-49)];
    [self.view setBackgroundColor:view_BackGroudColor];
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0 , 80, 80)];
    imageView.image = [UIImage imageNamed:@"network.png"];
    imageView.center = CGPointMake(160, 200);
    [self.view addSubview:imageView];
    
    label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 20)];
    label.text = @"当前网络不可用，请检查你的网络设置";
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:16.0];
    label.textAlignment = UITextAlignmentCenter;
    label.center = CGPointMake(160, 200+50);
    label.textColor = [UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1.0];
    [self.view addSubview:label];
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"重新加载" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:233/255.0 green:149/255.0 blue:147/255.0 alpha:1.0] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(reload) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    button.frame = CGRectMake(0, 0, 100, 30);
    button.center = CGPointMake(160, 200+20+20+35);
    [self.view addSubview:button];

    // Do any additional setup after loading the view.
}
-(void)reload
{
    if (delegate) {
        [delegate loading];
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
