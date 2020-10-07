#import <Foundation/Foundation.h>
@protocol CompletionObject <NSObject>
@required

- (NSString *)autocompleteString;

@end
