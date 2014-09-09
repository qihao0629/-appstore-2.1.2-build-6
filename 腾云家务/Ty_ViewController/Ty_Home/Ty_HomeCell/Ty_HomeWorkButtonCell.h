//
//  Ty_HomeWorkButtonCell.h
//  腾云家务
//
//  Created by 齐 浩 on 14-7-1.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ty_HomeWorkButton.h"

@protocol Ty_HomeWorkButtonCellDelegate <NSObject>

-(void)click_homeWorkButton:(Ty_HomeWorkButton*)sender;

@end

@interface Ty_HomeWorkButtonCell : UITableViewCell
@property(nonatomic,strong)Ty_HomeWorkButton* firstButton;
@property(nonatomic,strong)Ty_HomeWorkButton* secondButton;
@property(nonatomic,strong)Ty_HomeWorkButton* thirdButton;
@property(nonatomic,strong)Ty_HomeWorkButton* fourthButton;
@property(nonatomic,assign)id<Ty_HomeWorkButtonCellDelegate>delegate;
-(void)loadData:(NSArray*)_dataArray;
@end
