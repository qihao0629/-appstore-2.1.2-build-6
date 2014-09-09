//
//  Guid.h
//  腾云家务
//
//  Created by 则卷同学 on 13-10-12.
//  Copyright (c) 2013年 齐 浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Guid : NSObject

- (NSString *) getGuid;

+ (Guid *)share;

@end
