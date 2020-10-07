#import <UIKit/UIKit.h>

@interface TotalZoneView : UIView

@property (nonatomic) NSInteger total;
@property (nonatomic) NSInteger valor_a_sumar;
+ (id)newDragItem;
- (void)drawWithFrame: (CGRect)frame;
@end