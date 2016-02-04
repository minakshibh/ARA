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
// #import "UIView+Toast.h"

@interface dashboardViewController ()
{
    referralListViewController *RLvc;
}
@end

@implementation dashboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    i=0;
    lblComingSoon.layer.cornerRadius = 5.0;
    [lblComingSoon setClipsToBounds:YES];
    
    imagenotificationcount.hidden = YES;
    
    btnSubmitReferral.layer.cornerRadius = 4.0;
    btnmyprofile.layer.cornerRadius = 4.0;
    imageViewMenuProfile.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor colorWithRed:250.0f/255.0f green:196.0f/255.0f blue:39.0f/255.0f alpha:1]);
    
    [self.view addSubview:viewNew];
    [self.view bringSubviewToFront:viewNew];
//    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"self"];

    //--hide navigation bar
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    [self.view bringSubviewToFront:sideView];
    
    NSLog(@"%f",self.view.frame.size.height);
    
    imageViewMenuProfile.clipsToBounds = YES;
    
    
    lblEmailSideMenu.text = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"l_email"]];
//    [btnnewEmail setTitle:[NSString stringWithFormat:@"Email: %@",[[NSUserDefaults standardUserDefaults]valueForKey:@"l_email"]] forState:UIControlStateNormal];
//    
//    if ([[NSUserDefaults standardUserDefaults]valueForKey:@"l_phoneNo"] != nil) {
//         lblnewPhoneNo.text = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"l_phoneNo"]];
//       [btnnewPhoneNo setTitle:[NSString stringWithFormat:@"Phone: %@",[[NSUserDefaults standardUserDefaults]valueForKey:@"l_phoneNo"]] forState:UIControlStateNormal];
//        // set masking on number befroe displaying
//        
//        NSString *phone =[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"l_phoneNo"]];
//        // lblPhoneno.text=@"5454564564564564564";
//        NSMutableString *mutstr = [[NSMutableString alloc]init];
//        for (int h = 0; h<phone.length; h++)
//        {
//            NSString *character = [NSString stringWithFormat:@"%C",[phone characterAtIndex:h]];
//            if(h==0){
//                mutstr =[NSMutableString stringWithFormat:@"%@",character];
//            }else{
//                mutstr = [NSMutableString stringWithFormat:@"%@%@",mutstr,character];
//            }
//            [self showmaskonnumber:mutstr];
//        }
//
//    }else{
//        [btnnewPhoneNo setTitle:@"" forState:UIControlStateNormal];
//    }
   
    
    
    NSLog(@"%@",lblEmailSideMenu.text);
    
    
