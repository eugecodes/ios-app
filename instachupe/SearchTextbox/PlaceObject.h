#import <Foundation/Foundation.h>
#import "CompletionObject.h"
@interface PlaceObject : NSObject<CompletionObject>
@property(nonatomic,strong)NSDictionary *userInfo;
- (id)initWithPlaceName:(NSString *)name;

@end
