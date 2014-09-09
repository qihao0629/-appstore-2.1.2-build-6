//
//  Ty_Order_MySetting_WorkerCell.m
//  腾云家务
//
//  Created by lgs on 14-6-18.
//  Copyright (c) 2014年 齐 浩. All rights reserved.
//

#import "Ty_Order_MySetting_WorkerCell.h"

@implementation Ty_Order_MySetting_WorkerCell
@synthesize workerBigImageView;
@synthesize workerSmallImageView;
@synthesize workerSmallImageLabel;
@synthesize servieceTimeLabel;
@synthesize orderStageLabel;
@synthesize orderStageString;
@synthesize workNameLabel;
@synthesize servieceAreaLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        workNameLabel = [[UILabel alloc]init];
        
        [workNameLabel setFrame:CGRectMake(10,10,90, 15)];
        [workNameLabel setBackgroundColor:[UIColor clearColor]];
        [workNameLabel setHighlightedTextColor:[UIColor whiteColor]];
        workNameLabel.textColor = [UIColor grayColor];
        [workNameLabel setFont:FONT15_BOLDSYSTEM];
        [workNameLabel setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:workNameLabel];

        //抢单和预约绿色的
        workerSmallImageView = [[UIImageView alloc]init];
        [workerSmallImageView setFrame:CGRectMake(workNameLabel.frame.origin.x + workNameLabel.frame.size.width +8, 10, 26,16)];
        workerSmallImageView.layer.masksToBounds = YES;
        workerSmallImageView.layer.cornerRadius = 3;
        [workerSmallImageView setContentMode:UIViewContentModeScaleAspectFit];
        
        workerSmallImageLabel = [[UILabel alloc]initWithFrame:CGRectMake(2, 3, 22, 11)];
        [self.workerSmallImageLabel setBackgroundColor:[UIColor clearColor]];
        [self.workerSmallImageLabel setFont:FONT11_SYSTEM];
        [self.workerSmallImageLabel setTextColor:[UIColor whiteColor]];
        [self.workerSmallImageLabel setTextAlignment:NSTextAlignmentLeft];
        [self.workerSmallImageView addSubview:self.workerSmallImageLabel];
        [self addSubview:workerSmallImageView];

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
        
        workerBigImageView = [[UIImageView alloc]init];
        
        [workerBigImageView setFrame:CGRectMake(10,upGrayLine.frame.origin.y + 1 + 10, 46, 46)];
        workerBigImageView.layer.cornerRadius = 5.0;
        [workerBigImageView setContentMode:UIViewContentModeScaleAspectFit];
        [self addSubview:workerBigImageView];

        servieceAreaLabel = [[UILabel alloc]initWithFrame:CGRectMake(65, upGrayLine.frame.origin.y + 1 + 13, 225, 14)];
        [self.servieceAreaLabel setBackgroundColor:[UIColor clearColor]];
        [self.servieceAreaLabel setFont:FONT14_BOLDSYSTEM];
        [self.servieceAreaLabel setHighlightedTextColor:[UIColor whiteColor]];
        [self.servieceAreaLabel setTextColor:[UIColor grayColor]];
        [self.servieceAreaLabel setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:servieceAreaLabel];

        servieceTimeLabel = [[UILabel alloc]init];
        [servieceTimeLabel setFrame:CGRectMake(65, upGrayLine.frame.origin.y + 1 + 35, 225, 25)];
        [servieceTimeLabel setBackgroundColor:[UIColor clearColor]];
        [servieceTimeLabel setHighlightedTextColor:[UIColor whiteColor]];
        [servieceTimeLabel setTextColor:[UIColor grayColor]];
        [servieceTimeLabel setFont:FONT14_BOLDSYSTEM];
        [servieceTimeLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [self addSubview:servieceTimeLabel];

    }
    return self;
}
-(void)setHight
{
    CGSize labelSize = [workNameLabel.text sizeWithFont:FONT15_BOLDSYSTEM constrainedToSize:CGSizeMake(185, 400) lineBreakMode:NSLineBreakByCharWrapping];
    [workNameLabel setFrame:CGRectMake(10,10,labelSize.width, 15)];
    
    [workerSmallImageView setFrame:CGRectMake(workNameLabel.frame.origin.x + workNameLabel.frame.size.width + 8, 10, 26, 16)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
