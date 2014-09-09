//
//  ViewController.m
//  腾云家务
//
//  Created by 齐 浩 on 13-9-22.
//  Copyright (c) 2013年 齐 浩. All rights reserved.
//
/*
 * jpush 推送证书
 jpushAppKey="b038abc39fccd2140a59cbac";		  // 测试
 jpushMasterSecret="e94162e3b1a2bf9a5415f7a8";    // 测试
 jpushAppKey="1d6e8c6de99ede9f1e1fe348";		  // 正式
 jpushMasterSecret="a45eff4edac2476526538200";    // 正式
 */
#import "ViewController.h"
#define Blue [UIColor colorWithRed:7.0/255.0 green:174.0/255.0 blue:237/255.0 alpha:1]

@interface ViewController ()

@end

@implementation ViewController

@synthesize gotoMainViewBtn = _gotoMainViewBtn;

@synthesize imageView;
@synthesize left = _left;
@synthesize right = _right;
@synthesize pageScroll;
@synthesize pageControl;
@synthesize delegate;
@synthesize View1;
@synthesize image1;
@synthesize image4;
@synthesize image2;
@synthesize image3;
@synthesize AppVC;


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.view setFrame:CGRectMake(MainBounds.origin.x, MainBounds.origin.y, MainBounds.size.width, MainBounds.size.height)];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    pageControl=[[UIPageControl alloc]init];
    View1=[[UIView alloc]init];
    image1=[[UIImageView alloc]init];
    image2=[[UIImageView alloc]init];
    image3=[[UIImageView alloc]init];
    image4=[[UIImageView alloc]init];
    _gotoMainViewBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    
    imageView=[[UIImageView alloc]init];
    
    pageScroll=[[UIScrollView alloc]init];
    
    pageControl.numberOfPages = 4;
    pageControl.currentPage = 0;
//    pageControl.currentPageIndicatorTintColor=[UIColor blackColor];
//    pageControl.pageIndicatorTintColor=[UIColor grayColor];
//    [pageControl setPageIndicatorTintColor:[UIColor redColor]];
//    [pageControl setImagePageStateNormal:[UIImage imageNamed:@"BluePoint.png"]];
//    [pageControl setImagePageStateHightlighted:[UIImage imageNamed:@"RedPoint.png"]];

    pageScroll.delegate = self;
    
    pageScroll.contentSize = CGSizeMake(self.view.frame.size.width * 4, self.view.frame.size.height);
    
    [pageScroll setFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    pageScroll.pagingEnabled=YES;
    
    
    [View1 setFrame:CGRectMake(960,0,self.view.frame.size.width, self.view.frame.size.height)];
    
    [imageView setFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    [image1 setFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    [image2 setFrame:CGRectMake(320, 0, 320, self.view.frame.size.height)];
    [image3 setFrame:CGRectMake(640, 0, 320, self.view.frame.size.height)];
    if (self.view.frame.size.height>500) {
        imageView.image=[UIImage imageNamed:@"4boot-568h"];
        image1.image=[UIImage imageNamed:@"1boot-568h"];
        image2.image=[UIImage imageNamed:@"2boot-568h"];
        image3.image=[UIImage imageNamed:@"3boot-568h"];
    }else{
        
        imageView.image=[UIImage imageNamed:@"4boot"];
        image1.image=[UIImage imageNamed:@"1boot"];
        image2.image=[UIImage imageNamed:@"2boot"];
        image3.image=[UIImage imageNamed:@"3boot"];
    }
    

    [pageControl setFrame:CGRectMake(141, self.view.frame.size.height-44, 38, 36)];
    
//    [_gotoMainViewBtn setBackgroundImage:[UIImage imageNamed:@"in.png"] forState:0];
    if (self.view.frame.size.height>500) {
        [_gotoMainViewBtn setFrame:CGRectMake(80, self.view.frame.size.height-230, 160, 44)];
    }else{
        [_gotoMainViewBtn setFrame:CGRectMake(80, self.view.frame.size.height-170, 160, 44)];
    }
    
    [_gotoMainViewBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_gotoMainViewBtn setTitle:@"开启腾云家务" forState:UIControlStateNormal];
    [_gotoMainViewBtn.titleLabel setFont:FONT17_SYSTEM];
    [_gotoMainViewBtn setBackgroundImage:JWImageName(@"anniu") forState:UIControlStateNormal];

    [_gotoMainViewBtn addTarget:self action:@selector(gotoMainViewBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [View1 addSubview:imageView];
    [View1 addSubview:_gotoMainViewBtn];
    [pageScroll addSubview:View1];
    [pageScroll addSubview:image1];
    [pageScroll addSubview:image2];
    [pageScroll addSubview:image3];
    [self.view addSubview:pageScroll];
    [self.view addSubview:pageControl];
    
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}




-(void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    if ([animationID isEqualToString:@"split"] && finished) {
        
        CATransition *animation = [CATransition animation];
        animation.timingFunction = UIViewAnimationCurveEaseInOut;
        animation.duration=1.0f;
        animation.delegate=self;
        if (AppVC) {
            [[[UIApplication sharedApplication] delegate] window].rootViewController=AppVC;
        }else{
            self.view.hidden=YES;
        }
        [self.view.layer addAnimation:animation forKey:@"animation"];
    }
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.view.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
}

- (void)viewDidUnload {
    [self setGotoMainViewBtn:nil];
    [self setPageScroll:nil];
    [self setView:nil];
    [self setImageView:nil];
    [self setGotoMainViewBtn:nil];
    [self setImage1:nil];
    [self setImage2:nil];
    [self setImage1:nil];
    [self setPageControl:nil];
    [super viewDidUnload];
}
- (void)gotoMainViewBtn:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] forKey:@"versionNum"];
    [self.gotoMainViewBtn setHidden:YES];
    [self.pageScroll setHidden:YES];
    [self.pageControl setHidden:YES];
    [UIView beginAnimations:@"split" context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:1];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];

    [UIView commitAnimations];
    if (delegate) {
        [delegate pop];
    }
}
@end
