//
//  changePasswordViewController.h
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 31/08/15.
//  Copyright (c) 2015 Krishna_Mac_2. All rights reserved.
//

#import "ViewController.h"

@interface changePasswordViewController : ViewController
{
    IBOutlet UIButton *btnback;
    IBOutlet UILabel *lblheading;
    IBOutlet UITextField *txtOldpwd;
    IBOutlet UIImageView *headerImage;
    IBOutlet UIButton *btncahngpassword;

    IBOutlet UITextField *txtNewpwd;
    IBOutlet UITextField *txtConfirmnewpwd;
    NSMutableData *webData;
    IBOutlet UIScrollView *scrollView;
    CGPoint svos;
    NSString *recieved_status;
    IBOutlet UIImageView *imagelogo;
}
- (IBAction)btnBack:(id)sender;
- (IBAction)btnChangePWD:(id)sender;
@end
