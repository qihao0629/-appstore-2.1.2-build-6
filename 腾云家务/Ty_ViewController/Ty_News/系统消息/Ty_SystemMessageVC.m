//
//  Ty_SystemMessageVC.m
//  腾云家务
//
//  Created by liu on 14-7-12.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_SystemMessageVC.h"
#import "Ty_SystemMessageCell.h"
#import "Ty_Model_SystemMsgInfo.h"


@implementation Ty_SystemMessageVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        _allMessageArr = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)dealloc
{
    _allMessageArr = nil;
}
#pragma mark -- tableView datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _systemMsgBusine.messageArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    Ty_SystemMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (nil == cell)
    {
        cell = [[Ty_SystemMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    Ty_Model_SystemMsgInfo *systemMsgInfo = [_systemMsgBusine.messageArray objectAtIndex:indexPath.row];
    
    [cell setContent:systemMsgInfo];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}
#pragma mark scroll delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint offsetPoint = _tableView.contentOffset;
    NSLog(@"%f",offsetPoint.y);
    if (offsetPoint.y == _tableView.frame.size.height )
    {
       // NSLog(@" daodile");
    }
}

#pragma mark --- 辅助信息-获取时间
- (NSString *)getCurrentTime
{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *current = [dateFormatter stringFromDate:currentDate];
    dateFormatter = nil;
    return current;
}

- (void)viewWillbackAction
{
    [super viewWillbackAction];
    [_systemMsgBusine setSystemMsgIsRead];
}

- (void)popToPreviousController
{
    [_systemMsgBusine setSystemMsgIsRead];
    [self.naviGationController popToRootViewControllerAnimated:YES];
}

#pragma mark view lifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
   [self.view setBackgroundColor:view_BackGroudColor];
  //  self.view.backgroundColor = [UIColor clearColor];
    self.title = @"系统消息";
    
    self.naviGationController.userInteractionEnabled = YES;
    [self.naviGationController.leftBarButton setImage:[UIImage imageNamed:@"Message_back"] forState:UIControlStateNormal];
    [self.naviGationController.leftBarButton addTarget:self action:@selector(popToPreviousController) forControlEvents:UIControlEventTouchUpInside];
    self.naviGationController.leftBarButton.showsTouchWhenHighlighted = YES;
    
    _systemMsgBusine = [[Ty_SystemMessageBusine alloc]init];
    [_systemMsgBusine selectSystemMsgByPageNum:0];
    
    if (_systemMsgBusine.messageArray.count == 0)
    {
        Ty_Model_SystemMsgInfo *systemMsgInfo = [[Ty_Model_SystemMsgInfo alloc]init];
        systemMsgInfo.systemMsgContent = @"嗨，您好！您的订单详情也会以“系统消息”的方式推送给您，离线状态也能查看，请注意接收哦~";
        systemMsgInfo.systemMsg_Time = [self getCurrentTime];
        
        [_systemMsgBusine.messageArray addObject:systemMsgInfo];
        systemMsgInfo = nil;
    }
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width , self.view.frame.size.height - 44  - 20) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    
    [self.view bringSubviewToFront:self.naviGationController];
    
   
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.imageView_background.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

@end
