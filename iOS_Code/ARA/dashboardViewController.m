 //
//  dashboardViewController.m
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 11/08/15.
//  Copyright (c) 2015 Krishna_Mac_2. All rights reserved.
//

#import "dashboardViewController.h"
#import "ProfileViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "LoginViewController.h"
#import "SubmitReferralViewController.h"
#import "referralListViewController.h"
#import "myBadgesViewController.h"
#import "rewardListViewController.h"
#import "ScoreboardViewController.h"
#import "PaypalAccountsViewController.h"
#import "AboutAppViewController.h"
#import "AFURLConnectionOperation.h"
#import "AFHTTPRequestOperation.h"
#import "notificationViewController.h"
#import "ScheduleServiceViewController.h"
#import "SMContactsSelector.h"
#import "UIImageView+Webcache.h"
#import "DistributerDetailViewController.h"
// #import "UIView+Toast.h"

@interface dashboardViewController ()
{
    referralListViewController *RLvc;
    AFHTTPRequestOperation *requestOperation;
    NSTimer *refreshApiNotificationCountTimer;
}
@end

@implementation dashboardViewController

- (void)viewDidLoad {
    
    
    
    //.frame = CGRectMake(imagenotificationcount.frame.origin.x, imagenotificationcount.frame.origin.y, imagenotificationcount.frame.size.width-2, imagenotificationcount.frame.size.height-2)
    
    
    [btnSubmitReferral setHidden:NO];
    [sideMenuBtn setHidden:YES];
    [menuBtnImage setHidden:YES];
    [newReferralBtn setHidden:YES];
    [sendInvitationBtn setHidden:YES];
    
    [self centerButtonAndImageWithSpacing:6];
    [self newcenterButtonAndImageWithSpacing:8];
    
    
    label45 = [[UILabel alloc]init];
    requestOperation = [[AFHTTPRequestOperation alloc]init];
    
    [super viewDidLoad];
    i=0;
    lblComingSoon.layer.cornerRadius = 10.0;
    [lblComingSoon setClipsToBounds:YES];
    
    imagenotificationcount.hidden = YES;
    
    UIImageView *referralImage = [[UIImageView alloc]initWithFrame:CGRectMake(14, btnSubmitReferral.frame.size.height/2-10, 26, 21)];
    if (IS_IPHONE_6) {
         referralImage = [[UIImageView alloc]initWithFrame:CGRectMake(referralImage.frame.origin.x-4,referralImage.frame.origin.y-1 , referralImage.frame.size.width- 3, referralImage.frame.size.height-3)];
    }else if (IS_IPHONE_5){
        referralImage = [[UIImageView alloc]initWithFrame:CGRectMake(referralImage.frame.origin.x-4,referralImage.frame.origin.y-4, referralImage.frame.size.width-5, referralImage.frame.size.height-3)];
     //   btnSubmitReferral.frame = CGRectMake(50,266 ,181, 50);
        
     }else if (IS_IPHONE_4_OR_LESS){
          referralImage = [[UIImageView alloc]initWithFrame:CGRectMake(referralImage.frame.origin.x-4,referralImage.frame.origin.y-6, referralImage.frame.size.width-7, referralImage.frame.size.height-4)];
     }else if (IS_IPAD){
           referralImage = [[UIImageView alloc]initWithFrame:CGRectMake(referralImage.frame.origin.x+12,btnSubmitReferral.frame.size.height/2-6 , referralImage.frame.size.width+13, referralImage.frame.size.height+10)];
     }
   
    referralImage.image = [UIImage imageNamed:@"refer-icon11"];
    [btnSubmitReferral addSubview:referralImage];
    [btnSubmitReferral bringSubviewToFront:referralImage];
    
    UILabel *referralLabel = [[UILabel alloc]initWithFrame:CGRectMake(referralImage.frame.origin.x+referralImage.frame.size.width+8, referralImage.frame.origin.y, btnSubmitReferral.frame.size.width-referralImage.frame.size.width-referralImage.frame.origin.x, referralImage.frame.size.height)];
    if (IS_IPHONE_6) {
        referralLabel = [[UILabel alloc]initWithFrame:CGRectMake(referralImage.frame.origin.x+referralImage.frame.size.width+8, referralImage.frame.origin.y, btnSubmitReferral.frame.size.width-referralImage.frame.size.width-referralImage.frame.origin.x, referralImage.frame.size.height)];
       referralLabel.font = [UIFont fontWithName:@"Roboto-Regular" size:16];
    }else if (IS_IPHONE_5){
        referralLabel = [[UILabel alloc]initWithFrame:CGRectMake(referralImage.frame.origin.x+referralImage.frame.size.width+8, referralImage.frame.origin.y, btnSubmitReferral.frame.size.width-referralImage.frame.size.width-referralImage.frame.origin.x, referralImage.frame.size.height)];
     //   referralLabel.frame = CGRectMake(21,266 ,181, 40);
        referralLabel.font = [UIFont fontWithName:@"Roboto-Regular" size:14];
       }else if (IS_IPHONE_4_OR_LESS){
           referralLabel = [[UILabel alloc]initWithFrame:CGRectMake(referralImage.frame.origin.x+referralImage.frame.size.width+6, referralImage.frame.origin.y, btnSubmitReferral.frame.size.width-referralImage.frame.size.width-referralImage.frame.origin.x, referralImage.frame.size.height)];
           referralLabel.font = [UIFont fontWithName:@"Roboto-Regular" size:14];
       }else if (IS_IPAD){
           referralLabel = [[UILabel alloc]initWithFrame:CGRectMake(referralImage.frame.origin.x+referralImage.frame.size.width+15, referralImage.frame.origin.y, btnSubmitReferral.frame.size.width-referralImage.frame.size.width-referralImage.frame.origin.x+140, referralImage.frame.size.height)];
           referralLabel.font = [UIFont fontWithName:@"Roboto-Regular" size:28  ];
       }
      referralLabel.text = @"Refer a Friend/Family";
    referralLabel.textColor =  [UIColor blackColor];
    [btnSubmitReferral addSubview:referralLabel];
    
    
    [btnSubmitReferral setTitle:@"" forState:UIControlStateNormal];
    
    btnSubmitReferral.layer.cornerRadius = 4.0;
    btnmyprofile.layer.cornerRadius = 4.0;
    imageViewMenuProfile.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor colorWithRed:250.0f/255.0f green:196.0f/255.0f blue:39.0f/255.0f alpha:1]);
    
    [self.view addSubview:viewNew];
    [self.view bringSubviewToFront:viewNew];


    //--hide navigation bar
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    [self.view bringSubviewToFront:sideView];
    
//    NSLog(@"%f",self.view.frame.size.height);
    
    imageViewMenuProfile.clipsToBounds = YES;
    
    
    lblEmailSideMenu.text = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"l_email"]];

    
    [self registerDevice];
