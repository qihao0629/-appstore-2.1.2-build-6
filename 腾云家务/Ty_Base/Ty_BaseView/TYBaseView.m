//
//  TYBaseView.m
//  腾云家务
//
//  Created by 齐 浩 on 14-5-23.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "TYBaseView.h"
#import "MBProgressHUD.h"

@interface TYBaseView ()
{
    NSString *notificationName;
    
}
@end

@implementation TYBaseView
@synthesize naviGationController,titleString;
@synthesize button_back,button_ok,imageView_background;
@synthesize slidingBackbool;
@synthesize rightLabel;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        slidingBackbool = YES;
    }
    return self;
}
#pragma 设置导航隐藏
-(void)setNavigationBarHidden:(BOOL)_bool animated:(BOOL)isAnimation
{
    float duration = 0.0f;
    if (isAnimation) {
        duration = 0.25f;
    }
    [self viewisHidden:_bool duration:isAnimation];
}
#pragma 导航隐藏方法
-(void)viewisHidden:(BOOL)_bool duration:(float)_duration{
    if (_bool) {
        if (naviGationController!= nil) {
            [UIView animateWithDuration:_duration animations:^{
                if (IOS7) {
                    [self.view setBounds:CGRectMake(0, -20, SCREEN_WIDTH, SCREEN_HEIGHT)];
                    [naviGationController setFrame:CGRectMake(0, -64, SCREEN_WIDTH, 64)];
                    [naviGationController setImage:[UIImage imageNamed:@"titleBar"]];
                    
                }else{
                    
                    [self.view setBounds:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-20)];
                    [naviGationController setFrame:CGRectMake(0, -44, SCREEN_WIDTH, 44)];
                    [naviGationController setImage:[UIImage imageNamed:@"titleBar1"]];
                }
            }completion:^(BOOL finished) {
                [naviGationController removeFromSuperview];
            }];
        }else{
            [UIView animateWithDuration:_duration animations:^{
                if (IOS7) {
                    [self.view setBounds:CGRectMake(0, -20, SCREEN_WIDTH, SCREEN_HEIGHT)];
                    naviGationController = [[TYNavigationController alloc]initWithFrame:CGRectMake(0, -64, SCREEN_WIDTH, 64)];
                    [naviGationController setImage:[UIImage imageNamed:@"titleBar"]];
                    
                }else{
                    [self.view setBounds:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-20)];
                    naviGationController = [[TYNavigationController alloc]initWithFrame:CGRectMake(0, -44, SCREEN_WIDTH, 44)];
                    [naviGationController setImage:[UIImage imageNamed:@"titleBar1"]];
                }
            }completion:^(BOOL finished) {
                naviGationController.titleLabel.text = titleString;
                [self.view addSubview:naviGationController];
            }];
        }
    }else{
        
        if (naviGationController!= nil) {
            [UIView animateWithDuration:_duration animations:^{
                if (IOS7) {
                    [self.view setBounds:CGRectMake(0, -64, SCREEN_WIDTH, SCREEN_HEIGHT)];
                    [naviGationController setFrame:CGRectMake(0, -64, SCREEN_WIDTH, 64)];
                    [naviGationController setImage:[UIImage imageNamed:@"titleBar"]];
                    
                }else{
                    [self.view setBounds:CGRectMake(0, -44, SCREEN_WIDTH, SCREEN_HEIGHT)];
                    [naviGationController setFrame:CGRectMake(0, -44, SCREEN_WIDTH, 44)];
                    [naviGationController setImage:[UIImage imageNamed:@"titleBar1"]];
                }
            }completion:^(BOOL finished) {
                [self.view addSubview:naviGationController];
            }];
        }else{
            [UIView animateWithDuration:_duration animations:^{
                if (IOS7) {
                    [self.view setBounds:CGRectMake(0, -64, SCREEN_WIDTH, SCREEN_HEIGHT)];
                    naviGationController = [[TYNavigationController alloc]initWithFrame:CGRectMake(0, -64, SCREEN_WIDTH, 64)];
                    [naviGationController setImage:[UIImage imageNamed:@"titleBar"]];
                    
                }else{
                    [self.view setBounds:CGRectMake(0, -44, SCREEN_WIDTH, SCREEN_HEIGHT)];
                    naviGationController = [[TYNavigationController alloc]initWithFrame:CGRectMake(0, -44, SCREEN_WIDTH, 44)];
                    [naviGationController setImage:[UIImage imageNamed:@"titleBar1"]];
                }
            }completion:^(BOOL finished) {
                naviGationController.titleLabel.text = titleString;
                [self.view addSubview:naviGationController];
            }];
        }
    }
}

