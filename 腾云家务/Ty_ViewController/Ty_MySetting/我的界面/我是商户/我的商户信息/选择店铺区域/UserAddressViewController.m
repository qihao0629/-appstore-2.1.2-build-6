//
//  UserAddressViewController.m
//  腾云家务
//
//  Created by 艾飞 on 13-11-13.
//  Copyright (c) 2013年 齐 浩. All rights reserved.
//

#import "UserAddressViewController.h"
#import "UserCityViewController.h"
@interface UserAddressViewController ()

@end

@implementation UserAddressViewController

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
    self.title = @"省市";

    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"];
    array_city = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
//    NSLog(@"array_city: %@", array_city);//直接打印数据。

    
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
    
    return array_city.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * strCell = @"AddressCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:strCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:strCell];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    
    cell.textLabel.text = [[array_city objectAtIndex:indexPath.row] objectForKey:@"state"];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UserCityViewController * city = [[UserCityViewController alloc]init];
    city.array_areas = [[array_city objectAtIndex:indexPath.row] objectForKey:@"cities"];
    city.str_areas = [[array_city objectAtIndex:indexPath.row] objectForKey:@"state"];
    [self.naviGationController pushViewController:city animated:YES];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
