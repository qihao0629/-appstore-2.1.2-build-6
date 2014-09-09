//
//  Ty_HomeSearchVC.m
//  腾云家务
//
//  Created by 齐 浩 on 14-7-7.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_HomeSearchVC.h"
#import "Ty_HomeFind_ShopCell.h"
#import "Ty_HomeFind_PersonalCell.h"
#import "Ty_Model_ServiceObject.h"
#import "RefreshView.h"
#import "Ty_Model_WorkListInfo.h"

#import "iflyMSC/IFlyRecognizerViewDelegate.h"
#import "iflyMSC/IFlyRecognizerView.h"
#import "iflyMSC/IFlySpeechConstant.h"


@interface Ty_HomeSearchVC ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,IFlyRecognizerViewDelegate>
{
    UITableView* tableview_search;
    UITableView* tableview_data;
    UIButton *voiceButton;
    UIButton *searchButton;
    UITextField* searchTextField;
    RefreshView *_refreshLoadView;
    UIView* loadView;
    
    IFlyRecognizerView *_iFlyRecognizerView;
    NSString *_grammarID;
}
@end

@implementation Ty_HomeSearchVC
@synthesize searchBusine;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        searchBusine = [[Ty_SearchBusine alloc] init];
        searchBusine.delegate = self;
    }
    return self;
}
-(void)keyboardWillHide:(NSNotification *)notification
{
    [super keyboardWillHide:notification];
    searchBusine.searchBool = YES;
    tableview_data.hidden = YES;
    tableview_search.hidden = YES;
//    [tableview_data reloadData];
//    [tableview_search setFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height-64-49-44)];
}
-(void)keyboardWillShow:(NSNotification *)notification
{
    [super keyboardWillShow:notification];
    searchBusine.searchBool = NO;
    tableview_search.hidden = NO;
    tableview_data.hidden = YES;
    
    NSDictionary *info = [notification userInfo];
    
    NSValue   *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    
    [tableview_search setFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height-64-49-44-keyboardSize.height)];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _iFlyRecognizerView = [[IFlyRecognizerView alloc] initWithCenter:self.view.center];
    [_iFlyRecognizerView setParameter:_grammarID forKey:[IFlySpeechConstant CLOUD_GRAMMAR]];
    [_iFlyRecognizerView setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
    [_iFlyRecognizerView setParameter:@"16000" forKey:[IFlySpeechConstant SAMPLE_RATE]];
    [_iFlyRecognizerView setParameter:@"1800" forKey:[IFlySpeechConstant VAD_EOS]];
    [_iFlyRecognizerView setParameter:@"6000" forKey:[IFlySpeechConstant VAD_BOS]];
    [_iFlyRecognizerView setParameter:@"0" forKey:[IFlySpeechConstant ASR_PTT]];
    _iFlyRecognizerView.delegate = self;

    
    //设置title
    UIImageView * titleImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 77, 40)];
    [titleImage setImage:JWImageName(@"Home_titleImage")];
    self.naviGationController.titleView = titleImage;
    titleImage = nil;
    
    UIView *searchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    [searchView setBackgroundColor:Color_225];
    
    UIImageView *searchImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 3, self.view.frame.size.width-60, 38)];
    [searchImageView setImage:[JWImageName(@"home_searchbarBackImage") stretchableImageWithLeftCapWidth:10 topCapHeight:10]];
    [searchImageView setUserInteractionEnabled:YES];

    UIImageView *searchIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_searchBarIconImage"]];
    searchIcon.frame = CGRectMake(5, (searchImageView.frame.size.height-15)/2, 15, 15);
    
    searchTextField = [[UITextField alloc]initWithFrame:CGRectMake(25, 0, searchImageView.frame.size.width-25, searchImageView.frame.size.height)];
    [searchTextField setBackgroundColor:[UIColor clearColor]];
    [searchTextField setPlaceholder:@"请输入搜索内容"];
    searchTextField.delegate = self;
    [searchTextField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [searchTextField setFont:FONT13_SYSTEM];
    [searchTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [searchTextField setUserInteractionEnabled:YES];
    [searchTextField becomeFirstResponder];
    searchTextField.returnKeyType = UIReturnKeySearch; //设置按键类型
    searchTextField.enablesReturnKeyAutomatically = YES; //这里设置为无文字就灰色不可点
    
    [searchImageView addSubview:searchIcon];
    [searchImageView addSubview:searchTextField];
    
    voiceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    voiceButton.frame = CGRectMake(searchView.frame.size.width-50, 0, 50, 44);
    //    [beginButton setTitle:@"开始识别" forState:UIControlStateNormal];
    [voiceButton setImage:JWImageName(@"home_voice") forState:UIControlStateNormal];
    [voiceButton addTarget:self action:@selector(onBegin:) forControlEvents:UIControlEventTouchUpInside];
    
    searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchButton setFrame:CGRectMake(searchView.frame.size.width-50, 0, 50, 44)];
    [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    [searchButton.titleLabel setFont:FONT15_BOLDSYSTEM];
    [searchButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(searchButtonBegin) forControlEvents:UIControlEventTouchUpInside];
    
    if ([searchBusine.searchText isEqualToString:@""]||searchBusine.searchText == nil) {
        [voiceButton setHidden:NO];
        [searchButton setHidden:YES];
    }else{
        [voiceButton setHidden:YES];
        [searchButton setHidden:NO];
    }
    
    [searchView addSubview:searchImageView];
    [searchView addSubview:searchButton];
    [searchView addSubview:voiceButton];
    
    UIView* hotSearchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    [hotSearchView setBackgroundColor:[UIColor whiteColor]];
    
    UIButton* hotFirstButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [hotFirstButton setFrame:CGRectMake(10, 10, (self.view.frame.size.width-50)/4, 40)];
    [hotFirstButton setTitle:@"保洁" forState:UIControlStateNormal];
    [hotFirstButton setBackgroundColor:Color_225];
    [hotFirstButton setTag:1];
    [hotFirstButton.titleLabel setFont:FONT14_SYSTEM];
    [hotFirstButton setTitleColor:text_grayColor forState:UIControlStateNormal];
    [hotFirstButton addTarget:self action:@selector(searchBegin:) forControlEvents:UIControlEventTouchUpInside];

    UIButton* hotSecondtButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [hotSecondtButton setFrame:CGRectMake((self.view.frame.size.width-50)/4+20, 10, (self.view.frame.size.width-50)/4, 40)];
    [hotSecondtButton setTitle:@"月嫂" forState:UIControlStateNormal];
    [hotSecondtButton setBackgroundColor:Color_225];
    [hotSecondtButton setTag:2];
    [hotSecondtButton.titleLabel setFont:FONT14_SYSTEM];
    [hotSecondtButton setTitleColor:text_grayColor forState:UIControlStateNormal];
    [hotSecondtButton addTarget:self action:@selector(searchBegin:) forControlEvents:UIControlEventTouchUpInside];

    UIButton* hotThirdButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [hotThirdButton setFrame:CGRectMake((self.view.frame.size.width-50)/2+30, 10, (self.view.frame.size.width-50)/4, 40)];
    [hotThirdButton setTitle:@"空调清洗" forState:UIControlStateNormal];
    [hotThirdButton setBackgroundColor:Color_225];
    [hotThirdButton setTag:3];
    [hotThirdButton.titleLabel setFont:FONT14_SYSTEM];
    [hotThirdButton setTitleColor:text_grayColor forState:UIControlStateNormal];
    [hotThirdButton addTarget:self action:@selector(searchBegin:) forControlEvents:UIControlEventTouchUpInside];

    UIButton* hotFourthButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [hotFourthButton setFrame:CGRectMake((self.view.frame.size.width-50)/4*3+40, 10, (self.view.frame.size.width-50)/4, 40)];
    [hotFourthButton setTitle:@"保姆" forState:UIControlStateNormal];
    [hotFourthButton setBackgroundColor:Color_225];
    [hotFourthButton setTag:4];
    [hotFourthButton.titleLabel setFont:FONT14_SYSTEM];
    [hotFourthButton setTitleColor:text_grayColor forState:UIControlStateNormal];
    [hotFourthButton addTarget:self action:@selector(searchBegin:) forControlEvents:UIControlEventTouchUpInside];
    
    [hotSearchView addSubview:hotFirstButton];
    [hotSearchView addSubview:hotSecondtButton];
    [hotSearchView addSubview:hotThirdButton];
    [hotSearchView addSubview:hotFourthButton];
    
    loadView = [[UIView alloc]initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height-64-44-49)];
    [loadView setBackgroundColor:view_BackGroudColor];
    [self.view addSubview:loadView];
    
    tableview_data = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height-64-44-49) style:UITableViewStylePlain];
    tableview_data.dataSource = self;
    tableview_data.delegate = self;
    tableview_data.sectionIndexColor = [UIColor blackColor];
    [tableview_data setBackgroundColor:view_BackGroudColor];
    tableview_data.separatorColor = text_grayColor;
    tableview_data.hidden = YES;
    //定义tableview背景图片
    UIImageView* tableviewdataBackimage = [[UIImageView alloc]initWithFrame:self.view.frame];
    [tableviewdataBackimage setBackgroundColor:view_BackGroudColor];
    [tableview_data setBackgroundView:tableviewdataBackimage];
    [self.view addSubview:tableview_data];
    
    tableview_search = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height-64-44-49) style:UITableViewStylePlain];
    tableview_search.dataSource = self;
    tableview_search.delegate = self;
    tableview_search.sectionIndexColor = [UIColor blackColor];
    tableview_search.tableHeaderView = hotSearchView;
    [tableview_search setBackgroundColor:view_BackGroudColor];
    tableview_search.separatorColor = text_grayColor;
    
    //定义tableview背景图片
    UIImageView* tableviewBackimage = [[UIImageView alloc]initWithFrame:self.view.frame];
    [tableviewBackimage setBackgroundColor:view_BackGroudColor];
    [tableview_search setBackgroundView:tableviewBackimage];
    
    [self.view addSubview:searchView];
    [self.view addSubview:tableview_search];
    
    if (![searchBusine.searchText isEqualToString:@""]&&searchBusine != nil) {
//        [searchTextField resignFirstResponder];
//        searchBusine.searchBool = YES;
//        tableview_data.hidden = YES;
//        tableview_search.hidden = YES;
        searchTextField.text = searchBusine.searchText;
//        [self searchButtonBegin];
    }
    
    // Do any additional setup after loading the view.
}
#pragma mark ----语音

