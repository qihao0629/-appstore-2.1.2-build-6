//
//  Ty_WebViewVC.h
//  腾云家务
//
//  Created by 齐 浩 on 14-7-3.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "TYBaseView.h"
enum Ty_WebloadType
{
    Ty_WebloadNet,
    Ty_WebloadLocal
};
@interface Ty_WebViewVC : TYBaseView

/**传入参数*/
@property(nonatomic,strong)NSString* url;//web链接地址

@property(nonatomic,strong)NSString *filePath;//本地地址
/*end*/

+(id)shareWebView:(enum Ty_WebloadType)_ty_WebloadType;
@end
