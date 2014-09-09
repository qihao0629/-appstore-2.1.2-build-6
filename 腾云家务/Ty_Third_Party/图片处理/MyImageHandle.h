//
//  MyImageHandle.h
//  腾云家务
//
//  Created by 艾飞 on 14/7/8.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyImageHandle : NSObject
/**图片处理*/
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;
/**正常图片*/
+ (NSString *)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName type:(NSString *)type userGuid:(NSString *)userGuid;
/**小图片*/
+ (NSString *)saveSmallImage:(UIImage *)tempImage WithName:(NSString *)imageName type:(NSString *)type userGuid:(NSString *)userGuid;

@end
