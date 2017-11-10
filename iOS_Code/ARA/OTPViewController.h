//
//  OTPViewController.h
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 20/06/17.
//  Copyright © 2017 Krishna_Mac_2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OTPViewController : UIViewController
{
    IBOutlet UITextField *txtOTP;
    
    IBOutlet UIButton *btnVerify;
    IBOutlet UIButton *btnResendOTP;
    
    NSMutableData *webData;
    NSString *recieved_status;
    int webservice;
    
    IBOutlet UIButton *lblAlreadyhaveAnAccount;
    IBOutlet UIButton *btnLogin;
}

@property (strong,nonatomic) NSArray *valuesArray;

@property (strong,nonatomic) NSString *fromEmailView;
@property (strong,nonatomic) NSString *isClient;

@property (strong,nonatomic) NSString *userEmail;

@end
