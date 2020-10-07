#import "PlaceObject.h"
@interface PlaceObject ()
@property (strong) NSString *placeName;
@end

@implementation PlaceObject
-(id)initWithPlaceName:(NSString *)name{
    self = [super init];
    if (self) {
        [self setPlaceName:name];
    }
    return self;
}

-(NSString *)autocompleteString{
    return self.placeName;
}
@end
