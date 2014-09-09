//
//  Share_MainVC.h
//  腾云家务
//
//  Created by 齐 浩 on 14-5-6.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Share_MainAction.h"
@interface Share_MainVC : TYBaseView<UITableViewDataSource,UITableViewDelegate>
{
    UITableView* tableview;
    Share_MainAction * shareAction;
}
@end