//    if([_from_login isEqualToString:@"yes"])
//    {
//        NSString *first = [[NSUserDefaults standardUserDefaults]valueForKey:@"l_firstName"];
//        NSString *last = [[NSUserDefaults standardUserDefaults]valueForKey:@"l_lastName"];
//
//        NSString* namestr =[NSString stringWithFormat:@"%@ %@",first,last];
//        lblNameMenu.text = namestr;
//        lblEmailSideMenu.text = [[NSUserDefaults standardUserDefaults]valueForKey:@"l_email"];
//    }
//    
//    //--setting image and label values on the side menu
//    lblEmailSideMenu.text = [[NSUserDefaults standardUserDefaults ]valueForKey:@"user_email"];
//    NSData *image_data= [[NSUserDefaults standardUserDefaults]valueForKey:@"user_image"];
//    imageViewMenuProfile.image = [UIImage imageWithData:image_data];
//    lblNameMenu.text = [[NSUserDefaults standardUserDefaults]valueForKey:@"user_name"];
    
    
//    
//    int d = 0; // standard display
//    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2.0) {
//        d = 1; // is retina display
//    }
//    
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
//        d += 2;
//    }
//    
//    if (d==0) {
//        headerImage.image = [UIImage imageNamed:@"320X480.png"];
//    }
//    if (d==1) {
//        headerImage.image = [UIImage imageNamed:@"320X568.png"];
//    }
//    if (d==2) {
//        headerImage.image = [UIImage imageNamed:@"480X800.png"];
//    }
//    if (d==3) {
//        headerImage.image = [UIImage imageNamed:@"640X1136.png"];
//    }
    
    
   
    
    if (IS_IPHONE_6P) {
        viewnewNotification.frame = CGRectMake(viewnewNotification.frame.origin.x-7, viewnewNotification.frame.origin.y-12, viewnewNotification.frame.size.width+10, viewnewNotification.frame.size.height+10);
        lblnewContactUs.font = [lblnewContactUs.font fontWithSize:15];
        lblnewContactUs.frame = CGRectMake(lblnewContactUs.frame.origin.x, lblnewContactUs.frame.origin.y+7, lblnewContactUs.frame.size.width, lblnewContactUs.frame.size.height);
         lblComingSoon.font = [lblComingSoon.font fontWithSize:lblComingSoon.font.pointSize-1];
    }
    if (IS_IPHONE_6) {
         btnSubmitReferral.frame = CGRectMake(btnSubmitReferral.frame.origin.x-8, btnSubmitReferral.frame.origin.y, btnSubmitReferral.frame.size.width+8, btnSubmitReferral.frame.size.height);
        viewnewNotification.frame = CGRectMake(viewnewNotification.frame.origin.x-7, viewnewNotification.frame.origin.y-12, viewnewNotification.frame.size.width+10, viewnewNotification.frame.size.height+10);
        lblComingSoon.font = [lblComingSoon.font fontWithSize:12];
    }
    if ( IS_IPHONE_5) {
         imageViewMenuProfile.frame = CGRectMake(imageViewMenuProfile.frame.origin.x-6, imageViewMenuProfile.frame.origin.y-7, imageViewMenuProfile.frame.size.width, imageViewMenuProfile.frame.size.height);
        btnSubmitReferral.frame = CGRectMake(btnSubmitReferral.frame.origin.x-15, btnSubmitReferral.frame.origin.y, btnSubmitReferral.frame.size.width+15, btnSubmitReferral.frame.size.height);
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
    }
    if (IS_IPHONE_4_OR_LESS) {
        lblComingSoon.font = [lblComingSoon.font fontWithSize:11];
         imageViewMenuProfile.frame = CGRectMake(imageViewMenuProfile.frame.origin.x, imageViewMenuProfile.frame.origin.y-7, imageViewMenuProfile.frame.size.width, imageViewMenuProfile.frame.size.height);
        lblNameMenu.frame = CGRectMake(lblNameMenu.frame.origin.x, lblNameMenu.frame.origin.y+2, lblNameMenu.frame.size.width, lblNameMenu.frame.size.height);
        btnSubmitReferral.titleLabel.font = [btnSubmitReferral.titleLabel.font fontWithSize:9];
        btnSubmitReferral.frame = CGRectMake(btnSubmitReferral.frame.origin.x-4, btnSubmitReferral.frame.origin.y, btnSubmitReferral.frame.size.width+4, btnSubmitReferral.frame.size.height);
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
        NSLog(@"test");
    }
    
    if ( IS_IPAD )
    {
         lblComingSoon.font = [lblComingSoon.font fontWithSize:lblComingSoon.font.pointSize+2];
         lblComingSoon.frame = CGRectMake(lblComingSoon.frame.origin.x+13, lblComingSoon.frame.origin.y, lblComingSoon.frame.size.width-25, lblComingSoon.frame.size.height);
        
        
        
      //   btnSubmitReferral.titleLabel.font = [btnSubmitReferral.titleLabel.font fontWithSize:24];
       btnSubmitReferral.titleLabel.font = [btnSubmitReferral.titleLabel.font fontWithSize:18];
        
        btnSubmitReferral.frame = CGRectMake(btnSubmitReferral.frame.origin.x+20, btnSubmitReferral.frame.origin.y, btnSubmitReferral.frame.size.width-17, btnSubmitReferral.frame.size.height);
        
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
        btnmyprofile.titleLabel.font=[btnmyprofile.titleLabel.font fontWithSize:24];
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
        if(IS_IPAD_PRO_1366 )
        {
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
            
            
//            btnmyprofile.titleLabel.font=[btnmyprofile.titleLabel.font fontWithSize:30];
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
    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
//    // get documents path
//    NSString *documentsPath = [paths objectAtIndex:0];
//    // get the path to our Data/plist file
//   // NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"Data.plist"];
//    NSString *plistPath = [ NSString stringWithFormat:@"%@/Data.plist",documentsPath];
//    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath])
//    {
//        plistPath = [[NSBundle mainBundle] pathForResource:@"Data" ofType:@"plist"];
//        
//        
//    }
//    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
//    NSString *errorDesc = nil;
//    NSPropertyListFormat format;
//    NSDictionary *temp = (NSDictionary *)[NSPropertyListSerialization propertyListFromData:plistXML mutabilityOption:NSPropertyListMutableContainersAndLeaves format:&format errorDescription:&errorDesc];
//    if (!temp)
//    {
//        NSLog(@"Error reading plist: %@, format: %lu", errorDesc, (unsigned long)format);
//    }
//    
//    // assign values
//    NSLog(@"%@",[temp objectForKey:@"name"] );
//    NSMutableArray *phoneNumbers = [NSMutableArray arrayWithArray:[temp objectForKey:@"phones"]];
//    // display values
//    
//   NSLog(@"%@",[phoneNumbers objectAtIndex:0]);
//   NSLog(@"%@",[phoneNumbers objectAtIndex:1]);
//   NSLog(@"%@",[phoneNumbers objectAtIndex:2]);

    [NSTimer scheduledTimerWithTimeInterval:0.1
                                     target:self
                                   selector:@selector(targetMethod:)
                                   userInfo:nil
                                    repeats:NO];
//    [NSTimer scheduledTimerWithTimeInterval:4
//                                     target:self
//                                   selector:@selector(labelTransformation:)
//                                   userInfo:nil
//                                    repeats:YES];
//    self.timerDashboard = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(dashboardWebservice) userInfo:nil repeats:YES];

}
//-(void)labelTransformation:(NSTimer *)timer
//{
//    if (lblComingSoon.font.pointSize == 16) {
//    lblComingSoon.font = [UIFont boldSystemFontOfSize:14];
//    }else{
//        lblComingSoon.font = [UIFont boldSystemFontOfSize:16];
//    }
//    
//    lblComingSoon.transform = CGAffineTransformScale(lblComingSoon.transform, 0.25, 0.25);
//    [self.view addSubview:lblComingSoon];
//    [UIView animateWithDuration:2.0 animations:^{
//        lblComingSoon.transform = CGAffineTransformScale(lblComingSoon.transform, 4, 4);
//    }];
//}
-(void)dashboardWebservice
{
    [self getData];
}
-(void)viewWillAppear:(BOOL)animated
{
//    if ([[NSUserDefaults standardUserDefaults]valueForKey:@"l_phoneNo"] != nil) {
//        lblnewPhoneNo.text = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"l_phoneNo"]];
//        [btnnewPhoneNo setTitle:[NSString stringWithFormat:@"Phone: %@",[[NSUserDefaults standardUserDefaults]valueForKey:@"l_phoneNo"]] forState:UIControlStateNormal];
//        
//        NSString *phone =[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"l_phoneNo"]];
//        // lblPhoneno.text=@"5454564564564564564";
//        NSMutableString *mutstr = [[NSMutableString alloc]init];
//        for (int h = 0; h<phone.length; h++)
//        {
//            NSString *character = [NSString stringWithFormat:@"%C",[phone characterAtIndex:h]];
//            if(h==0){
//                mutstr =[NSMutableString stringWithFormat:@"%@",character];
//            }else{
//                mutstr = [NSMutableString stringWithFormat:@"%@%@",mutstr,character];
//            }
//            [self showmaskonnumber:mutstr];
//        }
//
//    }else{
//        [btnnewPhoneNo setTitle:@"" forState:UIControlStateNormal];
//    }
    [self getData];
   
    NSString* namestr = [NSString stringWithFormat:@"%@ %@",[[NSUserDefaults standardUserDefaults]valueForKey:@"l_firstName"],[[NSUserDefaults standardUserDefaults]valueForKey:@"l_lastName"]];
    lblNameMenu.text = namestr;
    
    
    NSString *imagestr = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"l_image"]];
   
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imagestr]];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"profile_picture"];
        [[NSUserDefaults standardUserDefaults]setObject:imageData forKey:@"profile_picture"];
        dispatch_async(dispatch_get_main_queue(), ^{
            // Update the UI
            imageViewMenuProfile.image = [UIImage imageWithData:imageData];
        //  imageViewMenuProfile.contentMode=UIViewContentModeScaleAspectFit;

        });
    });

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma  mark - Buttons
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
             NSLog(@"Completed");
              btnSubmitReferral.hidden = YES;
         }];
        
    }

}

