#import <UIKit/UIKit.h>
#import "DragDropProtocol.h"
@interface ViewController : UIViewController <DragDropDelegate>

@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

