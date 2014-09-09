//
//  TradingRecordVC.h
//  腾云家务
//
//  Created by liu on 14-7-3.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ty_TradingRecord_Busine.h"

@interface TradingRecordCell : UITableViewCell

@property (nonatomic,strong) UILabel *serviceLabel;

@property (nonatomic,strong) UILabel *dateLabel;

@property (nonatomic,strong) UILabel *moneyLabel;

@property (nonatomic,strong) UILabel *modeOfPaymentLabel;

@end

@interface TradingRecordVC : TYBaseView<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    
    NSMutableArray *_allDataArr;
    
    Ty_TradingRecord_Busine *_tradingRecordBusine;
}

@end
