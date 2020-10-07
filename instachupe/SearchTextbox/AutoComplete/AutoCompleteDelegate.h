#import <Foundation/Foundation.h>
#import "CompletionObject.h"

@class SearchTextbox;
@protocol AutoCompleteDelegate <NSObject>

@optional
- (BOOL)AutoCompletetxt:(SearchTextbox *)textField
    shouldStyleAutoCompleteTableView:(UITableView *)autoCompleteTableView
                      forBorderStyle:(UITextBorderStyle)borderStyle;

- (BOOL)AutoCompletetxt:(SearchTextbox *)textField
          shouldConfigureCell:(UITableViewCell *)cell
       withAutoCompleteString:(NSString *)autocompleteString
         withAttributedString:(NSAttributedString *)boldedString
        forAutoCompleteObject:(id<CompletionObject>)autocompleteObject
            forRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)AutoCompletetxt:(SearchTextbox *)textField
  didSelectAutoCompleteString:(NSString *)selectedString
       withAutoCompleteObject:(id<CompletionObject>)selectedObject
            forRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)AutoCompletetxt:(SearchTextbox *)textField
willShowAutoCompleteTableView:(UITableView *)autoCompleteTableView;


- (void)AutoCompletetxt:(SearchTextbox *)textField
willHideAutoCompleteTableView:(UITableView *)autoCompleteTableView;


- (void)AutoCompletetxt:(SearchTextbox *)textField
HeightDidChange:(float)height;

-(void)AutoCompletetxt:(SearchTextbox *)textField didResignWithExactMatch:(NSString*)strMatch;

@end
