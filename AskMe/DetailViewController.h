//
//  DetailViewController.h
//  AskMe
//
//  Created by Ronak Trivedi on 2/10/15.
//  Copyright (c) 2015 RoShow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

