#import "ViewController.h"
#import "CarbonKit.h"
#import "DragDropBackground.h"
#import "CollectionViewController.h"

@interface ViewController () <DropProtocol>{
    CarbonTabSwipeNavigation *tabSwipe;
    NSArray *names ;
}

@property (strong, nonatomic) DragDropBackground *dragdropBGView;

@end

@implementation ViewController
@synthesize contentView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    names= @[@"appleton-white.jpg",
             @"aspirina-40pzas.jpg" ,
             @"absolut-azul-750ml-2.jpg" ,
             @"absolut-mandarin-750ml-2.jpg"];
    
    UIColor *color = self.navigationController.navigationBar.barTintColor;
    tabSwipe = [[CarbonTabSwipeNavigation alloc] createWithRootViewController:self tabNames:names tintColor:color delegate:self];
    [tabSwipe setIndicatorHeight:2.f]; // default 3.f
    [tabSwipe addShadow];
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [tabSwipe setTranslucent:NO]; // remove translucent
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [tabSwipe setTranslucent:YES]; // add translucent
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - Carbon Tab Swipe Delegate
// required
- (UIViewController *)tabSwipeNavigation:(CarbonTabSwipeNavigation *)tabSwipe viewControllerAtIndex:(NSUInteger)index {
    
    /*if (index == 0) {
     ViewControllerOne *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewControllerOne"];
     return viewController;
     } else if (index == 1) {
     ViewControllerTwo *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewControllerTwo"];
     return viewController;
     } else {*/
    CollectionViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CollectionViewController"];
    viewController.image_name = names[index];
    // NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    //[formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    int n = arc4random() % 9000 + 1000;
    viewController.price = [NSString localizedStringWithFormat:@"$ %.2d", n];
    //[formatter stringFromNumber:rand()];
    
    return viewController;
    //}
}

// optional
- (void)tabSwipeNavigation:(CarbonTabSwipeNavigation *)tabSwipe didMoveAtIndex:(NSInteger)index {
    NSLog(@"Current tab: %d", (int)index);
}


- (DragDropBackground *)dragdropBGView {
    if (!_dragdropBGView) {
        _dragdropBGView = [DragDropBackground sharedView];
    }
    _dragdropBGView.delegate = self;
    return _dragdropBGView;
}

/**-----------------------------------------------------------------**/
#pragma mark - ListItemDelegate
- (void)dragView:(UIView *)sourceView beginToPoint:(CGPoint)point {
    [self.dragdropBGView showInView:self.tabBarController.view complete: ^{
        CGPoint pointX = [self.tabBarController.view convertPoint:point fromView:self.self.view];
        [self.dragdropBGView setHitPoint:pointX animated:YES duration:0.25];
    }];
    
    CGPoint point1 = [self.tabBarController.view convertPoint:sourceView.center fromView:self.view];
    [self.dragdropBGView beginHitPoint:point1];
    //	DLog(@"BEGIN");
}

- (void)dragView:(UIView *)sourceView moveToPoint:(CGPoint)point {
    //	DLog(@"MOVE");
    CGPoint pointX = [self.tabBarController.view convertPoint:point fromView:self.view];
    [self.dragdropBGView setHitPoint:pointX animated:YES];
}

- (void)dragView:(UIView *)sourceView endToPoint:(CGPoint)point {
    //	DLog(@"END");
    CGPoint pointX = [self.tabBarController.view convertPoint:point fromView:self.view];
    [self.dragdropBGView endHitPoint:pointX];
}

/*-----------------------------------------------------------------------------------------*/
#pragma mark - Drop
- (void)dropViewToPerfromAction {
    [[[UIAlertView alloc]initWithTitle:@"Do action" message:@"You have do an action via Drag & Drop" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
}

@end
