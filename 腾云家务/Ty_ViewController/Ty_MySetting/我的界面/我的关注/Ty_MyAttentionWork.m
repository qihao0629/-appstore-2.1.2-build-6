//
//  Ty_MyAttentionWork.m
//  腾云家务
//
//  Created by Xu Zhao on 14-6-9.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_MyAttentionWork.h"
#import "Ty_MyAttentionView.h"
@interface Ty_MyAttentionWork ()
@end

@implementation Ty_MyAttentionWork
@synthesize tableview;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setNavigationBarHidden:YES animated:NO];
    [self.imageView_background setHidden:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //UIColor * color = [UIColor colorWithPatternImage:[UIImage imageNamed:@"titleBar.png"]];
    //[self.view setBackgroundColor:color];
    [self.view setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];

    arrWorkName = [[NSArray alloc]init];
    arrWorkKind = [[NSArray alloc]init];
    
    myAttentionWord_busine = [[Ty_MyAttentionWork_Busine alloc]init];
    NSMutableArray *arrWork = [[NSMutableArray alloc]initWithArray:[myAttentionWord_busine getWorkName]];
    arrWorkName = [[NSArray alloc]initWithArray:[arrWork objectAtIndex:0]];
    arrWorkKind = [[NSArray alloc]initWithArray:[arrWork objectAtIndex:1]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushUserDetail:) name:@"pushUserDetail" object:nil];
    
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-20) style:UITableViewStylePlain];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Contact_workBackground.png"]];
    tableview.backgroundView = imageView;
    tableview.delegate=self;
    tableview.dataSource=self;
    [self.view addSubview:tableview];
    
    Ty_MyAttentionView *myAttention = [[Ty_MyAttentionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    myAttention.superVC = self;
    [self.view addSubview:myAttention];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrWorkName.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *Cell=@"cell";
    Ty_MyAttentionWorkTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:Cell];
    if(cell==nil)
    {
        cell = [[Ty_MyAttentionWorkTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellone"];
    }
    
    if(indexPath.row == 0 || [[arrWorkKind objectAtIndex:indexPath.row]intValue] == 0)//全部
    {
        [cell.labWorkName setFrame:CGRectMake(0, 0, 240, 50)];
        [cell.labWorkName setTextColor:[UIColor blackColor]];
    }
    else
    {
        [cell.labWorkName setFrame:CGRectMake(10, 0, 220, 50)];
        [cell.labWorkName setTextColor:[UIColor blackColor]];
    }
    [cell.labWorkName setText:[NSString stringWithFormat:@"    %@",[arrWorkName objectAtIndex:indexPath.row]]];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:[UIColor clearColor]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [myAttentionWord_busine getMyAttentionFromSql:indexPath.row];
    
    [tableview reloadData];
}

-(void)pushUserDetail:(NSNotification*)_notification
{
    [self.naviGationController pushViewController:[_notification object] animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