- (void) onBegin:(id) sender
{
    [_iFlyRecognizerView start];
    ResignFirstResponder
    
}
- (void) setGrammar:(NSString *)grammar
{
    _grammarID = grammar;
}

- (void)onResult:(NSArray *)resultArray isLast:(BOOL) isLast;
{
    if (!isLast) {
        NSMutableString *result = [[NSMutableString alloc] init];
        NSMutableString *resultString = [[NSMutableString alloc]init];
        NSDictionary *dic = resultArray [0];
        for (NSString* key in dic ){
            [result setString:key];
        }
        
        NSData *responseData = [result dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary* keyDic = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
        NSArray* wsArray = [[NSArray alloc]initWithArray:[keyDic objectForKey:@"ws"]];
        for (int i = 0; i<wsArray.count; i++) {
            NSDictionary* wsDic = [wsArray objectAtIndex:i];
            NSArray* cwArray = [[NSArray alloc]initWithArray:[wsDic objectForKey:@"cw"]];
            if (cwArray.count>0) {
                [resultString appendString:[NSString stringWithFormat:@"%@",[[cwArray objectAtIndex:0] objectForKey:@"w"]]];
            }
            wsDic = nil;
            cwArray = nil;
        }
        
        keyDic = nil;
        dic = nil;
        wsArray = nil;
        
        NSLog(@"识别结果：%@",[NSString stringWithFormat:@"%@",resultString]);
        
        if (![resultString isEqualToString:@""]&&resultString != nil&&![resultString isEqualToString:@" "]) {
            searchTextField.text = resultString;
            searchButton.hidden = NO;
            voiceButton.hidden = YES;
        }
        [_iFlyRecognizerView removeFromSuperview];
    }
}
- (void) onError:(IFlySpeechError *) error
{
    NSString *text ;
    if (error.errorCode  == 0 ) {
        
    }
    else
    {
        text = [NSString stringWithFormat:@"发生错误：%d %@",error.errorCode,error.errorDesc];
        NSLog(@"%@",text);
    }
}


-(void)BtnClick:(UITapGestureRecognizer *)imageTap
{
    NSLog(@"imageTag == %d", imageTap.view.tag );
    
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:1];
    //    for (int i = 0; i < [photos count]; i++) {
    // 替换为中等尺寸图片
    
    NSString * getImageStrUrl = [NSString stringWithFormat:@"%@", [[searchBusine.shopArray objectAtIndex:imageTap.view.tag-10000] headPhotoGaoQing]];
    MJPhoto *photo = [[MJPhoto alloc] init];
    photo.url = [NSURL URLWithString: getImageStrUrl ]; // 图片路径
    
    UIImageView * imageView = (UIImageView *)[self.view viewWithTag: imageTap.view.tag ];
    photo.srcImageView = imageView;
    [photos addObject:photo];
    //    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = 0; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
    photos = nil;
    getImageStrUrl = nil;
    photo = nil;
    imageView = nil;
    
}
-(void)BtnClick2:(UITapGestureRecognizer *)imageTap
{
    NSLog(@"imageTag == %d", imageTap.view.tag );
    
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:1];
    //    for (int i = 0; i < [photos count]; i++) {
    // 替换为中等尺寸图片
    
    NSString * getImageStrUrl = [NSString stringWithFormat:@"%@", [[searchBusine.personalArray objectAtIndex:imageTap.view.tag-10000] headPhotoGaoQing]];
    MJPhoto *photo = [[MJPhoto alloc] init];
    photo.url = [NSURL URLWithString: getImageStrUrl ]; // 图片路径
    
    UIImageView * imageView = (UIImageView *)[self.view viewWithTag: imageTap.view.tag ];
    photo.srcImageView = imageView;
    [photos addObject:photo];
    //    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = 0; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
    photos = nil;
    getImageStrUrl = nil;
    photo = nil;
    imageView = nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableview_data == tableView) {
        return 2;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableview_data == tableView) {
        switch (section) {
            case 0:
                return searchBusine.shopArray.count;
                break;
            case 1:
                return searchBusine.personalArray.count;
            default:
                return 0;
                break;
        }
    }else{
        return searchBusine.markArray.count+1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableview_data == tableView) {

        static NSString* Cellshop = @"Cellshop";
        static NSString* Cellpersonal = @"Cellpersonal";
        
        
        if (indexPath.section == 0){
            Ty_HomeFind_ShopCell* cellshop = [tableView dequeueReusableCellWithIdentifier:Cellshop];
            if (cellshop == nil) {
                cellshop = [[Ty_HomeFind_ShopCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:Cellshop];
            }
            cellshop.shopNameLabel.text = [NSString stringWithFormat:@"%@",[[searchBusine.shopArray objectAtIndex:indexPath.row] respectiveCompanies]];
            [cellshop.typeLabel setText:@"商户"];
            NSMutableString* arr = [[NSMutableString alloc]init];
            for (int i = 0; i<[[[searchBusine.shopArray objectAtIndex:indexPath.row] workTypeArray] count]; i++) {
                [arr appendFormat:@"%@.",[[[[searchBusine.shopArray objectAtIndex:indexPath.row] workTypeArray] objectAtIndex:i] workName]];
            }
            [cellshop.serviceNumLabel setText:[NSString stringWithFormat:@"共%@次接活",[[searchBusine.shopArray objectAtIndex:indexPath.row] serviceNumber]]];
            [cellshop.headImage setImageWithURL:[NSURL URLWithString:[[searchBusine.shopArray objectAtIndex:indexPath.row] headPhoto]] placeholderImage:JWImageName(@"Contact_image2")];
            cellshop.headImage.userInteractionEnabled = YES;
            cellshop.headImage.contentMode = UIViewContentModeScaleAspectFill;
            cellshop.headImage.tag = 10000+indexPath.row;
            [cellshop.headImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(BtnClick:)] ];
            [cellshop.distanceLabel setText:@""];
            [cellshop.customStar setCustomStarNumber:[[[searchBusine.shopArray objectAtIndex:indexPath.row] evaluate] floatValue]];
            cellshop.areaLabel.text = [[searchBusine.shopArray objectAtIndex:indexPath.row] intermediary_Region];
            [cellshop setLoadView];
            return cellshop;
        }else{
            Ty_HomeFind_PersonalCell* cellpersonal = [tableView dequeueReusableCellWithIdentifier:Cellpersonal];
            if (cellpersonal == nil) {
                cellpersonal = [[Ty_HomeFind_PersonalCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:Cellpersonal];
            }
            if ([[[searchBusine.personalArray objectAtIndex:indexPath.row]userType] isEqualToString:@"1"]) {
                cellpersonal.personalNameLabel.text = [NSString stringWithFormat:@"%@",[[searchBusine.personalArray objectAtIndex:indexPath.row] userRealName]];
                [cellpersonal.typeLabel setText:[NSString stringWithFormat:@"%@",[[searchBusine.personalArray objectAtIndex:indexPath.row] respectiveCompanies]]];
                if ([[[searchBusine.personalArray objectAtIndex:indexPath.row] workTypeArray] count]>0) {
                    cellpersonal.serviceNumLabel.text = [NSString stringWithFormat:@"共%@次接活",[[searchBusine.personalArray objectAtIndex:indexPath.row] serviceNumber]];
                }else{
                    cellpersonal.serviceNumLabel.text = [NSString stringWithFormat:@"共%@次接活",[[searchBusine.personalArray objectAtIndex:indexPath.row] serviceNumber]];
                }
                [cellpersonal.customLable setVerticalAlignment:UIControlContentVerticalAlignmentBottom];
                [cellpersonal.customLable setTextAlignment:NSTextAlignmentRight];
                if ([[[searchBusine.personalArray objectAtIndex:indexPath.row] sex]isEqualToString:@"0"]) {
                    [cellpersonal.headImage setImageWithURL:[NSURL URLWithString:[[searchBusine.personalArray objectAtIndex:indexPath.row] headPhoto]] placeholderImage:JWImageName(@"Contact_image1")];
                }else{
                    [cellpersonal.headImage setImageWithURL:[NSURL URLWithString:[[searchBusine.personalArray objectAtIndex:indexPath.row] headPhoto]] placeholderImage:JWImageName(@"Contact_image")];
                }
                cellpersonal.headImage.userInteractionEnabled = YES;
                cellpersonal.headImage.contentMode = UIViewContentModeScaleAspectFill;
                cellpersonal.headImage.tag = 10000+indexPath.row;
                [cellpersonal.headImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(BtnClick2:)] ];
            }else{
                //个人接活
                cellpersonal.personalNameLabel.text = [NSString stringWithFormat:@"%@",[[searchBusine.personalArray objectAtIndex:indexPath.row] userRealName]];
                [cellpersonal.typeLabel setText:@"个人"];
                if ([[[searchBusine.personalArray objectAtIndex:indexPath.row] workTypeArray] count]>0) {
                    cellpersonal.serviceNumLabel.text = [NSString stringWithFormat:@"共%@次接活",[[searchBusine.personalArray objectAtIndex:indexPath.row] serviceNumber]];
                }else{
                    cellpersonal.serviceNumLabel.text = [NSString stringWithFormat:@"共%@次接活",[[searchBusine.personalArray objectAtIndex:indexPath.row] serviceNumber]];
                }
                [cellpersonal.customLable setVerticalAlignment:UIControlContentVerticalAlignmentBottom];
                [cellpersonal.customLable setTextAlignment:NSTextAlignmentRight];
                if ([[[searchBusine.personalArray objectAtIndex:indexPath.row] sex]isEqualToString:@"0"]) {
                    [cellpersonal.headImage setImageWithURL:[NSURL URLWithString:[[searchBusine.personalArray objectAtIndex:indexPath.row] headPhoto]] placeholderImage:JWImageName(@"Contact_image1")];
                }else{
                    [cellpersonal.headImage setImageWithURL:[NSURL URLWithString:[[searchBusine.personalArray objectAtIndex:indexPath.row] headPhoto]] placeholderImage:JWImageName(@"Contact_image")];
                }
                cellpersonal.headImage.userInteractionEnabled = YES;
                cellpersonal.headImage.contentMode = UIViewContentModeScaleAspectFill;
                cellpersonal.headImage.tag = 10000+indexPath.row;
                [cellpersonal.headImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(BtnClick2:)] ];
            }
            [cellpersonal.customStar setCustomStarNumber:[[[searchBusine.personalArray objectAtIndex:indexPath.row] evaluate] floatValue]];
            [cellpersonal setLoadView];
            return cellpersonal;
            
        }
    }else{
        static NSString* Cell = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cell];
        }
        if (indexPath.row == searchBusine.markArray.count) {
            cell.textLabel.text = @"                   清空搜索记录";
        }else{
            [cell.textLabel setTextColor:text_grayColor];
            
            cell.textLabel.text = [searchBusine.markArray objectAtIndex:indexPath.row];
        }
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableview_data == tableView) {
        
    }else{
        [cell setBackgroundColor:view_BackGroudColor];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }else{
        if (searchBusine.personalArray.count>0) {
            return 25;
        }else{
            return 0;
        }
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        if (searchBusine.personalArray.count>0) {
            UIView* headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 25)];
            [headView setBackgroundColor:[UIColor colorWithRed:250.0/255.0 green:220.0/255.0 blue:218.0/255.0 alpha:1.0]];
            UILabel * headLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 300, 25)];
            [headLabel setBackgroundColor:[UIColor clearColor]];
            [headLabel setText:@"推荐阿姨"];
            [headLabel setTextColor:[UIColor redColor]];
            [headLabel setFont:FONT15_BOLDSYSTEM];
            [headView addSubview:headLabel];
            headLabel = nil;
            return headView;
        }else{
            UIView* headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 0)];
            [headView setBackgroundColor:[UIColor colorWithRed:250.0/255.0 green:220.0/255.0 blue:218.0/255.0 alpha:1.0]];
            UILabel * headLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 300, 0)];
            [headLabel setBackgroundColor:[UIColor clearColor]];
            [headLabel setText:@"推荐阿姨"];
            [headLabel setTextColor:[UIColor redColor]];
            [headLabel setFont:FONT15_BOLDSYSTEM];
            [headView addSubview:headLabel];
            headLabel = nil;
            return headView;
        }
        
    }else{
        return [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableview_data == tableView) {
        return 80;
    }
    return 44;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableview_data == tableView) {
        [self.naviGationController pushViewController:[searchBusine didSelectIndexPath:indexPath] animated:YES];
    }else{
        if (indexPath.row == searchBusine.markArray.count) {
            [self removeAllsearch];
        }else{
            [self searchBegin:[searchBusine.markArray objectAtIndex:indexPath.row]];
        }
    }
}
-(void)removeAllsearch
{
    [searchBusine removeMarkData];
    [searchBusine reloadMarkData];
    [tableview_search reloadData];
}
-(void)searchButtonBegin
{
    ResignFirstResponder
    searchBusine.currentPage = 1;
    [self showLoadingInView:loadView];
    searchBusine.searchText = searchTextField.text;
    [searchBusine searchBegin:searchBusine.searchText];
    [tableview_search reloadData];
}
-(void)searchBegin:(id)sender
{
    ResignFirstResponder
    searchBusine.currentPage = 1;
    [self showLoadingInView:loadView];
    if ([sender isMemberOfClass:[UIButton class]]) {
        UIButton* button = (UIButton*)sender;
        searchBusine.searchText = button.titleLabel.text;
        searchTextField.text = button.titleLabel.text;
        [searchBusine searchBegin:button.titleLabel.text];
        [tableview_search reloadData];
        button = nil;
    }else{
        NSString* string = (NSString* )sender;
        searchBusine.searchText = string;
        searchTextField.text = string;
        [searchBusine searchBegin:string];
        [tableview_search reloadData];
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    ResignFirstResponder
    if (![textField.text isEqualToString:@""]&&textField.text != nil) {
        searchBusine.searchText = textField.text;
        [self searchBegin:searchBusine.searchText];
        return YES;
    }else{
        return NO;
    }
    
}
-(BOOL)textFieldShouldClear:(UITextField *)textField
{
    searchButton.hidden = YES;
    voiceButton.hidden = NO;
    return YES;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@" "]) {
        return NO;
    }
    if (range.location == 0&&range.length == 1) {
        searchButton.hidden = YES;
        voiceButton.hidden = NO;
    }else{
        searchButton.hidden = NO;
        voiceButton.hidden = YES;
    }
    return YES;
}

