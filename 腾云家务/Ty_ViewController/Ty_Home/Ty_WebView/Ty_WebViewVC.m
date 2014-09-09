//
//  Ty_WebViewVC.m
//  腾云家务
//
//  Created by 齐 浩 on 14-7-3.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_WebViewVC.h"

@interface Ty_WebViewVC ()<UIWebViewDelegate,UIGestureRecognizerDelegate>
{
    UIWebView* webview;
    UITapGestureRecognizer * tapGesture;
}
@end

@implementation Ty_WebViewVC
@synthesize url,filePath;

static enum Ty_WebloadType ty_webloadType;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

+(id)shareWebView:(enum Ty_WebloadType)_ty_WebloadType
{
    Ty_WebViewVC* web = [[Ty_WebViewVC alloc]init];
    ty_webloadType = _ty_WebloadType;
    return web;
}
-(void)keyboardWillHide:(NSNotification *)notification
{
    [webview removeGestureRecognizer:tapGesture];
}
-(void)keyboardWillShow:(NSNotification *)notification
{
    [webview addGestureRecognizer:tapGesture];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    webview  = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-49)];
    [webview setBackgroundColor:view_BackGroudColor];
    if (ty_webloadType == Ty_WebloadNet) {
        NSURLRequest *request  = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        webview.delegate = self;
        if (url == nil||[url isEqualToString:@""]) {
            [self showMessageInView:self.view message:@"该活动暂未开始，请耐心等待，有惊喜哦！"];
        }else{
            [self.view addSubview: webview];
            [webview loadRequest:request];
        }
    }else if (ty_webloadType == Ty_WebloadLocal){
        [self.view addSubview: webview];
        NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        [webview loadHTMLString:htmlString baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] resourcePath]]];
    }
    tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyBoard)];
    tapGesture.delegate = self;
    tapGesture.cancelsTouchesInView = NO;
    // Do any additional setup after loading the view.
}
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
-(void)dismissKeyBoard
{
    ResignFirstResponder
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void )webViewDidStartLoad:(UIWebView  *)webView
{
    [self showLoadingInView:webView];
}
- (void )webViewDidFinishLoad:(UIWebView  *)webView
{
    [self hideLoadingView];
}
- (void)webView:(UIWebView *)webView  didFailLoadWithError:(NSError *)error
{
    [self showNetMessageInView:webView];
}
-(void)loading
{
    NSURLRequest *request  = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [webview loadRequest:request];
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
