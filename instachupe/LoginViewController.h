#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController


@property (weak, nonatomic) IBOutlet UIButton *btnToggleLoginState;

@property (weak, nonatomic) IBOutlet UIImageView *imgProfilePicture;

@property (weak, nonatomic) IBOutlet UILabel *lblFullname;

@property (weak, nonatomic) IBOutlet UILabel *lblEmail;
@property (weak, nonatomic) IBOutlet UILabel *lblTotalFriends;

@property (weak, nonatomic) IBOutlet UILabel *lblStatus;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;


- (IBAction)toggleLoginState:(id)sender;


@end


