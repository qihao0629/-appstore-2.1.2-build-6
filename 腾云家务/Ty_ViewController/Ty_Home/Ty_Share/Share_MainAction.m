//
//  Share_MainAction.m
//  腾云家务
//
//  Created by 齐 浩 on 14-5-6.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Share_MainAction.h"
#import <ShareSDK/ISSShareViewDelegate.h>
#import <ShareSDK/ShareSDK.h>
#import "WeiboApi.h"
#import "WXApi.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#define SMSCONTENT [NSString stringWithFormat:@"您的朋友%@，邀请您注册成为腾云家务的会员，现在注册即可获得腾云家务送上的好礼一份，腾云家务让您的居家生活更为便捷。下载包链接:http://www.jiawu8.com",MyLoginUserRealName]
#define SinaWeiboCONTENT [NSString stringWithFormat:@"我觉得腾云家务这个应用不错，选阿姨，找保洁，挑月嫂，什么都能替你找！现在注册即可获得腾云家务送上的好礼一份。腾云家务让您的居家生活更为便捷。下载链接:http://www.jiawu8.com"]
#define WeChatCONTENT [NSString stringWithFormat:@"我觉得腾云家务这个应用不错，选阿姨，找保洁，挑月嫂，什么都能替你找！现在注册即可获得腾云家务送上的好礼一份。腾云家务让您的居家生活更为便捷。下载链接:http://www.jiawu8.com"]

@implementation Share_MainAction
@synthesize DataArray,titleString;

- (id)init
{
    self = [super init];
    if (self) {
        titleString = @"    当您的好友成功通过您激活码注册后，您就可以获得奖励了～推荐越多，奖励越多，礼品越多，赶快为朋友送上“荐”面礼吧！";
        DataArray = [[NSMutableArray alloc]init];
        
        _appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        NSDictionary* dic1 = [[NSDictionary alloc]initWithObjectsAndKeys:@"短信邀请",@"titleName", @"SMS",@"titleImage",nil];
        NSDictionary* dic2 = [[NSDictionary alloc]initWithObjectsAndKeys:@"微博邀请",@"titleName", @"SinaWeibo",@"titleImage",nil];
        NSDictionary* dic3 = [[NSDictionary alloc]initWithObjectsAndKeys:@"微信邀请",@"titleName", @"WeChat",@"titleImage",nil];
        NSDictionary* dic4 = [[NSDictionary alloc]initWithObjectsAndKeys:@"朋友圈邀请",@"titleName", @"WeChatFriend",@"titleImage",nil];
        [DataArray addObject:dic1];
        [DataArray addObject:dic2];
        [DataArray addObject:dic3];
        [DataArray addObject:dic4];
        
        ;
    }
    return self;
}
/**
 *	@brief	短信分享
 *
 *	@param 	sender 	事件对象
 */
- (void)shareBySMSClickHandler:(UIViewController*)view
{
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"setup_about@2x"  ofType:@"png"];
    //创建分享内容
    id<ISSContent> publishContent = [ShareSDK content:SMSCONTENT
                                       defaultContent:@""
                                                image:nil
                                                title:nil
                                                  url:nil
                                          description:nil
                                            mediaType:SSPublishContentMediaTypeText];
    
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    [container setIPadContainerWithView:view.view arrowDirect:UIPopoverArrowDirectionRight];
    
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:YES
                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
                                                          viewDelegate:nil
                                               authManagerViewDelegate:_appDelegate.viewDelegate];
    
    //在授权页面中添加关注官方微博
    [authOptions setFollowAccounts:[NSDictionary dictionaryWithObjectsAndKeys:
                                    [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
                                    SHARE_TYPE_NUMBER(ShareTypeSinaWeibo),
                                    [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
                                    SHARE_TYPE_NUMBER(ShareTypeTencentWeibo),
                                    nil]];
    
    //显示分享菜单
    [ShareSDK showShareViewWithType:ShareTypeSMS
                          container:container
                            content:publishContent
                      statusBarTips:NO
                        authOptions:authOptions
                       shareOptions:[ShareSDK defaultShareOptionsWithTitle:nil
                                                           oneKeyShareList:[NSArray defaultOneKeyShareList]
                                                            qqButtonHidden:NO
                                                     wxSessionButtonHidden:NO
                                                    wxTimelineButtonHidden:NO
                                                      showKeyboardOnAppear:NO
                                                         shareViewDelegate:_appDelegate.viewDelegate
                                                       friendsViewDelegate:_appDelegate.viewDelegate
                                                     picViewerViewDelegate:nil]
                             result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                 if (state == SSPublishContentStateBegan) {
                                      [CustomStatusBar showSuccessWithStatus:[NSString stringWithFormat:@"短信分享中.."]];
                                 }else if (state  ==  SSPublishContentStateSuccess)
                                 {
                                     NSLocalizedString(@"TEXT_SHARE_SUC", @"发表成功");
                                      [CustomStatusBar showSuccessWithStatus:[NSString stringWithFormat:@"分享成功"]];
                                 }
                                 else if (state  ==  SSPublishContentStateFail)
                                 {
                                     NSLocalizedString(@"TEXT_SHARE_FAI", @"发布失败!error code  ==  %d, error code  ==  %@"), [error errorCode], [error errorDescription];
                                      [CustomStatusBar showSuccessWithStatus:[NSString stringWithFormat:@"分享失败,%@",[error errorDescription]]];
                                 }
                             }];
}
/**
 *	@brief	分享到新浪微博
 *
 *	@param 	sender 	事件对象
 */
