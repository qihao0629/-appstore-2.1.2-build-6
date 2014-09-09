//
//  DrawMoneyRecordVC.m
//  腾云家务
//
//  Created by liu on 14-7-3.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "DrawMoneyRecordVC.h"

@implementation DrawMoneyRecordCell

@synthesize moneyLabel = _moneyLabel;
@synthesize dateLabel = _dateLabel;
@synthesize statusLabel = _statusLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        _dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, 150, 20)];
        _dateLabel.backgroundColor = [UIColor clearColor];
        _dateLabel.textColor = [UIColor blackColor];
        _dateLabel.font = [UIFont boldSystemFontOfSize:15];
        [self.contentView addSubview:_dateLabel];
        
        _moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 10, 200, 20)];
        _moneyLabel.backgroundColor = [UIColor clearColor];
        _moneyLabel.textColor = [UIColor colorWithRed:93.0/255 green:180.0/255 blue:111.0/255 alpha:1.0];
        _moneyLabel.font = [UIFont boldSystemFontOfSize:15];
        _moneyLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_moneyLabel];
        
        _statusLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 30, 200, 20)];
        _statusLabel.backgroundColor = [UIColor clearColor];
        _statusLabel.textColor = [UIColor blackColor];
        _statusLabel.font = [UIFont systemFontOfSize:14];
        _statusLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_statusLabel];
    }
    
    return self;
}

@end

@implementation DrawMoneyRecordVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nil bundle:nil])
    {
        _allDataArr = [[NSMutableArray alloc]init];
    }
    return self;
}

#pragma mark -- tableView datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _allDataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    DrawMoneyRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell)
    {
        cell = [[DrawMoneyRecordCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    NSMutableDictionary *dic = [_allDataArr objectAtIndex:indexPath.row];
    
    cell.moneyLabel.text = [NSString stringWithFormat:@"%@元",[dic objectForKey:@"withdrawMoney"]];
    cell.dateLabel.text = [dic objectForKey:@"withdrawTime"];
    cell.statusLabel.text = [[dic objectForKey:@"withdrawState"] integerValue] == 1 ? @"办理中" : @"转出成功";
    
    
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

- (void)netRequestReceived:(NSNotification *)_notification
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
    self.title = @"提现记录";
    
    //tableView
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 20 - 44 - 44) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.hidden = YES;
    
    [self showLoadingInView:self.view];
    
    _drawMoneyBusine = [[Ty_DrawMoney_Busine alloc]init];
    [_drawMoneyBusine getDrawMoneyRecord];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self addNotificationForName:@"GetDrawRecord"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netRequestReceived:) name:@"GetDrawRecord" object:nil];
}

@end