//    NSLog(@"%@",lblEmailSideMenu.text);
 
    if (IS_IPHONE_6P) {
         menuBtnImage.frame = CGRectMake(15,34, 33, 35);
        viewnewNotification.frame = CGRectMake(viewnewNotification.frame.origin.x-7, viewnewNotification.frame.origin.y-12, viewnewNotification.frame.size.width+10, viewnewNotification.frame.size.height+10);
        lblnewContactUs.font = [lblnewContactUs.font fontWithSize:15];
        lblnewContactUs.frame = CGRectMake(lblnewContactUs.frame.origin.x, lblnewContactUs.frame.origin.y+7, lblnewContactUs.frame.size.width, lblnewContactUs.frame.size.height);
         lblComingSoon.font = [lblComingSoon.font fontWithSize:lblComingSoon.font.pointSize-1];
    }
    if (IS_IPHONE_6) {
        
        
         menuBtnImage.frame = CGRectMake(15,34, 33, 35);
         btnSubmitReferral.frame = CGRectMake(btnSubmitReferral.frame.origin.x-8, btnSubmitReferral.frame.origin.y, btnSubmitReferral.frame.size.width+8, btnSubmitReferral.frame.size.height);
        viewnewNotification.frame = CGRectMake(viewnewNotification.frame.origin.x-7, viewnewNotification.frame.origin.y-12, viewnewNotification.frame.size.width+10, viewnewNotification.frame.size.height+10);
        lblComingSoon.font = [lblComingSoon.font fontWithSize:12];
    }
    if ( IS_IPHONE_5) {
        lblComingSoon.layer.cornerRadius = 5;
         imageViewMenuProfile.frame = CGRectMake(imageViewMenuProfile.frame.origin.x-6, imageViewMenuProfile.frame.origin.y-7, imageViewMenuProfile.frame.size.width, imageViewMenuProfile.frame.size.height);
        btnSubmitReferral.frame = CGRectMake(btnSubmitReferral.frame.origin.x-12, btnSubmitReferral.frame.origin.y+2, btnSubmitReferral.frame.size.width+15, btnSubmitReferral.frame.size.height);
        btnProfile.frame = CGRectMake(btnProfile.frame.origin.x, btnProfile.frame.origin.y+5, btnProfile.frame.size.width, btnProfile.frame.size.height);
        
        btnSubmitReferral.titleLabel.font = [btnSubmitReferral.titleLabel.font fontWithSize:10];
        viewnewNotification.frame = CGRectMake(viewnewNotification.frame.origin.x-7, viewnewNotification.frame.origin.y-12, viewnewNotification.frame.size.width+10, viewnewNotification.frame.size.height+10);
         lblNameMenu.frame = CGRectMake(lblNameMenu.frame.origin.x, lblNameMenu.frame.origin.y+3, lblNameMenu.frame.size.width, lblNameMenu.frame.size.height);
        lblnewActiveSoldCount.font = [lblnewAutoAvenews.font fontWithSize:12];
        lblnewEarnedAwardePrice.font = [lblnewAutoAvenews.font fontWithSize:12];
        lblnewActiveSoldCount.frame = CGRectMake(lblnewActiveSoldCount.frame.origin.x, lblnewActiveSoldCount.frame.origin.y+3, lblnewActiveSoldCount.frame.size.width, lblnewActiveSoldCount.frame.size.height);
        lblnewEarnedAwardePrice.frame = CGRectMake(lblnewEarnedAwardePrice.frame.origin.x, lblnewEarnedAwardePrice.frame.origin.y+3, lblnewEarnedAwardePrice.frame.size.width, lblnewEarnedAwardePrice.frame.size.height);
        lblnewReferrals.font = [lblnewReferrals.font fontWithSize:14];
        lblnewReferralsReward.font = [lblnewReferralsReward.font fontWithSize:14];
        lblnewScheduleService.font = [lblnewScheduleService.font fontWithSize:14];
        lblnewAutoAvenews.font = [lblnewAutoAvenews.font fontWithSize:14];
        
        lblnewPhoneNo.frame = CGRectMake(lblnewPhoneNo.frame.origin.x, lblnewPhoneNo.frame.origin.y+3, lblnewPhoneNo.frame.size.width, lblnewPhoneNo.frame.size.height);
        lblComingSoon.font = [lblComingSoon.font fontWithSize:11];
          menuBtnImage.frame = CGRectMake(15,36, 32, 35);
        
        
    }
    if (IS_IPHONE_4_OR_LESS) {
        
        
        
        menuBtnImage.frame = CGRectMake(15,38, 28, 33);

        lblComingSoon.font = [lblComingSoon.font fontWithSize:11];
         imageViewMenuProfile.frame = CGRectMake(imageViewMenuProfile.frame.origin.x, imageViewMenuProfile.frame.origin.y-7, imageViewMenuProfile.frame.size.width, imageViewMenuProfile.frame.size.height);
        lblNameMenu.frame = CGRectMake(lblNameMenu.frame.origin.x, lblNameMenu.frame.origin.y+2, lblNameMenu.frame.size.width, lblNameMenu.frame.size.height);
        btnSubmitReferral.titleLabel.font = [btnSubmitReferral.titleLabel.font fontWithSize:9];
        btnSubmitReferral.frame = CGRectMake(btnSubmitReferral.frame.origin.x-4, btnSubmitReferral.frame.origin.y+3, btnSubmitReferral.frame.size.width+4, btnSubmitReferral.frame.size.height);
        btnProfile.frame = CGRectMake(btnProfile.frame.origin.x, btnProfile.frame.origin.y+4, btnProfile.frame.size.width, btnProfile.frame.size.height);
        lblComingSoon.layer.cornerRadius = 5;

         btnmyprofile.titleLabel.font = [btnmyprofile.titleLabel.font fontWithSize:12];
        lblnewReferrals.font = [lblnewReferrals.font fontWithSize:14];
        lblnewReferralsReward.font = [lblnewReferralsReward.font fontWithSize:14];
        lblnewScheduleService.font = [lblnewScheduleService.font fontWithSize:14];
        lblnewAutoAvenews.font = [lblnewAutoAvenews.font fontWithSize:14];
        
        lblnewActiveSoldCount.font = [lblnewAutoAvenews.font fontWithSize:12];
        lblnewEarnedAwardePrice.font = [lblnewAutoAvenews.font fontWithSize:12];
        lblnewActiveSoldCount.frame = CGRectMake(lblnewActiveSoldCount.frame.origin.x, lblnewActiveSoldCount.frame.origin.y+4, lblnewActiveSoldCount.frame.size.width, lblnewActiveSoldCount.frame.size.height);
        lblnewEarnedAwardePrice.frame = CGRectMake(lblnewEarnedAwardePrice.frame.origin.x, lblnewEarnedAwardePrice.frame.origin.y+4, lblnewEarnedAwardePrice.frame.size.width, lblnewEarnedAwardePrice.frame.size.height);
        
        lblEmailSideMenu.font = [lblEmailSideMenu.font fontWithSize:12];
        lblnewPhoneNo.font = [lblnewPhoneNo.font fontWithSize:12];
        lblnewPhoneNo.frame = CGRectMake(lblnewPhoneNo.frame.origin.x, lblnewPhoneNo.frame.origin.y+4, lblnewPhoneNo.frame.size.width, lblnewPhoneNo.frame.size.height);
        
         btnAboutApp.titleLabel.font = [btnAboutApp.titleLabel.font fontWithSize:11];
         btnLogout.titleLabel.font = [btnLogout.titleLabel.font fontWithSize:11];
         btnnewAppURL.titleLabel.font = [btnnewAppURL.titleLabel.font fontWithSize:11];
        
        viewnewNotification.frame = CGRectMake(viewnewNotification.frame.origin.x-7, viewnewNotification.frame.origin.y-12, viewnewNotification.frame.size.width+10, viewnewNotification.frame.size.height+10);
//        NSLog(@"test");
    }
    
    if ( IS_IPAD )
    {
        //menuBtnImage
        
       // menuBtnImage.frame = CGRectMake(15,34 , 23, 31);
         menuBtnImage.frame = CGRectMake(15,34 , 27, 35);
        
        
         lblComingSoon.font = [lblComingSoon.font fontWithSize:lblComingSoon.font.pointSize+2];
         lblComingSoon.frame = CGRectMake(lblComingSoon.frame.origin.x+13, lblComingSoon.frame.origin.y, lblComingSoon.frame.size.width-25, lblComingSoon.frame.size.height);
        
      //   btnSubmitReferral.titleLabel.font = [btnSubmitReferral.titleLabel.font fontWithSize:24];
       btnSubmitReferral.titleLabel.font = [btnSubmitReferral.titleLabel.font fontWithSize:18];
        
        btnSubmitReferral.frame = CGRectMake(btnSubmitReferral.frame.origin.x+20-6, btnSubmitReferral.frame.origin.y+6, btnSubmitReferral.frame.size.width-17, btnSubmitReferral.frame.size.height);
        
        btnProfile.frame = CGRectMake(btnProfile.frame.origin.x, btnProfile.frame.origin.y+8, btnProfile.frame.size.width, btnProfile.frame.size.height);

        
       lblheader.font=[lblheader.font fontWithSize:24];
        lblActiveReferral.font=[lblActiveReferral.font fontWithSize:24];
         lblSoldreferral.font=[lblSoldreferral.font fontWithSize:24];
         lblInactivereferral.font=[lblInactivereferral.font fontWithSize:24];
        lblTotalreferral.font=[lblTotalreferral.font fontWithSize:24];
        
        
        lblPotentialaward.font=[lblPotentialaward.font fontWithSize:15];
        lblAwardEarned.font=[lblAwardEarned.font fontWithSize:15];
        lblPotentialaward.frame = CGRectMake(lblPotentialaward.frame.origin.x, lblPotentialaward.frame.origin.y-2, lblPotentialaward.frame.size.width, lblPotentialaward.frame.size.height);
        lblAwardEarned.frame = CGRectMake(lblAwardEarned.frame.origin.x, lblAwardEarned.frame.origin.y-2, lblAwardEarned.frame.size.width, lblAwardEarned.frame.size.height);
        
        lblActiveAmount.font=[lblActiveAmount.font fontWithSize:35];
//        lblNameMenu.font=[lblNameMenu.font fontWithSize:35];
        lblNameMenu.font=[lblNameMenu.font fontWithSize:32];
         lblNameMenu.frame = CGRectMake(lblNameMenu.frame.origin.x, lblNameMenu.frame.origin.y+3, lblNameMenu.frame.size.width, lblNameMenu.frame.size.height);
        
        lblSoldreferralAmount.font=[lblSoldreferralAmount.font fontWithSize:35];
        
        lblActivereferralcount.font=[lblActivereferralcount.font fontWithSize:85];
        lblSoldreferralcount.font=[lblSoldreferralcount.font fontWithSize:85];
        
        lblInactivereferralcount.font=[lblInactivereferralcount.font fontWithSize:85];
        lbltotalreferralcount.font=[lbltotalreferralcount.font fontWithSize:85];
        lblEmailSideMenu.font=[lblEmailSideMenu.font fontWithSize:20];
        

//        btnmyprofile.titleLabel.font=[btnmyprofile.titleLabel.font fontWithSize:24];
        btnmyprofile.titleLabel.font=[btnmyprofile.titleLabel.font fontWithSize:20];
        btnreferral.titleLabel.font=[btnreferral.titleLabel.font fontWithSize:24];
        btnPaymentaccount.titleLabel.font=[btnPaymentaccount.titleLabel.font fontWithSize:24];
        btnmybadges.titleLabel.font=[btnmybadges.titleLabel.font fontWithSize:24];
        btnRewards.titleLabel.font=[btnRewards.titleLabel.font fontWithSize:24];
        btnScoreboard.titleLabel.font=[btnScoreboard.titleLabel.font fontWithSize:24];
        btnAboutApp.titleLabel.font=[btnAboutApp.titleLabel.font fontWithSize:24];
        btnLogout.titleLabel.font=[btnLogout.titleLabel.font fontWithSize:24];
        
        lblnewContactUs.font=[lblnewContactUs.font fontWithSize:26];
        btnnewEmail.titleLabel.font=[btnnewEmail.titleLabel.font fontWithSize:20];
        btnnewPhoneNo.titleLabel.font=[btnnewPhoneNo.titleLabel.font fontWithSize:20];
        btnnewEmail.frame = CGRectMake(btnnewEmail.frame.origin.x, btnnewEmail.frame.origin.y, btnnewEmail.frame.size.width, btnnewEmail.frame.size.height);
        
        lblnewActiveSoldCount.font = [lblnewActiveSoldCount.font fontWithSize:22];
        lblnewEarnedAwardePrice.font = [lblnewActiveSoldCount.font fontWithSize:22];
        lblnewReferrals.font = [lblnewReferrals.font fontWithSize:26];
        lblnewReferralsReward.font = [lblnewReferralsReward.font fontWithSize:26];
        lblnewScheduleService.font = [lblnewScheduleService.font fontWithSize:26];
        lblnewAutoAvenews.font = [lblnewAutoAvenews.font fontWithSize:26];
        
        btnAboutApp.titleLabel.font=[btnAboutApp.titleLabel.font fontWithSize:20];

        btnLogout.titleLabel.font=[btnLogout.titleLabel.font fontWithSize:20];
        btnnewAppURL.titleLabel.font=[btnnewAppURL.titleLabel.font fontWithSize:20];
        imageViewMenuProfile.frame = CGRectMake(imageViewMenuProfile.frame.origin.x+2, imageViewMenuProfile.frame.origin.y+4, imageViewMenuProfile.frame.size.width, imageViewMenuProfile.frame.size.height);
        /*
         Ipad pro  12.9-inch
         
         ipad air  7.5
         
         ipad air 2  9.7
         
         ipad mini 2 7.2
         
         ipad 2   9.7
         */
        viewnewNotification.frame = CGRectMake(viewnewNotification.frame.origin.x, viewnewNotification.frame.origin.y-6, viewnewNotification.frame.size.width, viewnewNotification.frame.size.height);
        if(IS_IPAD_PRO_1366 )
        {
             menuBtnImage.frame = CGRectMake(15,35,18,34);
            viewnewNotification.frame = CGRectMake(viewnewNotification.frame.origin.x-7, viewnewNotification.frame.origin.y-12, viewnewNotification.frame.size.width+10, viewnewNotification.frame.size.height+10);
             btnSubmitReferral.frame = CGRectMake(btnSubmitReferral.frame.origin.x-7   , btnSubmitReferral.frame.origin.y, btnSubmitReferral.frame.size.width+7, btnSubmitReferral.frame.size.height);
            btnSubmitReferral.titleLabel.font = [btnSubmitReferral.titleLabel.font fontWithSize:26];
             imagenotificationcount.frame = CGRectMake(imagenotificationcount.frame.origin.x, imagenotificationcount.frame.origin.y, imagenotificationcount.frame.size.width-2, imagenotificationcount.frame.size.height-2);
            
            lblnewActiveSoldCount.font = [lblnewActiveSoldCount.font fontWithSize:26];
            lblnewEarnedAwardePrice.font = [lblnewEarnedAwardePrice.font fontWithSize:26];
            lblnewReferrals.font = [lblnewReferrals.font fontWithSize:30];
            lblnewReferralsReward.font = [lblnewReferralsReward.font fontWithSize:30];
            lblnewScheduleService.font = [lblnewScheduleService.font fontWithSize:30];
            lblnewAutoAvenews.font = [lblnewAutoAvenews.font fontWithSize:30];
            
            lblnewContactUs.font=[lblnewContactUs.font fontWithSize:30];
            btnnewEmail.titleLabel.font=[btnnewEmail.titleLabel.font fontWithSize:26];
            btnnewPhoneNo.titleLabel.font=[btnnewPhoneNo.titleLabel.font fontWithSize:26];
            lblnewContactUs.frame = CGRectMake(lblnewContactUs.frame.origin.x, lblnewContactUs.frame.origin.y+4, lblnewContactUs.frame.size.width, lblnewContactUs.frame.size.height);
            btnAboutApp.titleLabel.font=[btnAboutApp.titleLabel.font fontWithSize:25];
            btnLogout.titleLabel.font=[btnLogout.titleLabel.font fontWithSize:25];
            btnnewAppURL.titleLabel.font=[btnnewAppURL.titleLabel.font fontWithSize:26];

            
            
            lblheader.font=[lblheader.font fontWithSize:30];
            lblActiveReferral.font=[lblActiveReferral.font fontWithSize:30];
            lblSoldreferral.font=[lblSoldreferral.font fontWithSize:30];
            lblInactivereferral.font=[lblInactivereferral.font fontWithSize:30];
            lblTotalreferral.font=[lblTotalreferral.font fontWithSize:30];
            
            
            lblPotentialaward.font=[lblPotentialaward.font fontWithSize:21];
            lblAwardEarned.font=[lblAwardEarned.font fontWithSize:21];
            lblPotentialaward.frame = CGRectMake(lblPotentialaward.frame.origin.x, lblPotentialaward.frame.origin.y, lblPotentialaward.frame.size.width, lblPotentialaward.frame.size.height);
            lblAwardEarned.frame = CGRectMake(lblAwardEarned.frame.origin.x, lblAwardEarned.frame.origin.y, lblAwardEarned.frame.size.width, lblAwardEarned.frame.size.height);
            
            lblActiveAmount.font=[lblActiveAmount.font fontWithSize:44];
            lblNameMenu.font=[lblNameMenu.font fontWithSize:44];
            lblSoldreferralAmount.font=[lblSoldreferralAmount.font fontWithSize:44];
            
            lblActivereferralcount.font=[lblActivereferralcount.font fontWithSize:94];
            lblSoldreferralcount.font=[lblSoldreferralcount.font fontWithSize:94];
            
            lblInactivereferralcount.font=[lblInactivereferralcount.font fontWithSize:94];
            lbltotalreferralcount.font=[lbltotalreferralcount.font fontWithSize:94];
            lblEmailSideMenu.font=[lblEmailSideMenu.font fontWithSize:24];
            
            
//
            btnmyprofile.titleLabel.font=[btnmyprofile.titleLabel.font fontWithSize:30];

            btnreferral.titleLabel.font=[btnreferral.titleLabel.font fontWithSize:30];
            btnPaymentaccount.titleLabel.font=[btnPaymentaccount.titleLabel.font fontWithSize:30];
            btnmybadges.titleLabel.font=[btnmybadges.titleLabel.font fontWithSize:30];
            btnRewards.titleLabel.font=[btnRewards.titleLabel.font fontWithSize:30];
            btnScoreboard.titleLabel.font=[btnScoreboard.titleLabel.font fontWithSize:30];
            btnAboutApp.titleLabel.font=[btnAboutApp.titleLabel.font fontWithSize:30];
            btnLogout.titleLabel.font=[btnLogout.titleLabel.font fontWithSize:30];
            
            
        }
        
    }
    

    [NSTimer scheduledTimerWithTimeInterval:0.1
                                     target:self
                                   selector:@selector(targetMethod:)
                                   userInfo:nil
                                    repeats:NO];
