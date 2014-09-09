//
//  CustomDate.h
//  腾云家务
//
//  Created by 齐 浩 on 13-10-11.
//  Copyright (c) 2013年 齐 浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomDate : NSObject
@property(nonatomic,copy)NSDate* date;
@property(nonatomic,copy)NSString *dayStr;
@property(nonatomic,copy)NSString *hourStr;
@property(nonatomic,copy)NSString *minStr;
@property(nonatomic,copy)NSMutableString *dateString;
@end
