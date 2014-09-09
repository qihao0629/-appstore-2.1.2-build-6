//
//  LeveyTabBarControllerViewController.m
//  LeveyTabBarController
//
//  Created by Levey Zhu on 12/15/10.
//  Copyright 2010 VanillaTech. All rights reserved.
//

#import "LeveyTabBarController.h"
#import "LeveyTabBar.h"

#define kTabBarHeight 49.0f

static LeveyTabBarController *leveyTabBarController;

@implementation UIViewController (LeveyTabBarControllerSupport)

- (LeveyTabBarController *)leveyTabBarController
{
	return leveyTabBarController;
}
@end


@interface LeveyTabBarController (private)
- (void)displayViewAtIndex:(NSUInteger)index;
@end

@implementation LeveyTabBarController
@synthesize delegate = _delegate;
@synthesize selectedViewController = _selectedViewController;
@synthesize viewControllers = _viewControllers;
@synthesize selectedIndex = _selectedIndex;
@synthesize tabBarHidden = _tabBarHidden;

#pragma mark -
#pragma mark lifecycle
- (id)initWithViewControllers:(NSArray *)vcs imageArray:(NSArray *)arr;
{
	self = [super init];
	if (self != nil)
	{
		_viewControllers = [[NSMutableArray arrayWithArray:vcs] retain];
        if (IOS7) {
            _containerView = [[UIView alloc] initWithFrame:MainBounds];
        }else{
            _containerView = [[UIView alloc] initWithFrame:MainFrame];
        }
		_transitionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320.0f, _containerView.frame.size.height - kTabBarHeight)];
		_transitionView.backgroundColor =  [UIColor groupTableViewBackgroundColor];
		
		_tabBar = [[LeveyTabBar alloc] initWithFrame:CGRectMake(0, _containerView.frame.size.height - kTabBarHeight, 320.0f, kTabBarHeight) buttonImages:arr];
		_tabBar.delegate = self;
		
        leveyTabBarController = self;
	}
	return self;
}

- (void)loadView
{
	[super loadView];
	
	[_containerView addSubview:_transitionView];
	[_containerView addSubview:_tabBar];
	self.view = _containerView;
    
    //  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(landing) name:@"langing" object:nil];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.selectedIndex = 0;
    redIcon=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"count.png"]];
    redIcon.hidden = YES;
    redIcon.frame = CGRectMake(35, 5, 18, 18);
    newsLabel = [[UILabel alloc]initWithFrame:redIcon.bounds];
    newsLabel.backgroundColor = [UIColor clearColor];
    newsLabel.textColor = [UIColor whiteColor];
    newsLabel.textAlignment = NSTextAlignmentCenter;
    newsLabel.font = FONT10_SYSTEM;
    [redIcon addSubview:newsLabel];
    [redIcon bringSubviewToFront:newsLabel];
    UIButton *button=[self.tabBar.buttons objectAtIndex:1];
    [button addSubview:redIcon];
}

//获取会话
- (void)get_session
{
}

//弹出登陆画面


- (void)viewDidUnload
{
	[super viewDidUnload];
	
	_tabBar = nil;
	_viewControllers = nil;
}


- (void)dealloc
{
    _tabBar.delegate = nil;
	[_tabBar release];
    [_containerView release];
    [_transitionView release];
	[_viewControllers release];
    [super dealloc];
}

#pragma mark - instant methods

