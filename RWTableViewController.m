//
//  RWTableViewController.m
//  UDo
//
//  Created by Soheil Azarpour on 12/21/13.
//  Copyright (c) 2013 Ray Wenderlich. All rights reserved.
//

#import "RWTableViewController.h"
#import "RWBasicTableViewCell.h"
#import "UIAlertView+RWBlock.h"
#import <Parse/Parse.h>

@interface RWTableViewController ()

@property (strong, nonatomic) NSMutableArray *_objects;

@end

@implementation RWTableViewController{
    NSArray *tableData;
    UIFont *italicFont;
}

@synthesize _objects;

#pragma mark - Custom accessors

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
}

#pragma mark - View life cycle

- (void)viewDidLoad {

    [super viewDidLoad];

    _objects = [NSMutableArray arrayWithObjects:@"Lorem Ipsum is simply dummy text  Ipsum is simply dummy text of the pr of the printing and typesettin",@"Check out the report and finalize it, please call me when you're done", nil];
    [self.tableView registerClass: [RWBasicTableViewCell class] forCellReuseIdentifier:@"Cell Identifier"];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.allowsSelection = NO;
    
    italicFont = [UIFont fontWithName:@"BrandonText-ThinItalic" size:12];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureRecognized:)];
    [self.tableView addGestureRecognizer:longPress];
    
    self.tableView.contentInset = UIEdgeInsetsMake(25, 0, 0, 0);
    
    [self QueryForTasks];

}

- (void) QueryForTasks{
    
    PFUser *user = [PFUser currentUser];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Delegate"];
    
    [query whereKey:@"sentTo"  equalTo:[PFUser currentUser]]; // "user" must be pointer in the post class (table)
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *obj in objects) {
                NSLog(@"object %@",obj);
            }
            
        }
        if (error) {
            NSLog(@"Retreive Error");
        }
    }];
}
     
#pragma mark - UITableView data source and delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_objects count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(19, view.frame.origin.y, view.frame.size.width-19, view.frame.size.height)];
    label.textColor = [[UIColor alloc] initWithRed:76/255.0f green:76/255.0f blue:76/255.0f alpha:1.0f];
    [label setFont:[UIFont fontWithName:@"BrandonText-Regular" size:12]];
    
    NSString *string = [self.tableView.dataSource tableView:tableView titleForHeaderInSection:section];
    [label setText:string];
    
    [view addSubview:label];
    return view;

}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    switch (section)
    {
        case 0:
            sectionName = NSLocalizedString(@"Morning", @"Morning");
            break;
        case 1:
            sectionName = NSLocalizedString(@"Afternoon", @"Afternoon");
            break;
        case 2:
            sectionName = NSLocalizedString(@"Evening", @"Evening");
            break;

        default:
            sectionName = @"Anytime";
            break;
    }
    return sectionName;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    static NSString *kIdentifier = @"Cell Identifier";
  
    //RWBasicTableViewCell *cell = [[RWBasicTableViewCell alloc] init];
    
    RWBasicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kIdentifier];

    if (cell == nil) {
        cell = [[RWBasicTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kIdentifier];
    }
    
    cell.selectedBackgroundView = [[UIView alloc] init];
    cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
  
  // Update cell content from data source.
    NSString *object = [_objects objectAtIndex:indexPath.row];
    NSString *reminderString = @"12:54am";
    NSString *appendedObject = [object stringByAppendingString:@"\n"];
    appendedObject = [appendedObject stringByAppendingString:reminderString];
    [cell.taskName setText:appendedObject];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:appendedObject];
    [str addAttribute:NSFontAttributeName value:italicFont range:NSMakeRange(object.length+1, reminderString.length)];
    cell.taskName.attributedText = str;
    [cell.taskName sizeToFit];
  
  return cell;
}

