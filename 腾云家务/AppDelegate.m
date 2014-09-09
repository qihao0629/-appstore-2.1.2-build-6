//
//  AppDelegate.m
//  腾云家务
//
//  Created by 齐 浩 on 14-5-21.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "AppDelegate.h"
#import "Ty_HomeVC.h"//首页
#import "Ty_HuodongVC.h"//活动
//#import "Ty_Order_Notification_Controller.h"//订单
#import "Ty_Order_Root_Controller.h"//订单
#import "Ty_NewsVC.h"//消息
#import "Ty_MySettingVC.h"//我的
#import "Ty_News_Busine_Jpush.h"//Jpush的业务层
#import "Ty_DbMethod.h"
#import "XmppManager.h"
#import "Ty_CheckVoiceMessage_Busine.h"
#import "Ty_MessageList_Busine.h"
#import "ViewController.h"

//share
#import <ShareSDK/ShareSDK.h>
#import "WeiboApi.h"
#import "WXApi.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "AppDelegateViewController.h"
#import "Reachability.h"
#import "iflyMSC/IFlySpeechUtility.h"

#import "Ty_SystemMessageBusine.h"
#import "Ty_LifeTipsBusine.h"

@implementation AppDelegate
@synthesize appTabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
//    NSSetUncaughtExceptionHandler (&UncaughtExceptionHandler); //捕获到异常之后发送邮件
    
//    self.window = [[UIApplication sharedApplication] keyWindow];
    
    [ShareSDK registerApp:@"1698012cb814"];
    
    //配置讯飞语音
    NSString *initString = [[NSString alloc] initWithFormat:@"appid = %@",XUNFEI_APPID];
    [IFlySpeechUtility createUtility:initString];

    
    [self initShareSdk];
//    [self onCheckVersion];
    
    [self upDataSqlite];
    
    Ty_HomeVC * ty_home = [[Ty_HomeVC alloc]init];
    
    Ty_NewsVC * ty_news = [[Ty_NewsVC alloc]init];
    
//    Ty_HuodongVC * ty_huodong = [[Ty_HuodongVC alloc]init];
    
    Ty_Order_Root_Controller * ty_order = [[Ty_Order_Root_Controller alloc]init];
    
    Ty_MySettingVC * ty_mysetting = [[Ty_MySettingVC alloc]init];
    
    NSArray * vcArray = [NSArray arrayWithObjects:ty_home,ty_news,ty_order,ty_mysetting, nil];
    
    UIImage * image1 = JWImageName(@"service_1");
    UIImage * image2 = JWImageName(@"service_2");
    NSDictionary * imageDic1 = [NSDictionary dictionaryWithObjectsAndKeys:image1,@"Default",image2,@"Seleted", nil];
    UIImage * image3 = JWImageName(@"private_letter_1");
    UIImage * image4 = JWImageName(@"private_letter_2");
    NSDictionary * imageDic2 = [NSDictionary dictionaryWithObjectsAndKeys:image3,@"Default",image4,@"Seleted", nil];
    UIImage * image5 = JWImageName(@"order_list_1");
    UIImage * image6 = JWImageName(@"order_list_2");
    NSDictionary * imageDic3 = [NSDictionary dictionaryWithObjectsAndKeys:image5,@"Default",image6,@"Seleted", nil];
    UIImage * image7 = JWImageName(@"management_1");
    UIImage * image8 = JWImageName(@"management_2");
    NSDictionary * imageDic4 = [NSDictionary dictionaryWithObjectsAndKeys:image7,@"Default",image8,@"Seleted", nil];
    
    NSArray * imageArray = [NSArray arrayWithObjects:imageDic1,imageDic2,imageDic3,imageDic4, nil];
    self.tabBarController = [[LeveyTabBarController alloc]initWithViewControllers:vcArray imageArray:imageArray ];
    
    _tabBarController.delegate = self;
    
    
    self.appTabBarController = [[AppDelegateViewController alloc]init];
    
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"versionNum"]==nil) {
        ViewController *appStartController = [[ViewController alloc] init];
        appStartController.AppVC=self.appTabBarController;
        self.window.rootViewController = appStartController;
    }else if(![[[NSUserDefaults standardUserDefaults] objectForKey:@"versionNum"] isEqualToString:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]])
    {
        ViewController *appStartController = [[ViewController alloc] init];
        appStartController.AppVC=self.appTabBarController;
        self.window.rootViewController = appStartController;
    }else{
        self.window.rootViewController=appTabBarController;
        
    }
    
