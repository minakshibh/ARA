//
//  referralDetailViewController.h
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 12/08/15.
//  Copyright (c) 2015 Krishna_Mac_2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReferralObj.h"

@interface referralDetailViewController : UIViewController <UITextViewDelegate>
{
    IBOutlet UIImageView *headerImage;

    IBOutlet UILabel *lblReferrerName;
    IBOutlet UIImageView *imagechainunchained;
    IBOutlet UIButton *btnback;
    IBOutlet UIView *commentView;
    IBOutlet UILabel *lblName;
    IBOutlet UILabel *lblEmail;
    IBOutlet UILabel *lblPhoneno;
    IBOutlet UILabel *lblreferralId;
    IBOutlet UILabel *lblMEAname;
    IBOutlet UILabel *lblsoldOpen;
    IBOutlet UILabel *lblComments;
    IBOutlet UILabel *lblTagColor;
    IBOutlet UILabel *lblsoldDatePrtitionLine;
    IBOutlet UILabel *btndirectindirect;
    IBOutlet UILabel *lblSoldDatetxt;
    IBOutlet UILabel *lblCreateDate;
    IBOutlet UILabel *lblSoldDateValue;
    IBOutlet UILabel *lblPricePrtitionLine;
    IBOutlet UILabel *lblSoldDate;
    IBOutlet UILabel *lblPricetxt;
    IBOutlet UILabel *lblPriceValue;
    IBOutlet UILabel *lblCommenttxt;
    IBOutlet UILabel *lblCommentValue;
    IBOutlet UILabel *lblname1;
    IBOutlet UILabel *lblCommentPrtitionLine;
    IBOutlet UILabel *lblemail1;
    IBOutlet UILabel *lblheading;
    IBOutlet UILabel *lblreferraltxt;
    IBOutlet UILabel *lblsolddate1;
    IBOutlet UILabel *lblcreateddate1;
    IBOutlet UILabel *lblmea1;
    IBOutlet UILabel *lblphoneno1;
    IBOutlet UIButton *btnAddNotes;
    IBOutlet UILabel *lblNotes;
    IBOutlet UITextView *txtNotesDetail;
    IBOutlet UILabel *lblNotesBottomLine;
    
    IBOutlet UITableView *tableView;

    NSMutableData *webData;
    NSString *response_status;
    UITextView *textViewNew;
    NSTimer *timer;
}
- (IBAction)btnBack:(id)sender;
@property (strong,nonatomic) ReferralObj *obj;
@property (strong,nonatomic) NSString * from_RewardList;
@end
