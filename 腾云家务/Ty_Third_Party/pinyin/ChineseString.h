//
//  ChineseString.h
//  腾云家务
//
//  Created by 齐 浩 on 14-5-14.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "pinyin.h"

@interface ChineseString : NSObject
@property(retain,nonatomic)NSString *string;
@property(retain,nonatomic)NSString *pinYin;

//-----  返回tableview右方indexArray
+(NSMutableArray*)IndexArray:(NSArray*)stringArr;

//-----  返回联系人
+(NSMutableArray*)LetterSortArray:(NSArray*)stringArr;
@end