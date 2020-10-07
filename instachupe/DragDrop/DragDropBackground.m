#import "DragDropBackground.h"
#import "RFScreenshot.h"
#import "UIImage+ImageEffects.h"
#import "DragItemView.h"
#import "DropZoneView.h"
#import "TotalZoneView.h"
#import "MMMacro.h"

@implementation DragDropBackground
{
	CGPoint _restorePoint;
}
@synthesize customItemView = _customItemView;
@synthesize dropZoneView = _dropZoneView;
@synthesize totalZoneView = _totalZoneView;
@synthesize image_name;
@synthesize price;
+ (id)sharedView {
	static id ___sharedView = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		___sharedView = [[self alloc]init];
	});
	return ___sharedView;
}

- (id)init {
	if (self = [super init]) {
		UILabel *lbInstruction = [[UILabel alloc]initWithFrame:CGRectZero];
		lbInstruction.tag = 1000;
		lbInstruction.text = @"Suelta para cancelar la compra";
		lbInstruction.textColor = [UIColor whiteColor];
		lbInstruction.textAlignment = NSTextAlignmentCenter;
		[lbInstruction sizeToFit];
		[self addSubview:lbInstruction];
	}
	return self;
}

- (void)layoutSubviews {
	[super layoutSubviews];
	UILabel *lbIn = (UILabel *)[self viewWithTag:1000];
	lbIn.center = CGPointMake(self.bounds.size.width / 2, 100);
}

- (void)showInView:(UIView *)view {
	[self showInView:view animated:YES complete:nil];
}

- (void)showInView:(UIView *)view complete:(void (^)(void))complation {
	[self showInView:view animated:YES complete:complation];
}

- (void)showInView:(UIView *)view animated:(BOOL)animated complete:(void (^)(void))complation {
	self.frame = view.bounds;
	UIImage *imgBG = [RFScreenshot takeScreenshot:view];
	imgBG = [imgBG applyDarkEffect];
	self.backgroundColor = [UIColor colorWithPatternImage:imgBG];
	self.alpha = 0;
	[view addSubview:self];

	[UIView animateWithDuration:(animated ? 0.25 : 0) animations: ^{
	    self.alpha = 1;
	} completion: ^(BOOL finished) {
	    [self showDropZoneWithAnimated:YES];
        [self showTotalZoneWithAnimated:YES];
	    if (complation) {
	        complation();
		}
	}];
}

- (void)dismiss {
	[self hideDropZoneWithAnimated:YES];
    [self hideTotalZoneWithAnimated:YES];
	[self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.25];
}

- (void)removeFromSuperview {
	[UIView animateWithDuration:0.25 animations: ^{
	    self.alpha = 0;
	} completion: ^(BOOL finished) {
	    [super removeFromSuperview];
	}];
}

/**-----------------------------------------------------------------**/
#pragma mark - Getters/Settes

- (void)setHitPoint:(CGPoint)hitPoint animated:(BOOL)animated duration:(NSTimeInterval)time {
//	CGFloat xDist = (hitPoint.x - _hitPoint.x);
//	CGFloat yDist = (hitPoint.y - _hitPoint.y);
//	CGFloat distance = sqrt((xDist * xDist) + (yDist * yDist));

	_hitPoint = hitPoint;

	if (CGRectContainsPoint(self.dropZoneView.frame, hitPoint)) {
		self.dropZoneView.backgroundColor = RGBCOLOR(237, 188, 25);
	}
	else {
		self.dropZoneView.backgroundColor = RGBCOLOR(250, 100, 81);
	}

	if (animated) {
		[UIView animateWithDuration:time animations: ^{
		    self.customItemView.center = _hitPoint;
		}];
	}
	else {
		self.customItemView.center = _hitPoint;
	}
}

- (void)setHitPoint:(CGPoint)hitPoint animated:(BOOL)animated {
	CGFloat xDist = (hitPoint.x - _hitPoint.x);
	CGFloat yDist = (hitPoint.y - _hitPoint.y);
	CGFloat distance = sqrt((xDist * xDist) + (yDist * yDist));

	[self setHitPoint:hitPoint animated:animated duration:distance / 1000];
}

- (void)beginHitPoint:(CGPoint)point {
	_restorePoint = point;
	//restore settings
	self.customItemView.alpha = 1;
	self.customItemView.transform = CGAffineTransformIdentity;

	[self setHitPoint:point animated:NO];
}

- (void)endHitPoint:(CGPoint)point {
	[self endHitPoint:point complete:nil];
}

