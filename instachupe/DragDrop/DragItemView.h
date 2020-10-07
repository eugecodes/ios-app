#import <UIKit/UIKit.h>

@interface DragItemView : UIView

+ (id)newDragItem;
- (void)setTempImage: (NSString*)image_path;
- (void)setPrice: (NSString*)price;
@property (nonatomic, strong) IBOutlet UIImageView *imvItem;
@property (nonatomic, weak) IBOutlet UILabel *lbPrice;
@property (nonatomic, weak) IBOutlet UILabel *lbDescription;

@end
