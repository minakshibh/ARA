//
//  ScheduleServiceViewController.h
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 21/01/16.
//  Copyright © 2016 Krishna_Mac_2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScheduleServiceViewController : UIViewController<UITextFieldDelegate,UIPopoverControllerDelegate,UIScrollViewDelegate,UITextViewDelegate>
{
    IBOutlet UILabel *lblphoneNoBackground;
    
    IBOutlet UILabel *lblemailAddressBackground;
    IBOutlet UILabel *lblfirstnameBackground;
    IBOutlet UILabel *lbllastNameBackground;
    IBOutlet UILabel *lbltypeOfServiceBackground;
    IBOutlet UILabel *lblcommentsBackground;
    IBOutlet UILabel *lblselectTimeSlotBackground;
    IBOutlet UILabel *lblprefferedDateBackground;
    IBOutlet UILabel *lblheading;
    IBOutlet UILabel *lblCommentPlaceholder;
    IBOutlet UILabel *lblCommentsCount;
    IBOutlet UITextField *txtFirstname;
    IBOutlet UIView *backgroundTouch;
    IBOutlet UITextField *txtLastName;
    IBOutlet UITextField *txtemailAddress;
    
    IBOutlet UITextField *txtPhoneNo;
    IBOutlet UITextField *txtTypeOfService;
    
    IBOutlet UITextField *txtSelectTimeSlot;
    IBOutlet UITextField *txtPrefferedDate;
    IBOutlet UITextView *txtComments;
    IBOutlet UITableView *tableViewTypeOfService;
    
    IBOutlet UITableView *tableViewSelectTimeSlot;
    
    
    IBOutlet UIButton *btnSubmit;
    IBOutlet UIButton *btnBack;
    IBOutlet UIButton *btnTypeOfService;
    IBOutlet UIButton *btnSelectTimeSlot;
    IBOutlet UIScrollView *scrollView;
    
    UIDatePicker *datepicker;
    UIPopoverController *popOverForDatePicker;
    BOOL statusService,statusTime;
    IBOutlet UIButton *btnDonePicker;
    IBOutlet UIButton *btnCancelPicker;
    IBOutlet UIView *viewPickerbackground;
    
    NSMutableData *webData;
    int webservice;
    NSString *recieved_status,*ServiceTypeSelectedId,*selectTimeSlotSeletedId,*pickerSelectedDate;
    NSMutableArray *serviceTypeNameArray,*serviceTypeIdArray,*selectTimeSlotArr,*selectTimeSlotIdArr;
    BOOL pickerDateStatus;
    IBOutlet UIDatePicker *pickerDate;
    CGPoint svos;
}
- (IBAction)btnCancelPicker:(id)sender;
- (IBAction)btnSelectTimeSlot:(id)sender;
- (IBAction)btnBack:(id)sender;
- (IBAction)btnTypeOfService:(id)sender;
- (IBAction)btnSubmit:(id)sender;
- (IBAction)btnDonePicker:(id)sender;
@end
