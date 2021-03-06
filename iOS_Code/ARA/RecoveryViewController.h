//
//  RecoveryViewController.h
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 20/04/16.
//  Copyright © 2016 Krishna_Mac_2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecoveryViewController : UIViewController<UIScrollViewDelegate>
{
    IBOutlet UILabel *lblBackgroundNewPassword;
    IBOutlet UITextField *txtNewPassword;
    IBOutlet UILabel *lblPartitionNewPassword;
    IBOutlet UIImageView *imageIconNewPassword;
    IBOutlet UILabel *lblBackgroundConfirmPassword;
    IBOutlet UITextField *txtConfirmPassword;
    IBOutlet UILabel *lblPartitionConfirmPassword;
    IBOutlet UIImageView *imageIconConfirmPassword;
    IBOutlet UIButton *btnlogin;
    IBOutlet UIButton *btnChangePassword;
    IBOutlet UIScrollView *scrollView;
    IBOutlet UILabel *lblAlreadyhaveavalidpwd;
    
    CGPoint svos;
    NSMutableData *webData;
    NSString *status;
}
@property (atomic,strong) NSString* email;
- (IBAction)btnChangePassword:(id)sender;
@end
