//
//  ProfileViewController.h
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 11/08/15.
//  Copyright (c) 2015 Krishna_Mac_2. All rights reserved.
//
//
//


#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController<UIPickerViewDelegate,UIImagePickerControllerDelegate,UIScrollViewDelegate>
{
    CGPoint svos;
    IBOutlet UIImageView *headerImage;
    
    UIActivityIndicatorView *activityIndicatorObject;
    IBOutlet UIImageView *imageProfile;
    IBOutlet UIScrollView *scrollView;
    IBOutlet UILabel *lblEmail;
    IBOutlet UILabel *lblpassword;
    IBOutlet UILabel *lblName;
    IBOutlet UIButton *btnEdit;
    IBOutlet UITextField *txtEmail;
    IBOutlet UITextField *txtPhoneNo;
    IBOutlet UITextField *txtRole;
    IBOutlet UITextField *txtMEA;
    IBOutlet UILabel *lblPhoneno;
    IBOutlet UILabel *lblRole;
    IBOutlet UILabel *lblMEAname;
    IBOutlet UIButton *btnCheckBox;
    IBOutlet UILabel *lblPurchased;
    BOOL checkbox_Value;
    UIImage *btnImage;
    IBOutlet UIButton *btnSave;
    IBOutlet UILabel *lblUserID;
    NSData *imagedata;
    IBOutlet UITextField *txtName;
    IBOutlet UIButton *btnsave;
    IBOutlet UIButton *btnedit;
    IBOutlet UIButton *btnback;
    NSMutableData *webData;
    IBOutlet UIButton *btnChangePassword;
    IBOutlet UILabel *lblheading;
    IBOutlet UILabel *lblerrorPhoneno;
    IBOutlet UILabel *phonelbl;
    IBOutlet UILabel *lblerrorName;
    IBOutlet UIView *viewtohidekeyboard;
    IBOutlet UILabel *namelbl;
    IBOutlet UILabel *purchasedlbl;
    IBOutlet UILabel *lblLastname;
    IBOutlet UITextField *txtLastname;
    IBOutlet UILabel *lastnamelbl;
    IBOutlet UIButton *btnEditImage;
    NSString * laststr;
    IBOutlet UIView *viewonimage;
    IBOutlet UILabel *lblemail1;
    IBOutlet UILabel *lblrole1;
    IBOutlet UILabel *lblpassword1;
    IBOutlet UILabel *lblmea1;
    IBOutlet UILabel *lblpurchased1;
    IBOutlet UILabel *lblphoneno1;
    
    NSString *status;
    NSString *email;
    NSString *password;
}
- (IBAction)btnEditImage:(id)sender;
- (IBAction)btnUploadImage:(id)sender;
- (IBAction)btnSave:(id)sender;
- (IBAction)btnCheckBox:(id)sender;
- (IBAction)btnback:(id)sender;
- (IBAction)btnEdit:(id)sender;
- (IBAction)btnChangePassword:(id)sender;
-(void)responseimageWebservice:(NSString*)imageurl;

@end
