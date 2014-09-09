//
//  MessageListTableView.h
//  腾云家务
//
//  Created by liu on 14-5-29.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JumpToNextDelegate.h"

@interface MessageListTableView : UITableView<UITableViewDataSource,UITableViewDelegate>
{
    
}

@property (nonatomic,assign) id<JumpToNextDelegate>jumpDelegate;

@property (nonatomic,strong) NSMutableArray *allMessageArr;

@end


