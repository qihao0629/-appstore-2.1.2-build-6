//
//  JumpToNextDelegate.h
//  腾云家务
//
//  Created by liu on 14-5-30.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JumpToNextDelegate <NSObject>


@optional

- (void)jumpToNextPageWithIndexRow:(int)indexRow;

- (void)deleteGroup:(NSString *)contactGuid;

@end