- (NSMutableAttributedString*)appendReminderToString: (NSMutableAttributedString *)taskDescription {
    
    UIColor *customRed = [[UIColor alloc] initWithRed:250/255.0f green:92/255.0f blue:109/255.0f alpha:1.0f];
    
    int startRange = 0;
    int endRange = 0;
    
    NSString *task = taskDescription;
    NSString *spacing = @"\n";
    NSString *reminderString = @"12:54am";
    NSString *s;
    
    s = [s stringByAppendingString:task];
    s = [s stringByAppendingString:spacing];
    s = [s stringByAppendingString:reminderString];

    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString: s];
    [text addAttribute:NSForegroundColorAttributeName
                 value:customRed
                 range:NSMakeRange(startRange, endRange)];
    return text;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
  return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
  return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
  [self._objects removeObjectAtIndex:indexPath.row];
  [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - IBActions

- (IBAction)addButtonPressed:(id)sender {
  
  // Display an alert view with a text input.
  UIAlertView *inputAlertView = [[UIAlertView alloc] initWithTitle:@"Add a new to-do item:" message:nil delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:@"Add", nil];
  
  inputAlertView.alertViewStyle = UIAlertViewStylePlainTextInput;
  
  __weak RWTableViewController *weakself = self;
  
  // Add a completion block (using our category to UIAlertView).
  [inputAlertView setCompletionBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
    
    // If user pressed 'Add'...
    if (buttonIndex == 1) {
      
      UITextField *textField = [alertView textFieldAtIndex:0];
      NSString *string = [textField.text capitalizedString];
      [weakself._objects addObject:string];
      
      NSUInteger row = [weakself._objects count] - 1;
      NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
      [weakself.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
  }];
  
  [inputAlertView show];
}

- (IBAction)longPressGestureRecognized:(id)sender {
    
  UILongPressGestureRecognizer *longPress = (UILongPressGestureRecognizer *)sender;
  UIGestureRecognizerState state = longPress.state;
  
  CGPoint location = [longPress locationInView:self.tableView];
  NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];
  
  static UIView       *snapshot = nil;        ///< A snapshot of the row user is moving.
  static NSIndexPath  *sourceIndexPath = nil; ///< Initial index path, where gesture begins.
  
  switch (state) {
    case UIGestureRecognizerStateBegan: {
      if (indexPath) {
        sourceIndexPath = indexPath;
        
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        
        // Take a snapshot of the selected row using helper method.
        snapshot = [self customSnapshoFromView:cell];
        
        // Add the snapshot as subview, centered at cell's center...
        __block CGPoint center = cell.center;
        snapshot.center = center;
        snapshot.alpha = 0.0;
        [self.tableView addSubview:snapshot];
        [UIView animateWithDuration:0.25 animations:^{
          
          // Offset for gesture location.
          center.y = location.y;
          snapshot.center = center;
          snapshot.transform = CGAffineTransformMakeScale(1.05, 1.05);
          snapshot.alpha = 0.98;
          cell.alpha = 0.0;
          
        } completion:^(BOOL finished) {
          
          cell.hidden = YES;
          
        }];
      }
      break;
    }
      
    case UIGestureRecognizerStateChanged: {
      CGPoint center = snapshot.center;
      center.y = location.y;
      snapshot.center = center;
      
        // Is destination valid and is it different from source?
        //added that the indexPath section has to be the same as the source index path. Can't reorder between sections.
        
      if (indexPath && ![indexPath isEqual:sourceIndexPath] && (indexPath.section == sourceIndexPath.section)) {
        
        // ... update data source.
        [self._objects exchangeObjectAtIndex:indexPath.row withObjectAtIndex:sourceIndexPath.row];
        
        // ... move the rows.
        [self.tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:indexPath];
        
        // ... and update source so it is in sync with UI changes.
        sourceIndexPath = indexPath;
      }
      break;
    }
      
    default: {
      // Clean up.
      UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:sourceIndexPath];
      cell.hidden = NO;
      cell.alpha = 0.0;
      
      [UIView animateWithDuration:0.25 animations:^{
        
        snapshot.center = cell.center;
        snapshot.transform = CGAffineTransformIdentity;
        snapshot.alpha = 0.0;
        cell.alpha = 1.0;
        
      } completion:^(BOOL finished) {
        
        sourceIndexPath = nil;
        [snapshot removeFromSuperview];
        snapshot = nil;
        
      }];
      
      break;
    }
  }
}

//- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
//    // Add your Colour.
//    RWBasicTableViewCell *cell = (RWBasicTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
//    [self setCellColor:[UIColor whiteColor] ForCell:cell];  //highlight colour
//}
//
//- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
//    // Reset Colour.
//    RWBasicTableViewCell *cell = (RWBasicTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
//    [self setCellColor:[UIColor colorWithWhite:0.961 alpha:1.000] ForCell:cell]; //normal color
//}
//
//- (void)setCellColor:(UIColor *)color ForCell:(UITableViewCell *)cell {
//    cell.contentView.backgroundColor = color;
//    cell.backgroundColor = color;
//}

#pragma mark - Helper methods

/** @brief Returns a customized snapshot of a given view. */
- (UIView *)customSnapshoFromView:(UIView *)inputView {
  
  // Make an image from the input view.
  UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, NO, 0);
  [inputView.layer renderInContext:UIGraphicsGetCurrentContext()];
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
    
  // Create an image view.
  UIView *snapshot = [[UIImageView alloc] initWithImage:image];
  snapshot.layer.masksToBounds = NO;
  snapshot.layer.cornerRadius = 0.0;
  snapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0);
  snapshot.layer.shadowRadius = 5.0;
  snapshot.layer.shadowOpacity = 0.4;
  
  return snapshot;
}

@end
