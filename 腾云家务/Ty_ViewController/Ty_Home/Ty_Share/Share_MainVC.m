//
//  Share_MainVC.m
//  腾云家务
//
//  Created by 齐 浩 on 14-5-6.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Share_MainVC.h"
#import <MessageUI/MessageUI.h>
#import<MessageUI/MFMailComposeViewController.h>

#define SMSCONTENT [NSString stringWithFormat:@"您的朋友%@，邀请您注册成为腾云家务的会员，现在注册即可获得腾云家务送上的好礼一份,腾云家务让您的居家生活更为便捷。下载包链接:http://www.jiawu8.com",MyLoginUserRealName]


@interface Share_MainVC ()<MFMessageComposeViewControllerDelegate>

@end

@implementation Share_MainVC

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
}
-(void)viewDidAppear:(BOOL)animated
{
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
    [self loadUI];
    
	// Do any additional setup after loading the view.
}
-(void)loadData
{
    shareAction = [[Share_MainAction alloc]init];
}
-(void)loadUI
{
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-69-49) style:UITableViewStylePlain ];
    UIImageView* imageBackGroud = [[UIImageView alloc]initWithFrame:tableview.frame];
    [imageBackGroud setBackgroundColor:view_BackGroudColor];
    tableview.backgroundView = imageBackGroud;
    tableview.separatorColor = view_BackGroudColor;
    tableview.delegate = self;
    tableview.dataSource = self;
    UIView* headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableview.frame.size.width, 70)];
    
    UILabel* headLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, tableview.frame.size.width-20, 70)];
    [headLabel setBackgroundColor:[UIColor clearColor]];
    [headLabel setText:shareAction.titleString];
    [headLabel setTextColor:[UIColor redColor]];
    [headLabel setFont:FONT15_BOLDSYSTEM];
    headLabel.numberOfLines = 3;

    [headView addSubview:headLabel];
//    tableview.tableHeaderView = headView;
    
    
    UILabel* footLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, self.view.frame.size.height-49-30, tableview.frame.size.width-20, 30)];
    [footLabel setBackgroundColor:[UIColor clearColor]];
//    [footLabel setText:[NSString stringWithFormat:@"我的邀请码：%@",USERINVITATIONCODE]];
    [footLabel setTextColor:[UIColor grayColor]];
    [footLabel setTextAlignment:NSTextAlignmentRight];
    [footLabel setFont:FONT15_BOLDSYSTEM];
    
    [self.view addSubview:tableview];
    [self.view addSubview:footLabel];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return shareAction.DataArray.count;
            break;
        case 1:
            return 2;
            break;
        default:
            return 0;
            break;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* Cell = @"Cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:Cell];
    if(cell  == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:Cell];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    switch (indexPath.section) {
        case 0:
            cell.imageView.image = JWImageName([[shareAction.DataArray objectAtIndex:indexPath.row] objectForKey:@"titleImage"]);
            cell.textLabel.text = [[shareAction.DataArray objectAtIndex:indexPath.row] objectForKey:@"titleName"];
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"已邀请的好友";
                    break;
                case 1:
                    cell.textLabel.text = @"通过邀请获得的礼品";
                    break;
                default:
                    break;
            }
            break;
        default:
            break;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableview deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
//                   [shareAction shareBySMSClickHandler:self.view];
                    [self showSMSPicker];
                    break;
                case 1:
                    [shareAction shareToSinaWeiboClickHandler:self];
                    break;
                case 2:
                    [shareAction shareToWeixinSessionClickHandler:self];
                    break;
                case 3:
                    [shareAction shareToWeixinTimelineClickHandler:self];
                    break;
                default:
                    break;
            }
            break;
        default:
            break;
    }

}
-(void)showSMSPicker{
    Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));
    
    if (messageClass !=  nil) {
        // Check whether the current device is configured for sending SMS messages
        if ([messageClass canSendText]) {
            [self displaySMSComposerSheet];
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"设备不支持短信功能" message:@"" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            
        }
    }
    else {
    }
}
-(void)displaySMSComposerSheet
{
    MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
    picker.messageComposeDelegate = self;
    NSString *smsBody = [NSString stringWithFormat:@"%@",SMSCONTENT];
    picker.body = smsBody;
    [self presentModalViewController:picker animated:YES];
}
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    if (result   ==  MessageComposeResultCancelled) {
        NSLog(@"cancel");
        
    }else if (result   ==  MessageComposeResultSent){
        NSLog(@"sent");
        
    }else {
        NSLog(@"fail");
        
    }
    [controller dismissModalViewControllerAnimated:YES];
    [self setNavigationBarHidden:NO animated:NO];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
