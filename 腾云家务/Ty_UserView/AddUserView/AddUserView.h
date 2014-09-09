//
//  AddUserView.h
//  appspring
//
//  Created by 齐 浩 on 13-12-16.
//  Copyright (c) 2013年 齐 浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CAppButton.h"

@class AddUserView;

@protocol AddUserViewDataSource <NSObject>
@required
-(void)AddUserView:(AddUserView *)_AddUserView getCAppButton:(CAppButton *)_appButton numberOftag:(int)_Number;//加载对象

@end
@protocol AddUserViewDelegate <NSObject>
@required
-(int)NumberOfView:(AddUserView*)_AddUserView;//设置一共多少对象
-(int)NumberOfRows:(AddUserView*)_AddUserView;//设置一行有多少对象
-(int)MaxNumberOfView:(AddUserView*)_AddUserView;//设置最大有多少个对象

-(void)AddUserView:(AddUserView*)_AddUserView selectViewOfTag:(int)_Number;//点击某个对象
@optional
-(void)AddUserView:(AddUserView*)_AddUserView moveViewOfTag:(int)_Number;//编辑某个对象

@end

@interface AddUserView : UIView
{
    int number;
    int numberOfrows;
    int maxnumber;
    BOOL m_bTransform;
    UILongPressGestureRecognizer *lpgr;
    UITapGestureRecognizer *tapGestureTel2;
}
@property(nonatomic,retain)id<AddUserViewDataSource>datasource;
@property(nonatomic,retain)id<AddUserViewDelegate>delegate;
@property(nonatomic,assign)BOOL editing;//可编辑
-(void)reloadData;
@end
