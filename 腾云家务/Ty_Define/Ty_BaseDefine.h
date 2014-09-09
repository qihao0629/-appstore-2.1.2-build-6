//
//  Ty_BaseDefine.h
//  腾云家务
//
//  Created by 齐 浩 on 14-5-22.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#ifndef _____Ty_BaseDefine_h
#define _____Ty_BaseDefine_h


/**屏幕宽度与高度*/
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

/**view 起点坐标X与Y 
 *以及宽度与高度
 */
#define TYFRAMEX(view) view.frame.origin.x
#define TYFRAMEY(view) view.frame.origin.y
#define TYFRAMEWIDTH(view) view.frame.size.width
#define TYFRAMEHEIGHT(view) view.frame.size.height

/**设备系统版本号*/
#define CurrentSystemVersion ([[UIDevice currentDevice] systemVersion])

/**appstore链接*/
#define EvaluateWebLink [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id717545126"]

/**判断是否系统版本大于7.0系统  大于或等于7.0返回YES 否则返回NO*/
#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? YES : NO)

/**获取导航viewcontroller池*/
#define TYNAVIGATION [TYNavigationTool shareNav]
#define TYJPush [Ty_News_Busine_Jpush shareJpush]

#define appDelegate (AppDelegate *)[UIApplication sharedApplication].delegate
/**基类网络回调通知标示名字*/

#define SETNotificationMark(name) [NSString stringWithFormat:@"%@%d",name,[TYNotificationTool setNotificationMark]]
#define GETNotificationMark(name) [NSString stringWithFormat:@"%@%d",name,[TYNotificationTool getNotificationMark]]
#define PostNetNotification(id,name) [[NSNotificationCenter defaultCenter] postNotificationName:GETNotificationMark(name) object:id]
#define PostNetDelegate(id,name) self.delegate!= nil?[self.delegate netRequestReceived:[NSNotification notificationWithName:name object:id]]:NSLog(@"%@",name)

/**网络判断回调参数*/
#define REQUESTSUCCESS @"success"
#define REQUESTFAIL    @"fail"

/**沙盒路径*/
#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
/**工种价格单位plist路径*/
#define WorkUnitTypefileForPath   [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0] stringByAppendingPathComponent:@"UnitPList.plist"]
/**开放工种plist路径*/
#define AddWorkTypefileForPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0] stringByAppendingPathComponent:@"AddworkType.plist"]
/**所有工种plist路径*/
#define WorkTypefileForPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0] stringByAppendingPathComponent:@"workType.plist"]

/**取得价格字典*/
#define WorkUnitDic [NSDictionary dictionaryWithContentsOfFile:WorkUnitTypefileForPath]

/**判断空字符串*/
#define ISNULLARRAY(arr) (arr == nil || (NSObject *)arr == [NSNull null] || arr.count == 0)
#define ISNULL(obj) (obj == nil || (NSObject *)obj == [NSNull null])
#define ISNULLSTR(str) (str == nil || (NSObject *)str == [NSNull null] || str.length == 0)

/**获取功能内部的图片，名称为imageName*/
#define JWImageName(imageName)  [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@@2x",imageName] ofType:@"png"]]

#define XUNFEI_APPID @"53bdeee9"


#define NUMBERS @"0123456789"

/**电话统计*/

#define PhoneBusine [Ty_PhoneBusine sharePhone]


#define DIC_SEX  [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"男",@"0",\
@"女",@"1",\
@"不限",@"-1",nil]

#define DIC_SEX2  [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"0",@"男",\
@"1",@"女",\
@"-1",@"不限",nil]

#define DIC_AGE  [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"20~30岁",@"0",\
@"30~40岁",@"1",\
@"40~50岁",@"2",\
@"50岁以上",@"3",\
@"不限",@"-1", nil]

#define DIC_AGE2  [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"0",@"20~30岁",\
@"1",@"30~40岁",\
@"2",@"40~50岁",\
@"3",@"50岁以上",\
@"-1",@"不限", nil]

#define DIC_WORKEXPRIENCE [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"一年以内",@"0",\
@"一年以内",@"1",\
@"一至三年",@"2",\
@"三至五年",@"3",\
@"五年以上",@"4",\
@"不限", @"-1",nil]

//学历
#define ARRAY_EDUCATION [NSArray arrayWithObjects:@"初中或小学",@"中专或职高", @"大专",@"大本",@"硕士", @"博士", @"出国留学",nil]

#define DIC_EDUCATION  [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"初中或小学",@"0",\
@"中专或职高",@"1",\
@"大专",@"2",\
@"大本",@"3",\
@"硕士",@"4",\
@"博士",@"5",\
@"出国留学",@"6",\
@"不限", @"-1",nil]

#define DIC_EDUCATION2  [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"0",@"初中或小学",\
@"1",@"中专或职高",\
@"2",@"大专",\
@"3",@"大本",\
@"4",@"硕士",\
@"5",@"博士",\
@"6",@"出国留学",\
@"-1", @"不限",nil]

#define DIC_USERTYPE  [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"不限",@"-1",\
@"只显示商铺",@"0",\
@"只显示签约员工",@"1",\
@"只显示个人",@"2",nil]

#define DIC_USERTYPE2  [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"-1",@"不限",\
@"0",@"只显示商铺",\
@"1",@"只显示签约员工",\
@"2",@"只显示个人",nil]


#endif