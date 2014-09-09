//
//  WithdrawsCashVC.m
//  腾云家务
//
//  Created by liu on 14-7-2.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//  提现页面

#import "WithdrawsCashVC.h"
#import "WithdrawsCashSuccessVC.h"
#import "AppDelegate.h"

@implementation WithdrawsCashCell

@synthesize moneyTextField = _moneyTextField;
@synthesize bankImageView = _bankImageView;
@synthesize bankMsgLabel = _bankMsgLabel;
@synthesize bankNameLabel = _bankNameLabel;
@synthesize arriveDateLabel = _arriveDateLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier indexSection:(NSInteger)indexSection
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        if (indexSection == 0)
        {
            _bankImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
            _bankImageView.backgroundColor = [UIColor clearColor];
            _bankImageView.image = [UIImage imageNamed:@"boc_test"];
            [self addSubview:_bankImageView];
            
            _bankNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 15, 200, 20)];
            _bankNameLabel.backgroundColor = [UIColor clearColor];
            _bankNameLabel.textColor = [UIColor blackColor];
            _bankNameLabel.font = [UIFont boldSystemFontOfSize:16];
            [self addSubview:_bankNameLabel];
            
            _bankMsgLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 35, 200, 20)];
            _bankMsgLabel.backgroundColor = [UIColor clearColor];
            _bankMsgLabel.textColor = [UIColor blackColor];
            _bankMsgLabel.font = [UIFont systemFontOfSize:14];
            [self addSubview:_bankMsgLabel];
            
        }
        else if (indexSection == 1)
        {
            UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 17.5, 150, 20)];
            titleLabel.backgroundColor = [UIColor clearColor];
            titleLabel.textColor = [UIColor blackColor];
            titleLabel.font = [UIFont boldSystemFontOfSize:15];
            titleLabel.text = @"到账日期";
            [self addSubview:titleLabel];
            
            _arriveDateLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 17.5, 200, 20)];
            _arriveDateLabel.backgroundColor = [UIColor clearColor];
            _arriveDateLabel.font = [UIFont systemFontOfSize:14];
            _arriveDateLabel.textColor = [UIColor blackColor];
            _arriveDateLabel.textAlignment = NSTextAlignmentRight;
            [self addSubview:_arriveDateLabel];
            
        }
        else if (indexSection == 2)
        {
            UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 17.5, 150, 20)];
            titleLabel.backgroundColor = [UIColor clearColor];
            titleLabel.textColor = [UIColor blackColor];
            titleLabel.font = [UIFont boldSystemFontOfSize:15];
            titleLabel.text = @"输入金额";
            [self addSubview:titleLabel];
            
            _moneyTextField = [[UITextField alloc]initWithFrame:CGRectMake(100, 17.5, 200, 20)];
            _moneyTextField.backgroundColor = [UIColor clearColor];
            _moneyTextField.placeholder = @"请输入金额（元）";
            _moneyTextField.font = [UIFont systemFontOfSize:14];
            _moneyTextField.textColor = [UIColor blackColor];
            _moneyTextField.textAlignment = NSTextAlignmentRight;
            _moneyTextField.keyboardType = UIKeyboardTypeNumberPad;
            [self addSubview:_moneyTextField];
            
        }
    }
    
    return self;
}

@end


@implementation WithdrawsCashVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nil bundle:nil])
    {
        _dataDic = [[NSMutableDictionary alloc]init];
        
        _cellDic = [[NSMutableDictionary alloc]init];
        
        _moneyStr = @"";
        
    }
    return self;
}

#pragma mark -- table datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = [NSString stringWithFormat:@"cell%d",indexPath.section];
    WithdrawsCashCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell)
    {
        cell = [[WithdrawsCashCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier indexSection:indexPath.section];
        
        [_cellDic setObject:cell forKey:identifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0)
    {
//        cell.imageView.image = [UIImage imageNamed:@"boc_test"];
//        cell.textLabel.text = @"中国银行";
//        cell.detailTextLabel.text = @"尾号1234的企业账号";
    }
    
    cell.bankNameLabel.text = _bankMsgModel.bankName;
    cell.bankMsgLabel.text = [NSString stringWithFormat:@"尾号为%@的企业账户",[_bankMsgModel.bankCardNum substringWithRange:NSMakeRange(_bankMsgModel.bankCardNum.length - 4, 4)]];
    cell.arriveDateLabel.text = @"1~3工作日";
    cell.moneyTextField.delegate = self;
    [cell.bankImageView setImageWithURL:[NSURL URLWithString:_bankMsgModel.bankLogo] placeholderImage:nil];
    
    NSLog(@"%@",_dataDic);
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *tmpView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    tmpView.backgroundColor = [UIColor clearColor];
    
    if (section == 1)
    {
    
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 100, 20)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = [UIFont systemFontOfSize:13];
        titleLabel.text = @"可转出金额：";
        [tmpView addSubview:titleLabel];
        
        
        CGSize size = [titleLabel.text sizeWithFont:[UIFont systemFontOfSize:13] forWidth:100 lineBreakMode:NSLineBreakByWordWrapping];
        
        UILabel *moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(10 + size.width, 5, 200, 20)];
        moneyLabel.backgroundColor = [UIColor clearColor];
        moneyLabel.font = [UIFont systemFontOfSize:13];
        moneyLabel.textColor = [UIColor colorWithRed:31.0/255 green:180.0/255 blue:101.0/255 alpha:1.0];
        moneyLabel.textAlignment = NSTextAlignmentLeft;
        moneyLabel.text = [NSString stringWithFormat:@"%@元",_bankMsgModel.mayTurnOutMoney];
        [tmpView addSubview:moneyLabel];
    }
    
    
    
    return tmpView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat heigth = 0;
    if (indexPath.section == 0)
    {
        heigth = 70;
    }
    else if (indexPath.section == 1)
    {
        heigth = 55;
    }
    else if (indexPath.section == 2)
    {
        heigth = 55;
    }
    
    return heigth;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat height = 12;
    
    if (section == 1)
    {
        return 5;
    }
    else if (section == 2)
    {
        return 20;
    }
    
    return height;
}