- (void)endHitPoint:(CGPoint)point complete:(void (^)(BOOL doneAction))complete {
	if (CGRectContainsPoint(self.dropZoneView.frame, point)) {
		_restorePoint = CGPointZero;

		[UIView animateWithDuration:0.25 animations: ^{
		    [self setHitPoint:self.dropZoneView.center animated:YES];
		    self.customItemView.transform = CGAffineTransformMakeScale(0.2, 0.2);
		    self.customItemView.alpha = 0.0;
		} completion: ^(BOOL finished) {
		    [self dismiss];
		    if ([self.delegate respondsToSelector:@selector(dropViewToPerfromAction)]) {
		        [self.delegate dropViewToPerfromAction];
		        DLog(@"PURCHASED");
			}
		    if (complete) {
		        complete(YES);
			}
		}];
	}
	else {
		DLog(@"CANCEL PURCHASE");
		[self setHitPoint:_restorePoint animated:YES duration:0.25];
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
			[self dismiss];
			if (complete) {
			    complete(NO);
			}
		});
	}
}

/*-----------------------------------------------------------------------------------------*/
#pragma mark -

- (UIView *)customItemView  {
	if (!_customItemView) {
        DragItemView *temp_view = [DragItemView newDragItem];
        //[temp_view   setTempImage: @"agua-mineral-2lt.jpg" ];
        
        //[temp_view setTempImage:image_name];
        _customItemView =temp_view;
		[self addSubview:_customItemView];
		_customItemView.center = self.hitPoint;
	}
    [(DragItemView*)_customItemView setTempImage: image_name];
    [(DragItemView*)_customItemView setPrice: price];
    
    NSLog(@"inserta imagen %@ con precio %@" , image_name, price);
  
    
//    _customItemView.imvItem = [[UIImage alloc] initWith:@"agua-mineral-2lt.jpg"];


  //  _customItemView.set
	[self bringSubviewToFront:_customItemView];
	return _customItemView;
}

- (void)setCustomItemView:(UIView *)customItemView {
	if (_customItemView) {
		[_customItemView removeFromSuperview];
		_customItemView = nil;
	}
	_customItemView = customItemView;
	_customItemView.center = self.hitPoint;
	[self addSubview:_customItemView];
	[self bringSubviewToFront:_customItemView];
}

- (UIView *)dropZoneView {
	if (!_dropZoneView) {
		_dropZoneView = [DropZoneView newDragItem];
		[_dropZoneView drawWithFrame:CGRectMake(0, self.bounds.size.height, self.bounds.size.width, _dropZoneView.bounds.size.height)];
		_dropZoneView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		[self addSubview:_dropZoneView];
	}
	return _dropZoneView;
}

- (UIView *)totalZoneView {
    if (!_totalZoneView) {
        _totalZoneView = [TotalZoneView newDragItem];
        [_totalZoneView drawWithFrame:CGRectMake(0, -1*self.bounds.size.height, self.bounds.size.width, _totalZoneView.bounds.size.height )];
        
       // [_totalZoneView drawWithFrame:CGRectMake(0, 0, self.bounds.size.width, _totalZoneView.bounds.size.height)];
        _totalZoneView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:_totalZoneView];
    }
    return _totalZoneView;
}


/**-----------------------------------------------------------------**/
#pragma mark -

- (void)showDropZoneWithAnimated:(BOOL)animated {
	self.dropZoneView.backgroundColor = RGBCOLOR(250, 100, 81);
	CGFloat zoneY = self.dropZoneView.frame.origin.y;
	zoneY = self.bounds.size.height - self.dropZoneView.frame.size.height;

	CGRect frame = self.dropZoneView.frame;
	frame.origin.y = zoneY;

	[UIView animateWithDuration:(animated ? 0.25 : 0) animations: ^{
	    [self.dropZoneView setFrame:frame];
	}];
}

- (void)showTotalZoneWithAnimated:(BOOL)animated {

    self.totalZoneView.backgroundColor = RGBCOLOR(250, 100, 81);
    CGFloat zoneY =0;// = self.totalZoneView.frame.origin.y;
    // zoneY = self.bounds.size.height - self.totalZoneView.frame.size.height;
    
    CGRect frame = self.totalZoneView.frame;
    frame.origin.y = zoneY;
    
    [UIView animateWithDuration:(animated ? 0.25 : 0) animations: ^{
        [self.totalZoneView setFrame:frame];
    }];
}
- (void)hideDropZoneWithAnimated:(BOOL)animated {
	CGFloat zoneY = self.dropZoneView.frame.origin.y;
	zoneY = self.bounds.size.height;

	CGRect frame = self.dropZoneView.frame;
	frame.origin.y = zoneY;

	[UIView animateWithDuration:(animated ? 0.25 : 0) animations: ^{
	    [self.dropZoneView setFrame:frame];
	}];
}

- (void)hideTotalZoneWithAnimated:(BOOL)animated {
    CGFloat zoneY ;//= self.totalZoneView.frame.origin.y;
    zoneY = - self.bounds.size.height;
    
    CGRect frame = self.totalZoneView.frame;
    frame.origin.y = zoneY;
    
    [UIView animateWithDuration:(animated ? 0.25 : 0) animations: ^{
        [self.totalZoneView setFrame:frame];
    }];
}

@end
