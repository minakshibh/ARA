//
//  ScoreboardViewController.h
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 17/08/15.
//  Copyright (c) 2015 Krishna_Mac_2. All rights reserved.
//

#import "ViewController.h"

@interface ScoreboardViewController : ViewController
{
    IBOutlet UIImageView *headerImage;

    IBOutlet UILabel *lblBackgroundEarning;
    IBOutlet UILabel *lblbackgroundReferral;
    IBOutlet UILabel *lblbackgroundSoldReferrals;
    IBOutlet UIButton *btnQuater;
    IBOutlet UIButton *btnYear;
    IBOutlet UIButton *btnAllTime;
    IBOutlet UILabel *lblHighestEarningPrice;
    IBOutlet UILabel *lblReferralCount;
    IBOutlet UILabel *lblSoldReferralCount;
    NSString *value;
    IBOutlet UILabel *lblEarning;
    IBOutlet UILabel *lblhighest;
    NSMutableData *webData;
    IBOutlet UILabel *lblhighestref;
    IBOutlet UILabel *lblhighestReferral;
    NSString *response_status,*timestamp;
    IBOutlet UILabel *lblHighestsoldreferral;
    IBOutlet UIButton *btnBack;
    IBOutlet UILabel *lblHeading;
    IBOutlet UILabel *lblHighestSOLDReferral;
}
- (IBAction)btnAllTime:(id)sender;
- (IBAction)btnYear:(id)sender;
- (IBAction)btnQuater:(id)sender;
- (IBAction)btnBack:(id)sender;
- (IBAction)btnReferrals:(id)sender;
- (IBAction)btnSoldReferrals:(id)sender;

- (IBAction)btnEarning:(id)sender;
@end
