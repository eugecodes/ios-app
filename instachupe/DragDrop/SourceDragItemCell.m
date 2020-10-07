#import "SourceDragItemCell.h"

@implementation SourceDragItemCell

- (void)awakeFromNib{
    [super awakeFromNib];
    UILongPressGestureRecognizer *longPressGR = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressDetected:)];
    [self addGestureRecognizer:longPressGR];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

#pragma mark - Gesture
- (void)longPressDetected:(UILongPressGestureRecognizer *)gesture {
    CGPoint point = [gesture locationInView:self.superview];
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            if ([self.delegate respondsToSelector:@selector(dragView:beginToPoint:)]) {
                [self.delegate dragView:self beginToPoint:point];
            }
        }
            break;
            
        case UIGestureRecognizerStateChanged: {
            if ([self.delegate respondsToSelector:@selector(dragView:moveToPoint:)]) {
                [self.delegate dragView:self moveToPoint:point];
            }
        }
            break;
            
        case UIGestureRecognizerStateEnded:
        {
            if ([self.delegate respondsToSelector:@selector(dragView:endToPoint:)]) {
                [self.delegate dragView:self endToPoint:point];
            }
        }
            break;
            
        default:
            break;
    }
}



@end