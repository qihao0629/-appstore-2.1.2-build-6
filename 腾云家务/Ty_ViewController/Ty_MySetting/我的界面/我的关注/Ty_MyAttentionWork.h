//
//  Ty_MyAttentionWork.h
//  腾云家务
//
//  Created by Xu Zhao on 14-6-9.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ty_MyAttentionWork_Busine.h"
#import "Ty_MyAttentionWorkTableViewCell.h"


@interface Ty_MyAttentionWork : TYBaseView<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *arrWorkName;
    NSArray *arrWorkKind;
    
    Ty_MyAttentionWork_Busine *myAttentionWord_busine;
}
@property(nonatomic,strong)UITableView *tableview;
@end
