//
//  addpaypalemailViewController.h
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 08/09/15.
//  Copyright (c) 2015 Krishna_Mac_2. All rights reserved.
//

#import "ViewController.h"
#import "paypalObj.h"

@interface addpaypalemailViewController : ViewController
{
    IBOutlet UILabel *lblheading;
    IBOutlet UIImageView *headerImage;

    IBOutlet UIImageView *imagelogo;
    IBOutlet UIButton *btnback;
    IBOutlet UITextField *txtDropDown;
    IBOutlet UIView *emailview;
    IBOutlet UITextField *txtEmail;
    IBOutlet UIScrollView *scrollView;
    CGPoint svos;
    int webservice;
    NSMutableData *webData;
    NSString *response_status,*value,*selected_id;
    
    IBOutlet UIButton *selectPaymentMode;
    BOOL status,status_dropdown;
    IBOutlet UIButton *btnCheckbox;
    IBOutlet UITableView *tableView;
    IBOutlet UIButton *btnSavechanges;
    NSArray *array_payment_id,*array_payment_name;
    IBOutlet UILabel *lblDropdown;
    IBOutlet UILabel *lblemailback;
    IBOutlet UIImageView *imageDropDownIcon;
}
- (IBAction)selectPaymentMode:(id)sender;
- (IBAction)btnBack:(id)sender;
- (IBAction)btnSavechanges:(id)sender;
- (IBAction)btnCheckbox:(id)sender;
@property (nonatomic,retain) paypalObj *obj;
@property (nonatomic,strong) NSString *trigger;
@property (nonatomic, assign) int paypalListCount;
@property (nonatomic,strong) NSArray *email_array;
@end
