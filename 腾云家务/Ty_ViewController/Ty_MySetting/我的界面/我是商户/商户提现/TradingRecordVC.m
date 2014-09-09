//
//  TradingRecordVC.m
//  腾云家务
//
//  Created by liu on 14-7-3.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "TradingRecordVC.h"

@implementation TradingRecordCell

@synthesize serviceLabel = _serviceLabel;
@synthesize dateLabel = _dateLabel;
@synthesize moneyLabel = _moneyLabel;
@synthesize modeOfPaymentLabel = _modeOfPaymentLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        _serviceLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 100, 20)];
        _serviceLabel.backgroundColor = [UIColor whiteColor];
        _serviceLabel.textColor = [UIColor blackColor];
        _serviceLabel.font = [UIFont boldSystemFontOfSize:15];
        [self.contentView addSubview:_serviceLabel];
        
        _dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 35, 100, 20)];
        _dateLabel.backgroundColor = [UIColor clearColor];
        _dateLabel.textColor = [UIColor blackColor];
        _dateLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_dateLabel];
        
        _moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(200, 10, 100, 20)];
        _moneyLabel.backgroundColor = [UIColor clearColor];
        _moneyLabel.textColor = [UIColor redColor];
        _moneyLabel.font = [UIFont boldSystemFontOfSize:15];
        _moneyLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_moneyLabel];
        
        _modeOfPaymentLabel = [[UILabel alloc]initWithFrame:CGRectMake(200, 35, 100, 20)];
        _modeOfPaymentLabel.backgroundColor = [UIColor clearColor];
        _modeOfPaymentLabel.textColor = [UIColor blackColor];
        _modeOfPaymentLabel.font = [UIFont systemFontOfSize:13];
        _modeOfPaymentLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_modeOfPaymentLabel];
    }
    
    return self;
}

@end

@implementation TradingRecordVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nil bundle:nil])
    {
        _allDataArr = [[NSMutableArray alloc]init];
    }
    
    return self;
}

#pragma mark -- tableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _allDataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    TradingRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell)
    {
        cell = [[TradingRecordCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    NSMutableDictionary *dic = [_allDataArr objectAtIndex:indexPath.row];
    
    cell.serviceLabel.text = [dic objectForKey:@"workName"];
    cell.dateLabel.text = [dic objectForKey:@"requirementPayTime"];
    cell.moneyLabel.text = [NSString stringWithFormat:@"%@元",[dic objectForKey:@"requirementDealMoney"]];
    cell.modeOfPaymentLabel.text = [[dic objectForKey:@"requirementPayWay"] integerValue] == 1 ? @"在线支付" : @"现金支付";
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -- tableView delegate

-(void)netRequestReceived:(NSNotification *)_notification
{
    NSDictionary *dic = [_notification object];
    
    if ([[dic objectForKey:@"code"]integerValue] == 200)
    {
        _allDataArr = [dic objectForKey:@"rows"];
        [self hideLoadingView];
        _tableView.hidden = NO;
        [_tableView reloadData];
    }
    else
    {
        [self hideLoadingView];
        [self showToastMakeToast:[dic objectForKey:@"msg"] duration:2 position:@"center"];
    }
}
#pragma mark -- view lifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"交易记录";
    
    //tableView
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 20 - 44 - 44) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.hidden = YES;
    
    [self showLoadingInView:self.view];
    
    _tradingRecordBusine = [[Ty_TradingRecord_Busine alloc]init];
    [_tradingRecordBusine getTradingRecord];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netRequestReceived:) name:@"GetTradingRecord" object:nil];
  //  [self addNotificationForName:@"GetTradingRecord"];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

@end
