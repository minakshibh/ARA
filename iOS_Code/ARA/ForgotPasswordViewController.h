//
//  ForgotPasswordViewController.h
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 10/08/15.
//  Copyright (c) 2015 Krishna_Mac_2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgotPasswordViewController : UIViewController
{
    IBOutlet UIImageView *imagelogo;
    CGPoint svos;
    IBOutlet UIScrollView *scrollView;

    IBOutlet UITextField *txtEmail;
    IBOutlet UIButton *btnSingUp;
    IBOutlet UIButton *btnResetPassword;
    IBOutlet UIButton *btnLogIn;
    NSMutableData *webData;
    NSString *recieved_status;
    IBOutlet UILabel *lblOr;
}
- (IBAction)btnResetPassword:(id)sender;
@property (nonatomic,strong) NSString *email;
- (IBAction)btnSingUp:(id)sender;
- (IBAction)btnLogIn:(id)sender;

@end