//    [NSTimer scheduledTimerWithTimeInterval:0.1
//                                     target:self
//                                   selector:@selector(imageReload:)
//                                   userInfo:nil
//                                    repeats:YES];
//


}

-(void)imageReload
{
    UIImage *img = [[SDImageCache sharedImageCache]imageFromMemoryCacheForKey:@"l_image"];
    if (img != nil){
        imageViewMenuProfile.image = img;
    }else{
    
    
    NSString *imagestr = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"l_image"]];
    
     [imageViewMenuProfile sd_setImageWithURL:[NSURL URLWithString:imagestr]placeholderImage:[UIImage imageNamed:@"user-i.png"]options:SDWebImageRefreshCached];
    }
    
}

-(void) centerButtonAndImageWithSpacing:(CGFloat)spacing {
    
    [newReferralBtn setImage:[UIImage imageNamed:@"refer-icon11.png"] forState:UIControlStateNormal];
    
    [newReferralBtn setTitle:@"Refer a Friend/Family" forState:UIControlStateNormal];
    [newReferralBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    if(IS_IPAD_PRO_1366 )
    {
    newReferralBtn.titleLabel.font = [UIFont systemFontOfSize:24.0];
    }
    if(IS_IPAD)
    {
        newReferralBtn.titleLabel.font = [UIFont systemFontOfSize:24.0];
    }
    
    if (IS_IPHONE_6) {
     
        newReferralBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];


        
    }
    if (IS_IPHONE_6P)
    {
      
        newReferralBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    }
    
    if (IS_IPHONE_5){
   
     newReferralBtn.titleLabel.font = [UIFont systemFontOfSize:10.0];
        
    }
    
    if (IS_IPHONE_4_OR_LESS)
    {
         newReferralBtn.titleLabel.font = [UIFont systemFontOfSize:10.0];
    }
    newReferralBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, spacing);
    newReferralBtn.titleEdgeInsets = UIEdgeInsetsMake(0, spacing, 0, 0);
}
-(void) newcenterButtonAndImageWithSpacing:(CGFloat)spacing {
    
    [sendInvitationBtn setImage:[UIImage imageNamed:@"send_invitation1"] forState:UIControlStateNormal];
    
    [sendInvitationBtn setTitle:@" Send Invitation " forState:UIControlStateNormal];
    [sendInvitationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    if(IS_IPAD_PRO_1366 )
    {
    sendInvitationBtn.titleLabel.font = [UIFont systemFontOfSize:24.0];
    }
    if(IS_IPAD)
    {
        sendInvitationBtn.titleLabel.font = [UIFont systemFontOfSize:24.0];
    }
     if (IS_IPHONE_6) {
         //   sendInvitationBtn.frame = CGRectMake(195.0,245.0, 170.0, 32.0);
           sendInvitationBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
         
     }
    if (IS_IPHONE_6P)
    {
       
        sendInvitationBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    }
    if (IS_IPHONE_5){
      // sendInvitationBtn.frame = CGRectMake(172.0,206.0, 137.0, 30.0);
        sendInvitationBtn.titleLabel.font = [UIFont systemFontOfSize:10.0];
    }
    if (IS_IPHONE_4_OR_LESS)
    {
        sendInvitationBtn.titleLabel.font = [UIFont systemFontOfSize:10.0];
    }
    sendInvitationBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, spacing);
    sendInvitationBtn.titleEdgeInsets = UIEdgeInsetsMake(0, spacing, 0, 0);
}
-(void) sideMenuCenterButton:(CGFloat)spacing {
    

    sideMenuBtn.contentMode = UIViewContentModeScaleToFill;
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
//    [HelperAlert alertWithOneBtn:@"" description:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"badgeCountValue"]] okBtn:@"Okay"];
    
    [self imageReload];
    
    sideMenuBtn.layer.cornerRadius=4.0;
    NSString *getValue = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"Value"];
    
    if ([getValue isEqualToString:@"1"])
    {
        [btnSubmitReferral setHidden:YES];
        [menuBtnImage setHidden:NO];
        [sideMenuBtn setHidden:NO];
        [self sideMenuCenterButton:2];
        
        
        [newReferralBtn setHidden:NO];
        [self centerButtonAndImageWithSpacing:6];
        
      
        [sendInvitationBtn setHidden:NO];
        [self newcenterButtonAndImageWithSpacing:8];
        
        [newReferralBtn setTitle:@"Refer a Friend/Family" forState:UIControlStateNormal];
        newReferralBtn.layer.cornerRadius = 4.0;
          sendInvitationBtn.layer.cornerRadius = 4.0;
    }
   
    NSString* namestr = [NSString stringWithFormat:@"%@ %@",[[NSUserDefaults standardUserDefaults]valueForKey:@"l_firstName"],[[NSUserDefaults standardUserDefaults]valueForKey:@"l_lastName"]];
    lblNameMenu.text = namestr;
    
    refreshApiNotificationCountTimer = [NSTimer scheduledTimerWithTimeInterval: 10.0 target:self selector:@selector(refreshApiNotificationCount:) userInfo:nil repeats: YES];
    
    [self getData];
    
    [self resetBadgeCount];
}