- (LeveyTabBar *)tabBar
{
	return _tabBar;
}
- (BOOL)tabBarTransparent
{
	return _tabBarTransparent;
}
- (void)setTabBarTransparent:(BOOL)yesOrNo
{
	if (yesOrNo == YES)
	{
		_transitionView.frame = _containerView.bounds;
	}
	else
	{
		_transitionView.frame = CGRectMake(0, 0, 320.0f, _containerView.frame.size.height - kTabBarHeight);
	}
    
}
-(void)setUserInteractionEnabled:(BOOL)yesOrNO
{
    self.tabBar.userInteractionEnabled=yesOrNO;
}
- (void)hidesTabBar:(BOOL)yesOrNO animated:(BOOL)animated;
{
	if (yesOrNO == YES)
	{
		if (self.tabBar.frame.origin.y == self.view.frame.size.height)
		{
			return;
		}
	}
	else
	{
		if (self.tabBar.frame.origin.y == self.view.frame.size.height - kTabBarHeight)
		{
			return;
		}
	}
	
	if (animated == YES)
	{
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.3f];
		if (yesOrNO == YES)
		{
			self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y + kTabBarHeight, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
            _transitionView.frame= CGRectMake(0, 0, 320.0f, _containerView.frame.size.height );
            
		}
		else
		{
			self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y - kTabBarHeight, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
            _transitionView.frame = CGRectMake(0, 0, 320.0f, _containerView.frame.size.height-kTabBarHeight );
		}
		[UIView commitAnimations];
	}
	else
	{
		if (yesOrNO == YES)
		{
			self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y + kTabBarHeight, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
            _transitionView.frame =CGRectMake(0, 0, 320.0f, _containerView.frame.size.height );
            
		}
		else
		{
			self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y - kTabBarHeight, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
            _transitionView.frame =CGRectMake(0, 0, 320.0f, _containerView.frame.size.height-kTabBarHeight );
		}
	}
}

- (NSUInteger)selectedIndex
{
	return _selectedIndex;
}
- (UIViewController *)selectedViewController
{
    return [_viewControllers objectAtIndex:_selectedIndex];
}

-(void)setSelectedIndex:(NSUInteger)index
{
    [self displayViewAtIndex:index];
    [_tabBar selectTabAtIndex:index];
}

- (void)removeViewControllerAtIndex:(NSUInteger)index
{
    if (index >= [_viewControllers count])
    {
        return;
    }
    // Remove view from superview.
    [[(UIViewController *)[_viewControllers objectAtIndex:index] view] removeFromSuperview];
    // Remove viewcontroller in array.
    [_viewControllers removeObjectAtIndex:index];
    // Remove tab from tabbar.
    [_tabBar removeTabAtIndex:index];
}

- (void)insertViewController:(UIViewController *)vc withImageDic:(NSDictionary *)dict atIndex:(NSUInteger)index
{
    [_viewControllers insertObject:vc atIndex:index];
    [_tabBar insertTabWithImageDic:dict atIndex:index];
}


#pragma mark - Private methods
- (void)displayViewAtIndex:(NSUInteger)index
{
    // Before changing index, ask the delegate should change the index.
    
    
    if ([_delegate respondsToSelector:@selector(tabBarController:shouldSelectViewController:)])
    {
        if (![_delegate tabBarController:self shouldSelectViewController:[self.viewControllers objectAtIndex:index]])
        {
            return;
        }
    }
    
    UIViewController *targetViewController = [self.viewControllers objectAtIndex:index];
    
    // If target index is equal to current index.
    if (_selectedIndex == index && [[_transitionView subviews] count] != 0)
    {
        if ([targetViewController isKindOfClass:[UINavigationController class]]) {
            [(UINavigationController*)targetViewController popToRootViewControllerAnimated:YES];
        }
        return;
    }
    //NSLog(@"Display View.");
    _selectedIndex = index;
    
    //    if (_selectedIndex == 2)
    //    {
    //        NSLog(@"我是我的需求");
    //        LandingController *landing = [[LandingController alloc]init];
    //        [self presentViewController:landing animated:YES completion:nil];
    //        return;
    //    }
    
	[_transitionView.subviews makeObjectsPerformSelector:@selector(setHidden:) withObject:(id)YES];
    targetViewController.view.hidden = NO;
	targetViewController.view.frame = _transitionView.frame;
	if ([targetViewController.view isDescendantOfView:_transitionView])
	{
		[_transitionView bringSubviewToFront:targetViewController.view];
	}
	else
	{
		[_transitionView addSubview:targetViewController.view];
	}
    
    // Notify the delegate, the viewcontroller has been changed.
    if ([_delegate respondsToSelector:@selector(tabBarController:didSelectViewController:)])
    {
        [_delegate tabBarController:self didSelectViewController:targetViewController];
    }
}

