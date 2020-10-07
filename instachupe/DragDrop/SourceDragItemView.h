#import <UIKit/UIKit.h>
#import "DragDropProtocol.h"

@interface SourceDragItemView : UIImageView

@property (nonatomic, weak) IBOutlet id<DragDropDelegate> delegate;

@end