-(void)refreshApiNotificationCount:(NSTimer *)timer
{
    [self getData];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [refreshApiNotificationCountTimer invalidate];
}

- (void)showContacts
{
    SMContactsSelector *controller = [[SMContactsSelector alloc] initWithNibName:@"SMContactsSelector" bundle:nil];
  controller.showModal = YES;
    controller.requestData = DATA_CONTACT_EMAIL;
    controller.showCheckButton = YES;
    
    [self.navigationController pushViewController:controller animated:YES];
    
   
}
- (void)sideMenu
{
   DistributerDetailViewController  *detail = [[DistributerDetailViewController alloc] initWithNibName:@"DistributerDetailViewController" bundle:nil];
    [self.navigationController pushViewController:detail animated:YES];
    
    
}


#pragma SMContactsSelectorDelegate Methods
- (void)numberOfRowsSelected:(NSInteger)numberRows withData:(NSArray *)data andDataType:(DATA_CONTACT)type
{
    if (type == DATA_CONTACT_TELEPHONE)
    {
        for ( i = 0; i < [data count]; i++)
        {
            NSString *str = [data objectAtIndex:i];
            
            str = [str reformatTelephone];
            
//            NSLog(@"Telephone: %@", str);
        }
    }
    else if (type == DATA_CONTACT_EMAIL)
    {
        for ( i = 0; i < [data count]; i++)
        {
            NSString *str = [data objectAtIndex:i];
            
//            NSLog(@"Emails: %@", str);
        }
    }
    else
    {
        for ( i = 0; i < [data count]; i++)
        {
            NSString *str = [data objectAtIndex:i];
            
//            NSLog(@"IDs: %@", str);
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma  mark - Buttons
- (IBAction)sendInvitation:(id)sender
{
   [self showContacts];
}

- (IBAction)btnSideMenu:(id)sender
{
    [self sideMenu];
}

- (IBAction)btnScheduleServices:(id)sender{
    ScheduleServiceViewController *scheduleServicesVC = [[ScheduleServiceViewController alloc]initWithNibName:@"ScheduleServiceViewController" bundle:nil];
    [self.navigationController pushViewController:scheduleServicesVC animated:YES];
}
- (IBAction)btnnewnotificationView:(id)sender{
    
    notificationViewController *notificationView = [[notificationViewController alloc]initWithNibName:@"notificationViewController" bundle:nil];
    [self.navigationController pushViewController:notificationView animated:YES];
}
- (IBAction)btnnewAppURL:(id)sender{
    NSString *urlStr = [NSString stringWithFormat:@"http://%@",btnnewAppURL.titleLabel.text];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];

}

- (IBAction)btnnewPhoneNo:(id)sender{
    NSString* phoneno = [btnnewPhoneNo.titleLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSCharacterSet *unwantedStr = [NSCharacterSet characterSetWithCharactersInString:@"+() -"];
    phoneno = [[phoneno componentsSeparatedByCharactersInSet: unwantedStr] componentsJoinedByString: @""];
    
    
    
    NSArray *phoneArr = [phoneno componentsSeparatedByString:@":"];
    NSString *phoneStr = [phoneArr objectAtIndex:1];
    
    NSString *phoneStr1 = [NSString stringWithFormat:@"tel:%@",phoneStr];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneStr1]];
}

- (IBAction)btnnewEmail:(id)sender{
    
    NSArray *emailArr = [btnnewEmail.titleLabel.text componentsSeparatedByString:@" "];
    NSString *emailStr = [emailArr objectAtIndex:1];
    NSString *recipients = [NSString stringWithFormat:@"mailto:%@",emailStr];
    
//    NSString *body = @"&body= ";
    
    NSString *email = [NSString stringWithFormat:@"%@", recipients];
    
    email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
}

- (IBAction)btnAboutApp:(id)sender {
    AboutAppViewController *AAVC = [[AboutAppViewController alloc]initWithNibName:@"AboutAppViewController" bundle:nil];
    [self.navigationController pushViewController:AAVC animated:YES];
}

- (IBAction)btnMyRewards:(id)sender {
    rewardListViewController *RELvc = [[rewardListViewController alloc]initWithNibName:@"rewardListViewController" bundle:nil];
    [self.navigationController pushViewController:RELvc animated:YES];
  //  [self  menuSlideBack];
}

- (IBAction)btnReferrals:(id)sender {
    RLvc = [[referralListViewController alloc]initWithNibName:@"referralListViewController" bundle:nil];
    RLvc.webservice_trigger = @"all";
    RLvc.headerstr =@"TOTAL REFERRALS";

    [self.navigationController pushViewController:RLvc animated:YES];
  //  [self  menuSlideBack];
}

- (IBAction)btnSubmitReferral:(id)sender {
    SubmitReferralViewController *SRvc = [[SubmitReferralViewController alloc]initWithNibName:@"SubmitReferralViewController" bundle:nil];
    [self.navigationController pushViewController:SRvc animated:YES];
    //[self  menuSlideBack];
}

- (IBAction)btnMenu:(id)sender {
    if (sideView.frame.origin.x==0)
    {
        [self menuSlideBack];
    }else{
       
        [UIView animateWithDuration:0.3
                              delay:0.1
                            options: UIViewAnimationCurveEaseOut
                         animations:^
         {
             sideView.hidden=NO;
             
             CGRect frame = sideView.frame;
             frame.origin.y = sideView.frame.origin.y;
             frame.origin.x = 0;
             sideView.frame = frame;
             
             CGRect btnmenu_frame = btnMenu.frame;
             btnmenu_frame.origin.x = btnMenu.frame.origin.x + sideView.frame.size.width;
             btnMenu.frame = btnmenu_frame;
         }
                         completion:^(BOOL finished)
                {
//             NSLog(@"Completed");
              btnSubmitReferral.hidden = YES;
         }];
        
    }

}

- (IBAction)btnMyprofile:(id)sender
{
    ProfileViewController *Pvc = [[ProfileViewController alloc]initWithNibName:@"ProfileViewController" bundle:nil];
    [self.navigationController pushViewController:Pvc animated:YES];
 }

- (IBAction)btnlogout:(id)sender {
    
    self.stop = true;
    [self logoutFunction];
    
}
-(void)logoutFunction{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.timerDashboard invalidate];
    });
    
    if([[[NSUserDefaults standardUserDefaults]valueForKey:@"from_fb"] isEqualToString:@"yes"])
    {
        
        if (FBSession.activeSession.state == FBSessionStateOpen
            || FBSession.activeSession.state == FBSessionStateOpenTokenExtended) {
            
           
            [FBSession.activeSession closeAndClearTokenInformation];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"from_fb"];
            
            return;
        }
    }else{
        [self logout];
        
        
        
        
        
    }
    [[SDImageCache sharedImageCache]removeImageForKey:@"l_image"];
}
- (IBAction)myBadges:(id)sender {
    myBadgesViewController *MBvc = [[myBadgesViewController alloc]initWithNibName:@"myBadgesViewController" bundle:nil];
    [self.navigationController pushViewController:MBvc animated:YES];
 //   [self menuSlideBack];

}

