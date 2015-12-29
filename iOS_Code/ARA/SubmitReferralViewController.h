//
//  SubmitReferralViewController.h
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 12/08/15.
//  Copyright (c) 2015 Krishna_Mac_2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBookUI/AddressBookUI.h>
#import <AddressBook/AddressBook.h>
#import "KGModal.h"

@interface SubmitReferralViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate,ABPeoplePickerNavigationControllerDelegate>
{
    CGPoint svos;
    IBOutlet UIImageView *headerImage;

    IBOutlet UILabel *lblFirstname;
    IBOutlet UITextField *txtFirstname;
    IBOutlet UILabel *lblLastname;
    IBOutlet UITextField *txtLastname;
    IBOutlet UILabel *lblPhoneno;
    IBOutlet UITextField *txtPhoneno;
    IBOutlet UILabel *lblEmail;
    IBOutlet UITextField *txtEmail;
    IBOutlet UILabel *lblMEA;
    IBOutlet UILabel *lblComments;
    IBOutlet UITextView *txtComment;
    IBOutlet UIButton *btnSubmitReferral;
    IBOutlet UIButton *btnImportContacts;
    IBOutlet UIScrollView *scrollView;
    IBOutlet UILabel *lblheading;
    
    IBOutlet UIButton *btnback;
    NSString *firstname,*lastname,*phoneno,*UserDetailId,*found_client;
    IBOutlet UILabel *lblCommentsPlaceholder;
    IBOutlet UITextField *txtmea;
    NSMutableData *webData;
    int webservice;
    NSArray *id_mea_array,*name_mea_array,*sampleArray;
    NSString *selected_mea_value,*selected_text_id;
    IBOutlet UITableView *tableView;
    IBOutlet UIButton *btnMEA;
    BOOL status,isPhoneNo,unSelected;
    IBOutlet UIView *viewEmailindicator;
    IBOutlet UIImageView *imagecheckforemailView;
    IBOutlet UILabel *lblemailerror;
    IBOutlet UILabel *lblphonenoerror;
    NSString *response_status,*email_checked;
    NSMutableArray *contact_name,*contact_phoneno,*contact_email,*twoValueArray,*twoValueArrayID;
    IBOutlet UIView *viewHeaderPOPUP;
    IBOutlet UIView *viewDetailPOPUP;
    UIScrollView *scrollViewPOPUP;
    IBOutlet UITableView *tableViewPopup;
    NSMutableDictionary *contactDict,*selectedContactDict;
    IBOutlet UITableView *tableViewPopupEmail;
    int selectedIndex;
    IBOutlet UIButton *btnShowEmailPopup;
    float viewPopUp_h,tableviewPopup_h;
    IBOutlet UILabel *lblNamePOPUPView;
    IBOutlet UILabel *lblTypeheaderpopup;
    IBOutlet UIView *viewHeaderPOPUPemail;
    IBOutlet UILabel *lblTypePOPUPEmail;
    IBOutlet UILabel *lblNamePOPUPEmail;
    NSTimer *aTimer;
    IBOutlet UIButton *btnDonePOPUPemail;
     IBOutlet UILabel *lblheaderbackgroungPopup;
    IBOutlet UILabel *lblheaderbackgroungPopupEmail;
}
- (IBAction)btnShowEmailPopup:(id)sender;
- (IBAction)btnDonePOPUPemail:(id)sender;

- (IBAction)btnSubmitReferral:(id)sender;
- (IBAction)btnMEA:(id)sender;
- (IBAction)btnImportContacts:(id)sender;
- (IBAction)btnBack:(id)sender;
- (id)initWithNibName:(NSString *)nibNameOrNil WithKey:(NSString *)key bundle:(NSBundle *)nibBundleOrNil;
@property (nonatomic, strong) ABPeoplePickerNavigationController *addressBookController;
@property (nonatomic, strong) NSMutableArray *arrContactsData;


@end
