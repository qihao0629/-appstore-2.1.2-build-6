//
//  UserCityViewController.m
//  腾云家务
//
//  Created by 艾飞 on 13-11-13.
//  Copyright (c) 2013年 齐 浩. All rights reserved.
//

#import "UserCityViewController.h"
#import "UserAddressDetailViewController.h"
@interface UserCityViewController ()

@end

@implementation UserCityViewController
@synthesize array_areas;
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
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"城市";
    
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
    
    return [array_areas count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * strCell = @"AddressCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:strCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:strCell];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    
    
    cell.textLabel.text = [[array_areas objectAtIndex:indexPath.row] objectForKey:@"city"];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
    UserAddressDetailViewController * userAddress = [[UserAddressDetailViewController alloc]init];
    userAddress.array_area = [[array_areas objectAtIndex:indexPath.row] objectForKey:@"areas"];
    userAddress.str_area = [NSString stringWithFormat:@"%@  %@",_str_areas,[[array_areas objectAtIndex:indexPath.row] objectForKey:@"city"]];
    [self.naviGationController pushViewController:userAddress animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
