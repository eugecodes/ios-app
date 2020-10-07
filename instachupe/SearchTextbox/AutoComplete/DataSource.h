#import <Foundation/Foundation.h>

@class MLPAutoCompleteTextField;
@protocol MLPAutoCompleteTextFieldDataSource <NSObject>

- (NSArray *)autoCompleteTextField:(MLPAutoCompleteTextField *)textField
      possibleCompletionsForString:(NSString *)string;



@end
