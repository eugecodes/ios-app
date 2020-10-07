#import <UIKit/UIKit.h>
#import "DataSource.h"
#import "AutoCompleteDelegate.h"

@protocol AutoCompleteDelegate <NSObject>
- (void)autoCompleteTermsDidSort:(NSArray *)completions;
@end

@protocol AutoCompleteDelegateFetchAction <NSObject>
- (void)autoCompleteTermsDidFetch:(NSDictionary *)fetchInfo;
@end


@interface SearchTextbox : UITextField <UITableViewDataSource, UITableViewDelegate, AutoCompleteDelegate, AutoCompleteDelegateFetchAction>

+ (NSString *) accessibilityLabelForIndexPath:(NSIndexPath *)indexPath;

@property (strong, readonly) UITableView *autoCompleteTableView;

@property (strong) id <DataSource> autoCompleteDataSource;
@property (weak) id <AutoCompleteDelegate> autoCompleteDelegate;

@property (assign) NSTimeInterval autoCompleteFetchRequestDelay;
@property (assign) BOOL sortAutoCompleteSuggestionsByClosestMatch;
@property (assign) BOOL applyBoldEffectToAutoCompleteSuggestions;
@property (assign) BOOL reverseAutoCompleteSuggestionsBoldEffect;
@property (assign) BOOL showTextFieldDropShadowWhenAutoCompleteTableIsOpen;
@property (assign) BOOL showAutoCompleteTableWhenEditingBegins;
@property (assign) BOOL disableAutoCompleteTableUserInteractionWhileFetching;
@property (assign) BOOL autoCompleteTableAppearsAsKeyboardAccessory;


@property (assign) BOOL autoCompleteTableViewHidden;


@property (assign) CGFloat autoCompleteFontSize;
@property (strong) NSString *autoCompleteBoldFontName;
@property (strong) NSString *autoCompleteRegularFontName;

@property (assign) NSInteger maximumNumberOfAutoCompleteRows;
@property (assign) CGFloat partOfAutoCompleteRowHeightToCut;
@property (assign) CGFloat autoCompleteRowHeight;
@property (nonatomic, assign) CGRect autoCompleteTableFrame;
@property (assign) CGSize autoCompleteTableOriginOffset;
@property (assign) CGFloat autoCompleteTableCornerRadius;
@property (nonatomic, assign) UIEdgeInsets autoCompleteContentInsets;
@property (nonatomic, assign) UIEdgeInsets autoCompleteScrollIndicatorInsets;
@property (nonatomic, strong) UIColor *autoCompleteTableBorderColor;
@property (nonatomic, assign) CGFloat autoCompleteTableBorderWidth;
@property (nonatomic, strong) UIColor *autoCompleteTableBackgroundColor;
@property (strong) UIColor *autoCompleteTableCellBackgroundColor;
@property (strong) UIColor *autoCompleteTableCellTextColor;


@property (nonatomic,strong)UIView *superViewOfList;
@property (assign) BOOL autoCompleteShouldHideOnSelection;
@property (assign) BOOL autoCompleteShouldHideClosingKeyboard;
@property (assign) BOOL autoCompleteShouldSelectOnExactMatchAutomatically;

- (void)registerAutoCompleteCellNib:(UINib *)nib forCellReuseIdentifier:(NSString *)reuseIdentifier;
- (void)registerAutoCompleteCellClass:(Class)cellClass forCellReuseIdentifier:(NSString *)reuseIdentifier;
- (void)reloadData;
@end