- (IBAction)btnScoreboard:(id)sender {
    ScoreboardViewController *SBLvc =[[ScoreboardViewController alloc]initWithNibName:@"ScoreboardViewController" bundle:nil];
    [self.navigationController pushViewController:SBLvc animated:YES];
 //   [self  menuSlideBack];

}

- (IBAction)btnPayPal:(id)sender {
    PaypalAccountsViewController *PPvc = [[PaypalAccountsViewController alloc]initWithNibName:@"PaypalAccountsViewController" bundle:nil];
    [self.navigationController pushViewController:PPvc animated:YES];
//    [self  menuSlideBack];
}

- (IBAction)btnActiveReferrals:(id)sender {
    RLvc = [[referralListViewController alloc]initWithNibName:@"referralListViewController" bundle:nil];
    RLvc.webservice_trigger = @"open";
    RLvc.headerstr =@"ACTIVE REFERRALS";
    [self.navigationController pushViewController:RLvc animated:YES];
}

- (IBAction)btnInActiveReferrals:(id)sender {
    RLvc = [[referralListViewController alloc]initWithNibName:@"referralListViewController" bundle:nil];
    RLvc.webservice_trigger = @"inactive";
    RLvc.headerstr =@"INACTIVE REFERRALS";

    [self.navigationController pushViewController:RLvc animated:YES];
}

