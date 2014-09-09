//
//  LeveyTabBar.m
//  LeveyTabBarController
//
//  Created by Levey Zhu on 12/15/10.
//  Copyright 2010 VanillaTech. All rights reserved.
//

#import "LeveyTabBar.h"

#define mainFrame     [[UIScreen mainScreen]applicationFrame]

@implementation LeveyTabBar
@synthesize backgroundView = _backgroundView;
@synthesize delegate = _delegate;
@synthesize buttons = _buttons;
@synthesize contactTagBool;
- (id)initWithFrame:(CGRect)frame buttonImages:(NSArray *)imageArray
{
    self = [super initWithFrame:frame];
    if (self)
	{
        currIndex = 0;
        
		self.backgroundColor = [UIColor clearColor];
		_backgroundView = [[UIImageView alloc] initWithFrame:self.bounds];
		[self addSubview:_backgroundView];
		
		self.buttons = [NSMutableArray arrayWithCapacity:[imageArray count]];
		UIButton *btn;
		CGFloat width = 320.0f / [imageArray count];
		for (int i = 0; i < [imageArray count]; i++)
		{
			btn = [UIButton buttonWithType:UIButtonTypeCustom];
			btn.showsTouchWhenHighlighted = NO;
            btn.exclusiveTouch = YES;
			btn.tag = i;
			btn.frame = CGRectMake(width * i, 0, width, frame.size.height);
			[btn setImage:[[imageArray objectAtIndex:i] objectForKey:@"Default"] forState:UIControlStateNormal];
//			[btn setImage:[[imageArray objectAtIndex:i] objectForKey:@"Highlighted"] forState:UIControlStateHighlighted];
			[btn setImage:[[imageArray objectAtIndex:i] objectForKey:@"Seleted"] forState:UIControlStateSelected];
			[btn addTarget:self action:@selector(tabBarButtonClicked:) forControlEvents:UIControlEventTouchDown];
            btn.adjustsImageWhenHighlighted=NO;
			[self.buttons addObject:btn];
			[self addSubview:btn];
		}
        
        contactTagBool = 1;//通讯录标签打开判定，1为可以跳转
    }
    return self;
}

- (void)setBackgroundImage:(UIImage *)img
{
	[_backgroundView setImage:img];
}

- (void)tabBarButtonClicked:(id)sender
{
	UIButton *btn = sender;
	[self selectTabAtIndex:btn.tag];

}

- (void)selectTabAtIndex:(NSInteger)index
{
    //create by liu
    for (int i = 0; i < [self.buttons count]; i++)
    {
        UIButton *b = [self.buttons objectAtIndex:i];
        b.selected = NO;
    }
    
    if (index==0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Home" object:[NSString stringWithFormat:@"%d",index]];
    }
    else if(index == 1)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"private" object:[NSString stringWithFormat:@"%d",index]];
    }
    else if(index == 2)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Activity" object:[NSString stringWithFormat:@"%d",index]];
    }
    else if(index == 3)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"setup" object:[NSString stringWithFormat:@"%d",index]];
    }
    
    if(!IFLOGINYES && (index == 1))
    {
        UIButton *btn = [self.buttons objectAtIndex:currIndex];
        btn.selected = YES;
        if ([_delegate respondsToSelector:@selector(tabBar:didSelectIndex:)])
        {
            [_delegate tabBar:self didSelectIndex:currIndex];
        }
    }
    else
    {
        UIButton *btn = [self.buttons objectAtIndex:index];
        btn.selected = YES;
        if ([_delegate respondsToSelector:@selector(tabBar:didSelectIndex:)])
        {
            [_delegate tabBar:self didSelectIndex:btn.tag];
        }
        NSLog(@"Select index: %d",btn.tag);
        
        currIndex = index;
    }
}

- (void)removeTabAtIndex:(NSInteger)index
{
    // Remove button
    [(UIButton *)[self.buttons objectAtIndex:index] removeFromSuperview];
    [self.buttons removeObjectAtIndex:index];
   
    // Re-index the buttons
     CGFloat width = 320.0f / [self.buttons count];
    for (UIButton *btn in self.buttons) 
    {
        if (btn.tag > index)
        {
            btn.tag --;
        }
        btn.frame = CGRectMake(width * btn.tag, 0, width, self.frame.size.height);
    }
}
- (void)insertTabWithImageDic:(NSDictionary *)dict atIndex:(NSUInteger)index
{
    // Re-index the buttons
    CGFloat width = 320.0f / ([self.buttons count] + 1);
    for (UIButton *b in self.buttons) 
    {
        if (b.tag >= index)
        {
            b.tag ++;
        }
        b.frame = CGRectMake(width * b.tag, 0, width, self.frame.size.height);
    }
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.showsTouchWhenHighlighted = YES;
    btn.tag = index;
    btn.frame = CGRectMake(width * index, 0, width, self.frame.size.height);
    [btn setImage:[dict objectForKey:@"Default"] forState:UIControlStateNormal];
    [btn setImage:[dict objectForKey:@"Highlighted"] forState:UIControlStateHighlighted];
    [btn setImage:[dict objectForKey:@"Seleted"] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(tabBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttons insertObject:btn atIndex:index];
    [self addSubview:btn];
}

- (void)dealloc
{
    [_backgroundView release];
    [_buttons release];
    [super dealloc];
}

@end
