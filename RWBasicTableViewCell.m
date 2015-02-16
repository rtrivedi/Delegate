//
//  RWBasicTableViewCell.m
//  UDo
//
//  Created by Soheil M. Azarpour on 8/9/14.
//  Copyright (c) 2014 Soheil Azarpour. All rights reserved.
//

#import "RWBasicTableViewCell.h"

@implementation RWBasicTableViewCell{
    
    UIView *firstThird;
    UIView *Middle;
    UIView *Third;
}

//- (id)initWithFrame:(CGRect)frame
//{   
//    self = [super initWithFrame:frame];
//    if (self) {
//        
//        UIFont *labelFont = [UIFont fontWithName:@"BrandonText-Regular" size:11];
//        UIFont *reminderFont = [UIFont fontWithName:@"BrandonText-ThinItalic" size:10];
//        
//        //NSLog(@"width = %f, height = %f", frame.size.width, frame.size.height);
//
//        firstThird = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width*0.25, frame.size.height)];
//        Middle = [[UIView alloc] initWithFrame:CGRectMake(firstThird.frame.size.width - 5, 0, frame.size.width - firstThird.frame.size.width, frame.size.height)];
//        firstThird.backgroundColor = [UIColor redColor];
//        
//        _senderThumbnail = [[UIImageView alloc] initWithFrame:CGRectMake(19, frame.origin.y*0.5 + 10, 40, 40)];
//        [_senderThumbnail setContentMode:UIViewContentModeScaleAspectFill];
//        _senderThumbnail.layer.cornerRadius = _senderThumbnail.frame.size.width / 2;
//        _senderThumbnail.clipsToBounds = YES;
//        _senderThumbnail.image = [UIImage imageNamed: @"ronakprofile.png"];
//        _senderThumbnail.center = CGPointMake(firstThird.center.x, firstThird.center.y + 10 );
//        
//        _taskName = [[UILabel alloc] initWithFrame:CGRectMake(Middle.frame.origin.x,_senderThumbnail.frame.origin.y, Middle.frame.size.width, 60)];
//        _taskName.textColor = [[UIColor alloc] initWithRed:136/255.0f green:136/255.0f blue:136/255.0f alpha:1.0f];
//        [_taskName setNumberOfLines:4];
//        _taskName.font = labelFont;
//        
//        _reminderTime = [[UILabel alloc] initWithFrame:CGRectMake(Middle.frame.origin.x,_taskName.frame.origin.y + _taskName.frame.size.height, Middle.frame.size.width, 20)];
//        _reminderTime.textColor = [[UIColor alloc] initWithRed:136/255.0f green:136/255.0f blue:136/255.0f alpha:1.0f];
//        _reminderTime.font = reminderFont;
//        
//        UIImage *img = [self imageWithImage:[UIImage imageNamed:@"checkmark.png"] scaledToSize:CGSizeMake(50, 50)];
//        _doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _doneButton.frame = CGRectMake(Middle.frame.origin.x + Middle.frame.size.width, _senderThumbnail.frame.origin.y, 50, 50);
//        _doneButton.center = CGPointMake(_doneButton.center.x, _senderThumbnail.center.y);
//        
//        [_doneButton setImage:img forState:UIControlStateNormal];
//
//        [self.contentView addSubview:firstThird];
//        [self.contentView addSubview:_senderThumbnail];
//        [self.contentView addSubview:_taskName];
//        [self.contentView addSubview:_reminderTime];
//        [self.contentView addSubview:_doneButton];
//        
//    }
//    return self;
//}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIFont *labelFont = [UIFont fontWithName:@"BrandonText-Regular" size:11];
        UIFont *reminderFont = [UIFont fontWithName:@"BrandonText-ThinItalic" size:10];
        UIColor *customGreen = [[UIColor alloc] initWithRed:138/255.0f green:182/255.0f blue:97/255.0f alpha:1.0f];
        
        //NSLog(@"width = %f, height = %f", frame.size.width, frame.size.height);
        
        _senderThumbnail = [[UIImageView alloc] initWithFrame:CGRectMake(19, self.bounds.origin.y*0.5 + 10, 45, 45)];
        [_senderThumbnail setContentMode:UIViewContentModeScaleAspectFill];
        _senderThumbnail.layer.cornerRadius = _senderThumbnail.frame.size.width / 2;
        _senderThumbnail.clipsToBounds = YES;

        _taskName = [[UILabel alloc] initWithFrame:Middle.frame];
        _taskName.textColor = [[UIColor alloc] initWithRed:136/255.0f green:136/255.0f blue:136/255.0f alpha:1.0f];
        [_taskName setNumberOfLines:4];
        _taskName.font = labelFont;
        
        _reminderTime = [[UILabel alloc] initWithFrame:CGRectMake(Middle.frame.origin.x,_taskName.frame.origin.y + _taskName.frame.size.height, Middle.frame.size.width, 20)];
        _reminderTime.textColor = [[UIColor alloc] initWithRed:136/255.0f green:136/255.0f blue:136/255.0f alpha:1.0f];
        _reminderTime.font = reminderFont;
        
