#import <Foundation/Foundation.h>

@class SearchTextbox;
@protocol DataSource <NSObject>

- (NSArray *)AutoCompletetxt:(SearchTextbox *)textField
      possibleCompletionsForString:(NSString *)string;



@end
