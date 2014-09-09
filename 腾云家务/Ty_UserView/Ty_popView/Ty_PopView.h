//
//  PopView.h
//  腾云家务
//
//  Created by 齐 浩 on 14-3-16.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ty_PopViewData.h"
enum Ty_PopViewStyle {
    PopViewStyleOne = 1,//单排
    
};
@class Ty_PopView;


@protocol Ty_PopViewDelegate <NSObject>

-(void)PopView:(Ty_PopView* )_PopView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end

@interface Ty_PopView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UITableView* tableview;
    UIView* backView;
    UIView* secondBackView;
    enum Ty_PopViewStyle popStyle;
    UITapGestureRecognizer *tapGesture;
}
@property(nonatomic,copy)NSArray* array;
@property(nonatomic,strong)id<Ty_PopViewDelegate>delegate;
@property(nonatomic,strong)Ty_PopViewData* popData;

-(void)showInView:(UIView *)view;
-(void)dismissKeyBoard;
-(void)setPopViewStyle:(enum Ty_PopViewStyle)_popViewStyle;
- (id)initWithFrame:(CGRect)frame dataArray:(NSArray*)_array;

@end