//        UIImage *img = [self imageWithImage:[UIImage imageNamed:@"checkmark.png"] scaledToSize:CGSizeMake(50, 50)];
//        _doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_doneButton setImage:img forState:UIControlStateNormal];
        
        _donePaperButton = [[BFPaperButton alloc] initWithFrame:CGRectMake(0,0,40,40)];
        [_donePaperButton setTitle:@"Done" forState:UIControlStateNormal];
        [_donePaperButton setTitleColor: customGreen forState:UIControlStateNormal];
        _donePaperButton.cornerRadius = _donePaperButton.frame.size.width / 2;
        [_donePaperButton setTintColor:[[UIColor alloc] initWithRed:138/255.0f green:182/255.0f blue:97/255.0f alpha:1.0f]];
        [_donePaperButton setBackgroundColor: [UIColor whiteColor]];
        [_donePaperButton setTitleFont:labelFont];
        
        UIImage *img = [self imageWithImage:[UIImage imageNamed:@"delete.png"] scaledToSize:CGSizeMake(45, 45)];
        _propertyOne = [[BFPaperButton alloc] initWithFrame:_senderThumbnail.frame raised:NO];
        [_propertyOne setBackgroundImage:img forState:UIControlStateNormal];
        _propertyOne.cornerRadius = _propertyOne.frame.size.width / 2;
        _propertyOne.layer.masksToBounds = YES;
        _propertyOne.tapCircleColor = [[UIColor alloc] initWithRed:255/255.0f green:72/255.0f blue:72/255.0f alpha:1.0f];

        
        UIImage *img2 = [self imageWithImage:[UIImage imageNamed:@"dropbox.png"] scaledToSize:CGSizeMake(45, 45)];
        _propertyTwo = [[BFPaperButton alloc] initWithFrame:_senderThumbnail.frame raised:NO];
        [_propertyTwo setBackgroundImage:img2 forState:UIControlStateNormal];
        _propertyTwo.cornerRadius = _propertyTwo.frame.size.width / 2;
        _propertyTwo.layer.masksToBounds = YES;
        _propertyTwo.tapCircleColor = [[UIColor alloc] initWithRed:0/255.0f green:123/255.0f blue:239/255.0f alpha:1.0f];

        
        UIImage *img3 = [self imageWithImage:[UIImage imageNamed:@"message.png"] scaledToSize:CGSizeMake(45, 45)];
        _propertyThree = [[BFPaperButton alloc] initWithFrame:_senderThumbnail.frame raised:NO];
        [_propertyThree setBackgroundImage:img3 forState:UIControlStateNormal];
        _propertyThree.cornerRadius = _propertyThree.frame.size.width / 2;
        _propertyThree.layer.masksToBounds = YES;
        _propertyThree.tapCircleColor = [[UIColor alloc] initWithRed:236/255.0f green:48/255.0f blue:242/255.0f alpha:1.0f];


        
        UIImage *img4 = [self imageWithImage:[UIImage imageNamed:@"checkmark.png"] scaledToSize:CGSizeMake(45, 45)];
        _propertyFour = [[BFPaperButton alloc] initWithFrame:_senderThumbnail.frame raised:NO];
        [_propertyFour setBackgroundImage:img4 forState:UIControlStateNormal ];
        _propertyFour.cornerRadius = _propertyFour.frame.size.width / 2;
        _propertyFour.layer.masksToBounds = YES;
        _propertyFour.tapCircleColor = [[UIColor alloc] initWithRed:5/255.0f green:201/255.0f blue:65/255.0f alpha:1.0f];

    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    firstThird = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.bounds.size.width*0.25, self.bounds.size.height)];
    Middle = [[UIView alloc] initWithFrame:CGRectMake(firstThird.frame.size.width, 0, self.contentView.bounds.size.width - firstThird.frame.size.width-60, self.bounds.size.height)];
    Third = [[UIView alloc] initWithFrame:CGRectMake(Middle.frame.origin.x + Middle.frame.size.width, 0, 50, self.bounds.size.height)];

    firstThird.backgroundColor = [UIColor redColor];
    Middle.backgroundColor = [UIColor blueColor];
    Third.backgroundColor = [UIColor greenColor];

    _senderThumbnail.image = [UIImage imageNamed: @"ronakprofile.png"];
    _senderThumbnail.center = CGPointMake(firstThird.center.x, firstThird.frame.origin.y + 30);
    
    [_taskName setFrame:CGRectMake(Middle.frame.origin.x, Middle.frame.origin.y-10, Middle.frame.size.width, Middle.frame.size.height*0.5)];
    //_taskName.backgroundColor = [UIColor redColor];
    _donePaperButton.center = CGPointMake(Third.center.x, _senderThumbnail.center.y);
    
    _propertyOne.center = CGPointMake(_taskName.frame.origin.x+22.5, _senderThumbnail.center.y + _taskName.frame.size.height);
    //_propertyOne.center = CGPointMake(_senderThumbnail.center.x, _senderThumbnail.center.y + _taskName.frame.size.height);
    _propertyTwo.center = CGPointMake(_propertyOne.frame.origin.x+80, _propertyOne.center.y);
    _propertyThree.center = CGPointMake(_propertyTwo.frame.origin.x+80, _propertyTwo.center.y);
    _propertyFour.center = CGPointMake(_propertyThree.frame.origin.x+80, _propertyThree.center.y);

//    [_doneButton setFrame:Third.frame];
//    _doneButton.center = CGPointMake(Third.center.x, _senderThumbnail.center.y);
    
    //[self.contentView addSubview:firstThird];
    //[self.contentView addSubview:Middle];
    //[self.contentView addSubview:Third];
    [self.contentView addSubview:_senderThumbnail];
    [self.contentView addSubview:_taskName];
    [self.contentView addSubview:_reminderTime];
    //[self.contentView addSubview:_donePaperButton];
    [self.contentView addSubview:_propertyOne];
    [self.contentView addSubview:_propertyTwo];
    [self.contentView addSubview:_propertyThree];
    [self.contentView addSubview:_propertyFour];


    



}

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


- (void)prepareForReuse
{
    [super prepareForReuse];
}

@end