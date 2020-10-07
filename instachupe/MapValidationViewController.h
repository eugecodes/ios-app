#import <UIKit/UIKit.h>
#import <MapboxGL/MapboxGL.h>
#import "SearchTextbox.h"
//@import GoogleMaps;

@interface MapValidationViewController : UIViewController<MGLMapViewDelegate ,PDataDelegate,UITextFieldDelegate>
- (IBAction)showSearchAddressPopUP:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnSearchAddress;
@property (weak, nonatomic) IBOutlet MGLMapView *mapboxView;

//@property (nonatomic, retain) IBOutlet GMSMapView *googleMapView;
- (IBAction)ValidarUbicaciob:(id)sender;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *Activity;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UILabel *lblEstatus;
@property (weak, nonatomic) IBOutlet SearchTextbox *placeSearchTxt;
@end