
#import "RKSwipeBetweenViewControllers.h"

//%%% customizeable button attributes
#define X_BUFFER 0 //%%% the number of pixels on either side of the segment
#define Y_BUFFER 14 //%%% number of pixels on top of the segment
#define HEIGHT 30 //%%% height of the segment

//%%% customizeable selector bar attributes (the black bar under the buttons)
#define ANIMATION_SPEED 0.2 //%%% the number of seconds it takes to complete the animation
#define SELECTOR_Y_BUFFER 69 //%%% the y-value of the bar that shows what page you are on (0 is the top)
#define SELECTOR_HEIGHT 4 //%%% thickness of the selector bar

#define X_OFFSET 8 //%%% for some reason there's a little bit of a glitchy offset.  I'm going to look for a better workaround in the future

@interface RKSwipeBetweenViewControllers () {
    
    UIScrollView *pageScrollView;
    NSInteger currentPageIndex;
}

@end

@implementation RKSwipeBetweenViewControllers
@synthesize viewControllerArray;
@synthesize selectionBar;
@synthesize panGestureRecognizer;
@synthesize pageController;
@synthesize navigationView;
@synthesize buttonText;
@synthesize appTitle;

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIColor *blueBackground =  [[UIColor alloc] initWithRed:30/255.0f green:170/255.0f blue:241/255.0f alpha:1.0f];
    
    self.navigationBar.backgroundColor = blueBackground;
    self.navigationBar.barTintColor = blueBackground; //%%% bartint
    self.navigationBar.translucent = NO;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    viewControllerArray = [[NSMutableArray alloc]init];
    currentPageIndex = 0;
}

//%%% color of the status bar
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
    
//    return UIStatusBarStyleDefault;
}

