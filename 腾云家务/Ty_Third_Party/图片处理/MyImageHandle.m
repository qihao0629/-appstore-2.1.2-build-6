//
//  MyImageHandle.m
//  腾云家务
//
//  Created by 艾飞 on 14/7/8.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "MyImageHandle.h"

@implementation MyImageHandle


#pragma mark - 图片处理
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

+ (NSString *)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName type:(NSString *)type userGuid:(NSString *)userGuid
{
    NSData* imageData = UIImagePNGRepresentation(tempImage);
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    // Now we get the full path to the file
    //    NSMutableString * childWorkName  = [NSMutableString stringWithString:[tempStr stringByAppendingString:[[self.arForTable objectAtIndex:indexPath.row] valueForKey:@"workName"]]];
    //    NSString * str_type = [NSString stringWithString:[@"/" stringByAppendingString:type]];
    
    NSString * tempStr = [NSString stringWithString:[@"/" stringByAppendingString:[userGuid stringByAppendingString:type]]];
    
    NSMutableString * mutableStr = [NSMutableString stringWithString:[documentsDirectory stringByAppendingString:tempStr]];
    NSString * tempString  = [[NSMutableString alloc] init];
    tempString = [mutableStr stringByAppendingString:imageName];
    // and then we write it out
    [imageData writeToFile:tempString atomically:NO];
    return tempString;
}
+ (NSString *)saveSmallImage:(UIImage *)tempImage WithName:(NSString *)imageName type:(NSString *)type userGuid:(NSString *)userGuid
{
    NSData* imageData = UIImagePNGRepresentation(tempImage);
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    // Now we get the full path to the file
    //    NSMutableString * childWorkName  = [NSMutableString stringWithString:[tempStr stringByAppendingString:[[self.arForTable objectAtIndex:indexPath.row] valueForKey:@"workName"]]];
    NSString * str = [NSString stringWithString:[@"/" stringByAppendingString:@"Small"]];
    //    NSString * str_type = [NSString stringWithString:[@"/" stringByAppendingString:type]];
    NSString * tempStr = [NSString stringWithString:[[str stringByAppendingString:userGuid] stringByAppendingString:type]];
    
    NSMutableString * mutableStr = [NSMutableString stringWithString:[documentsDirectory stringByAppendingString:tempStr]];
    NSString * tempString  = [[NSMutableString alloc] init];
    tempString = [mutableStr stringByAppendingString:imageName];
    // and then we write it out
    [imageData writeToFile:tempString atomically:NO];
    return tempString;
}

@end