- (IBAction)btnMyprofile:(id)sender
{
    ProfileViewController *Pvc = [[ProfileViewController alloc]initWithNibName:@"ProfileViewController" bundle:nil];
    [self.navigationController pushViewController:Pvc animated:YES];
 //   [self  menuSlideBack];
}

- (IBAction)btnlogout:(id)sender {
     [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"dashboardNotificationTimeStamp"];
    [self.timerDashboard invalidate];
    
    if([[[NSUserDefaults standardUserDefaults]valueForKey:@"from_fb"] isEqualToString:@"yes"])
    {
        if (FBSession.activeSession.state == FBSessionStateOpen
            || FBSession.activeSession.state == FBSessionStateOpenTokenExtended) {
            
            // Close the session and remove the access token from the cache
            // The session state handler (in the app delegate) will be called automatically
            [FBSession.activeSession closeAndClearTokenInformation];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"from_fb"];
            // If the session state is not any of the two "open" states when the button is clicked
            return;
        }
    }else{
        [self logout];
        
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

        
        
        

    }
    
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
    NSLog(@"response status code: %ld %@", (long)[httpResponse statusCode],httpResponse.debugDescription);
    
    NSLog(@"Received Response");
    [webData setLength: 0];
    
    if((long)[httpResponse statusCode] == ResultOk)
    {
        NSLog(@"Received Response");
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
        [HelperAlert  alertWithOneBtn:@"ERROR" description:@"Internet connection lost. Could not connect to the server" okBtn:OkButtonTitle];
        return;
    }
    
    if ([[NSString stringWithFormat:@"%@",error] rangeOfString:@"The request timed out" options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        [HelperAlert  alertWithOneBtn:@"ERROR" description:@"The request timed out. Not able to connect to server" okBtn:OkButtonTitle];
        return;
    }
    [HelperAlert  alertWithOneBtn:@"ERROR" description:@"Intenet connection failed.. Try again later." okBtn:OkButtonTitle];
    NSLog(@"ERROR with the Connection ");
    webData =nil;
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data1
{
    [webData appendData:data1];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [kappDelegate HideIndicator];
    
    NSLog(@"DONE. Received Bytes: %lu", (unsigned long)[webData length]);
    
    if ([webData length]==0)
        return;
    
    NSString *responseString = [[NSString alloc] initWithData:webData encoding:NSUTF8StringEncoding];
    NSLog(@"responseString:%@",responseString);
    NSError *error;
    //    if ([responseString rangeOfString:@"#Ref" options:NSCaseInsensitiveSearch].location != NSNotFound)
    //    {
    //        NSString *msg = [NSString stringWithFormat:@"Thank you for submitting referral. You can track this referal using this referral id %@.",responseString];
    //        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"ARA" message:msg delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    //        [alert show];
    //        return;
    //    }
    SBJsonParser *json = [[SBJsonParser alloc] init];
    NSMutableDictionary *userDetailDict=[json objectWithString:responseString error:&error];
    
if([recieved_status isEqualToString:@"passed"])
{
    if(webservice==1)
    {
//    NSArray *amount = [userDetailDict valueForKey:@"Amount"];
//    NSArray *refCount = [userDetailDict valueForKey:@"ReferralCount"];
    NSArray *refType = [userDetailDict valueForKey:@"DashboardResult"];
    NSString *notificationCountStr= [NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"NotificationsCount"]];
      //  int notificationCount = (int)notificationCountStr;
        [lblNotificationCount removeFromSuperview];
        
        lblNotificationCount = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, imagenotificationcount.frame.size.width, imagenotificationcount.frame.size.height)];
        lblNotificationCount.text = notificationCountStr;
         lblNotificationCount.font = (IS_IPAD) ? [UIFont fontWithName:@"Roboto-Regular" size:14] : [UIFont fontWithName:@"Roboto-Regular" size:10];
        lblNotificationCount.textAlignment = NSTextAlignmentCenter;
        lblNotificationCount.textColor = [UIColor whiteColor];
        [imagenotificationcount addSubview:lblNotificationCount];
        
        int noti = [notificationCountStr intValue];
        if (noti > 0) {
            imagenotificationcount.hidden = NO;
        }else{
            imagenotificationcount.hidden = YES;
        }
        
    [kappDelegate HideIndicator];
        
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
            NSLog(@"%@",[NSString stringWithFormat:@"($%@)",[[refType valueForKey:@"Amount"] objectAtIndex:k]]);
            lblnewEarnedAwardePrice.text = [NSString stringWithFormat:@"$%@",[[refType valueForKey:@"Amount"] objectAtIndex:k]];
            lblSoldreferralAmount.text = [NSString stringWithFormat:@"($%@)",[[refType valueForKey:@"Amount"] objectAtIndex:k]];
            lblSoldreferralcount.text = [NSString stringWithFormat:@"%@",[[refType valueForKey:@"ReferralCount"]objectAtIndex:k]];
            
            NSString *finalStr= [NSString stringWithFormat:@"%@%@ Sold",lblnewActiveSoldCount.text,[[refType valueForKey:@"ReferralCount"]objectAtIndex:k]];
         //   finalStr = @"19 Open / 13 Sold";
         //   value = @"13";
            NSString *val1 =[NSString stringWithFormat:@"%@",[[refType valueForKey:@"ReferralCount"]objectAtIndex:k]];
         //   val1 = @"23";
            NSLog(@"%lu",(unsigned long)val1.length);
           
            
            NSLog(@"%@",lblnewActiveSoldCount.text);
            
            NSUInteger length1 = lblnewActiveSoldCount.text.length;
            NSUInteger length2 = val1.length ;
            
            
            //3 Open / 4 Sold
           
            NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:finalStr];
            [string addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,value.length)];
            [string addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(length1,length2)];
            lblnewActiveSoldCount.attributedText = string;
            
            
           
            
        }
        if([[[refType valueForKey:@"ReferralType" ] objectAtIndex:k] isEqualToString:@"inactive"])
        {
            //  lblInactivereferralAmount.text = [NSString stringWithFormat:@"($%@)",[[userDetailDict valueForKey:@"Amount"] objectAtIndex:i]];
            lblInactivereferralcount.text = [NSString stringWithFormat:@"%@",[[refType valueForKey:@"ReferralCount"]objectAtIndex:k]];
            }
        if([[[refType valueForKey:@"ReferralType" ] objectAtIndex:k] isEqualToString:@"Total"])
            {
           
                //lbltotalreferralAmount.text = [NSString stringWithFormat:@"($%@)",[[userDetailDict valueForKey:@"Amount"]objectAtIndex:i]];
                lbltotalreferralcount.text = [NSString stringWithFormat:@"%@",[[refType valueForKey:@"ReferralCount"]objectAtIndex:k]];
                }
            }
            [self registerDevice];
        }else if(webservice==2)
        {
            NSLog(@"%@",responseString);
           
            
        }else if (webservice==3)
        {
            //[self.view makeToast:[NSString stringWithFormat:@"%@",responseString]];
//            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"ARA" message:responseString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//            [alert show];
            [kappDelegate HideIndicator];
            
            LoginViewController *LIvc = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
            [self.navigationController pushViewController:LIvc animated:YES];
            
            return;
        }
    }else{
        
        if (webservice==1) {    
            
            if ([responseString rangeOfString:@"An error occurred while updating the entries." options:NSCaseInsensitiveSearch].location != NSNotFound)
            {
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
    NSLog(@"%@",[user valueForKey:@"l_userid"]);
    NSString *userid = [NSString stringWithFormat: @"%@",[user valueForKey:@"l_userid"]];
    //    NSString *udid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    //    NSString *currSys = @"ios";
    //    NSString *devToken = [[NSUserDefaults standardUserDefaults] valueForKey: @"deviceToken"];
    
    _postData = [NSString stringWithFormat:@""];
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/users/%@/logout",Kwebservices,userid]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
    
    NSLog(@"data post >>> %@",_postData);
    
    [request setHTTPMethod:@"POST"];
    //[request addValue:mea forHTTPHeaderField:@"MEAId"];
    //[request addValue:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"UserToken"]] forHTTPHeaderField:@"token"];
    
    [request setHTTPBody: [_postData dataUsingEncoding:NSUTF8StringEncoding]];
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if(connection)
    {
        if(webData==nil)
        {
            webData = [NSMutableData data] ;
            NSLog(@"data");
        }
        else
        {
            webData=nil;
            webData = [NSMutableData data] ;
        }
        NSLog(@"server connection made");
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
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSLog(@"%@",[user valueForKey:@"l_userid"]);
    NSString *userid = [NSString stringWithFormat: @"%@",[user valueForKey:@"l_userid"]];
    //    NSString *udid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    //    NSString *currSys = @"ios";
    //    NSString *devToken = [[NSUserDefaults standardUserDefaults] valueForKey: @"deviceToken"];
    
    _postData = [NSString stringWithFormat:@""];
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/users/%@/logout",Kwebservices,userid]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
    
    NSLog(@"data post >>> %@",_postData);
    
    [request setHTTPMethod:@"POST"];
    //[request addValue:mea forHTTPHeaderField:@"MEAId"];
    //[request addValue:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"UserToken"]] forHTTPHeaderField:@"token"];
    
    [request setHTTPBody: [_postData dataUsingEncoding:NSUTF8StringEncoding]];
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if(connection)
    {
        if(webData==nil)
        {
            webData = [NSMutableData data] ;
            NSLog(@"data");
        }
        else
        {
            webData=nil;
            webData = [NSMutableData data] ;
        }
        NSLog(@"server connection made");
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
         //   sideView.hidden=YES;
         
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
         NSLog(@"Completed");
         
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
    NSLog(@"%@",[user valueForKey:@"l_userid"]);
    NSString *userid = [NSString stringWithFormat: @"%@",[user valueForKey:@"l_userid"]];
    
    
    NSString *dashboardTimeStamp = [[NSUserDefaults standardUserDefaults]valueForKey:@"dashboardNotificationTimeStamp"];
    NSLog(@"%@",dashboardTimeStamp);
    NSArray *strArr = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"dashboardNotificationTimeStamp"]] componentsSeparatedByString:@"."];
    
    
    _postData = [NSString stringWithFormat:@"userId=%@&Timestamp=%@",userid,[[NSUserDefaults standardUserDefaults]valueForKey:@"loginDateSaved"]];
    if(dashboardTimeStamp!=nil)
    {
        _postData = [NSString stringWithFormat:@"userId=%@&Timestamp=%@",userid,[[NSUserDefaults standardUserDefaults]valueForKey:@"dashboardNotificationTimeStamp"]];
    }
    
    
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/dashboard",Kwebservices]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
    
    NSLog(@"data post >>> %@",_postData);
    
    [request setHTTPMethod:@"POST"];
    //[request addValue:mea forHTTPHeaderField:@"MEAId"];
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"UserToken"]);
    [request addValue:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"UserToken"]] forHTTPHeaderField:@"token"];
    
    [request setHTTPBody: [_postData dataUsingEncoding:NSUTF8StringEncoding]];
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if(connection)
    {
        if(webData==nil)
        {
            webData = [NSMutableData data] ;
            NSLog(@"data");
        }
        else
        {
            webData=nil;
            webData = [NSMutableData data] ;
        }
        NSLog(@"server connection made");
    }
    else
    {
        NSLog(@"connection is NULL");
    }
}