- (IBAction)btnTotalReferrals:(id)sender
{
    RLvc = [[referralListViewController alloc]initWithNibName:@"referralListViewController" bundle:nil];
    RLvc.webservice_trigger = @"all";
    RLvc.headerstr =@"TOTAL REFERRALS";

    [self.navigationController pushViewController:RLvc animated:YES];
}

- (IBAction)btnSoldReferrals:(id)sender
{
    RLvc = [[referralListViewController alloc]initWithNibName:@"referralListViewController" bundle:nil];
    RLvc.webservice_trigger = @"sold";
    RLvc.headerstr =@"SOLD REFERRALS";

    [self.navigationController pushViewController:RLvc animated:YES];
}

#pragma mark - connection delegate

-(NSInteger)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
//    NSLog(@"response status code: %ld %@", (long)[httpResponse statusCode],httpResponse.debugDescription);
    
//    NSLog(@"Received Response");
    [webData setLength: 0];
    
    if((long)[httpResponse statusCode] == ResultOk)
    {
//        NSLog(@"Received Response");
        [webData setLength: 0];
        recieved_status = @"passed";
        
    }else if ((long)[httpResponse statusCode] == ResultFailed)
    {
        recieved_status = @"failed";
        return [httpResponse statusCode];
        
    }
    return  YES;
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [kappDelegate HideIndicator];
    
    if(webservice!=1)
    {
        if ([[NSString stringWithFormat:@"%@",error] rangeOfString:@"The Internet connection appears to be offline." options:NSCaseInsensitiveSearch].location != NSNotFound)
        {
            [HelperAlert  alertWithOneBtn:@"ERROR" description:@"The Internet connection appears to be offline." okBtn:OkButtonTitle];
            return;
        }
        if ([[NSString stringWithFormat:@"%@",error] rangeOfString:@"The network connection was lost" options:NSCaseInsensitiveSearch].location != NSNotFound)
        {
            [HelperAlert  alertWithOneBtn:@"ERROR" description:@"The network connection was lost" okBtn:OkButtonTitle];
            return;
        }
        if ([[NSString stringWithFormat:@"%@",error] rangeOfString:@"Could not connect to the server" options:NSCaseInsensitiveSearch].location != NSNotFound)
        {
            [HelperAlert  alertWithOneBtn:@"ERROR" description:@"Server connection lost. Could not connect to the server" okBtn:OkButtonTitle];
            return;
        }
        
        if ([[NSString stringWithFormat:@"%@",error] rangeOfString:@"The request timed out" options:NSCaseInsensitiveSearch].location != NSNotFound)
        {
            [HelperAlert  alertWithOneBtn:@"ERROR" description:@"The request timed out. Not able to connect to server" okBtn:OkButtonTitle];
            return;
        }
        [HelperAlert  alertWithOneBtn:@"ERROR" description:@"Intenet connection failed.. Try again later." okBtn:OkButtonTitle];
        //    NSLog(@"ERROR with the Connection ");

    }

    webData =nil;
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data1
{
    [webData appendData:data1];
//    NSLog(@"data Received %@",webData);
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [kappDelegate HideIndicator];
    
//    NSLog(@"DONE. Received Bytes: %lu", (unsigned long)[webData length]);
    
    if ([webData length]==0)
        return;
    
    NSString *responseString = [[NSString alloc] initWithData:webData encoding:NSUTF8StringEncoding];
//    NSLog(@"responseString:%@",responseString);
    NSError *error;
   
    SBJsonParser *json = [[SBJsonParser alloc] init];
    NSMutableDictionary *userDetailDict=[json objectWithString:responseString error:&error];
    
if([recieved_status isEqualToString:@"passed"] )
{
    if(webservice==1 && userDetailDict != nil)
    {
        webservice=0;
    NSArray *refType = [userDetailDict valueForKey:@"DashboardResult"];
    NSString *notificationCountStr= [NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"NotificationsCount"]];
        [lblNotificationCount removeFromSuperview];
        
        lblNotificationCount = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, imagenotificationcount.frame.size.width, imagenotificationcount.frame.size.height)];
        lblNotificationCount.text = notificationCountStr;
        
 //       int val = [notificationCountStr intValue];

        lblNotificationCount.textAlignment = NSTextAlignmentCenter;
        lblNotificationCount.textColor = [UIColor whiteColor];
        
        lblNotificationCount.font = [UIFont boldSystemFontOfSize:lblNotificationCount.font.hash];
        [btnSubmitReferral addSubview:lblNotificationCount];
        [imagenotificationcount bringSubviewToFront:lblNotificationCount];
        
        [label45 removeFromSuperview];
        label45 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, imagenotificationcount.frame.size.width, imagenotificationcount.frame.size.height)];
        label45.adjustsFontSizeToFitWidth=YES;
        label45.minimumScaleFactor=0.5;
        label45.textAlignment = NSTextAlignmentCenter;
        label45.textColor = [UIColor whiteColor];
        label45.text = notificationCountStr;