//    self.window.rootViewController = self.appTabBarController;
    
    
    
    if (IOS7) {
        [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    }
//    self.window.rootViewController = self.tabBarController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    /*
     jpush需要的
     */
    //注册推送通知功能
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
    
    [TYJPush setupWithOption:launchOptions];
    
    // 如果推送 APN 时，Badge number 被指定为0 ，则可能出现 APN 消息在通知中心被点击后，尽管调用了   [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0]; 但 APN 消息在通知中心不会被删除的情况。 这种情况可以按如下代码调用以清除通知中心的 APN 通知。
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];

    //数据库实例化
    [Ty_DbMethod shareDbService];
    
    //初始化检查失败语音
    [Ty_CheckVoiceMessage_Busine shareCheckVoiceMessage];
    
    //若为登录状态，启动APP时，要再次登录xmpp
    [self loginXmpp];
    
    
    //请求小贴士
    if (IFLOGINYES)
    {
        [self getLifeTips];
    }
    
    
    //设置角标
    Ty_MessageList_Busine *messageBusine = [[Ty_MessageList_Busine alloc]init];
    [self.appTabBarController setTabBarIcon:[messageBusine getAllUnreadMessageNum] atIndex:1];
    messageBusine = nil;
    
   
    
    return YES;
}

- (void)getLifeTips
{
    Ty_LifeTipsBusine *lifeTipsBusine = [[Ty_LifeTipsBusine alloc]init];
    [lifeTipsBusine getLifeDataFromNet];
    lifeTipsBusine = nil;
}

-(void)initShareSdk
{
    _viewDelegate = [[AGViewDelegate alloc] init];
    
    //添加新浪微博应用
    [ShareSDK connectSinaWeiboWithAppKey:@"2379625799"
                               appSecret:@"9949482d3d1e05383a7faa7a51997499"
                             redirectUri:@"http://www.sharesdk.cn"];
    
    //添加腾讯微博应用
    [ShareSDK connectTencentWeiboWithAppKey:@"801489311"
                                  appSecret:@"943ae8fb878552df61e32ec2beb9d098"
                                redirectUri:@"https://itunes.apple.com/cn/app/teng-yun-jia-wu/id717545126?mt = 8"];
    
    //微信应用
    //    [ShareSDK connectWeChatTimelineWithAppId:@"wx9871e23843555e80" wechatCls:[WXApi class]];
    [ShareSDK connectWeChatWithAppId:@"wx9871e23843555e80" wechatCls:[WXApi class]];
    
    //短信分享
    [ShareSDK connectSMS];
}


#pragma mark ---- 登录xmpp

- (void)loginXmpp
{
    if (IFLOGINYES)
    {
        [[XmppManager shareXmppManager] reconnect];
    }
}



#pragma mark - 推送

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    /*
     JPush    // Required
     */
    [TYJPush registerDeviceToken:deviceToken];
    [TYJPush saveTokenToUserDefaultWithDeviceToken:deviceToken];
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [[XmppManager shareXmppManager] goOffline];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    //[[XmppManager shareXmppManager] goOnline];
    NSString *password_md5 = [MyLoginInformation objectForKey:@"userpassword"];
    NSString *password = [NSString stringWithFormat:@"%@%@",[password_md5 substringToIndex:3],[password_md5 substringWithRange:NSMakeRange(29, 3)]];
    [[XmppManager shareXmppManager] loginWithUsername:[MyLoginInformation  objectForKey:@"userName"]  andPassword:password andCompletion:^(BOOL ret)
     {
         if (ret)
         {
             //登录成功
             NSLog(@"xmpp登录成功~");
         }
         else
         {
             //失败
             NSLog(@"xmpp登录失败~~");
         }
     }];
}
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    if (!IFLOGINYES) {
        [TYJPush releaseJpush];
    }
    [PhoneBusine sendPhoneData];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSLog(@"22");
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==10000) {
        if (buttonIndex==0) {
            exit(0);
        }
        if (buttonIndex==1) {
            NSURL *url = [NSURL URLWithString:EvaluateWebLink];
            [[UIApplication sharedApplication]openURL:url];
            exit(0);
            
        }
    }else if (alertView.tag==20000){
        if (buttonIndex==1) {
            NSURL *url = [NSURL URLWithString:EvaluateWebLink];
            [[UIApplication sharedApplication]openURL:url];
        }
    }
}

