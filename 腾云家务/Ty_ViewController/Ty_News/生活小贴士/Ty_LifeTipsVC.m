//
//  Ty_LifeTipsVC.m
//  腾云家务
//
//  Created by liu on 14-8-6.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_LifeTipsVC.h"
#import "Ty_Model_LifeTipsInfo.h"
#import "LifeTipsCell.h"

@implementation Ty_LifeTipsVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nil bundle:nil])
    {
        _lifeTipsBusine = [[Ty_LifeTipsBusine alloc]init];
    }
    
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _lifeTipsBusine.lifeTipsArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    LifeTipsCell *cell = [_tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell)
    {
        cell = [[LifeTipsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.selected = NO;
    
    Ty_Model_LifeTipsInfo *lifeTipInfo = [_lifeTipsBusine.lifeTipsArr objectAtIndex:indexPath.row];
    [cell setContent:lifeTipInfo];
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

#pragma mark -- 
- (void)getLifeTipMessage:(NSNotification *)object
{
    [_lifeTipsBusine.lifeTipsArr removeAllObjects];
    [_lifeTipsBusine getLifeMessageDataByPageNum:0];
    [_tableView reloadData];
}

- (void)viewWillbackAction
{
    [super viewWillbackAction];
    [_lifeTipsBusine setAllLifeTipsStatusRead];
}


//- (void)viewWillbackAction
//{
//    [super viewWillbackAction];
//    
//}
- (void)popToPreviousController
{
    [_lifeTipsBusine setAllLifeTipsStatusRead];
    [self.naviGationController popToRootViewControllerAnimated:YES];
}

#pragma mark -- view lifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = view_BackGroudColor;
    self.title = @"生活小贴士";
    
    self.naviGationController.userInteractionEnabled = YES;
    [self.naviGationController.leftBarButton setImage:[UIImage imageNamed:@"Message_back"] forState:UIControlStateNormal];
    [self.naviGationController.leftBarButton addTarget:self action:@selector(popToPreviousController) forControlEvents:UIControlEventTouchUpInside];
    self.naviGationController.leftBarButton.showsTouchWhenHighlighted = YES;
    
    [_lifeTipsBusine getLifeMessageDataByPageNum:0];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width , self.view.frame.size.height - 44  - 20) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    
    
    
    [_lifeTipsBusine getLifeDataFromNet];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getLifeTipMessage:) name:@"GetLifeTipMessage" object:nil];
    self.imageView_background.hidden = YES;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

@end