//        if(val > 99)
//        {
//            label45.text = @"99+";
////            label45.frame = CGRectMake(label45.frame.origin.x, label45.frame.origin.y, label45.frame.size.width+4, label45.frame.size.height);
//        }
        [imagenotificationcount addSubview:label45];
        
        
        int noti = [notificationCountStr intValue];
        if (noti > 0) {
            imagenotificationcount.hidden = NO;
        }else{
            imagenotificationcount.hidden = YES;
        }
        
        [kappDelegate HideIndicator];
        
        NSString *upcomingStr= [NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"UpcomingRewards"]];
        NSString *earnedStr= [NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"EarnedRewards"]];
        NSString* finalStr = [NSString stringWithFormat:@"$%@ Paid / $%@ Pending",earnedStr,upcomingStr];
        
        NSUInteger firstStringCount = earnedStr.length+1;
        NSUInteger secondStringCountStart = 9+earnedStr.length;
        NSUInteger secondStringCountEnd = upcomingStr.length+1;
        
        NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:finalStr];
        [string addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,firstStringCount)];
        [string addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(secondStringCountStart,secondStringCountEnd)];
        lblnewEarnedAwardePrice.attributedText = string;
        
        
        
        
        NSString * value ;
    for (int k=0; k<refType.count; k++) {
        
        if([[[refType valueForKey:@"ReferralType" ] objectAtIndex:k] isEqualToString:@"open"])
        {
            NSString *amountstr = [NSString stringWithFormat:@"($%@)",[[refType valueForKey:@"Amount"] objectAtIndex:k]];
            lblActiveAmount.text = amountstr;
            lblActivereferralcount.text = [NSString stringWithFormat:@"%@",[[refType valueForKey:@"ReferralCount"] objectAtIndex:k ]];
            
            lblnewActiveSoldCount.text = [NSString stringWithFormat:@"%@ Open / ",[[refType valueForKey:@"ReferralCount"] objectAtIndex:k]];
            value = [NSString stringWithFormat:@"%@",[[refType valueForKey:@"ReferralCount"] objectAtIndex:k]];
            
        }
        if([[[refType valueForKey:@"ReferralType" ] objectAtIndex:k] isEqualToString:@"sold"])
        {
//            NSLog(@"%@",[NSString stringWithFormat:@"($%@)",[[refType valueForKey:@"Amount"] objectAtIndex:k]]);

            
            lblSoldreferralAmount.text = [NSString stringWithFormat:@"($%@)",[[refType valueForKey:@"Amount"] objectAtIndex:k]];
            lblSoldreferralcount.text = [NSString stringWithFormat:@"%@",[[refType valueForKey:@"ReferralCount"]objectAtIndex:k]];
            
            NSString *finalStr= [NSString stringWithFormat:@"%@%@ Sold",lblnewActiveSoldCount.text,[[refType valueForKey:@"ReferralCount"]objectAtIndex:k]];
        
            NSString *val1 =[NSString stringWithFormat:@"%@",[[refType valueForKey:@"ReferralCount"]objectAtIndex:k]];

//            NSLog(@"%lu",(unsigned long)val1.length);
           
            
//            NSLog(@"%@",lblnewActiveSoldCount.text);
            
            NSUInteger length1 = lblnewActiveSoldCount.text.length;
            NSUInteger length2 = val1.length ;
            
            
            
            NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:finalStr];
            [string addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,value.length)];
            [string addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(length1,length2)];
            lblnewActiveSoldCount.attributedText = string;
            
            
           
            
        }
        if([[[refType valueForKey:@"ReferralType" ] objectAtIndex:k] isEqualToString:@"inactive"])
        {
            
            lblInactivereferralcount.text = [NSString stringWithFormat:@"%@",[[refType valueForKey:@"ReferralCount"]objectAtIndex:k]];
            }
        if([[[refType valueForKey:@"ReferralType" ] objectAtIndex:k] isEqualToString:@"Total"])
            {
           
              
                lbltotalreferralcount.text = [NSString stringWithFormat:@"%@",[[refType valueForKey:@"ReferralCount"]objectAtIndex:k]];
                }
            }
        }else if(webservice==2)
        {
//            NSLog(@"%@",responseString);
           webservice=0;
            
            
        }else if (webservice==3)
        {
           webservice=0;
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"l_email"];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"l_firstName"];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"l_lastName"];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"l_facebookUser"];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"l_meaId"];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"l_meaName"];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"l_phoneNo"];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"l_userName"];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"l_userid"];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"l_roleName"];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"l_roleId"];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"l_purchasedBefore"];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"l_image"];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"l_loggedin"];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"from_fb"];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"profile_picture"];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"savedImageURL"];
//            NSLog(@"FFFFFFFFFFFFFFFFF%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"profile_picture"]);
            
            [kappDelegate HideIndicator];
            if (count_status==0) {
                [[NSUserDefaults standardUserDefaults]setObject:@"yes" forKey:@"user_logout"];
                LoginViewController *LIvc = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
                [self.navigationController pushViewController:LIvc animated:YES];
//                NSLog(@"-----webservice------");
                count_status++;
            }
           
            return;
        }
        else if (webservice==13)
        {
            webservice=0;
//            NSLog(@"%@",responseString);
        }
    }else{
        
        if (webservice==1) {    
            
            if ([responseString rangeOfString:@"An error occurred while updating the entries." options:NSCaseInsensitiveSearch].location != NSNotFound)
            {
                return;
            }
            if ([responseString rangeOfString:@" UserId is missing" options:NSCaseInsensitiveSearch].location != NSNotFound){
                return;
            }
        }
        [HelperAlert  alertWithOneBtn:AlertTitle description:responseString okBtn:OkButtonTitle];

        

}
    [kappDelegate HideIndicator];

}

#pragma  mark - Other Methods
-(void)getNotificationCount
{
    [kappDelegate ShowIndicator];
    webservice=3;
    NSMutableURLRequest *request ;
    NSString*_postData ;
    NSURLConnection *connection;
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSLog(@"%@",[user valueForKey:@"profile_picture"]);
    NSString *userid = [NSString stringWithFormat: @"%@",[user valueForKey:@"profile_picture"]];
   
    _postData = [NSString stringWithFormat:@""];
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/users/%@/logout",Kwebservices,userid]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
    
//    NSLog(@"data post >>> %@",_postData);
    
    [request setHTTPMethod:@"POST"];
    
    
    [request setHTTPBody: [_postData dataUsingEncoding:NSUTF8StringEncoding]];
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if(connection)
    {
        if(webData==nil)
        {
            webData = [NSMutableData data] ;
//            NSLog(@"data");
        }
        else
        {
            webData=nil;
            webData = [NSMutableData data] ;
        }
//        NSLog(@"server connection made");
    }
    else
    {
        NSLog(@"connection is NULL");
    }
    

}

-(void)resetBadgeCount
{
    NSMutableURLRequest *request ;
    NSString*_postData ;
    NSURLConnection *connection;
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    //    NSLog(@"%@",[user valueForKey:@"l_userid"]);
    NSString *userid = [NSString stringWithFormat: @"%@",[user valueForKey:@"l_userid"]];
    
    
    _postData = [NSString stringWithFormat:@""];
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/userdevice/SetDefaultBadge/%@",Kwebservices,userid]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
    
    //    NSLog(@"data post >>> %@",_postData);
    
    [request setHTTPMethod:@"GET"];
    
    [request setHTTPBody: [_postData dataUsingEncoding:NSUTF8StringEncoding]];
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if(connection)
    {
        if(webData==nil)
        {
            webData = [NSMutableData data] ;
            //            NSLog(@"data");
        }
        else
        {
            webData=nil;
            webData = [NSMutableData data] ;
        }
        //        NSLog(@"server connection made");
    }
    else
    {
        NSLog(@"connection is NULL");
    }
}

