//
//  Ty_Pub_RequirementsVC.m
//  腾云家务
//
//  Created by 齐 浩 on 14-6-7.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_Pub_RequirementsVC.h"
#import "Ty_Pub_ReqSelectCell.h"
#import "Ty_Pub_ReqRightTextCell.h"
#import "Ty_Pub_ReqCinCell.h"
#import "Ty_Pub_RequirementsBusine.h"
#import "Ty_Pub_ReqMemoCell.h"
#import "Ty_Pub_SelectCategoryVC.h"
#import "Ty_Model_XuQiuInfo.h"
#import "Ty_Pub_SelectCityVC.h"
#import "Ty_pub_ReqFinishViewController.h"
//#import "CustomDatePicker.h"
#import "AppDelegate.h"
#import "Ty_CustomDatePicker.h"
#import "Ty_Pub_ReqTextViewCell.h"
#import "Ty_Pub_selectCouponVC.h"

@interface Ty_Pub_RequirementsVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIAlertViewDelegate,UITextViewDelegate>
{
    UITableView* tableview;
    
    UITapGestureRecognizer * tapGesture;
    int textFieldTag;
    UIButton* submitButton;//确认下单按钮
}
@end

@implementation Ty_Pub_RequirementsVC
@synthesize pub_RequirementsBusine;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        pub_RequirementsBusine = [[Ty_Pub_RequirementsBusine alloc]init];
        pub_RequirementsBusine.delegate = self;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(CityChanged) name:@"CityChanged" object:nil];
    }
    return self;
}
#pragma mark ----键盘弹出和落下
-(void)keyboardWillShow:(NSNotification *)notification
{
//    [super keyboardWillShow:notification];
    [tableview addGestureRecognizer:tapGesture];
    NSDictionary *info = [notification userInfo];
    NSValue   *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.25];
    [tableview setFrame:CGRectMake(10, 0, tableview.frame.size.width, self.view.frame.size.height-64-keyboardSize.height)];
//    if (IS_IPHONE_5) {
//        
//    }else{
//        switch (textFieldTag) {
//            case 100:
//                if (tableview.frame.size.height-304<keyboardSize.height) {
//                    [tableview setFrame:CGRectMake(10, -keyboardSize.height+tableview.frame.size.height-304, tableview.frame.size.width, tableview.frame.size.height)];
//                }
//                break;
//            case 200:
//                if (tableview.frame.size.height-348<keyboardSize.height) {
//                    [tableview setFrame:CGRectMake(10, -keyboardSize.height+tableview.frame.size.height-348, tableview.frame.size.width, tableview.frame.size.height)];
//                }
//                break;
//            case 1000:
//                if (tableview.frame.size.height-250<keyboardSize.height) {
//                    [tableview setFrame:CGRectMake(10, -keyboardSize.height+tableview.frame.size.height-250, tableview.frame.size.width, tableview.frame.size.height)];
//                }
//                break;
//            default:
//                break;
//        }
//    }
//    [UIView commitAnimations];
}
-(void)keyboardWillHide:(NSNotification *)notification
{
//    [super keyboardWillHide:notification];
    [tableview removeGestureRecognizer:tapGesture];
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.25];
    [tableview setFrame:CGRectMake(10, 0, tableview.frame.size.width, self.view.frame.size.height-64-49)];
//    [UIView commitAnimations];
}

#pragma mark ----键盘下落方法
-(void)dismissKeyBoard
{
    ResignFirstResponder
}
#pragma mark ----ViewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(10, 0, self.view.frame.size.width-20, self.view.frame.size.height-64-49) style:UITableViewStylePlain];
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.dataSource = self;
    tableview.delegate = self;
    tableview.showsVerticalScrollIndicator = NO;
    [tableview setBackgroundColor:view_BackGroudColor];
    
    [self.view addSubview:tableview];
    
    submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitButton setBackgroundImage:[UIImage imageNamed:@"pub_reqactionButton"] forState:UIControlStateNormal];
    //    [submitButton setImage:[UIImage imageNamed:@"blueSubmit"] forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(Submit) forControlEvents:UIControlEventTouchUpInside];
    [submitButton setFrame:CGRectMake(0, 0, 100, 30)];
    [submitButton setCenter:CGPointMake(self.imageView_background.frame.size.width/2, self.imageView_background.frame.size.height/2)];
    [submitButton setTitle:@"确认下单" forState:UIControlStateNormal];

    [self.imageView_background addSubview:submitButton];
    
    pub_RequirementsBusine.xuqiuInfo.province = USERPROVINCE;
    pub_RequirementsBusine.xuqiuInfo.city = USERCITY;
    if (USERAREA != nil&&![USERAREA isEqualToString:@""]) {
        pub_RequirementsBusine.xuqiuInfo.area = USERAREA;
    }