#pragma mark 数据库升级
//数据库升级
-(void)upDataSqlite
{
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"Ty_SqliteVersion"]==nil) {
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"Ty_SqliteVersion"];
        
        NSString *extension = @"";
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        
        NSArray *contents = [fileManager contentsOfDirectoryAtPath:documentsDirectory error:NULL];
        NSEnumerator *e = [contents objectEnumerator];
        NSString *filename;
        while ((filename = [e nextObject])) {
            
            if ([[filename pathExtension] isEqualToString:extension]) {
                
                [fileManager removeItemAtPath:[documentsDirectory stringByAppendingPathComponent:filename] error:NULL];
            }
        }
        [Ty_DbMethod shareDbService];
    }
}
#pragma mark ----版本号检测
-(void)onCheckVersion
{
    
    [[Ty_NetRequestService shareNetWork] request:GetIosVersionUrl andTarget:self andSeletor:@selector(getIosVersion: dic:)];
    
}

-(void)getIosVersion:(NSString*)_isSuccess dic:(NSMutableDictionary*)_dic
{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    NSString *currentmuVersion = [infoDic objectForKey:@"CFBundleVersion"];
    if ([_isSuccess isEqualToString:REQUESTSUCCESS]) {
        if ([[_dic objectForKey:@"code"] intValue] == 200) {
            if (![[_dic objectForKey:@"version"] isEqualToString:currentVersion]) {
                if ([[_dic objectForKey:@"muVersion"] intValue] >[currentmuVersion intValue]) {
                    UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:@"更新" message:@"有新的版本更新，是否前往更新？" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:@"更新", nil];
                    alert1.tag = 10000;
                    [alert1 show];
                }else{
                    UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:@"更新" message:@"有新的版本更新，是否前往更新？" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:@"更新", nil];
                    alert1.tag = 20000;
                    [alert1 show];
                }
            }else{
                //            UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:@"更新" message:@"此版本为最新版本" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                //            alert1.tag = 10001;
                //            [alert1 show];
            }
        }
    }else{
        
    }
}
#pragma mark ----网络检测
-(void) isConnectionAvailable{
    
    int isExistenceNetwork = 0;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = 0;
            //NSLog(@"notReachable");
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = 1;
            //NSLog(@"WIFI");
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = 2;
            //NSLog(@"3G");
            break;
    }
    switch (isExistenceNetwork) {
        case 0:
            [[[UIApplication sharedApplication] keyWindow] makeToast:@"网络情况不好，请检查网络!" duration:2 position:@"bottom"];
            break;
        case 1:
            [[[UIApplication sharedApplication] keyWindow] makeToast:@"正在使用Wi-Fi" duration:2 position:@"bottom"];
            break;
        case 2:
            [[[UIApplication sharedApplication] keyWindow] makeToast:@"正在使用3G/2G网络" duration:2 position:@"bottom"];
            break;
        default:
            break;
    }
    
}
#pragma mark ----崩溃邮件捕捉
void UncaughtExceptionHandler(NSException *exception) {
    NSArray *arr = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    NSDictionary* infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString* versionNum = [infoDict objectForKey:@"CFBundleShortVersionString"];
    NSString *urlStr = [NSString stringWithFormat:@"mailto://errlog@jiawu8.com?&subject=bug报告&amp;body=感谢您的配合<br><br><br>"
                        "iphone版本错误详情:<br>name:%@<br>--------------------------<br>reason:%@<br>---------------------<br>%@  <br>--------------------<br>版本号:%@<br>所在服务器%@",
                        name,reason,[arr componentsJoinedByString:@"<br>"],versionNum,HOSTLOCATION];
    
    
    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [[UIApplication sharedApplication] openURL:url];
}
@end
