//
//  TY_BaseBusine.m
//  腾云家务
//
//  Created by 齐 浩 on 14-8-20.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "TY_BaseBusine.h"

@implementation TY_BaseBusine
@synthesize delegate;

-(void)netRequestReceived:(NSNotification *)_notification
{

}
-(void)dealloc
{
    delegate = nil;
}
@end