- (void)shareToSinaWeiboClickHandler:(UIViewController *)view
{
    //创建分享内容
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"setup_about@2x"  ofType:@"png"];
    id<ISSContent> publishContent = [ShareSDK content:SinaWeiboCONTENT
                                       defaultContent:@""
                                                image:[ShareSDK imageWithPath:imagePath]
                                                title:nil
                                                  url:nil
                                          description:nil
                                            mediaType:SSPublishContentMediaTypeText];
    
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    [container setIPadContainerWithView:view.view arrowDirect:UIPopoverArrowDirectionUp];
    
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:YES
                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
                                                          viewDelegate:nil
                                               authManagerViewDelegate:_appDelegate.viewDelegate];
    
    //在授权页面中添加关注官方微博
    [authOptions setFollowAccounts:[NSDictionary dictionaryWithObjectsAndKeys:
                                    [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
                                    SHARE_TYPE_NUMBER(ShareTypeSinaWeibo),
                                    [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
                                    SHARE_TYPE_NUMBER(ShareTypeTencentWeibo),
                                    nil]];
    
    //显示分享菜单
    [ShareSDK showShareViewWithType:ShareTypeSinaWeibo
                          container:container
                            content:publishContent
                      statusBarTips:NO
                        authOptions:authOptions
                       shareOptions:[ShareSDK defaultShareOptionsWithTitle:nil
                                                           oneKeyShareList:[NSArray defaultOneKeyShareList]
                                                            qqButtonHidden:NO
                                                     wxSessionButtonHidden:NO
                                                    wxTimelineButtonHidden:NO
                                                      showKeyboardOnAppear:NO
                                                         shareViewDelegate:_appDelegate.viewDelegate
                                                       friendsViewDelegate:_appDelegate.viewDelegate
                                                     picViewerViewDelegate:nil]
                             result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                 if (state == SSPublishContentStateBegan) {
                                     [CustomStatusBar showSuccessWithStatus:[NSString stringWithFormat:@"新浪微博分享中.."]];
                                 }
                                 if (state  ==  SSPublishContentStateSuccess)
                                 {
                                     NSLocalizedString(@"TEXT_SHARE_SUC", @"发表成功");
                                     [CustomStatusBar showSuccessWithStatus:[NSString stringWithFormat:@"分享成功"]];
                                 }
                                 else if (state  ==  SSPublishContentStateFail)
                                 {
                                     NSLocalizedString(@"TEXT_SHARE_FAI", @"发布失败!%@"),[error errorDescription];
                                     [CustomStatusBar showSuccessWithStatus:[NSString stringWithFormat:@"分享失败,%@",[error errorDescription]]];
                                 }
                             }];
}
/**
 *	@brief	分享到微信朋友
 *
 *	@param 	sender 	事件对象
 */
