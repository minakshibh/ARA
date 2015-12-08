//
//  rewardDetailViewController.h
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 16/09/15.
//  Copyright (c) 2015 Krishna_Mac_2. All rights reserved.
//

#import "ViewController.h"
#import "ReferralObj.h"
@interface rewardDetailViewController : ViewController
{
    IBOutlet UILabel *lblrewardAmount;
    IBOutlet UILabel *lblRewardAmount;
    IBOutlet UILabel *lblrewarddesc;
    IBOutlet UILabel *lblrewardtype;
    IBOutlet UILabel *lblReferralId;
    IBOutlet UILabel *lblrewardname;
    IBOutlet UILabel *lblrewardlevel;
    IBOutlet UILabel *lblTransitionid;
    IBOutlet UIButton *btnreferraldetails;
    IBOutlet UIButton *btnBack;
    IBOutlet UILabel *lblRewardDescription;
    IBOutlet UIImageView *headerImage;

    IBOutlet UILabel *lblRewardName;
    IBOutlet UILabel *lblRewardType;
    IBOutlet UILabel *lblRewardlevel;
    IBOutlet UILabel *lblTransactionID;
    IBOutlet UILabel *lblReferralID;
    IBOutlet UILabel *lblTransactionIDtxt;
    IBOutlet UILabel *lblHeading;
    IBOutlet UILabel *lblTransactionIDpartition;
}
- (IBAction)btnBack:(id)sender;
- (IBAction)btnReferrarDetail:(id)sender;
@property (nonatomic,strong) ReferralObj *obj;
@end
