#import <Foundation/Foundation.h>

@protocol PDataDelegate <NSObject>

-(void)placeDetailForReferance:(NSString*)referance didFinishWithResult:(NSMutableDictionary*)resultDict;
@end

@interface PlaceDetail : NSObject{
    NSString *aStrApiKey;
}

@property(nonatomic,strong)id <PDataDelegate> delegate;
-(id)initWithApiKey:(NSString*)ApiKey;
-(void)getPlaceDetailForReferance:(NSString*)strReferance;
@end
