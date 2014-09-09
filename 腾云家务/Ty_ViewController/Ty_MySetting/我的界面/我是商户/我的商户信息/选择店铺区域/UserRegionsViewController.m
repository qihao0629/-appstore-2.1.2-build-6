//
//  UserRegionsViewController.m
//  腾云家务
//
//  Created by 艾飞 on 14-1-6.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "UserRegionsViewController.h"

@interface UserRegionsViewController ()

@end

@implementation UserRegionsViewController
@synthesize array_city;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"区域";

    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainBounds.size.width, MainBounds.size.height-49-20-44) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //    _tableView.scrollEnabled = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView = nil;
    [self.view addSubview:_tableView];
    

}

#pragma mark ---- UITableView Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [array_city count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * strCell = @"AddressCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:strCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:strCell];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    
    cell.textLabel.text = [array_city objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSMutableDictionary * dicDefaults = [[NSMutableDictionary alloc]init];
    [dicDefaults setDictionary:MyShopInforDefaults];
    [dicDefaults setObject:[NSString stringWithFormat:@"%@  %@",_str_city,[array_city objectAtIndex:indexPath.row]] forKey:@"detailIntermediaryArea"];
    [[NSUserDefaults standardUserDefaults]setObject:dicDefaults forKey:@"MyShopInformation"];
    
    [self.naviGationController popToViewController:[self.naviGationController.viewControllers objectAtIndex:1] animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
