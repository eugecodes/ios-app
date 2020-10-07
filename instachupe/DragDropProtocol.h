#import <UIKit/UIKit.h>

@protocol DragDropDelegate <NSObject>

@optional
- (void)dragView:(UIView *)sourceView beginToPoint:(CGPoint)point;
- (void)dragView:(UIView *)sourceView moveToPoint:(CGPoint)point;
- (void)dragView:(UIView *)sourceView endToPoint:(CGPoint)point;
- (void)dragView:(UIView *)sourceView;

@end
