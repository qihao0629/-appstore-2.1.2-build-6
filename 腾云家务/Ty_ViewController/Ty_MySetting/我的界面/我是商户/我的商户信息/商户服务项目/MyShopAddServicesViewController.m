//
//  MyShopAddServicesViewController.m
//  腾云家务
//
//  Created by 艾飞 on 14-4-11.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "MyShopAddServicesViewController.h"
#import "MyShopCell.h"
#import "MyAddServicesCell.h"
#import "My_ShopAddWork_busine.h"//处理
@interface MyShopAddServicesViewController ()

@end

@implementation MyShopAddServicesViewController
@synthesize workName;
@synthesize _tableView;
@synthesize WorklistModel;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        WorklistModel = [[Ty_Model_WorkListInfo alloc]init];
        
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];

    if(IS_IPHONE_5 ){
        _tableView.center = CGPointMake(_tableView.center.x, 227.5);
    }else{
        _tableView.center = CGPointMake(_tableView.center.x,183.5);
        
    }
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"UnitPList" ofType:@"plist"];
    dic_price = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    NSLog(@"%@",dic_price);
    
    self.title = @"新增服务项目";
    
    UIButton * but_add_ok = [UIButton buttonWithType:UIButtonTypeCustom];
    but_add_ok.frame = CGRectMake(110, 9, 100, 30);
    [but_add_ok setBackgroundImage:[UIImage imageNamed:@"i_setupbutaddok.png"] forState:UIControlStateNormal];
    [but_add_ok setTitle:@"新增项目" forState:UIControlStateNormal];
    but_add_ok.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [but_add_ok setTitleColor:[UIColor colorWithRed:244.0/255.0 green:29.0/255.0 blue:31.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [but_add_ok addTarget:self action:@selector(but_add_ok:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageView_background addSubview:but_add_ok];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 0, 300,SCREEN_HEIGHT - 20- 44- 49 )style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = NO;
    _tableView.scrollEnabled = NO;
    _tableView.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0];
    _tableView.backgroundView = nil;
    [self.view addSubview:_tableView];
    
    [self addNotificationForName:@"MyshopAddworkList"];
}

#pragma mark - 网络_回调
-(void)netRequestReceived:(NSNotification *)_notification{
    [self hideLoadingView];
    if ([[_notification object] isKindOfClass:[NSString class]] && [[_notification object] isEqualToString:@"fail"]) {
        
        [self alertViewTitle:@"提示" message:@"网络连接暂时不可用，请稍后再试"];
        
    }else {
        if ([[[_notification object] objectForKey:@"code"]intValue] == 200) {
            
            [self.myShopAddSkill loadDataGetSkill];
            [self.naviGationController popToViewController:[self.naviGationController.viewControllers objectAtIndex:1] animated:YES];
            
        }else {
            
            [self alertViewTitle:@"提示" message:[[_notification object] objectForKey:@"msg"]];
            
        }
        
    }
    
}


#pragma mark - 输入完成
-(void)but_add_ok:(UIButton *)but{

    if ([WorklistModel.workName isEqualToString:@"日常保洁"]||[WorklistModel.workName isEqualToString:@"空调清洗"]) {
        
        UITextField * textMoney = (UITextField *)[self.view viewWithTag:1005];
        if (ISNULLSTR(textMoney.text)) {
            
            [self alertViewTitle:@"提示" message:@"请输入价格"];
            
        }else{
            
            WorklistModel.postRealSalary = textMoney.text;
            [[My_ShopAddWork_busine alloc]loadDataAddWork:WorklistModel];
            ResignFirstResponder;
        }
        
    }else{
  
        UITextField * textMoneyMin = (UITextField *)[self.view viewWithTag:1003];
        UITextField * textMoneyMax = (UITextField *)[self.view viewWithTag:1004];

        if (ISNULLSTR(textMoneyMax.text)|| ISNULLSTR(textMoneyMin.text)) {
            
            [self alertViewTitle:@"提示" message:@"请输入价格"];

            
        }else{
            if ([textMoneyMin.text intValue] > [textMoneyMax.text intValue]) {
                [self alertViewTitle:@"提示" message:@"最低价格不可高于最高价格"];

            }
            WorklistModel.postSalary = [NSString stringWithFormat:@"%@-%@",textMoneyMin.text,textMoneyMax.text];
            [[My_ShopAddWork_busine alloc]loadDataAddWork:WorklistModel];
            ResignFirstResponder;
        }
    }

}

