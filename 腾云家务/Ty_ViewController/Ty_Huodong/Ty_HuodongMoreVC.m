//
//  Ty_HuodongMoreVC.m
//  腾云家务
//
//  Created by Xu Zhao on 14-6-3.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_HuodongMoreVC.h"

@interface Ty_HuodongMoreVC ()
@end

@implementation Ty_HuodongMoreVC
@synthesize strURL;

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
    [self.view setBackgroundColor:view_BackGroudColor];
    self.title=@"活动详情";
    self.imageView_background.hidden = YES;
    [self loadBackButton];
    
    UIWebView *webView =  [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-20-44)];
    [webView setBackgroundColor:view_BackGroudColor];
    [webView setScalesPageToFit:YES];
    [self.view addSubview:webView];
    webView.delegate = self;
    
    NSString *path = [NSString stringWithFormat:@"%@?userGuid=%@",strURL,MyLoginUserGuid];
    NSURL *url = [NSURL URLWithString:path];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    /*NSMutableString *strNews = [[NSMutableString alloc]
                                initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@",strURL]]
                                encoding:NSUTF8StringEncoding
                                error:nil];
    if(strNews != nil)
    {
        [webView loadHTMLString:strNews  baseURL:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"网络连接错误"
                                                       delegate:self
                                              cancelButtonTitle:@"知道了"
                                              otherButtonTitles:nil];
        [alert show];
    }*/
    
    // remove shadow view when drag web view
    for (UIView *subView in [webView subviews]) {
        if ([subView isKindOfClass:[UIScrollView class]]) {
            for (UIView *shadowView in [subView subviews]) {
                if ([shadowView isKindOfClass:[UIImageView class]]) {
                    shadowView.hidden = YES;
                }
            }
        }
    }
}
#pragma mark 加载返回按钮
-(void)loadBackButton
{
    self.naviGationController.userInteractionEnabled = YES;
    [self.naviGationController.leftBarButton setImage:[UIImage imageNamed:@"Message_back"] forState:UIControlStateNormal];
    [self.naviGationController.leftBarButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    self.naviGationController.leftBarButton.showsTouchWhenHighlighted = YES;
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
