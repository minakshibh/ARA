//
//  dashboardViewController.h
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 11/08/15.
//  Copyright (c) 2015 Krishna_Mac_2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface dashboardViewController : UIViewController
{
    
    IBOutlet UIImageView *imageViewMenuProfile;
    IBOutlet UIImageView *headerImage;
    IBOutlet UIView *sideView;
    IBOutlet UIButton *btnMenu;
    IBOutlet UILabel *lblEmailSideMenu;
    IBOutlet UILabel *lblNameMenu;
    NSMutableData *webData;
    IBOutlet UILabel *lblActivereferralcount;
    IBOutlet UILabel *lblActiveAmount;
    IBOutlet UILabel *lblSoldreferralcount;
    IBOutlet UILabel *lblSoldreferralAmount;
    IBOutlet UILabel *lblInactivereferralcount;
    IBOutlet UILabel *lbltotalreferralcount;
    IBOutlet UILabel *lblInactivereferralAmount;
    IBOutlet UILabel *lbltotalreferralAmount;
    int webservice,i;
    NSString *recieved_status;
    IBOutlet UIButton *btnSubmitReferral;
    IBOutlet UILabel *lblheader;
    
    IBOutlet UIProgressView *progressbar;
    IBOutlet UILabel *lblAwardEarned;
    IBOutlet UILabel *lblPotentialaward;
    IBOutlet UILabel *lblInactivereferral;
    IBOutlet UILabel *lblTotalreferral;
    IBOutlet UILabel *lblActiveReferral;
    IBOutlet UILabel *lblSoldreferral;
    IBOutlet UIButton *btnmyprofile;
    IBOutlet UIButton *btnreferral;
    IBOutlet UIButton *btnPaymentaccount;
    IBOutlet UIButton *btnmybadges;
    IBOutlet UIButton *btnRewards;
    IBOutlet UIButton *btnScoreboard;
    IBOutlet UIButton *btnAboutApp;
    IBOutlet UIButton *btnLogout;
    unsigned long long bytes;
}
- (IBAction)btnAboutApp:(id)sender;
- (IBAction)btnMyRewards:(id)sender;
- (IBAction)btnReferrals:(id)sender;
- (IBAction)btnSubmitReferral:(id)sender;
- (IBAction)btnMenu:(id)sender;
- (IBAction)btnMyprofile:(id)sender;
- (IBAction)btnlogout:(id)sender;
- (IBAction)myBadges:(id)sender;
- (IBAction)btnScoreboard:(id)sender;
- (IBAction)btnPayPal:(id)sender;
- (IBAction)btnActiveReferrals:(id)sender;
- (IBAction)btnInActiveReferrals:(id)sender;
- (IBAction)btnTotalReferrals:(id)sender;
- (IBAction)btnSoldReferrals:(id)sender;
@property (nonatomic,strong) NSString *from_login;
-(void)getData;


@end
