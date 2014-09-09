//
//  Guid.m
//  腾云家务
//
//  Created by 则卷同学 on 13-10-12.
//  Copyright (c) 2013年 齐 浩. All rights reserved.
//

#import "Guid.h"

@implementation Guid

static Guid *shareGuid = nil;

+ (Guid *)share
{
    if (shareGuid == nil)
    {
        shareGuid = [[Guid alloc]init];
    }
    
    return shareGuid;
}

- (id)init
{
    if (self = [super init])
    {
        
    }
    
    return self;
}

- (NSString *) getGuid

{
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef str_ref = CFUUIDCreateString(NULL, uuid_ref);
    CFRelease(uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString *)str_ref];
    CFRelease(str_ref);
    
    uuid = [uuid stringByReplacingOccurrencesOfString:@"-" withString:@""];
    return uuid;
}

@end
