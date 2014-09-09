//
//  WithdrawsCashVC.h
//  腾云家务
//
//  Created by liu on 14-7-2.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ty_BankMsg_Busine.h"
#import "My_BankMsgModel.h"



@interface WithdrawsCashCell : UITableViewCell

@property (nonatomic,strong) UIImageView *bankImageView;

@property (nonatomic,strong) UILabel *bankNameLabel;

@property (nonatomic,strong) UILabel *bankMsgLabel;

@property (nonatomic,strong) UILabel *arriveDateLabel;

@property (nonatomic,strong) UITextField *moneyTextField;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier indexSection:(NSInteger)indexSection;

@end


@interface WithdrawsCashVC : TYBaseView<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UITableView *_tableView;
    
    Ty_BankMsg_Busine *_bankMsgBusin;
    
    NSMutableDictionary *_dataDic;
    
    My_BankMsgModel *_bankMsgModel;
    
    NSMutableDictionary *_cellDic;
    
    NSString *_moneyStr;
}

@end