#pragma mark -- keyBoard notification
- (void)keyboardWillShow:(NSNotification *)notification
{
    
}
- (void)keyboardWillHide:(NSNotification *)notification
{
    
}

#pragma mark -- textField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark -- 转出
- (void)submitRequest
{
    NSString *identifier = [NSString stringWithFormat:@"cell%d",2];
    WithdrawsCashCell *cell = [_cellDic objectForKey:identifier];
    [cell.moneyTextField resignFirstResponder];
    
    _moneyStr = cell.moneyTextField.text;
    
    [self showProgressHUD:@"正在请求..."];
    [_bankMsgBusin drawMoneyRequest:[NSMutableDictionary dictionaryWithObjectsAndKeys:_bankMsgModel.bankGuid,@"userBankCardGuid",cell.moneyTextField.text,@"withdrawMoney", nil]];
}

- (void)netRequestReceived:(NSNotification *)_notification
{
    NSString *str = [_notification name];
    str = [str substringToIndex:10];
    if ([str isEqualToString:@"GetBankMsg"])
    {
        _dataDic = [_notification object];
        
        if ([[_dataDic objectForKey:@"code"]intValue] == 200)
        {
            [self hideLoadingView];
            _bankMsgModel = [_dataDic objectForKey:@"bankMsg"];
            _tableView.hidden = NO;
            [_tableView reloadData];
        }
        else
        {
            NSLog(@"%@",[_dataDic objectForKey:@"msg"]);
            [self hideLoadingView];
           // [self showNetMessageInView:self.view];
            [self showToastMakeToast:[_dataDic objectForKey:@"msg"] duration:2 position:@"center"];
        }

        
    }
    else
    {
        NSMutableDictionary *dic = [_notification object];
        if ([[dic objectForKey:@"code"] integerValue] == 200)
        {
            
            //提现成功
            [self hideProgressHUD];
            
            WithdrawsCashSuccessVC *withdrawsCashSuccessVC = [[WithdrawsCashSuccessVC alloc]init];
            withdrawsCashSuccessVC.money = _moneyStr;
            NSArray* array = [self.naviGationController.viewControllers subarrayWithRange:NSMakeRange(2, 1)];
            [self removeViewControllersFromWindow:array];
            [self.naviGationController pushViewController:withdrawsCashSuccessVC animated:YES];
            withdrawsCashSuccessVC = nil;
        }
        else
        {
            [self hideProgressHUD];
            [self showToastMakeToast:[dic objectForKey:@"msg"] duration:2 position:@"center"];
            
        }
    }
    
}

#pragma mark -- view lifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"转出申请";
    
    //初始化tableView
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 20 - 40 - 40) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundView = nil;
    
    UIView *tmpView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 70)];
    tmpView.backgroundColor = [UIColor clearColor];
    
    UIButton *drawMoneyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    drawMoneyBtn.frame = CGRectMake(10, 10,300 , 40);
    [drawMoneyBtn setBackgroundImage:[UIImage imageNamed:@"login"] forState:UIControlStateNormal];
    [drawMoneyBtn setTitle: @"确认转出" forState:UIControlStateNormal];
    [drawMoneyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    drawMoneyBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [drawMoneyBtn addTarget:self action:@selector(submitRequest) forControlEvents:UIControlEventTouchUpInside];
    [tmpView addSubview:drawMoneyBtn];
    
    _tableView.tableFooterView = tmpView;
    
    [self.view addSubview:_tableView];
    
    _tableView.hidden = YES;
    
    _bankMsgBusin = [[Ty_BankMsg_Busine alloc]init];
    [_bankMsgBusin getBankMsgRequest];
    [self showLoadingInView:self.view];
    
  //  NSLog(@"%@",self.naviGationController.viewControllers);
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [_tableView deselectRowAtIndexPath:[_tableView indexPathForSelectedRow] animated:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    //[self addNotificationForName:@"GetBankMsg"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netRequestReceived:) name:@"GetBankMsg" object:nil];
    
    [[NSNotificationCenter defaultCenter ] addObserver:self selector:@selector(netRequestReceived:) name:@"DrawsMoney" object:nil];
    
  //  [self addNotificationForName:@"DrawsMoney"];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