-(void)registerDevice
{
    webservice=2;
    NSMutableURLRequest *request ;
    NSString*_postData ;
    NSURLConnection *connection;
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSLog(@"%@",[user valueForKey:@"l_userid"]);
    NSString *userid = [NSString stringWithFormat: @"%@",[user valueForKey:@"l_userid"]];
    NSString *udid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSString *currSys = @"ios";
    NSString *devToken = [[NSUserDefaults standardUserDefaults] valueForKey: @"deviceToken"];
    
    
    _postData = [NSString stringWithFormat:@"UserID=%@&DeviceUDID=%@&DeviceOS=%@&TokenID=%@",userid,udid,currSys,devToken];
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/userdevice",Kwebservices]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
    
    NSLog(@"data post >>> %@",_postData);
    
    [request setHTTPMethod:@"POST"];
    //[request addValue:mea forHTTPHeaderField:@"MEAId"];
    [request addValue:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"UserToken"]] forHTTPHeaderField:@"token"];
    
    [request setHTTPBody: [_postData dataUsingEncoding:NSUTF8StringEncoding]];
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if(connection)
    {
        if(webData==nil)
        {
            webData = [NSMutableData data] ;
            NSLog(@"data");
        }
        else
        {
            webData=nil;
            webData = [NSMutableData data] ;
        }
        NSLog(@"server connection made");
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
//        [txtPhoneNo becomeFirstResponder];
        
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
