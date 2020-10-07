#import <Foundation/Foundation.h>
#import "SearchTextbox.h"
#import "SearchTextbox.h"
#import "PlaceObject.h"

@protocol PlaceSearchTextFieldDelegate <NSObject>
-(void)placeSearchResponseForSelectedPlace:(NSMutableDictionary*)responseDict;
-(void)placeSearchWillShowResult;
-(void)placeSearchWillHideResult;
-(void)placeSearchResultCell:(UITableViewCell*)cell withPlaceObject:(PlaceObject*)placeObject atIndex:(NSInteger)index;
@end

@interface SearchTextbox : SearchTextbox
@property(nonatomic,strong)NSString *strApiKey;

@property(nonatomic,strong)IBOutlet id<PlaceSearchTextFieldDelegate>placeSearchDelegate;
@end
