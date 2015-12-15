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
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"self"];

    //--hide navigation bar
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    [self.view bringSubviewToFront:sideView];
    
    NSLog(@"%f",self.view.frame.size.height);
    
    imageViewMenuProfile.clipsToBounds = YES;
    
    
    lblEmailSideMenu.text = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"l_email"]];
    
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
    
    
    
    int d = 0; // standard display
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2.0) {
        d = 1; // is retina display
    }
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        d += 2;
    }
    
    if (d==0) {
        headerImage.image = [UIImage imageNamed:@"320X480.png"];
    }
    if (d==1) {
        headerImage.image = [UIImage imageNamed:@"320X568.png"];
    }
    if (d==2) {
        headerImage.image = [UIImage imageNamed:@"480X800.png"];
    }
    if (d==3) {
        headerImage.image = [UIImage imageNamed:@"640X1136.png"];
    }

    if ( IS_IPAD )
    {
       btnSubmitReferral.titleLabel.font = [btnSubmitReferral.titleLabel.font fontWithSize:24];
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
        lblNameMenu.font=[lblNameMenu.font fontWithSize:35];
        lblSoldreferralAmount.font=[lblSoldreferralAmount.font fontWithSize:35];
        
        lblActivereferralcount.font=[lblActivereferralcount.font fontWithSize:85];
        lblSoldreferralcount.font=[lblSoldreferralcount.font fontWithSize:85];
        
        lblInactivereferralcount.font=[lblInactivereferralcount.font fontWithSize:85];
        lbltotalreferralcount.font=[lbltotalreferralcount.font fontWithSize:85];
        lblEmailSideMenu.font=[lblEmailSideMenu.font fontWithSize:20];
        

        btnmyprofile.titleLabel.font=[btnmyprofile.titleLabel.font fontWithSize:24];
        btnreferral.titleLabel.font=[btnreferral.titleLabel.font fontWithSize:24];
        btnPaymentaccount.titleLabel.font=[btnPaymentaccount.titleLabel.font fontWithSize:24];
        btnmybadges.titleLabel.font=[btnmybadges.titleLabel.font fontWithSize:24];
        btnRewards.titleLabel.font=[btnRewards.titleLabel.font fontWithSize:24];
        btnScoreboard.titleLabel.font=[btnScoreboard.titleLabel.font fontWithSize:24];
        btnAboutApp.titleLabel.font=[btnAboutApp.titleLabel.font fontWithSize:24];
        btnLogout.titleLabel.font=[btnLogout.titleLabel.font fontWithSize:24];
        
        if(IS_IPAD_PRO_1366 || IS_IPAD_PRO_1024)
        {
            
            btnSubmitReferral.titleLabel.font = [btnSubmitReferral.titleLabel.font fontWithSize:30];
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
}
-(void)viewWillAppear:(BOOL)animated
{
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
    NSArray *refType = [userDetailDict valueForKey:@"ReferralType"];
    
    [kappDelegate HideIndicator];
    for (int k=0; k<refType.count; k++) {
        
        if([[refType objectAtIndex:k] isEqualToString:@"open"])
        {
            NSString *amountstr = [NSString stringWithFormat:@"($%@)",[[userDetailDict valueForKey:@"Amount"] objectAtIndex:k]];
            lblActiveAmount.text = amountstr;
            lblActivereferralcount.text = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"ReferralCount"] objectAtIndex:k ]];
        }
        if([[refType objectAtIndex:k] isEqualToString:@"sold"])
        {
            NSLog(@"%@",[NSString stringWithFormat:@"($%@)",[[userDetailDict valueForKey:@"Amount"] objectAtIndex:k]]);
            lblSoldreferralAmount.text = [NSString stringWithFormat:@"($%@)",[[userDetailDict valueForKey:@"Amount"] objectAtIndex:k]];
            lblSoldreferralcount.text = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"ReferralCount"]objectAtIndex:k]];
        }
        if([[refType objectAtIndex:k] isEqualToString:@"inactive"])
        {
            //  lblInactivereferralAmount.text = [NSString stringWithFormat:@"($%@)",[[userDetailDict valueForKey:@"Amount"] objectAtIndex:i]];
            lblInactivereferralcount.text = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"ReferralCount"]objectAtIndex:k]];
            }
            if([[refType objectAtIndex:k] isEqualToString:@"Total"])
            {
           
                //lbltotalreferralAmount.text = [NSString stringWithFormat:@"($%@)",[[userDetailDict valueForKey:@"Amount"]objectAtIndex:i]];
                lbltotalreferralcount.text = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"ReferralCount"]objectAtIndex:k]];
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
        [HelperAlert  alertWithOneBtn:AlertTitle description:responseString okBtn:OkButtonTitle];

        

}
    [kappDelegate HideIndicator];

}

#pragma  mark - Other Methods

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
        frame.size.width = 210;
        frame.size.height = 210;
        frame.origin.x = frame.origin.x +14;
        frame.origin.y = frame.origin.y -10;
        if(IS_IPAD_PRO_1366 || IS_IPAD_PRO_1024)
        {
            frame.origin.x = frame.origin.x + 10;
            frame.size.width = 260;
            frame.size.height = 260;
        }
        
        imageViewMenuProfile.frame = frame;
        
        imageViewMenuProfile.layer.cornerRadius = imageViewMenuProfile.frame.size.width /2;
        imageViewMenuProfile.layer.masksToBounds = YES;
        imageViewMenuProfile.layer.borderWidth = 2;
        imageViewMenuProfile.layer.borderColor=[[UIColor lightGrayColor] CGColor];
        imageViewMenuProfile.hidden = NO;
    }else{
        //---making image round
        if ([[ UIScreen mainScreen ] bounds ].size.width == 320 )
        {
            CGRect frame = imageViewMenuProfile.frame;
            frame.size.width = 100;
            frame.size.height = 100;
            imageViewMenuProfile.frame = frame;
        }
        imageViewMenuProfile.layer.cornerRadius = imageViewMenuProfile.frame.size.width /2;
        imageViewMenuProfile.layer.borderWidth = 2.0f;
        imageViewMenuProfile.layer.borderWidth = 2;
        imageViewMenuProfile.layer.borderColor=[[UIColor lightGrayColor] CGColor];
        
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
    
    _postData = [NSString stringWithFormat:@""];
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/dashboard/%@",Kwebservices,userid]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
    
    NSLog(@"data post >>> %@",_postData);
    
    [request setHTTPMethod:@"GET"];
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

@end