-(void)netRequestReceived:(NSNotification *)_notification
{
    [self hideLoadingView];
    [self hideMessageView];
    if ([[[_notification object]objectForKey:@"code"] isEqualToString:@"200"]) {
        tableview_data.hidden = NO;
        [tableview_data reloadData];
        if (searchBusine.currentPage == 1) {
            [tableview_data scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
        }
        
        searchBusine.currentPage++;
        if (tableview_data.contentSize.height>tableview_data.frame.size.height) {
            if (_refreshLoadView  ==  nil)
            {
                _refreshLoadView = [[RefreshView alloc]initWithFrame:CGRectMake(10, 0, self.view.bounds.size.width - 20, 40.0)];
                _refreshLoadView._messageLabel.text = @"正在加载...";
                _refreshLoadView.backgroundColor = [UIColor clearColor];
            }
            tableview_data.tableFooterView = _refreshLoadView;
        }else{
            tableview_data.tableFooterView = nil;
            _refreshLoadView = nil;
        }
        searchBusine._isRefreshing = NO;
    }else if([[[_notification object]objectForKey:@"code"] isEqualToString:@"203"]){
        tableview_data.hidden = NO;
        if (searchBusine.currentPage == 1) {
            [self showMessageInView:tableview_data message:@"无查询结果"];
            tableview_data.tableFooterView = nil;
        }
        [tableview_data reloadData];
        if (tableview_data.contentSize.height>tableview_data.frame.size.height) {
            tableview_data.tableFooterView = _refreshLoadView;
        }
        searchBusine._isRefreshing = YES;
        _refreshLoadView._messageLabel.text = @"已加载全部";
    }else if([[[_notification object]objectForKey:@"code"] isEqualToString:@"202"]){
        if (searchBusine.currentPage == 1) {
            tableview_data.hidden = YES;
            [self showMessageInView:tableview_data message:@"202错误"];
            tableview_data.tableFooterView = nil;
        }else{
            tableview_data.hidden = NO;
            [tableview_data reloadData];
            if (tableview_data.contentSize.height>tableview_data.frame.size.height) {
                tableview_data.tableFooterView = _refreshLoadView;
            }
            searchBusine._isRefreshing = NO;
            _refreshLoadView._messageLabel.text = @"202错误请重新加载";
        }
        
    }else{
        [self showNetMessageInView:self.view];
        //        _refreshLoadView._messageLabel.text = @"加载失败！";
        searchBusine._isRefreshing = NO;
    }
    [_refreshLoadView._netMind stopAnimating];

}
#pragma mark ----上拉刷新
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"Ani -- %d",_refreshLoadView._netMind.isAnimating);
    NSLog(@"ref --%d",searchBusine._isRefreshing);
    if (scrollView.contentOffset.y >=  scrollView.contentSize.height - scrollView.bounds.size.height  && _refreshLoadView !=  nil)
    {
        NSLog(@" -- 我是上拉刷新");
        if (!searchBusine._isRefreshing )
        {
            [_refreshLoadView._netMind startAnimating];
            _refreshLoadView._messageLabel.text = @"正在加载...";
            searchBusine._isRefreshing = YES;
            [searchBusine loadDatatarget];
        }
    }
}
-(void)loading{
    [self showLoadingInView:loadView];
    [searchBusine loadDatatarget];
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