-(void)addNotificationForName:(NSString* )_name
{
    notificationName = _name;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netRequestReceived:) name:SETNotificationMark(notificationName) object:nil];
   
}
-(void)viewDidDisappear:(BOOL)animated
{

}

-(void)viewWillDisappear:(BOOL)animated
{
    

    [[NSNotificationCenter defaultCenter]removeObserver:self name:GETNotificationMark(notificationName) object:nil];
}
-(void)viewDidAppear:(BOOL)animated
{
    [self.view bringSubviewToFront:naviGationController];
    [self.view bringSubviewToFront:imageView_background];
}
-(void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netRequestReceived:) name:SETNotificationMark(notificationName) object:nil];
    
//    if (IOS7) {
//        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//    }else{
//        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
//    }
}


#pragma mark ----加载视图
- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view setBackgroundColor:view_BackGroudColor];
    if (naviGationController == nil) {
        if (IOS7) {
            [self.view setBounds:CGRectMake(0, -64, SCREEN_WIDTH, SCREEN_HEIGHT)];
            naviGationController = [[TYNavigationController alloc]initWithFrame:CGRectMake(0, -64, SCREEN_WIDTH, 64)];
            [naviGationController setImage:[UIImage imageNamed:@"titleBar"]];
            
        }else{
            [self.view setBounds:CGRectMake(0, -44, SCREEN_WIDTH, SCREEN_HEIGHT)];
            naviGationController = [[TYNavigationController alloc]initWithFrame:CGRectMake(0, -44, SCREEN_WIDTH, 44)];
            [naviGationController setImage:[UIImage imageNamed:@"titleBar1"]];
        }
        
        naviGationController.titleLabel.text = titleString;
        [self.view addSubview:naviGationController];
    }
    imageView_background = [[UIImageView alloc]init];

    imageView_background.frame = CGRectMake(0, SCREEN_HEIGHT- 20 - 44 - 49, SCREEN_WIDTH, 49);//底部导航
    
    imageView_background.image = [UIImage imageNamed:@"footViewImage"];
    [imageView_background setUserInteractionEnabled:YES];
    //返回
    button_back = [UIButton buttonWithType:UIButtonTypeCustom];
    button_back.frame = CGRectMake(0, 0, 49, 49);
    [button_back setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [button_back addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    
    [imageView_background addSubview:button_back];
    
    button_ok = [UIButton buttonWithType:UIButtonTypeCustom];
    button_ok.frame = CGRectMake(320-49, 0, 49, 49);
    button_ok.hidden = YES;
    [button_ok setImage:[UIImage imageNamed:@"button_ok"] forState:UIControlStateNormal];
    [button_ok addTarget:self action:@selector(button_okClick) forControlEvents:UIControlEventTouchUpInside];
    [imageView_background addSubview:button_ok];
    
    rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(210, 0, 100, 49)];
    [rightLabel setText:@""];
    rightLabel.adjustsFontSizeToFitWidth = YES;
    [rightLabel setBackgroundColor:[UIColor clearColor]];
    [rightLabel setFont:FONT14_BOLDSYSTEM];
    [rightLabel setTextColor:text_RedColor];
    [rightLabel setTextAlignment:NSTextAlignmentRight];
    
    [imageView_background addSubview:rightLabel];
    
    [self.view addSubview:imageView_background];
	// Do any additional setup after loading the view.
    
    //键盘高度监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark ----当view出发右滑触发
-(void)viewWillbackAction
{
    NSLog(@"aaaa");
}

#pragma mark ----- 成功but 函数
-(void)button_okClick{


}
#pragma mark ---- 设置下方导航条右边label
-(void)setRightLabel
{
    
}
#pragma mark ----- 返回but 函数
-(void)backClick{
    ResignFirstResponder
    [self popViewControllerWithAnimation:YES];
}
- (void)removeViewControllersFromWindow:(NSArray* )viewControllers
{
    [TYNAVIGATION removeViewControllersFromWindow:viewControllers];
}
#pragma mark ----push and pop 方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [TYNAVIGATION pushViewController:viewController withAnimation:animated];
}
-(void)popViewControllerWithAnimation:(BOOL)isAnimation
{
    [TYNAVIGATION popViewControllerWithAnimation:isAnimation];
}
- (void)popToViewController:(UIViewController *)viewController animated:(BOOL)isAnimation
{
    [TYNAVIGATION popToViewController:viewController animated:isAnimation];
}
- (void)popToRootViewControllerAnimated:(BOOL)isAnimation
{
    [TYNAVIGATION popToRootViewControllerAnimated:isAnimation];
}