- (void)shareToWeixinSessionClickHandler:(UIViewController*)view
{
    //创建分享内容
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"setup_about@2x"  ofType:@"png"];
    id<ISSContent> publishContent = [ShareSDK content:WeChatCONTENT
                                       defaultContent:@""
                                                image:[ShareSDK imageWithPath:imagePath]
                                                title:@"腾云家务"
                                                  url:@"http://www.jiawu8.com"
                                          description:nil
                                            mediaType:SSPublishContentMediaTypeText];
    
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:YES
                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
                                                          viewDelegate:nil
                                               authManagerViewDelegate:_appDelegate.viewDelegate];
    
    //在授权页面中添加关注官方微博
    [authOptions setFollowAccounts:[NSDictionary dictionaryWithObjectsAndKeys:
                                    [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
                                    SHARE_TYPE_NUMBER(ShareTypeSinaWeibo),
                                    [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
                                    SHARE_TYPE_NUMBER(ShareTypeTencentWeibo),
                                    nil]];
    
    //显示分享菜单
    [ShareSDK showShareViewWithType:ShareTypeWeixiSession
                          container:nil
                            content:publishContent
                      statusBarTips:NO
                        authOptions:authOptions
                       shareOptions:[ShareSDK defaultShareOptionsWithTitle:nil
                                                           oneKeyShareList:[NSArray defaultOneKeyShareList]
                                                            qqButtonHidden:NO
                                                     wxSessionButtonHidden:NO
                                                    wxTimelineButtonHidden:NO
                                                      showKeyboardOnAppear:NO
                                                         shareViewDelegate:_appDelegate.viewDelegate
                                                       friendsViewDelegate:_appDelegate.viewDelegate
                                                     picViewerViewDelegate:nil]
                             result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                 if (state == SSPublishContentStateBegan) {
                                     [CustomStatusBar showSuccessWithStatus:[NSString stringWithFormat:@"微信朋友分享中.."]];
                                 }else if (state  ==  SSPublishContentStateSuccess)
                                 {
                                     NSLocalizedString(@"TEXT_SHARE_SUC", @"发表成功");
                                     [CustomStatusBar showSuccessWithStatus:[NSString stringWithFormat:@"分享成功"]];
                                 }
                                 else if (state  ==  SSPublishContentStateFail)
                                 {
                                     NSLocalizedString(@"TEXT_SHARE_FAI", @"发布失败!%@"), [error errorDescription];
                                     [CustomStatusBar showSuccessWithStatus:[NSString stringWithFormat:@"分享失败,%@",[error errorDescription]]];
                                 }
                             }];
}
/**
 *	@brief	分享给微信朋友圈
 *
 *	@param 	sender 	事件对象
 */
- (void)shareToWeixinTimelineClickHandler:(UIViewController *)view
{
    //创建分享内容
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"setup_about@2x"  ofType:@"png"];
    id<ISSContent> publishContent = [ShareSDK content:WeChatCONTENT
                                       defaultContent:@""
                                                image:[ShareSDK imageWithPath:imagePath]
                                                title:@"腾云家务"
                                                  url:@"http://www.jiawu8.com"
                                          description:nil
                                            mediaType:SSPublishContentMediaTypeText];
    
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:YES
                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
                                                          viewDelegate:nil
                                               authManagerViewDelegate:_appDelegate.viewDelegate];
    
    //在授权页面中添加关注官方微博
    [authOptions setFollowAccounts:[NSDictionary dictionaryWithObjectsAndKeys:
                                    [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
                                    SHARE_TYPE_NUMBER(ShareTypeSinaWeibo),
                                    [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
                                    SHARE_TYPE_NUMBER(ShareTypeTencentWeibo),
                                    nil]];
    
    //显示分享菜单
    [ShareSDK showShareViewWithType:ShareTypeWeixiTimeline
                          container:nil
                            content:publishContent
                      statusBarTips:NO
                        authOptions:authOptions
                       shareOptions:[ShareSDK defaultShareOptionsWithTitle:nil
                                                           oneKeyShareList:[NSArray defaultOneKeyShareList]
                                                            qqButtonHidden:NO
                                                     wxSessionButtonHidden:NO
                                                    wxTimelineButtonHidden:NO
                                                      showKeyboardOnAppear:NO
                                                         shareViewDelegate:_appDelegate.viewDelegate
                                                       friendsViewDelegate:_appDelegate.viewDelegate
                                                     picViewerViewDelegate:nil]
                             result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                 if (state == SSPublishContentStateBegan) {
                                     [CustomStatusBar showSuccessWithStatus:[NSString stringWithFormat:@"微信朋友圈分享中.."]];
                                 }else if (state  ==  SSPublishContentStateSuccess)
                                 {
                                     NSLocalizedString(@"TEXT_SHARE_SUC", @"发表成功");
                                     [CustomStatusBar showSuccessWithStatus:[NSString stringWithFormat:@"分享成功"]];
                                 }
                                 else if (state  ==  SSPublishContentStateFail)
                                 {
                                     NSLocalizedString(@"TEXT_SHARE_FAI", @"发布失败!%@"),[error errorDescription];
                                     [CustomStatusBar showSuccessWithStatus:[NSString stringWithFormat:@"分享失败,%@",[error errorDescription]]];
                                 }
                             }];
}

@end