//    if (USERREGION != nil&&![USERREGION isEqualToString:@""]) {
//        pub_RequirementsBusine.xuqiuInfo.region = USERREGION;
//    }
    if (USERADDRESSDETAIL != nil&&![USERADDRESSDETAIL isEqualToString:@""]) {
        pub_RequirementsBusine.xuqiuInfo.addressDetail = USERADDRESSDETAIL;
    }
    
    
    tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyBoard)];
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [tableview reloadData];
}
#pragma mark ----当要返回的时候。触发方法
-(void)viewWillbackAction
{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"信息尚未保存发布，是否退出？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    [alert setTag:1000];
    [alert show];
}
-(void)backClick
{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"信息尚未保存发布，是否退出？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    [alert setTag:1000];
    [alert show];
}
#pragma mark ----通知修改选择城市和地址
-(void)CityChanged
{
    pub_RequirementsBusine.xuqiuInfo.province = USERPROVINCE;
    pub_RequirementsBusine.xuqiuInfo.city = USERCITY;
    if (USERAREA != nil&&![USERAREA isEqualToString:@""]) {
        pub_RequirementsBusine.xuqiuInfo.area = USERAREA;
    }else{
        pub_RequirementsBusine.xuqiuInfo.area = @"";
    }
    //    if (USERREGION != nil&&![USERREGION isEqualToString:@""]) {
    //        appointMentBusine.xuqiuInfo.region = USERREGION;
    //    }
    if (USERADDRESSDETAIL != nil&&![USERADDRESSDETAIL isEqualToString:@""]) {
        pub_RequirementsBusine.xuqiuInfo.addressDetail = USERADDRESSDETAIL;
    }else{
        pub_RequirementsBusine.xuqiuInfo.addressDetail = @"";
    }
    [tableview reloadData];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (alertView.tag) {
        case 1000:
            switch (buttonIndex) {
                case 0:
                    
                    break;
                case 1:
                    [self.naviGationController popViewControllerAnimated:YES];
                    break;
                default:
                    break;
            }
            break;
            
        default:
            break;
    }
}
#pragma mark ----确认下单
-(void)Submit
{
    [self dismissKeyBoard];
    [self showLoadingInView:self.view];
    submitButton.userInteractionEnabled = NO;
    self.view.userInteractionEnabled = NO;
    submitButton.alpha = 0.5f;
    [pub_RequirementsBusine pub_Requirements];
}
#pragma mark ----回调
-(void)netRequestReceived:(NSNotification *)_notification
{
    [self hideLoadingView];
    submitButton.userInteractionEnabled = YES;
    self.view.userInteractionEnabled = YES;
    submitButton.alpha = 1.0f;
    if ([[[_notification object] objectForKey:@"code"]isEqualToString:REQUESTFAIL]) {
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:nil message:[[_notification object] objectForKey:@"message"] delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alert show];
    }else if([[[_notification object] objectForKey:@"code"] isEqualToString:REQUESTSUCCESS]){
        [self pushFinishViewFaBu];
        
        AppDelegateViewController *appDelegateVC = (AppDelegateViewController *)[[UIApplication sharedApplication].delegate window].rootViewController;
        
        [appDelegateVC setOrderTabBarIcon:1];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowTopTipNotification" object:nil];

    }
}
#pragma mark ----发布成功
-(void)pushFinishViewFaBu
{
    Ty_pub_ReqFinishViewController* finishView = [[Ty_pub_ReqFinishViewController alloc]init];
    [finishView.finishLabel setText:@"您的抢单已成功发布！"];
    finishView.xuqiuInfo = pub_RequirementsBusine.xuqiuInfo;
    [finishView.contentsLabel setText:@"服务商正在应征和报价中，请稍候..."];
    [finishView.finishImage setImage:JWImageName(@"pub_qiangdanimage")];
    [finishView.AciontButton setTitle:@"查看我的抢单详细" forState:UIControlStateNormal];
    finishView.title = @"发抢单";
    TYBaseView* viewController = [[appDelegate appTabBarController] appNavigation];
    NSRange range;
    range.length = self.naviGationController.viewControllers.count-1;
    range.location = 1;
    NSArray* array = [self.naviGationController.viewControllers subarrayWithRange:range];
    [self removeViewControllersFromWindow:array];
    [viewController.naviGationController pushViewController:finishView animated:YES];

}
#pragma mark ----tableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 4;
            break;
        case 1:
            return 2;
            break;
        case 2:
            return 5;
            break;
        case 3:
            return 2;
            break;
        case 4:
            return 2;
            break;
        default:
            return 0;
            break;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* CellSelect = @"CellSelect";
    static NSString* CellText = @"CellText";
    static NSString* CellTextView = @"CellTextView";
    static NSString* CellCin = @"CellCin";
    static NSString* CellMemo = @"CellMemo";
    Ty_Pub_ReqSelectCell * cellSelect = [tableView dequeueReusableCellWithIdentifier:CellSelect];
    if(cellSelect == nil)
    {
        cellSelect = [[Ty_Pub_ReqSelectCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellSelect];
        cellSelect.backgroundColor = [UIColor whiteColor];
        cellSelect.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cellSelect setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    Ty_Pub_ReqRightTextCell * rightTextFieldCell  = [tableView dequeueReusableCellWithIdentifier:CellText];
    if (rightTextFieldCell  ==  nil)
    {
        rightTextFieldCell = [[Ty_Pub_ReqRightTextCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellText];
        rightTextFieldCell.backgroundColor = [UIColor whiteColor];
        rightTextFieldCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    Ty_Pub_ReqTextViewCell * TextViewCell  = [tableView dequeueReusableCellWithIdentifier:CellTextView];
    if (TextViewCell  ==  nil)
    {
        TextViewCell = [[Ty_Pub_ReqTextViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellTextView];
        TextViewCell.backgroundColor = [UIColor whiteColor];
        TextViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    Ty_Pub_ReqCinCell * cincell = [tableView dequeueReusableCellWithIdentifier:CellCin];
    if(cincell == nil)
    {
        cincell = [[Ty_Pub_ReqCinCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellCin];
        cincell.backgroundColor = [UIColor whiteColor];
        //                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cincell.textLabel setFont:FONT14_BOLDSYSTEM];
        cincell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    Ty_Pub_ReqMemoCell * cellMemo  = [tableview dequeueReusableCellWithIdentifier:CellMemo];
    if (cellMemo == nil) {
        cellMemo = [[Ty_Pub_ReqMemoCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellMemo];
        cellMemo.selectionStyle = UITableViewCellSelectionStyleNone;
        cellMemo.backgroundColor = [UIColor whiteColor];
    }

    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                cellSelect.leftLabel.text = @"类别";
                cellSelect.detailLabel.text = [pub_RequirementsBusine.xuqiuInfo.workName isEqualToString:@""] ?  @"请选择服务分类" :  pub_RequirementsBusine.xuqiuInfo.workName;
                cellSelect.detailLabel.textColor = [pub_RequirementsBusine.xuqiuInfo.workName isEqualToString:@""] ? text_morenGrayColor:text_blackColor;
                return cellSelect;
                break;
            case 1:
                cellSelect.leftLabel.text = @"服务时间";
                cellSelect.detailLabel.text = [pub_RequirementsBusine.xuqiuInfo.startTime isEqualToString:@""] ?  @"请选择预约时间" :  pub_RequirementsBusine.xuqiuInfo.startTime;
                cellSelect.detailLabel.textColor = [pub_RequirementsBusine.xuqiuInfo.startTime isEqualToString:@""]  ? text_morenGrayColor:text_blackColor;
                return cellSelect;
                break;
            case 2:
                cincell.textLabel.text = @"工作量";
                //            cincell.imageView.image = [UIImage imageNamed:@"xingxing"];
                [cincell.textfield setPlaceholder:@"请输入工作量"];
                [cincell.textfield setKeyboardType:UIKeyboardTypeNumberPad];
                [cincell.textfield setTag:1000];
                if ([pub_RequirementsBusine.xuqiuInfo.workName isEqualToString:@""]) {
                    cincell.detailTextLabel.text = @"小时";
                }else{
                    cincell.detailTextLabel.text = [[[NSDictionary alloc] initWithContentsOfFile:WorkUnitTypefileForPath] objectForKey:pub_RequirementsBusine.xuqiuInfo.workName];
                }
                //                int i = cincell.detailTextLabel.text.length;
                //                [cincell.textfield setFrame:CGRectMake(90, 5, 185-14*i, 34)];
                [cincell.textfield setDelegate:self];
                [cincell.textfield setText:pub_RequirementsBusine.xuqiuInfo.workAmount];
                return cincell;
                break;
            case 3:
                TextViewCell.leftLabel.text=@"备注";
                [TextViewCell.helpLabel setText:@"点击填写备注信息（选填）"];
                [TextViewCell.detailTextView setDelegate:self];
                [TextViewCell.detailTextView setTag:1000];
                if ([pub_RequirementsBusine.xuqiuInfo.ask_Other isEqualToString:@""]) {
                    TextViewCell.helpLabel.hidden=NO;
                }else{
                    TextViewCell.helpLabel.hidden=YES;
                }
                [TextViewCell.detailTextView setText:pub_RequirementsBusine.xuqiuInfo.ask_Other];
                return TextViewCell;
                break;
            default:
                break;
        }
        
    }else if (indexPath.section == 1){
        switch (indexPath.row) {
            case 0:
                cellSelect.leftLabel.text = @"优惠券";
                cellSelect.detailLabel.text = [pub_RequirementsBusine.xuqiuInfo.usedCouponInfo.couponTitle isEqualToString:@""] ?  @"请选择优惠券" :  pub_RequirementsBusine.xuqiuInfo.usedCouponInfo.couponTitle;
                cellSelect.detailLabel.textColor = [pub_RequirementsBusine.xuqiuInfo.usedCouponInfo.couponTitle isEqualToString:@""]  ? text_morenGrayColor:text_blackColor;
                return cellSelect;
            case 1:
                [cellMemo.memoLabel setFont:FONT12_BOLDSYSTEM];
                cellMemo.memoLabel.text=@"友情提示：使用优惠券的抢单只发送给该券相关的服务商！";
                [cellMemo setmemoHeight];
                return cellMemo;
            default:
            
                break;
        }
        
    }else if(indexPath.section == 2){
        switch (indexPath.row) {
            case 0:
                cellSelect.leftLabel.text = @"所在区域";
                cellSelect.detailLabel.text = [pub_RequirementsBusine.xuqiuInfo.area isEqualToString:@""] ?  @"请选择所在区域" :[NSString stringWithFormat:@"%@  %@",pub_RequirementsBusine.xuqiuInfo.area,pub_RequirementsBusine.xuqiuInfo.region];
                cellSelect.detailLabel.textColor = [pub_RequirementsBusine.xuqiuInfo.area isEqualToString:@""]  ? text_morenGrayColor:text_blackColor;
                return cellSelect;
                break;
            case 1:
                TextViewCell.leftLabel.text=@"服务地址";
                [TextViewCell.helpLabel setText:@"至少5字,不超过50字。"];
                [TextViewCell.detailTextView setDelegate:self];
                [TextViewCell.detailTextView setTag:2000];
                if ([pub_RequirementsBusine.xuqiuInfo.addressDetail isEqualToString:@""]) {
                    TextViewCell.helpLabel.hidden=NO;
                }else{
                    TextViewCell.helpLabel.hidden=YES;
                }
                [TextViewCell.detailTextView setText:pub_RequirementsBusine.xuqiuInfo.addressDetail];
                return TextViewCell;
                break;
            case 2:
                rightTextFieldCell.leftLabel.text  = @"联系人";
                [rightTextFieldCell.detailTextField setPlaceholder:@"请填写联系人"];
                [rightTextFieldCell.detailTextField setDelegate:self];
                [rightTextFieldCell.detailTextField setTag:100];
                [rightTextFieldCell.detailTextField setText: pub_RequirementsBusine.xuqiuInfo.contact];
                return rightTextFieldCell;
                break;
            case 3:
                rightTextFieldCell.leftLabel.text  = @"手机号";
                [rightTextFieldCell.detailTextField setPlaceholder:@"请填写联系人手机号"];
                [rightTextFieldCell.detailTextField setDelegate:self];
                [rightTextFieldCell.detailTextField setTag:200];
                [rightTextFieldCell.detailTextField setText: pub_RequirementsBusine.xuqiuInfo.contactPhone];
                return rightTextFieldCell;
                
                break;
            case 4:
                [cellMemo.memoLabel setFont:FONT14_BOLDSYSTEM];
                cellMemo.memoLabel.text = @"我们不会把您的联系方式透露给抢单服务商如果您有疑问也可以直接与我们客服联系！";
                [cellMemo setmemoHeight];
                return cellMemo;
                break;
            default:
                break;
        }
    }else if (indexPath.section == 3){
        switch (indexPath.row) {
            
            default:
                break;
        }
    }else if (indexPath.section == 4){
        switch (indexPath.row) {
            
            
                
            default:
                break;
        }
    }
    return cellSelect;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 3:
                    [cell setBackgroundView:[[UIImageView alloc] initWithImage:[JWImageName(@"i_setupcellbg") stretchableImageWithLeftCapWidth:5 topCapHeight:5]]];
                    break;
                default:
                    [cell setBackgroundView:[[UIImageView alloc] initWithImage:[JWImageName(@"i_setupcellbgtop")stretchableImageWithLeftCapWidth:5 topCapHeight:5]]];
                    break;
            }
            break;
        case 1:
            switch (indexPath.row) {
                case 1:
                    [cell setBackgroundView:[[UIImageView alloc] initWithImage:[JWImageName(@"i_setupcellbg")stretchableImageWithLeftCapWidth:5 topCapHeight:5]]];
                    break;
                default:
                    [cell setBackgroundView:[[UIImageView alloc] initWithImage:[JWImageName(@"i_setupcellbgtop")stretchableImageWithLeftCapWidth:5 topCapHeight:5]]];
                    break;
            }
            break;
        case 2:
            switch (indexPath.row) {
                case 4:
                    [cell setBackgroundView:[[UIImageView alloc] initWithImage:[JWImageName(@"i_setupcellbg")stretchableImageWithLeftCapWidth:5 topCapHeight:5]]];
                    break;
                default:
                    [cell setBackgroundView:[[UIImageView alloc] initWithImage:[JWImageName(@"i_setupcellbgtop")stretchableImageWithLeftCapWidth:5 topCapHeight:5]]];
                    break;
            }
            break;
        case 3:
            switch (indexPath.row) {
                case 1:
                    [cell setBackgroundView:[[UIImageView alloc] initWithImage:[JWImageName(@"i_setupcellbg")stretchableImageWithLeftCapWidth:5 topCapHeight:5]]];
                    break;
                default:
                    [cell setBackgroundView:[[UIImageView alloc] initWithImage:[JWImageName(@"i_setupcellbgtop")stretchableImageWithLeftCapWidth:5 topCapHeight:5]]];
                    break;
            }
            break;
        case 4:
            switch (indexPath.row) {
                case 1:
                    [cell setBackgroundView:[[UIImageView alloc] initWithImage:[JWImageName(@"i_setupcellbg")stretchableImageWithLeftCapWidth:5 topCapHeight:5]]];
                    break;
                default:
                    [cell setBackgroundView:[[UIImageView alloc] initWithImage:[JWImageName(@"i_setupcellbgtop")stretchableImageWithLeftCapWidth:5 topCapHeight:5]]];
                    break;
            }
            break;
        default:
            break;
    }
    
}


#pragma mark ----tableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 3) {
            UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
            return cell.frame.size.height;
        }
    }else if(indexPath.section==1){
        if (indexPath.row==1) {
            UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
            return cell.frame.size.height;
        }
    }else if(indexPath.section == 2){
        if (indexPath.row == 4 || indexPath.row == 1) {
            UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
            return cell.frame.size.height;
        }
    }
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 10;
            break;
        default:
            return 0;
            break;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width,10)];
    switch (section) {
        case 0:
            return view;
            break;
            
        default:
            return nil;
            break;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 10)];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self dismissKeyBoard];
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                {
                    Ty_Pub_SelectCategoryVC* create = [[Ty_Pub_SelectCategoryVC alloc]init];
                    create.xuqiuInfo = pub_RequirementsBusine.xuqiuInfo;
                    create.title = @"服务类型";
                    [self.naviGationController pushViewController:create animated:YES];
                }
                    break;
                case 1:
                {
                    Ty_CustomDatePicker *customDatePicker = [[Ty_CustomDatePicker alloc]initWithTitle:@"选择服务时间" delegate:self];
                    [customDatePicker setTag:100];
                    [customDatePicker showInView:self.view];
                }
                    break;
                default:
                    break;
            }
            break;
        case 1:
            switch (indexPath.row) {
                case 0:{
                    if ([pub_RequirementsBusine.xuqiuInfo.workGuid isEqualToString:@""]) {
                        [self showToastMakeToast:@"请选择服务类型" duration:1.0f position:@"bottom"];
                    }else{
                        Ty_Pub_selectCouponVC * pub_selectCoupon = [[Ty_Pub_selectCouponVC alloc] init];
                        pub_selectCoupon.selectCouponBusine.xuqiuInfo = pub_RequirementsBusine.xuqiuInfo;
                        [self.naviGationController pushViewController:pub_selectCoupon animated:YES];
                    }
                    break;
                }
                default:
                    break;
            }
            break;
        case 2:
            switch (indexPath.row) {
                case 0:
                {
                    Ty_Pub_SelectCityVC* create = [[Ty_Pub_SelectCityVC alloc]init];
                    create.xuqiuInfo = pub_RequirementsBusine.xuqiuInfo;
                    create.title = @"选择区";
                    [self.naviGationController pushViewController:create animated:YES];
                }
                    break;
                default:
                    break;
            }
            break;
        default:
            break;
    }
    
    
}
#pragma mark ----textField代理
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    textFieldTag = textField.tag;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField.tag == 100){
        pub_RequirementsBusine.xuqiuInfo.contact = textField.text;
    }else if(textField.tag == 200){
        pub_RequirementsBusine.xuqiuInfo.contactPhone = textField.text;
    }else if(textField.tag == 1000){
        pub_RequirementsBusine.xuqiuInfo.workAmount = textField.text;
    }
    [tableview removeGestureRecognizer:tapGesture];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField.tag == 100){
        
    }else if(textField.tag == 200){
        int length = textField.text.length;
        if (length >= 11  &&  string.length >0)
        {
            return  NO;
        }
        NSCharacterSet *cs;
        cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
        NSString *filtered  = 
        [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basic = [string isEqualToString:filtered];
        return basic;
    }else if(textField.tag == 1000){
        int length = textField.text.length;
        if (length >= 5  &&  string.length >0)
        {
            return  NO;
        }
        NSCharacterSet *cs;
        cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
        NSString *filtered  = 
        [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basic = [string isEqualToString:filtered];
        if (basic) {
           pub_RequirementsBusine.xuqiuInfo.workAmount = [NSString stringWithFormat:@"%@%@",textField.text,string];
        }
        return basic;
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]) {
        ResignFirstResponder
        return NO;
    }
    if ([text isEqualToString:@" "]) {
        return NO;
    }
    if (range.location == 0 && [text isEqualToString:@""] && range.length <= 1 && textView.text.length<=1) {
        
        for(UIView* helpLabel in textView.subviews)
        {
            if ([helpLabel isKindOfClass:[UILabel class]] && helpLabel.tag == 1000) {
                helpLabel.hidden=NO;
            }
        }
    }else{
        for(UIView* helpLabel in textView.subviews)
        {
            if ([helpLabel isKindOfClass:[UILabel class]] && helpLabel.tag == 1000) {
                helpLabel.hidden=YES;
            }
        }
    }
    if (range.location>50&&range.length==0) {
        return NO;
    }else{
        
        return YES;
    }
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.tag == 2000) {
        pub_RequirementsBusine.xuqiuInfo.addressDetail=textView.text;
        [tableview removeGestureRecognizer:tapGesture];
    }else if(textView.tag == 1000){
        pub_RequirementsBusine.xuqiuInfo.ask_Other=textView.text;
        [tableview removeGestureRecognizer:tapGesture];
    }
   
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if(actionSheet.tag == 100){
        Ty_CustomDatePicker *datepicker = (Ty_CustomDatePicker *)actionSheet;
        NSDateFormatter* dateformatter = [[NSDateFormatter alloc]init];
        
        if (buttonIndex == 1) {
            pub_RequirementsBusine.xuqiuInfo.startTime = [NSString stringWithFormat:@"%@",datepicker.customDate.dateString];
            [tableview reloadData];
        }
    }
    if (actionSheet.tag == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark ----- Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