#pragma mark ----－网络回调
-(void)netRequestReceived:(NSNotification *)_notification
{

}

#pragma mark ----显示与隐藏 loading加载
- (Ty_BaseLoading*) showLoadingInView:(UIView*)view
{
    [self hideNetMessageView];
    [self hideMessageView];
    if(_loadingView !=  nil) {
        [self hideLoadingView];
    }
    _loadingView = [[Ty_BaseLoading alloc] init];
    [view addSubview:_loadingView.view];
    return _loadingView;
}
- (void) hideLoadingView
{
    if(_loadingView !=  nil) {
        [_loadingView.view removeFromSuperview];
        _loadingView = nil;
    }
}
#pragma mark ----显示与隐藏 加载失败视图
-(Ty_BaseNetMessage*)showNetMessageInView:(UIView*)view
{
    [self hideLoadingView];
    [self hideMessageView];
    if(_netMessageView !=  nil) {
        [self hideNetMessageView];
    }
    _netMessageView = [[Ty_BaseNetMessage alloc] init];
    _netMessageView.delegate = self;
    [view addSubview:_netMessageView.view];
    return _netMessageView;
}

-(void)hideNetMessageView
{
    if(_netMessageView !=  nil) {
        [_netMessageView.view removeFromSuperview];
        _netMessageView = nil;
    }
}
#pragma mark ----显示提示信息
-(Ty_BaseNetMessage*)showMessageInView:(UIView*)view message:(NSString* )_message
{
    [self hideLoadingView];
    [self hideNetMessageView];
    if(_dataMessageView !=  nil) {
        [self hideMessageView];
    }
    _dataMessageView = [[Ty_BaseNetMessage alloc] init];
    [view addSubview:_dataMessageView.view];
    _dataMessageView.label.text = _message;
    _dataMessageView.button.hidden = YES;
    return _dataMessageView;
}

-(void)hideMessageView
{
    if(_dataMessageView !=  nil) {
        [_dataMessageView.view removeFromSuperview];
        _dataMessageView = nil;
    }
}


#pragma mark ----重新加载代理回执
-(void)loading
{
    
}

#pragma mark ----MBProgressHUB 加载与隐藏
-(MBProgressHUD* ) showProgressHUD {
    return [self showProgressHUD:nil];
}
-(MBProgressHUD* ) showProgressHUD:(NSString*) labelText{
    if(_progressHUD !=  nil) {
        [self hideProgressHUD];
    }
    _progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    if(labelText) {
        _progressHUD.labelText = labelText;
    }
    [self.view addSubview:_progressHUD];
    [_progressHUD show:YES];
    return _progressHUD;
}

-(void) hideProgressHUD {
    if(_progressHUD !=  nil) {
        [_progressHUD removeFromSuperview];
        _progressHUD = nil;
    }
}

#pragma mark ----显示Toast
-(void)showToastMakeToast:(NSString* )_totast duration:(float)_duration position:(id)_position
{
    [self.view makeToast:_totast duration:_duration position:_position];
}
#pragma mark ----设置导航标题
-(void)setTitle:(NSString *)title
{
    titleString = title;
    naviGationController.titleLabel.text = titleString;
}
#pragma mark ----设置滑动返回开关
-(void)setSlidingBack:(BOOL)_isOpen
{
    slidingBackbool = _isOpen;
    [TYNAVIGATION setSlidingBack:_isOpen View:self.view];
}
#pragma mark ----- 键盘高低监听回调
- (void)keyboardDidShow:(NSNotification *)notification {

}
- (void)keyboardWillShow:(NSNotification *)notification {
    
    NSDictionary *info = [notification userInfo];
    
    NSValue   *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    
    [UIView beginAnimations:nil context:nil];
    
    [UIView setAnimationDuration:0.25];
    imageView_background.frame = CGRectMake(0, SCREEN_HEIGHT- 20 - 44-49 -keyboardSize.height, SCREEN_WIDTH, 49);//底部导航
    [UIView commitAnimations];
//    [imageView_background sendSubviewToBack:self.view];
    
}

- (void)keyboardWillHide:(NSNotification *)notification {
    [UIView beginAnimations:nil context:nil];
    
    [UIView setAnimationDuration:0.25];
    imageView_background.frame = CGRectMake(0, SCREEN_HEIGHT- 20 - 44 -49, SCREEN_WIDTH, 49);//底部导航
    [UIView commitAnimations];
}


#pragma mark ----- alerView
-(void)alertViewTitle:(NSString *)title message:(NSString *)message{
    
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    
    [alert show];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