//- (void)setNumIcon:(int)numIndex andForImageId:(int)imgIndex{
//    UIButton * button=[self.tabBar.buttons objectAtIndex:imgIndex-1];
//    buttonIndex=imgIndex;
//    for (UIView * view in [button subviews]  ) {
//        if ([view isKindOfClass:[UIImageView class]]) {
//            UIImageView * imageView=(UIImageView*)view;
//            for (UIView * subview in [imageView subviews]) {
//                if ([subview isKindOfClass:[UILabel class]]) {
//                    UILabel * label=(UILabel*)subview;
//                    label.text=[NSString stringWithFormat:@"%d",numIndex];
//                    return;
//                }
//            }
//                UILabel * label=[[UILabel alloc]initWithFrame:imageView.frame] ;
//                label.backgroundColor=[UIColor clearColor];
//                label.textAlignment=NSTextAlignmentCenter;
//                label.text=[NSString stringWithFormat:@"%d",numIndex];
//                [imageView addSubview:label];
//                [label release];
//        }
//    }
//}

- (void)setNumIcon:(int)numIndex andForImageId:(int)imgIndex
{
   if (0!=numIndex) {
        redIcon.hidden=NO;
        //UIButton * button=[self.tabBar.buttons objectAtIndex:imgIndex-1];
        //buttonIndex=imgIndex;
        for (UIView * view in redIcon.subviews) {
            if ([view isKindOfClass:[UILabel class]])
            {
                UIColor *color = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Privateletter_unread.png"]];
                UILabel *label=(UILabel *)view;
                [label setFrame:CGRectMake(11, 3, 15, 15)];
                [label setBackgroundColor:color];
                [label setTextAlignment:NSTextAlignmentCenter];

                if(numIndex < 10)
                {
                    [label setFont:FONT9_SYSTEM];
                    label.text = [NSString stringWithFormat:@"%d",numIndex];
                }
                else if(numIndex < 100)
                {
                    [label setFont:FONT8_SYSTEM];
                    label.text = [NSString stringWithFormat:@"%d",numIndex];
                }
                else
                {
                    [label setFont:FONT7_SYSTEM];
                    label.text = @"99+";
                }
                //NSLog(@"label.text=%@",label.text);
            }
        }
    }
    else if(0==numIndex)
    {
        redIcon.hidden=YES;
    }
    
    //newsLabel.text=[NSString stringWithFormat:@"%d",numIndex];
    //redIcon bringSubviewToFront:newsLabel];
    //[button bringSubviewToFront:redIcon];
}

#pragma mark -
#pragma mark tabBar delegates
- (void)tabBar:(LeveyTabBar *)tabBar didSelectIndex:(NSInteger)index
{
    
	[self displayViewAtIndex:index];
    
    if (index == 4 )
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTable" object:nil];
    }
    [[self.viewControllers objectAtIndex:index] viewWillAppear:YES];
    
    
    if (buttonIndex-1>=0)
    {
        UIButton * button=[self.tabBar.buttons objectAtIndex:buttonIndex-1];
        for (UIView * view in [button subviews]  )
        {
            if ([view isKindOfClass:[UIImageView class]])
            {
                UIImageView * imageView=(UIImageView*)view;
                for (UIView * subview in [imageView subviews])
                {
                    if ([subview isKindOfClass:[UILabel class]])
                    {
                        [subview removeFromSuperview];
                        
                    }
                }
            }
        }
        
    }
    
}

#pragma mark -接口部分



@end