-(void)logout
{
    [kappDelegate ShowIndicator];
    webservice=3;
    NSMutableURLRequest *request ;
    NSString*_postData ;
    NSURLConnection *connection;
    count_status = 0;
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSLog(@"%@",[user valueForKey:@"l_userid"]);
    NSString *userid = [NSString stringWithFormat: @"%@",[user valueForKey:@"l_userid"]];
  
    
    _postData = [NSString stringWithFormat:@""];
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/users/%@/logout",Kwebservices,userid]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
    
//    NSLog(@"data post >>> %@",_postData);
    
    [request setHTTPMethod:@"POST"];
    
    [request setHTTPBody: [_postData dataUsingEncoding:NSUTF8StringEncoding]];
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if(connection)
    {
        if(webData==nil)
        {
            webData = [NSMutableData data] ;
//            NSLog(@"data");
        }
        else
        {
            webData=nil;
            webData = [NSMutableData data] ;
        }
//        NSLog(@"server connection made");
    }
    else
    {
        NSLog(@"connection is NULL");
    }
    
    
}
-(void)menuSlideBack
{
    btnSubmitReferral.hidden = NO;
    [UIView animateWithDuration:0.3
                          delay:0.1
                        options: UIViewAnimationCurveEaseIn
                     animations:^
     {
         
         CGRect frame = sideView.frame;
         frame.origin.y = sideView.frame.origin.y;
         frame.origin.x = self.view.frame.origin.x - sideView.frame.size.width;
         sideView.frame = frame;
         
         CGRect btnmenu_frame = btnMenu.frame;
         btnmenu_frame.origin.x = btnMenu.frame.origin.x - sideView.frame.size.width;
         btnMenu.frame = btnmenu_frame;
     }
                     completion:^(BOOL finished)
     {
//         NSLog(@"Completed");
         
     }];
    
}
-(void)targetMethod:(NSTimer *)timer
{
    if ( IS_IPAD )
    {
        
        CGRect frame = imageViewMenuProfile.frame;
//        frame.size.width = 210;
//        frame.size.height = 210;
//        frame.origin.x = frame.origin.x +14;
//        frame.origin.y = frame.origin.y -10;
        frame.size.width = 170;
        frame.size.height = 170;
        
        frame.origin.x = frame.origin.x +14;
        frame.origin.y = frame.origin.y -10;
        if(IS_IPAD_PRO_1366 )
        {
            frame.origin.x = frame.origin.x + 5;
            frame.size.width = 230;
            frame.size.height = 230;
        }
        
        
        imageViewMenuProfile.frame = frame;
        
        imageViewMenuProfile.layer.cornerRadius = imageViewMenuProfile.frame.size.width /2;
        imageViewMenuProfile.layer.masksToBounds = YES;
        imageViewMenuProfile.layer.borderWidth = 2;
        imageViewMenuProfile.layer.borderColor=[[UIColor colorWithRed:250.0f/255.0f green:196.0f/255.0f blue:39.0f/255.0f alpha:1] CGColor];
        imageViewMenuProfile.hidden = NO;
    }else{
        //---making image round
         CGRect frame = imageViewMenuProfile.frame;
        if ([[ UIScreen mainScreen ] bounds ].size.width == 320 )
        {
           
            frame.size.width = 100;
            frame.size.height = 100;
           
        }
        if (IS_IPHONE_4_OR_LESS) {
            frame.size.width = 85;
            frame.size.height = 85;
        }
         imageViewMenuProfile.frame = frame;
        
        imageViewMenuProfile.layer.cornerRadius = imageViewMenuProfile.frame.size.width /2;
        imageViewMenuProfile.layer.borderWidth = 2.0f;
        imageViewMenuProfile.layer.borderWidth = 2;
        imageViewMenuProfile.layer.borderColor=[[UIColor colorWithRed:250.0f/255.0f green:196.0f/255.0f blue:39.0f/255.0f alpha:1] CGColor];
        
    }
    //---image
    
}
-(void)setRoundedAvatar:(UIImageView *)avatarView toDiameter:(float)newSize atView:(UIView *)containedView;
{
    avatarView.layer.cornerRadius = newSize/2;
    avatarView.clipsToBounds = YES;
    
    if(i==0)
    {
        CGRect frame = avatarView.frame;
        frame.size.width = newSize;
        frame.size.height = newSize;
        frame.origin.y = frame.origin.y -8;
        avatarView.frame = frame;
        i++;
    }
    
}

-(void)getData
{
    webservice=1;
    NSMutableURLRequest *request ;
    NSString*_postData ;
    NSURLConnection *connection;
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSLog(@"%@",[user valueForKey:@"l_userid"]);
    NSString *userid = [NSString stringWithFormat: @"%@",[user valueForKey:@"l_userid"]];
    
    

   
    NSData *data2222 = [[NSUserDefaults standardUserDefaults] objectForKey:@"dashboardNotificationTimeStamp"];
    NSMutableDictionary *dict3333 = [NSKeyedUnarchiver unarchiveObjectWithData:data2222];
    NSString *latestCreatedDateStr = [dict3333 valueForKey:userid];
    
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginDateSaved"];
    NSMutableDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSString *loginDateStr = [dict valueForKey:userid];
    
    
    _postData = [NSString stringWithFormat:@"userId=%@&Timestamp=%@",userid,loginDateStr];
    
    
    if(latestCreatedDateStr!=nil)
    {
        _postData = [NSString stringWithFormat:@"userId=%@&Timestamp=%@",userid,latestCreatedDateStr];
    }
    
    
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/dashboard",Kwebservices]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
    
//    NSLog(@"data post >>> %@",_postData);
    
    [request setHTTPMethod:@"POST"];
   
//    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"UserToken"]);
    [request addValue:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"UserToken"]] forHTTPHeaderField:@"token"];
    
    [request setHTTPBody: [_postData dataUsingEncoding:NSUTF8StringEncoding]];
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if(connection)
    {
        if(webData==nil)
        {
            webData = [NSMutableData data] ;
//            NSLog(@"data");
        }
        else
        {
            webData=nil;
            webData = [NSMutableData data] ;
        }
//        NSLog(@"server connection made");
    }
    else
    {
        NSLog(@"connection is NULL");
    }
}

-(void)registerDevice
{
    
    NSMutableURLRequest *request ;
    NSString*_postData ;
    NSURLConnection *connection;
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSLog(@"%@",[user valueForKey:@"l_userid"]);
    NSString *userid = [NSString stringWithFormat: @"%@",[user valueForKey:@"l_userid"]];
    NSString *udid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSString *currSys = @"ios";
    NSString *devToken = [[NSUserDefaults standardUserDefaults] valueForKey: @"deviceToken"];
    
    
    _postData = [NSString stringWithFormat:@"UserID=%@&DeviceUDID=%@&DeviceOS=%@&TokenID=%@",userid,udid,currSys,devToken];
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/userdevice",Kwebservices]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
    
//    NSLog(@"%@",[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"UserToken"]] );
//    NSLog(@"data post >>> %@",_postData);
    [request setHTTPMethod:@"POST"];
   
    [request addValue:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"UserToken"]] forHTTPHeaderField:@"token"];
    
    [request setHTTPBody: [_postData dataUsingEncoding:NSUTF8StringEncoding]];
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if(connection)
    {
        if(webData==nil)
        {
            webData = [NSMutableData data] ;
//            NSLog(@"data");
        }
        else
        {
            webData=nil;
            webData = [NSMutableData data] ;
        }
//        NSLog(@"server connection made");
    }
    else
    {
        NSLog(@"connection is NULL");
    }
    
    
    
}
-(void)showmaskonnumber:(NSString*)number
{
    
    NSString *newString = number;
    if(newString.length==0)
    {   [btnnewPhoneNo setTitle:@"" forState:UIControlStateNormal];;
        return ;
    }
    NSArray *components = [newString componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]];
    NSString *decimalString = [components componentsJoinedByString:@""];
    
    NSUInteger length = decimalString.length;
    BOOL hasLeadingOne = length > 1 && [decimalString characterAtIndex:0] == '1';
    
    if (length == 0 || (length > 10 && !hasLeadingOne) || (length > 11)) {
        
        return;
    }
    
    NSUInteger index = 0;
    NSMutableString *formattedString = [NSMutableString string];
    
    if (hasLeadingOne) {
        [formattedString appendString:@"1 "];
        index += 1;
    }
    
    if (length - index > 3) {
        NSString *areaCode = [decimalString substringWithRange:NSMakeRange(index, 3)];
        [formattedString appendFormat:@"(%@) ",areaCode];
        index += 3;
    }
    
    if (length - index > 3) {
        NSString *prefix = [decimalString substringWithRange:NSMakeRange(index, 3)];
        [formattedString appendFormat:@"%@-",prefix];
        index += 3;
    }
    
    NSString *remainder = [decimalString substringFromIndex:index];
    [formattedString appendString:remainder];
    
    NSString *frmtStr = formattedString;
    
    [btnnewPhoneNo setTitle:[NSString stringWithFormat:@"Phone: %@",frmtStr] forState:UIControlStateNormal];
}



@end
