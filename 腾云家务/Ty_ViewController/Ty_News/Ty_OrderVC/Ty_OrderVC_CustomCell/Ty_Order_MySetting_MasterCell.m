//
//  Ty_Order_MySetting_MasterCell.m
//  腾云家务
//
//  Created by lgs on 14-6-18.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_Order_MySetting_MasterCell.h"

@implementation Ty_Order_MySetting_MasterCell
@synthesize masterSmallImageView;
@synthesize masterSmallImageLabel;
@synthesize servieceTimeLabel;
//@synthesize receivedTimeLabel;
@synthesize orderStageLabel;
@synthesize orderStageString;
@synthesize workerNameLabel;
@synthesize workNameLabel;
@synthesize masterBigImageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setFrame:CGRectMake(10, 0, MainFrame.size.width - 20, 101)];
        
        workNameLabel = [[UILabel alloc]init];
        
        [workNameLabel setFrame:CGRectMake(10,10,90, 15)];
        [workNameLabel setBackgroundColor:[UIColor clearColor]];
        [workNameLabel setHighlightedTextColor:[UIColor whiteColor]];
        workNameLabel.textColor = [UIColor grayColor];
        [workNameLabel setFont:FONT15_BOLDSYSTEM];
        [workNameLabel setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:workNameLabel];
        
        //抢单和预约绿色的
        masterSmallImageView = [[UIImageView alloc]init];
        [masterSmallImageView setFrame:CGRectMake(workNameLabel.frame.origin.x + workNameLabel.frame.size.width +8, 10, 26,16)];
        masterSmallImageView.layer.masksToBounds = YES;
        masterSmallImageView.layer.cornerRadius = 3;
        [masterSmallImageView setContentMode:UIViewContentModeScaleAspectFit];
        
        masterSmallImageLabel = [[UILabel alloc]initWithFrame:CGRectMake(2, 3, 22, 11)];
        [self.masterSmallImageLabel setBackgroundColor:[UIColor clearColor]];
        [self.masterSmallImageLabel setFont:FONT11_SYSTEM];
        [self.masterSmallImageLabel setTextColor:[UIColor whiteColor]];
        [self.masterSmallImageLabel setTextAlignment:NSTextAlignmentLeft];
        [self.masterSmallImageView addSubview:self.masterSmallImageLabel];
        [self addSubview:masterSmallImageView];

        orderStageLabel  = [[UILabel alloc]initWithFrame:CGRectMake(170, 6, 120, 25)];
        [orderStageLabel setBackgroundColor:[UIColor clearColor]];
        [orderStageLabel setFont:FONT15_BOLDSYSTEM];
        [orderStageLabel setTextColor:[UIColor redColor]];
        [orderStageLabel setHighlightedTextColor:[UIColor whiteColor]];
        [orderStageLabel setTextAlignment:NSTextAlignmentRight];
        [self addSubview:orderStageLabel];

        
        upGrayLine = [[UIView alloc]initWithFrame:CGRectMake(0, 34, 300, 1)];
        [upGrayLine setBackgroundColor:[UIColor grayColor]];
        [self addSubview:upGrayLine];
        
        masterBigImageView = [[UIImageView alloc]init];
        
        [masterBigImageView setFrame:CGRectMake(10,upGrayLine.frame.origin.y + 1 + 10, 46, 46)];
        masterBigImageView.layer.cornerRadius = 5.0;
        [masterBigImageView setContentMode:UIViewContentModeScaleAspectFit];
        [self addSubview:masterBigImageView];
        
        servieceTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(65, upGrayLine.frame.origin.y + 1 + 13, 225, 14)];
        [self.servieceTimeLabel setBackgroundColor:[UIColor clearColor]];
        [self.servieceTimeLabel setFont:FONT14_BOLDSYSTEM];
        [self.servieceTimeLabel setHighlightedTextColor:[UIColor whiteColor]];
        [self.servieceTimeLabel setTextColor:[UIColor grayColor]];
        [self.servieceTimeLabel setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:servieceTimeLabel];

        workerNameLabel = [[UILabel alloc]init];
        [workerNameLabel setFrame:CGRectMake(65, upGrayLine.frame.origin.y + 1 + 35, 225, 25)];
        [workerNameLabel setBackgroundColor:[UIColor clearColor]];
        [workerNameLabel setHighlightedTextColor:[UIColor whiteColor]];
        [workerNameLabel setTextColor:[UIColor grayColor]];
        [workerNameLabel setFont:FONT14_BOLDSYSTEM];
        [workerNameLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [self addSubview:workerNameLabel];

        
//        receivedTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(245, 17.5, 65, 25)];
//        [receivedTimeLabel setBackgroundColor:[UIColor clearColor]];
//        [receivedTimeLabel setTextColor:[UIColor grayColor]];
//        [receivedTimeLabel setHighlightedTextColor:[UIColor whiteColor]];
//        [receivedTimeLabel setFont:FONT14_SYSTEM];
//        [receivedTimeLabel setTextAlignment:NSTextAlignmentRight];
//        [self addSubview: receivedTimeLabel];
//        
    }
    return self;
}
-(void)setHight
{
    CGSize labelSize = [workNameLabel.text sizeWithFont:FONT15_BOLDSYSTEM constrainedToSize:CGSizeMake(185, 400) lineBreakMode:NSLineBreakByCharWrapping];
    [workNameLabel setFrame:CGRectMake(10,10,labelSize.width, 15)];
    
    [masterSmallImageView setFrame:CGRectMake(workNameLabel.frame.origin.x + workNameLabel.frame.size.width + 8, 10, 26, 16)];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
