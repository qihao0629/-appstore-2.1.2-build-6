//
//  DrawMoneyRecordVC.h
//  腾云家务
//
//  Created by liu on 14-7-3.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ty_DrawMoney_Busine.h"

@interface DrawMoneyRecordCell : UITableViewCell

@property (nonatomic,strong) UILabel *dateLabel;

@property (nonatomic,strong) UILabel *moneyLabel;

@property (nonatomic,strong) UILabel *statusLabel;

@end

@interface DrawMoneyRecordVC : TYBaseView<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    
    NSMutableArray *_allDataArr;
    
    Ty_DrawMoney_Busine *_drawMoneyBusine;
}

@end
