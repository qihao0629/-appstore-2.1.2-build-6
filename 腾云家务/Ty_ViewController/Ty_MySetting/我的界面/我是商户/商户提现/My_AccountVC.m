//
//  My_AccountVC.m
//  腾云家务
//
//  Created by liu on 14-7-1.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "My_AccountVC.h"
#import "WithdrawsCashVC.h"
#import "TradingRecordVC.h"
#import "DrawMoneyRecordVC.h"

@implementation My_AccountVC

@synthesize accountMoney = _accountMoney;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nil bundle:nil])
    {
        _accountMoney = @"";
    }
    return self;
}

#pragma mark ---- tableView datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    if (indexPath.row == 0)
    {
        cell.textLabel.text = @"交易记录";
    }
    else if (indexPath.row == 1)
    {
        cell.textLabel.text = @"转出（提现）记录";
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *tmpView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 35)];
    tmpView.backgroundColor = [UIColor clearColor];
    
    UILabel *moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 300, 20)];
    moneyLabel.backgroundColor = [UIColor clearColor];
    moneyLabel.font = [UIFont boldSystemFontOfSize:14];
    moneyLabel.textColor = [UIColor redColor];
    moneyLabel.text = _accountMoney;
    moneyLabel.textAlignment = NSTextAlignmentRight;
    
    CGSize size = [moneyLabel.text sizeWithFont:[UIFont boldSystemFontOfSize:14] forWidth:200 lineBreakMode:NSLineBreakByWordWrapping];
    
    moneyLabel.frame = CGRectMake(300 - size.width - 2, 10, size.width + 2, 20);
    [tmpView addSubview:moneyLabel];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(300 - size.width - 2 - 100, 10,100, 20)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"账户金额 ：";
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textAlignment = NSTextAlignmentRight;
    [tmpView addSubview:titleLabel];
    
    return tmpView;
}



#pragma mark -- tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        TradingRecordVC *tradingRecordVC = [[TradingRecordVC alloc]init];
        [self.naviGationController pushViewController:tradingRecordVC animated:YES];
        tradingRecordVC = nil;
    }
    else if (indexPath.row == 1)
    {
        DrawMoneyRecordVC *drawMoneyVC = [[DrawMoneyRecordVC alloc]init];
        [self.naviGationController pushViewController:drawMoneyVC animated:YES];
        drawMoneyVC = nil;
    }
}

#pragma mark ---提现操作
- (void)withdrawsCashAction
{
    WithdrawsCashVC *withdrawsCashVC = [[WithdrawsCashVC alloc]init];
    [self.naviGationController pushViewController:withdrawsCashVC animated:YES];
    withdrawsCashVC = nil;
}

#pragma mark -- view lifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"账户金额";
    
    //初始化tableView
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 44 - 44 - 20) style:UITableViewStyleGrouped];
    _tableView.backgroundView = nil;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    
    
    UIView *tmpView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 70)];
    tmpView.backgroundColor = [UIColor clearColor];
    
    UIButton *drawMoneyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    drawMoneyBtn.frame = CGRectMake(10, 10,300 , 40);
    [drawMoneyBtn setBackgroundImage:[UIImage imageNamed:@"login"] forState:UIControlStateNormal];
    [drawMoneyBtn setTitle: @"申请转出（提现）" forState:UIControlStateNormal];
    [drawMoneyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    drawMoneyBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [drawMoneyBtn addTarget:self action:@selector(withdrawsCashAction) forControlEvents:UIControlEventTouchUpInside];
    [tmpView addSubview:drawMoneyBtn];
    
    _tableView.tableFooterView = tmpView;
    
    [self.view addSubview:_tableView];
    
    tmpView = nil;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [_tableView deselectRowAtIndexPath:[_tableView indexPathForSelectedRow] animated:YES];
}

@end
