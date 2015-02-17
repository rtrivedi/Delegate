//
//  RWBasicTableViewCell.h
//  UDo
//
//  Created by Soheil M. Azarpour on 8/9/14.
//  Copyright (c) 2014 Soheil Azarpour. All rights reserved.
//

#import "BFPaperButton.h"

@import UIKit;

@interface RWBasicTableViewCell : UITableViewCell

@property (retain, nonatomic) UIImageView *senderThumbnail;
@property (retain, nonatomic) UILabel *taskName;
@property (retain, nonatomic) UILabel *reminderTime;
@property (retain, nonatomic) UIButton *doneButton;
@property (retain, nonatomic) BFPaperButton *donePaperButton;

@property (retain, nonatomic) BFPaperButton *propertyOne;
@property (retain, nonatomic) BFPaperButton *propertyTwo;
@property (retain, nonatomic) BFPaperButton *propertyThree;
@property (retain, nonatomic) BFPaperButton *propertyFour;
@property (retain, nonatomic) BFPaperButton *bumps;
@property (retain, nonatomic) UILabel *bumpCount;



@end
