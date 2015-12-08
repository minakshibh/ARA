//
//  LoginViewController.h
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 10/08/15.
//  Copyright (c) 2015 Krishna_Mac_2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignUpViewController.h"
#import "JSON.h"
#import "SBJson.h"

@interface LoginViewController : UIViewController
{
    IBOutlet UIImageView *imagelogo;
    CGPoint svos;
    IBOutlet UIScrollView *scrollView;
    IBOutlet UILabel *lblPass;
    IBOutlet UILabel *lblAlreadyHaveAnAccount;
    IBOutlet UILabel *lblEmail;
    IBOutlet UIButton *btnForgotPassword;
    IBOutlet UIButton *btnSignUp;
    IBOutlet UIButton *btnFacebookLogin;
    SignUpViewController *SUvc;
    NSUserDefaults *user_detail;
    IBOutlet UIButton *btnLogin;
    IBOutlet UIButton *btnCheckbox;
    BOOL checkbox_Value;
    UIImage *btnImage;
    IBOutlet UITextField *txtEmail;
    IBOutlet UITextField *txtPassword;
    NSMutableData *webData;
    NSString *status;
}
- (IBAction)btnCheckbox:(id)sender;
- (IBAction)btnForgotPassword:(id)sender;
- (IBAction)btnSignUp:(id)sender;
- (IBAction)btnFacebookLogin:(id)sender;
- (IBAction)btnLogin:(id)sender;
-(void)facebookLogin;

@end
