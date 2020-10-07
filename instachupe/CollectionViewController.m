@import AudioToolbox;
#import "CollectionViewController.h"
#import "SourceDragItemCell.h"
#import "DragDropBackground.h"
@interface CollectionViewController () <UICollectionViewDataSource, DropProtocol>

@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;
@property (strong, nonatomic) UIImage *myImage;
@property (strong, nonatomic) DragDropBackground *dragdropBGView;
@end

@implementation CollectionViewController
@synthesize image_name;
@synthesize price;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //self.myImage = [UIImage imageNamed:@"agua-mineral-2lt.jpg"];
    self.myImage = [UIImage imageNamed:image_name];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SourceDragItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.myImageView.image = self.myImage;
    cell.Precio.text = self.price;
    
    return cell;
}

- (DragDropBackground *)dragdropBGView {
    if (!_dragdropBGView) {
        _dragdropBGView = [DragDropBackground sharedView];

    }

    _dragdropBGView.delegate = self;
    _dragdropBGView.image_name =self.image_name;
    _dragdropBGView.price =self.price;

    //NSLog(@"Asigna imagen %@", self.image_name);
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
    [self playSound:@"Tone 4 - 01" :@"mp3" ];
    NSLog(@"BEGIN");
}

- (void)dragView:(UIView *)sourceView moveToPoint:(CGPoint)point {
    NSLog(@"MOVE");
    CGPoint pointX = [self.tabBarController.view convertPoint:point fromView:self.view];
    [self.dragdropBGView setHitPoint:pointX animated:YES];
}

- (void)dragView:(UIView *)sourceView endToPoint:(CGPoint)point {
    NSLog(@"END");
    CGPoint pointX = [self.tabBarController.view convertPoint:point fromView:self.view];
    [self.dragdropBGView endHitPoint:pointX];
}

/*-----------------------------------------------------------------------------------------*/
#pragma mark - Drop
- (void)dropViewToPerfromAction {
    [self playSound:@"Tone 1 - 01" :@"mp3" ];
    [[[UIAlertView alloc]initWithTitle:@"Do action" message:@"You have do an action via Drag & Drop" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
}

- (void)playSound :(NSString *)fName :(NSString *) ext{
    SystemSoundID audioEffect;
    NSString *path = [[NSBundle mainBundle] pathForResource : fName ofType :ext];
    if ([[NSFileManager defaultManager] fileExistsAtPath : path]) {
        NSURL *pathURL = [NSURL fileURLWithPath: path];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef) pathURL, &audioEffect);
        AudioServicesPlaySystemSound(audioEffect);
    }
    else {
        NSLog(@"error, file not found: %@", path);
    }
}

@end