#import "DragItemView.h"

@implementation DragItemView{

}
@synthesize imvItem;
@synthesize lbPrice;
+ (id)newDragItem {
	id item = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
	return item;
}

-(void)setTempImage:(NSString *)image_path{
    imvItem.image = [UIImage imageNamed:image_path];

}
-(void)setPrice:(NSString *)price{
    lbPrice.text = price;
}

- (void)awakeFromNib {
	[super awakeFromNib];
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.layer.borderWidth = 2;
}

@end
