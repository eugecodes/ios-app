#import <UIKit/UIKit.h>
#import "DragDropProtocol.h"

@interface SourceDragItemCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet id<DragDropDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UILabel *Precio;

@end
