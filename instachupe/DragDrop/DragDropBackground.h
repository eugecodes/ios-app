#import <UIKit/UIKit.h>

@class DropZoneView;
@class TotalZoneView;
@class DragDropBackground;
@protocol DropProtocol <NSObject>

- (void)dropViewToPerfromAction;

@end

@interface DragDropBackground : UIView

@property (nonatomic, strong) DropZoneView *dropZoneView;
@property (nonatomic, strong) TotalZoneView *totalZoneView;
@property (nonatomic, strong) UIView *customItemView;
@property (nonatomic, readonly) CGPoint hitPoint;
@property (nonatomic, strong) NSString *image_name;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, weak) id <DropProtocol> delegate;

+ (id)sharedView;

- (void)showInView:(UIView *)view;
- (void)showInView:(UIView *)view complete:(void (^)(void))complation;
- (void)dismiss;

- (void)setHitPoint:(CGPoint)hitPoint animated:(BOOL)animated duration:(NSTimeInterval)time;
- (void)setHitPoint:(CGPoint)hitPoint animated:(BOOL)animated;
- (void)beginHitPoint:(CGPoint)point;
- (void)endHitPoint:(CGPoint)point;

@end
