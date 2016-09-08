//
//  DistributerDetailViewController.h
//  AUTOAVES_REFERRAL
//
//  Created by Mac on 19/08/16.
//  Copyright © 2016 Krishna_Mac_2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DistributerDetailViewController : UIViewController
{
    IBOutlet UIButton *btnNetworkInvitation;
    IBOutlet UIButton *btnAppInstallation;
    IBOutlet UIButton *btnNetworkReferral;
    IBOutlet UIButton *btnMyInvitation;
    IBOutlet UIButton *Backbtn;
    IBOutlet UILabel *lblmyInvitation;
    IBOutlet UILabel *lblTotalNetwork;
     IBOutlet UILabel *lblApp;
     IBOutlet UILabel *lblNetwork;
    IBOutlet UILabel *lblviewHeading;
    
//    IBOutlet UILabel*Install;
//    IBOutlet UILabel*Invitation;
//    IBOutlet UILabel*Referral;
    
    IBOutlet UILabel *lblmyInvitationCount;
    IBOutlet UILabel *lblNetworkInvitationCount;
    IBOutlet UILabel *lblAppInstallsCount;
    IBOutlet UILabel *lblNetworkReferralCount;
    
    IBOutlet UIButton *btnAboutApp;
    IBOutlet UIButton *btnLogout;
    IBOutlet UIButton *btnnewAppURL;
    int webservice,count_status;
    
    IBOutlet UIImageView *myinvitationBtnImage;
     IBOutlet UIImageView *networkInvitationBtnImage;
     IBOutlet UIImageView *appInstallBtnImage;
     IBOutlet UIImageView *networkReferralBtnImage;
    
    NSMutableData *webData;
    NSString *recieved_status;
}
-(IBAction)myInvitation:(id)sender;
-(IBAction)networkInvitation:(id)sender;
-(IBAction)appInstallation:(id)sender;
-(IBAction)networkReferral:(id)sender;
-(IBAction)returnBack:(id)sender;
-(IBAction)btnnewAppURL:(id)sender;
-(IBAction)btnAboutApp:(id)sender;
-(IBAction)btnlogout:(id)sender;

@property (atomic) BOOL stop;

@end
