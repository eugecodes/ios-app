#import <Foundation/Foundation.h>
#import "MapValidationViewController.h"
@import GoogleMaps;
#import <MapboxGL/MapboxGL.h>


#import <CoreLocation/CoreLocation.h>

@interface MapValidationViewController(){
    GMSAddress *mapAddress;
    BOOL    firstLocationUpdate_;

}


@end

@implementation MapValidationViewController

- (void)viewDidLoad {
    
    self.Activity.hidden = true;


    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    // Set a movement threshold for new events.
    self.locationManager.distanceFilter = 50; // meters
    self.locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    self.locationManager.distanceFilter=kCLDistanceFilterNone;
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startMonitoringSignificantLocationChanges];
    [self.locationManager startUpdatingLocation];
    
    self.mapboxView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.mapboxView.styleURL = [NSURL URLWithString:@"asset://styles/emerald-v7.json"];
    //_googleMapView.settings.compassButton = YES;
    //_googleMapView.settings.myLocationButton = YES;
    
    /*[_googleMapView addObserver:self
               forKeyPath:@"myLocation"
                  options:NSKeyValueObservingOptionNew
                  context:NULL];
     */
   
    dispatch_async(dispatch_get_main_queue(), ^{
       // _googleMapView.myLocationEnabled = YES;
       //     NSLog(@"User's location: %@", _googleMapView.myLocation);
        [self getAddress :self.locationManager.location.coordinate];
        UIImage *btnImage = [UIImage imageNamed:@"search-32.png"];
        [self.btnSearchAddress setImage:btnImage forState:UIControlStateNormal];
    });

    self.mapboxView.showsUserLocation = YES;
    self.mapboxView.zoomLevel =18;
    self.mapboxView.userTrackingMode = MGLUserTrackingModeFollow;
 
    
    self.placeSearchTxt.placeSearchDelegate                 = self;
    self.placeSearchTxt.strApiKey                           = @"AIzaSyCDi2dklT-95tEHqYoE7Tklwzn3eJP-MtM";
    self.placeSearchTxt.superViewOfList                     = self.view;  // View, on which Autocompletion list should be appeared.
    self.placeSearchTxt.autoCompleteShouldHideOnSelection   = YES;
    self.placeSearchTxt.maximumNumberOfAutoCompleteRows     = 5;
}
- (IBAction)showSearchAddressPopUP:(id)sender{
 
    [self performSegueWithIdentifier:@"show_search_address" sender:self];
}
-(void)mapView:(MGLMapView * __nonnull)mapView regionDidChangeAnimated:(BOOL)animated{
;

  /*  NSLog(@"latitude %+.6f, longitude %+.6f\n",
 self.mapboxView.centerCoordinate.latitude,
 self.mapboxView.centerCoordinate.longitude);*/
            [self getAddress : self.mapboxView.centerCoordinate];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //Optional Properties
    //Optional Properties
    /*self.placeSearchTxt.autoCompleteRegularFontName =  @"HelveticaNeue-Bold";
    self.placeSearchTxt.autoCompleteBoldFontName = @"HelveticaNeue";
    self.placeSearchTxt.autoCompleteTableCornerRadius=0.0;
    self.placeSearchTxt.autoCompleteRowHeight=35;
    self.placeSearchTxt.autoCompleteTableCellTextColor=[UIColor colorWithWhite:0.131 alpha:1.000];
    self.placeSearchTxt.autoCompleteFontSize=14;
    self.placeSearchTxt.autoCompleteTableBorderWidth=1.0;
    self.placeSearchTxt.showTextFieldDropShadowWhenAutoCompleteTableIsOpen=YES;
    self.placeSearchTxt.autoCompleteShouldHideOnSelection=YES;
    self.placeSearchTxt.autoCompleteShouldHideClosingKeyboard=YES;
    self.placeSearchTxt.autoCompleteShouldSelectOnExactMatchAutomatically = YES;
    self.placeSearchTxt.autoCompleteTableFrame = CGRectMake((self.view.frame.size.width-self.placeSearchTxt.frame.size.width)*0.5, self.placeSearchTxt.frame.size.height+100.0, self.placeSearchTxt.frame.size.width, 200.0);
*/
}

-(void) getAddress :(CLLocationCoordinate2D)currentCoordinate{
    [self.Activity startAnimating];
    self.Activity.hidden=false;

    [[GMSGeocoder geocoder] reverseGeocodeCoordinate:currentCoordinate completionHandler:^(GMSReverseGeocodeResponse* response, NSError* error) {
            GMSAddress* addressObj = [response results].firstObject;
            if (addressObj != nil && [addressObj.lines count]>0 )
                self.lblEstatus.text = [addressObj.lines componentsJoinedByString:@", "] ;
        /*for(GMSAddress* addressObj in [response results])
        {
            NSLog(@"coordinate.latitude=%f", addressObj.coordinate.latitude);
            NSLog(@"coordinate.longitude=%f", addressObj.coordinate.longitude);
            NSLog(@"thoroughfare=%@", addressObj.thoroughfare);
            NSLog(@"locality=%@", addressObj.locality);
            NSLog(@"subLocality=%@", addressObj.subLocality);
            NSLog(@"administrativeArea=%@", addressObj.administrativeArea);
            NSLog(@"postalCode=%@", addressObj.postalCode);
            NSLog(@"country=%@", addressObj.country);
            NSLog(@"lines=%@", addressObj.lines);
            
        }*/
            self.Activity.hidden=true;
            [self.Activity stopAnimating];

        }];
}
- (void)dealloc {
    //[_googleMapView removeObserver:self forKeyPath:@"myLocation"];
}

#pragma mark - KVO updates


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)ValidarUbicaciob:(id)sender {
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"detalle_de_cliente"])
    {

    }
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
-(void)placeSearchResponseForSelectedPlace:(NSMutableDictionary*)responseDict{
    [self.view endEditing:YES];
    NSLog(@"%@",responseDict);
    
    NSDictionary *aDictLocation=[[[responseDict objectForKey:@"result"] objectForKey:@"geometry"] objectForKey:@"location"];
    NSLog(@"SELECTED ADDRESS :%@",aDictLocation);
 
    //NSNumber longitud =     (double)[aDictLocation objectForKey:@"lat"];
    NSNumber *latitud = [[NSNumber alloc] initWithDouble:0.0];
   latitud = [aDictLocation objectForKey:@"lat"];
    NSNumber *longitud = [[NSNumber alloc] initWithDouble:0.0];
    longitud = [aDictLocation objectForKey:@"lng"];
    

    [self.mapboxView setCenterCoordinate:CLLocationCoordinate2DMake(latitud.doubleValue , longitud.doubleValue) zoomLevel:18
                        animated:NO];
}
-(void)SearchWillShowResult{
    NSLog(@"Empieza a mostrar el resultado");
}
-(void)SearchWillHideResult{
    NSLog(@"Empieza a ocultar el resultado");
}
-(void)SearchResultCell:(UITableViewCell *)cell withPlaceObject:(PlaceObject *)plObject atIndex:(NSInteger)index{
    if(index%2==0){
        cell.contentView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    }else{
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
}

@end

