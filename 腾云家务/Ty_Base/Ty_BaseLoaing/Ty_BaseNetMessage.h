//
//  Ty_BaseNetMessage.h
//  腾云家务
//
//  Created by 齐 浩 on 14-5-26.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol Ty_BaseNetMessageDelegate <NSObject>

@required
-(void)loading;

@end

@interface Ty_BaseNetMessage : UIViewController
@property(nonatomic,strong)UILabel * label;
@property(nonatomic,strong)UIButton* button;
@property(nonatomic,strong)id<Ty_BaseNetMessageDelegate>delegate;
@end
