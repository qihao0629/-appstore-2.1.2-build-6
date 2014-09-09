//
//  HomeWorkTypeView.h
//  腾云家务
//
//  Created by 齐 浩 on 14-1-14.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HomeWorkTypeViewDelegate <NSObject>

-(void)HomeWorkTypeViewButtonClick:(id)sender;

@end
@interface Ty_HomeWorkTypeView : UIView
@property(nonatomic,strong)id<HomeWorkTypeViewDelegate>delegate;
@property(nonatomic,assign)int numberForRows;
@property(nonatomic,assign)int heightRows;
@property(nonatomic,assign)float size_Juli;
@property(nonatomic,assign)float size_Wite;
-(void)setData:(NSMutableArray *)_arr;
@end
