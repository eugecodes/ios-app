#import "SearchTextbox.h"
#import "PlaceDetail.h"
#import "PlaceObject.h"
#import "SearchTextbox.h"
@interface SearchTextbox ()<AutoCompleteDelegateFetchAction,AutoCompleteDelegate,DataSource,AutoCompleteDelegate,PDataDelegate>

@end


@implementation SearchTextbox

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib{

    self.autoCompleteDataSource=self;
    self.autoCompleteDelegate=self;
    self.autoCompleteFontSize=14;
    self.autoCompleteTableBorderWidth=0.0;
    self.showTextFieldDropShadowWhenAutoCompleteTableIsOpen=NO;
    self.autoCompleteShouldHideOnSelection=YES;
    self.maximumNumberOfAutoCompleteRows= 5;
    self.autoCompleteShouldHideClosingKeyboard = YES;

    
}
#pragma mark - Datasource Autocomplete
//example of asynchronous fetch:
- (void)AutoCompletetxt:(SearchTextbox *)textField
 possibleCompletionsForString:(NSString *)string
            completionHandler:(void (^)(NSArray *))handler
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_async(queue, ^{
        
        NSString *aQuery=[textField.text stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
        
//        NSString *aStrURl=[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/queryautocomplete/json?&key=%@&sensor=false&input=%@",_strApiKey,aQuery];
        NSString *aStrURl;
        if(_strApiKey){
            aStrURl=[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/autocomplete/json?input=%@&sensor=true&key=%@",aQuery,_strApiKey];
        }else{
            aStrURl=[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/autocomplete/json?input=%@&sensor=true",aQuery];
        }
        
        NSMutableDictionary *aResultDict=[self stringWithUrl:[NSURL URLWithString:aStrURl]].mutableCopy;
        
        if(aResultDict){
            NSArray *aResult=[aResultDict objectForKey:@"predictions"];
            NSMutableArray *arrfinal=[NSMutableArray array];
            for (NSDictionary *aTempDict in aResult) {
                PlaceObject *placeObj=[[PlaceObject alloc]initWithPlaceName:[aTempDict objectForKey:@"description"]];
                placeObj.userInfo=aTempDict;
                [arrfinal addObject:placeObj];
            }
            handler(arrfinal);
        }else{
            handler(nil);
        }
    });
}


#pragma mark - AutoComplete Delegates
-(void)AutoCompletetxt:(SearchTextbox *)textField didSelectAutoCompleteString:(NSString *)selectedString withAutoCompleteObject:(id<CompletionObject>)selectedObject forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PlaceObject *placeObj=(PlaceObject*)selectedObject;
    NSString *aStrPlaceReferance=[placeObj.userInfo objectForKey:@"reference"];
    PlaceDetail *placeDetail=[[PlaceDetail alloc]initWithApiKey:_strApiKey];
    placeDetail.delegate=self;
    [placeDetail getPlaceDetailForReferance:aStrPlaceReferance];
    
}
-(BOOL)AutoCompletetxt:(SearchTextbox *)textField
         shouldConfigureCell:(UITableViewCell *)cell
      withAutoCompleteString:(NSString *)autocompleteString
        withAttributedString:(NSAttributedString *)boldedString
       forAutoCompleteObject:(id<CompletionObject>)autocompleteObject
           forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([_placeSearchDelegate respondsToSelector:@selector(placeSearchResultCell:withPlaceObject:atIndex:)]){
        [_placeSearchDelegate placeSearchResultCell:cell withPlaceObject:autocompleteObject atIndex:indexPath.row];
    }else{
        cell.contentView.backgroundColor=[UIColor whiteColor];
    }
    return YES;
}

-(void)AutoCompletetxt:(SearchTextbox *)textField willShowAutoCompleteTableView:(UITableView *)autoCompleteTableView{
    if([_placeSearchDelegate respondsToSelector:@selector(placeSearchWillShowResult)]){
        [_placeSearchDelegate placeSearchWillShowResult];
    }
}
-(void)AutoCompletetxt:(SearchTextbox *)textField willHideAutoCompleteTableView:(UITableView *)autoCompleteTableView{
    if([_placeSearchDelegate respondsToSelector:@selector(placeSearchWillHideResult)]){
        [_placeSearchDelegate placeSearchWillHideResult];
    }
}


#pragma mark - PlaceDetail Delegate

-(void)placeDetailForReferance:(NSString *)referance didFinishWithResult:(NSMutableDictionary *)resultDict{
    dispatch_sync(dispatch_get_main_queue(), ^{
        //Respond To Delegate
        [_placeSearchDelegate placeSearchResponseForSelectedPlace:resultDict];
    });
    
}


#pragma mark - URL Operation
- (NSDictionary *)stringWithUrl:(NSURL *)url
{
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url
                                                cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                            timeoutInterval:30];
    // Fetch the JSON response
    NSData *urlData;
    NSURLResponse *response;
    NSError *error;
    
    // Make synchronous request
    urlData = [NSURLConnection sendSynchronousRequest:urlRequest
                                    returningResponse:&response
                                                error:&error];
    if(urlData){
        // Construct a Dictionary around the Data from the response
        NSDictionary *aDict=[NSJSONSerialization JSONObjectWithData:urlData options:NSJSONReadingAllowFragments error:&error];
        return aDict;
    }else{return nil;}
    
}



@end