#pragma mark - UITableView Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
 
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * strID = @"myCell";
    MyAddServicesCell * cell = [tableView dequeueReusableCellWithIdentifier:strID];
    if (cell == nil) {
        cell = [[MyAddServicesCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID];
        
    }
    cell.textContent.delegate = self;
    cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    cell.textContent.returnKeyType = UIReturnKeyDone;
    cell.textContentMax.delegate = self;
    cell.textContentMax.returnKeyType = UIReturnKeyDone;
    cell.lablexian.hidden = YES;
    cell.lableMoney.hidden = YES;
    cell.textContentMax.hidden = YES;
    cell.textContent.enabled = YES;
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    //界面
    if (IOS7) {
        
        cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"i_setupcellbgtop.png"]];

        if (indexPath.row == 1) {
            
            cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"i_setupcellbg.png"]];

        }
        
       }else{
        //非ios 7
        cell.textContent.frame = CGRectMake(90, 12, 180, 20);
    }
    
    if (indexPath.row == 0) {
        
        cell.lableName.text = @"服务项目:";
        cell.textContent.placeholder = @"请选择服务项目";
        cell.selectionStyle =  UITableViewCellSelectionStyleGray;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textContent.enabled = NO;
        cell.textContent.tag = 1001;
        cell.textContent.text = WorklistModel.workName;
        
    }else{
    
        
        if ([WorklistModel.workName isEqualToString:@"日常保洁"]||[WorklistModel.workName isEqualToString:@"空调清洗"]) {
            
            cell.lableName.text = @"服务价格:";
            cell.textContent.placeholder = @"请输入价格";
            cell.textContent.keyboardType = UIKeyboardTypeASCIICapable;
            cell.textContent.tag = 1005;
            cell.lableMoney.text = [NSString stringWithFormat:@"元/%@",[WorkUnitDic objectForKey:WorklistModel.workName]];
            cell.lableMoney.hidden = NO;


        }else{
        
            cell.lableName.text = @"服务价格:";
            cell.textContent.placeholder = @"最低价格";
            cell.textContent.frame = CGRectMake(90, 12, 60, 20);
            cell.textContentMax.placeholder = @"最高价格";
            cell.textContentMax.hidden = NO;
            cell.lablexian.hidden = NO;
            cell.lableMoney.hidden = NO;
            cell.textContent.keyboardType = UIKeyboardTypeASCIICapable;
            cell.textContentMax.keyboardType = UIKeyboardTypeASCIICapable;
            cell.textContentMax.tag = 1004;
            cell.textContent.tag = 1003;
            cell.textContent.textAlignment = UITextAlignmentCenter;
            cell.lableMoney.text = [NSString stringWithFormat:@"元/%@",[WorkUnitDic objectForKey:WorklistModel.workName]];

        }

    }
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
    
        
    }
    
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField.tag == 1003 || textField.tag == 1004 || textField.tag == 1005) {
        if (range.location >= 5) {
            return NO;
        }
    }
    
    NSCharacterSet *cs;
    if (textField.tag == 1003 || textField.tag == 1004 || textField.tag == 1005) {
        
        cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basicTest = [string isEqualToString:filtered];
        if(!basicTest)
        {
            
            return NO;
        }
    }
    
    //其他的类型不需要检测，直接写入
    return YES;
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    ResignFirstResponder;
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
