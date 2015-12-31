//
//  SignUpViewController.h
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 10/08/15.
//  Copyright (c) 2015 Krishna_Mac_2. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SignUpViewController : UIViewController<UITextFieldDelegate,UIScrollViewDelegate,UIAlertViewDelegate>
{
    IBOutlet UIImageView *imagelogo;
    IBOutlet UILabel *lblEmail;
    IBOutlet UILabel *lblUserId;
    IBOutlet UILabel *lblPhoneNo;
    IBOutlet UILabel *lbllastname;
    IBOutlet UILabel *lblFirstname;
    IBOutlet UIScrollView *scrollView;
    IBOutlet UILabel *lblStickPassword;
    IBOutlet UILabel *lblStickPreview;
    IBOutlet UILabel *lblStickMEA;
    IBOutlet UITextField *txtFirstName;
    IBOutlet UITextField *txtLastName;
    IBOutlet UITextField *txtUserId;
    IBOutlet UITextField *txtPhoneNo;
    IBOutlet UIButton *btnLogIn;
    IBOutlet UITextField *txtEmail;
    IBOutlet UITextField *txtPassword;
    IBOutlet UILabel *lblPassword;
    IBOutlet UIImageView *imageIconPassword;
    IBOutlet UIImageView *ImagePreviewIcon;
    IBOutlet UILabel *lblpreview;
    IBOutlet UIButton *btnPreview;
    IBOutlet UIImageView *ImagePreviewDropdown;
    IBOutlet UIImageView *imageMEAicon;
    IBOutlet UILabel *lblMEA;
    IBOutlet UIButton *btnMEA;
    IBOutlet UIImageView *imageMEAdropdown;
    IBOutlet UIButton *btnCheckBox;
    IBOutlet UILabel *lblPurchaseVehicle;
    IBOutlet UILabel *lblEnteremailaddress;
    IBOutlet UILabel *lblComposeyourprofile;
    IBOutlet UIButton *btnSignup;
    IBOutlet UILabel *lblAlready;
     CGPoint svos;
    BOOL checkbox_Value;
    UIImage *btnImage;
    IBOutlet UIView *passwordView;
    NSMutableData *webData;
    int webservice,internal,internal1;
    NSArray *id_array_prev_cust,*name_array_prev_cust,*id_array_Mea,*name_array_Mea,*email_array_Mea;
    NSData *image_data;
    IBOutlet UITextField *txtPreviousCoustomer;
    IBOutlet UITableView *tableViewMEA;
    IBOutlet UITextField *txtMEA;
    IBOutlet UITableView *tableViewPreviousCustomer;
    IBOutlet UIButton *btnPreviewCustomer;
    IBOutlet UIView *viewUserIdindicator;
    IBOutlet UIView *viewEmailindicator;
    UIActivityIndicatorView *activityIndicatorObject,*activityIndicatorObject1;
    IBOutlet UIView *rigthview;

    IBOutlet UIView *leftview;
    IBOutlet UILabel *lblemailerror;
    IBOutlet UIImageView *imagecheckforemailView;
    IBOutlet UIImageView *imagecheckforuseridView;
    IBOutlet UILabel *lbluseriderror;
    NSString* firstname,*lastname,*phoneno,*UserDetailId,*found_client,*response_status,*selected_meaid,*selected_previousid,*webserviceStatus;
    
    BOOL status,status1,flag;
    IBOutlet UIView *loweView;
    int error;
    IBOutlet UIImageView *imageViewDisablestep1;
}
- (IBAction)btnMEA:(id)sender;
- (IBAction)btnPreviewCustomer:(id)sender;
- (IBAction)btnLogIn:(id)sender;
- (IBAction)btnSignup:(id)sender;
- (IBAction)btnCheckBox:(id)sender;
-(void)userRegestration:(NSString*)firstName LastName:(NSString*)lastName RoleID:(NSString *)roleId PhoneNumber:(NSString*)phoneNo Emailid:(NSString*)emailid Password:(NSString *)password PurchasedBefore:(NSString*)purchasedBefore  IsFacebookUser:(NSString*)isFacebookUser  MEAID:(NSString*)meaID UserName:(NSString*)userName userid:(NSString*)userid;
-(void)gestureHandlerMethod2:(UITapGestureRecognizer*)sender;
@property (strong,nonatomic) NSString *fromEmailView;
@property (strong,nonatomic) NSArray *valuesArray;
@property (strong,nonatomic) NSString *from_fb_button,*isClient;
@end