//%%% sets up the tabs using a loop.  You can take apart the loop to customize individual buttons, but remember to tag the buttons.  (button.tag=0 and the second button.tag=1, etc)
-(void)setupSegmentButtons
{
    navigationView = [[UIView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.navigationBar.frame.size.height)];
    navigationView.backgroundColor = [[UIColor alloc] initWithRed:30/255.0f green:170/255.0f blue:241/255.0f alpha:1.0f];
    
    appTitle = [[UILabel alloc] initWithFrame:CGRectMake(0,0,100,self.navigationBar.frame.size.height)];
    appTitle.center = self.navigationBar.center;
    appTitle.text = @"Delegate";
    appTitle.font = [UIFont fontWithName:@"BrandonText-Thin" size:18];
    appTitle.textColor = [UIColor whiteColor];
    [navigationView addSubview: appTitle];

    NSInteger numControllers = [viewControllerArray count];
    
    if (!buttonText) {
         buttonText = [[NSArray alloc]initWithObjects: @"Today",@"Tomorrow",@"Later",nil];
    }
    
    for (int i = 0; i<numControllers; i++) {
        
//        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(X_BUFFER+i*(self.view.frame.size.width-2*X_BUFFER)/numControllers-X_OFFSET, 40, (self.view.frame.size.width-2*X_BUFFER)/numControllers, HEIGHT)];
        
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(i*(self.view.frame.size.width/3) - 8, 43, self.view.frame.size.width/3, HEIGHT)];
        
        [navigationView addSubview:button];
        
        button.tag = i; //%%% IMPORTANT: if you make your own custom buttons, you have to tag them appropriately
        button.backgroundColor = [[UIColor alloc] initWithRed:30/255.0f green:170/255.0f blue:241/255.0f alpha:0.9f];//%%% buttoncolors
        
        [button addTarget:self action:@selector(tapSegmentButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [button setTitle:[buttonText objectAtIndex:i] forState:UIControlStateNormal]; //%%%buttontitle
        button.titleLabel.font = [UIFont fontWithName:@"BrandonText-Regular" size:16];
        
    }
    pageController.navigationController.navigationBar.topItem.titleView = navigationView;
    
    //%%% example custom buttons example:
    /*
    NSInteger width = (self.view.frame.size.width-(2*X_BUFFER))/3;
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(X_BUFFER, Y_BUFFER, width, HEIGHT)];
    UIButton *middleButton = [[UIButton alloc]initWithFrame:CGRectMake(X_BUFFER+width, Y_BUFFER, width, HEIGHT)];
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(X_BUFFER+2*width, Y_BUFFER, width, HEIGHT)];
    
    [self.navigationBar addSubview:leftButton];
    [self.navigationBar addSubview:middleButton];
    [self.navigationBar addSubview:rightButton];
    
    leftButton.tag = 0;
    middleButton.tag = 1;
    rightButton.tag = 2;
    
    leftButton.backgroundColor = [UIColor colorWithRed:0.03 green:0.07 blue:0.08 alpha:1];
    middleButton.backgroundColor = [UIColor colorWithRed:0.03 green:0.07 blue:0.08 alpha:1];
    rightButton.backgroundColor = [UIColor colorWithRed:0.03 green:0.07 blue:0.08 alpha:1];
    
    [leftButton addTarget:self action:@selector(tapSegmentButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [middleButton addTarget:self action:@selector(tapSegmentButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton addTarget:self action:@selector(tapSegmentButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [leftButton setTitle:@"left" forState:UIControlStateNormal];
    [middleButton setTitle:@"middle" forState:UIControlStateNormal];
    [rightButton setTitle:@"right" forState:UIControlStateNormal];
     */
    
    [self setupSelector];
}


//%%% sets up the selection bar under the buttons on the navigation bar
-(void)setupSelector
{
    selectionBar = [[UIView alloc]initWithFrame:CGRectMake(X_BUFFER-X_OFFSET, SELECTOR_Y_BUFFER,(self.view.frame.size.width-2*X_BUFFER)/[viewControllerArray count], SELECTOR_HEIGHT)];
    selectionBar.backgroundColor = [[UIColor alloc] initWithRed:241/255.0f green:43/255.0f blue:130/255.0f alpha:1.0f]; //%%% sbcolor
    //selectionBar.alpha = 0.8; //%%% sbalpha
    [navigationView addSubview:selectionBar];
}



//generally, this shouldn't be changed unless you know what you're changing
////////////////////////////////////////////////////////////
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%        SETUP       %%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//                                                        //

-(void)viewWillAppear:(BOOL)animated
{
    [self setupPageViewController];
    [self setupSegmentButtons];
    
//    for (NSString* family in [UIFont familyNames])
//    {
//        NSLog(@"%@", family);
//        
//        for (NSString* name in [UIFont fontNamesForFamilyName: family])
//        {
//            NSLog(@"  %@", name);
//        }
//    }
}

//%%% generic setup stuff for a pageview controller.  Sets up the scrolling style and delegate for the controller
-(void)setupPageViewController
{
    pageController = (UIPageViewController*)self.topViewController;
    pageController.delegate = self;
    pageController.dataSource = self;
    [pageController setViewControllers:@[[viewControllerArray objectAtIndex:0]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    [self syncScrollView];
}

//%%% this allows us to get information back from the scrollview, namely the coordinate information that we can link to the selection bar.
-(void)syncScrollView
{
    for (UIView* view in pageController.view.subviews){
        if([view isKindOfClass:[UIScrollView class]])
        {
            pageScrollView = (UIScrollView *)view;
            pageScrollView.delegate = self;
        }
    }
}


//                                                        //
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%        SETUP       %%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
////////////////////////////////////////////////////////////




//%%% methods called when you tap a button or scroll through the pages
// generally shouldn't touch this unless you know what you're doing or
// have a particular performance thing in mind
//////////////////////////////////////////////////////////
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%        MOVEMENT         %%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//                                                      //

//%%% when you tap one of the buttons, it shows that page,
//but it also has to animate the other pages to make it feel like you're crossing a 2d expansion,
//so there's a loop that shows every view controller in the array up to the one you selected
//eg: if you're on page 1 and you click tab 3, then it shows you page 2 and then page 3
-(void)tapSegmentButtonAction:(UIButton *)button
{
    NSInteger tempIndex = currentPageIndex;
    
    __weak typeof(self) weakSelf = self;
    
    //%%% check to see if you're going left -> right or right -> left
    if (button.tag > tempIndex) {
        
        //%%% scroll through all the objects between the two points
        for (int i = (int)tempIndex+1; i<=button.tag; i++) {
            [pageController setViewControllers:@[[viewControllerArray objectAtIndex:i]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL complete){
                
                //%%% if the action finishes scrolling (i.e. the user doesn't stop it in the middle),
                //then it updates the page that it's currently on
                if (complete) {
                    [weakSelf updateCurrentPageIndex:i];
                }
            }];
        }
    }
    
    //%%% this is the same thing but for going right -> left
    else if (button.tag < tempIndex) {
        for (int i = (int)tempIndex-1; i >= button.tag; i--) {
            [pageController setViewControllers:@[[viewControllerArray objectAtIndex:i]] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:^(BOOL complete){
                if (complete) {
                    [weakSelf updateCurrentPageIndex:i];
                }
            }];
        }
    }
}

//%%% makes sure the nav bar is always aware of what page you're on
//in reference to the array of view controllers you gave
-(void)updateCurrentPageIndex:(int)newIndex
{
    currentPageIndex = newIndex;
}

//%%% method is called when any of the pages moves.
//It extracts the xcoordinate from the center point and instructs the selection bar to move accordingly
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat xFromCenter = self.view.frame.size.width-pageScrollView.contentOffset.x; //%%% positive for right swipe, negative for left
    
    //%%% checks to see what page you are on and adjusts the xCoor accordingly.
    //i.e. if you're on the second page, it makes sure that the bar starts from the frame.origin.x of the
    //second tab instead of the beginning
    NSInteger xCoor = X_BUFFER+selectionBar.frame.size.width*currentPageIndex-X_OFFSET;
    selectionBar.frame = CGRectMake(xCoor-xFromCenter/[viewControllerArray count], selectionBar.frame.origin.y, selectionBar.frame.size.width, selectionBar.frame.size.height);
}

//                                                      //
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%         MOVEMENT         %%%%%%%%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//////////////////////////////////////////////////////////


//%%% the delegate functions for UIPageViewController.
//Pretty standard, but generally, don't touch this.
////////////////////////////////////////////////////////////
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%       UIPageViewController Delegate       %%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger index = [self indexOfController:viewController];
    
    if ((index == NSNotFound) || (index == 0)) {
        return nil;
    }
    
    index--;
    return [viewControllerArray objectAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger index = [self indexOfController:viewController];
    
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    
    if (index == [viewControllerArray count]) {
        return nil;
    }
    return [viewControllerArray objectAtIndex:index];
}

-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    if (completed) {
        currentPageIndex = [self indexOfController:[pageViewController.viewControllers lastObject]];
    }
}


//%%% checks to see which item we are currently looking at from the array of view controllers.
// not really a delegate method, but is used in all the delegate methods, so might as well include it here
-(NSInteger)indexOfController:(UIViewController *)viewController
{
    for (int i = 0; i<[viewControllerArray count]; i++) {
        if (viewController == [viewControllerArray objectAtIndex:i])
        {
            return i;
        }
    }
    return NSNotFound;
}

//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
//%%%%%%       UIPageViewController Delegate       %%%%%%%//
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%//
////////////////////////////////////////////////////////////

@end
