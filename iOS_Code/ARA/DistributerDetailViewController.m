//
//  DistributerDetailViewController.m
//  AUTOAVES_REFERRAL
//
//  Created by Mac on 19/08/16.
//  Copyright © 2016 Krishna_Mac_2. All rights reserved.
//

#import "DistributerDetailViewController.h"
#import "APIDetailsViewController.h"
#import "AboutAppViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "LoginViewController.h"
@interface DistributerDetailViewController ()

@end

@implementation DistributerDetailViewController
@synthesize stop;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setContentSize];
    [self getDistributionData];
    
}
-(IBAction)myInvitation:(id)sender
{
    NSString *Save = @"myInvitation";
    [[NSUserDefaults standardUserDefaults] setObject:Save forKey:@"myInvitationBtn"];
    NSString *title=@"MY INVITATIONS";
    [[NSUserDefaults standardUserDefaults] setObject:title forKey:@"TITLE"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
     [self goToNextView];
    
    

}
-(IBAction)networkInvitation:(id)sender
{
    
    NSString *Save = @"networkInvitation";
    [[NSUserDefaults standardUserDefaults] setObject:Save forKey:@"networkInvitationBtn"];
   
    NSString *title=@"TOTAL NETWORK INVITATIONS";
    [[NSUserDefaults standardUserDefaults] setObject:title forKey:@"NETWORK_TITLE"];
    [[NSUserDefaults standardUserDefaults] synchronize];

     [self goToNextView];

   
}

-(IBAction)appInstallation:(id)sender
{
    
    NSString *Save = @"appInstallation";
    [[NSUserDefaults standardUserDefaults] setObject:Save forKey:@"appInstallationBtn"];
    
    NSString *title=@"TOTAL APPLICATION INSTALLS";
    [[NSUserDefaults standardUserDefaults] setObject:title forKey:@"APP_TITLE"];
    [[NSUserDefaults standardUserDefaults] synchronize];
     [self goToNextView];
    
 }
-(IBAction)networkReferral:(id)sender
{
    
    NSString *Save = @"networkReferral";
    [[NSUserDefaults standardUserDefaults] setObject:Save forKey:@"networkReferralBtn"];
    
    NSString *title=@"TOTAL NETWORK REFERRALS";
    [[NSUserDefaults standardUserDefaults] setObject:title forKey:@"REFERRAL_TITLE"];
       [[NSUserDefaults standardUserDefaults] synchronize];
    [self goToNextView];
   
 
}

-(IBAction)returnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
   
}
- (IBAction)btnAboutApp:(id)sender {
    AboutAppViewController *AAVC = [[AboutAppViewController alloc]initWithNibName:@"AboutAppViewController" bundle:nil];
    [self.navigationController pushViewController:AAVC animated:YES];
}

- (IBAction)btnnewAppURL:(id)sender{
    NSString *urlStr = [NSString stringWithFormat:@"http://%@",btnnewAppURL.titleLabel.text];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
    
}

- (IBAction)btnlogout:(id)sender {
   
    self.stop = true;
    [self logoutFunction];
    
}



-(void)logoutFunction{
   


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
    NSLog(@"%@",[user valueForKey:@"l_userid"]);
    NSString *userid = [NSString stringWithFormat: @"%@",[user valueForKey:@"l_userid"]];
  
    
    _postData = [NSString stringWithFormat:@""];
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/users/%@/logout",Kwebservices,userid]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
    
    NSLog(@"data post >>> %@",_postData);
    
    [request setHTTPMethod:@"POST"];
   
    
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

-(void)getDistributionData
{
    [kappDelegate ShowIndicator];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSLog(@"%@",[user valueForKey:@"l_userid"]);
    NSString *userid = [NSString stringWithFormat: @"%@",[user valueForKey:@"l_userid"]];
    NSMutableURLRequest *request ;
    NSString*getData ;
    
    getData = [NSString stringWithFormat:@""];
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/Dashboard/DistributorDashBoardCounts",Kwebservices]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
    
    NSLog(@"Get >>> %@",request);
    
    [request setHTTPMethod:@"GET"];
    [request addValue:userid forHTTPHeaderField:@"userid"];
    
    
    [request setHTTPBody: [getData dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
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
-(void)goToNextView
{
   APIDetailsViewController  *controller = [[APIDetailsViewController alloc] initWithNibName:@"APIDetailsViewController" bundle:nil];
    
    [self.navigationController pushViewController:controller animated:YES];

}
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
    NSLog(@"data Received %@",webData);
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
    SBJsonParser *json = [[SBJsonParser alloc] init];
    NSMutableDictionary *userDetailDict=[json objectWithString:responseString error:&error];
    
    NSLog(@"Dictionary data %@",userDetailDict);
   
    NSString *installAppCount;
    installAppCount =[NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"InstalledApplicationCount"]];
    
    NSString *myInvitationCount=[NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"MyInvitationCount"]];
    NSString *networkInvitationCount=[NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"NetworkInvitationCount"]];
    NSString *networkReferralCount=[NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"NetworkReferralCount"]];
    
     lblmyInvitationCount.text=myInvitationCount;
    lblAppInstallsCount.text=installAppCount;
   
    lblNetworkInvitationCount.text=networkInvitationCount;    lblNetworkReferralCount.text=networkReferralCount;
     if (webservice==3)
    {
        
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
        NSLog(@"FFFFFFFFFFFFFFFFF%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"profile_picture"]);
        
        [kappDelegate HideIndicator];
        if (count_status==0) {
            [[NSUserDefaults standardUserDefaults]setObject:@"yes" forKey:@"user_logout"];
            LoginViewController *LIvc = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
            [self.navigationController pushViewController:LIvc animated:YES];
            NSLog(@"-----webservice------");
            count_status++;
        }
        
        return;
    }

    
}
-(void)setContentSize
{
    
    if (IS_IPHONE_4_OR_LESS) {
        
        //set count label size
        
        lblmyInvitationCount.font=[lblmyInvitationCount.font fontWithSize:30];
        lblNetworkInvitationCount.font=[lblNetworkInvitationCount.font fontWithSize:30];
        lblAppInstallsCount.font=[lblAppInstallsCount.font fontWithSize:30];
        lblNetworkReferralCount.font=[lblNetworkReferralCount.font fontWithSize:30];
        
        //
        lblmyInvitation.font=[lblmyInvitation.font fontWithSize:12];
        lblTotalNetwork.font=[lblTotalNetwork.font fontWithSize:12];
        lblApp.font=[lblApp.font fontWithSize:12];
        lblNetwork.font=[lblNetwork.font fontWithSize:12];
        
        
        //set button image
        
//        myinvitationBtnImage.frame = CGRectMake(35, 146, 110, 110);
        networkInvitationBtnImage.frame = CGRectMake(networkInvitationBtnImage.frame.origin.x+10, networkInvitationBtnImage.frame.origin.y, networkInvitationBtnImage.frame.size.width, networkInvitationBtnImage.frame.size.height);
//        appInstallBtnImage.frame = CGRectMake(35, 416, 110, 110);
        networkReferralBtnImage.frame = CGRectMake(networkReferralBtnImage.frame.origin.x+10, networkReferralBtnImage.frame.origin.y, networkReferralBtnImage.frame.size.width, networkReferralBtnImage.frame.size.height);
        
        lblNetworkInvitationCount.frame = CGRectMake(lblNetworkInvitationCount.frame.origin.x+10, lblNetworkInvitationCount.frame.origin.y, lblNetworkInvitationCount.frame.size.width, lblNetworkInvitationCount.frame.size.height);
        lblNetworkReferralCount.frame = CGRectMake(lblNetworkReferralCount.frame.origin.x+10, lblNetworkReferralCount.frame.origin.y, lblNetworkReferralCount.frame.size.width, lblNetworkReferralCount.frame.size.height);

        btnAboutApp.titleLabel.font = [btnAboutApp.titleLabel.font fontWithSize:11];
        btnLogout.titleLabel.font = [btnLogout.titleLabel.font fontWithSize:11];
        btnnewAppURL.titleLabel.font = [btnnewAppURL.titleLabel.font fontWithSize:11];
         lblviewHeading.font=[lblviewHeading.font fontWithSize:11];
        
        
    }
    if (IS_IPHONE_5) {
        
        
         lblmyInvitationCount.font=[lblApp.font fontWithSize:50];
         lblNetworkInvitationCount.font=[lblApp.font fontWithSize:50];
        lblAppInstallsCount.font=[lblApp.font fontWithSize:50];
        lblNetworkReferralCount.font=[lblNetwork.font fontWithSize:50];
        lblmyInvitation.font=[lblmyInvitation.font fontWithSize:13];
         lblTotalNetwork.font=[lblTotalNetwork.font fontWithSize:13];
         lblApp.font=[lblApp.font fontWithSize:13];
         lblNetwork.font=[lblNetwork.font fontWithSize:13];
      
        
        
        lblmyInvitation.frame = CGRectMake(34, 345, 120, 30);
        lblTotalNetwork.frame = CGRectMake(210, 345, 200, 30);
       // lblApp.frame = CGRectMake(34, 340, 200, 30);
        lblNetwork.frame = CGRectMake(210,625, 200, 30);
        
        
        
        lblmyInvitationCount.frame = CGRectMake(32, 272, 120, 80);

        lblNetworkInvitationCount.frame = CGRectMake(250, 272, 140, 80);
        
        
        lblAppInstallsCount.frame = CGRectMake(52,550, 80, 80);
        lblNetworkReferralCount.frame = CGRectMake(278, 550, 80, 80);

        
        
        //set button image
        
    myinvitationBtnImage.frame = CGRectMake(35, 146, 120, 120);
   appInstallBtnImage.frame = CGRectMake(35, 430, 120, 120);
        
    networkInvitationBtnImage.frame = CGRectMake(255, 146, 120, 120);
   
    networkReferralBtnImage.frame = CGRectMake(255, 430, 120, 120);
        
            }
    if (IS_IPHONE_6) {
        
        lblmyInvitation.font=[lblmyInvitation.font fontWithSize:14];
        lblTotalNetwork.font=[lblTotalNetwork.font fontWithSize:14];
        lblApp.font=[lblApp.font fontWithSize:14];
        lblNetwork.font=[lblNetwork.font fontWithSize:14];
        
        
        //set button image
        
        myinvitationBtnImage.frame = CGRectMake(35, 146, 135, 135);
        appInstallBtnImage.frame = CGRectMake(35, 421, 135, 135);
        
        networkInvitationBtnImage.frame = CGRectMake(250, 146, 135, 135);
        
        networkReferralBtnImage.frame = CGRectMake(250, 421, 135, 135);
        
        //count label
        lblmyInvitationCount.frame = CGRectMake(45, 285, 110, 70);
         lblNetworkInvitationCount.frame = CGRectMake(260, 285, 110, 70);
        lblNetworkReferralCount.frame = CGRectMake(260, 563, 110, 70);
        
        
        //set name
        lblmyInvitation.frame = CGRectMake(15, 345, 170, 30);

        lblTotalNetwork.frame = CGRectMake(225, 345, 175, 30);
        lblNetwork.frame = CGRectMake(230, 626, 170, 30);
        
    }
     if (IS_IPHONE_6P) {
        
        //count label
        lblNetworkInvitationCount.frame = CGRectMake(255, 285, 120, 70);
        lblNetworkReferralCount.frame = CGRectMake(265, 563, 100, 70);
        lblmyInvitationCount.frame = CGRectMake(50, 285, 100, 70);
        
        //naming label
        lblmyInvitation.font=[lblmyInvitation.font fontWithSize:16];
        lblTotalNetwork.font=[lblTotalNetwork.font fontWithSize:16];
        lblApp.font=[lblApp.font fontWithSize:16];
        lblNetwork.font=[lblNetwork.font fontWithSize:16];
        
        
        //set button image
        
        myinvitationBtnImage.frame = CGRectMake(37, 146, 135, 135);
        appInstallBtnImage.frame = CGRectMake(37, 428, 135, 135);
        networkInvitationBtnImage.frame = CGRectMake(250, 150, 135, 135);
        
        networkReferralBtnImage.frame = CGRectMake(250, 428, 135, 135);
        
    }

   
    if ( IS_IPAD )
    {
    myinvitationBtnImage.frame = CGRectMake(40, 142, 120, 150);
        appInstallBtnImage.frame = CGRectMake(40, 427, 120, 150);
        
        networkInvitationBtnImage.frame = CGRectMake(250, 142, 120, 150);
        
        networkReferralBtnImage.frame = CGRectMake(250, 427, 120, 150);
        
        
        
        //Count labels
        lblmyInvitationCount.frame = CGRectMake(55, 277, 90, 90);
            lblAppInstallsCount.frame = CGRectMake(55, 565, 90, 90);
        
        lblNetworkInvitationCount.frame = CGRectMake(269, 277, 90, 90);

        lblNetworkReferralCount.frame = CGRectMake(269, 565, 90, 90);
       
        
         lblmyInvitationCount.font=[lblmyInvitationCount.font fontWithSize:65];
        lblAppInstallsCount.font=[lblAppInstallsCount.font fontWithSize:65];
        lblNetworkInvitationCount.font=[lblNetworkInvitationCount.font fontWithSize:65];
        lblNetworkReferralCount.font=[lblNetworkReferralCount.font fontWithSize:65];
        
        //Simple label
        lblmyInvitation.frame=CGRectMake(15, 345, 170, 30);
        lblTotalNetwork.frame = CGRectMake(230, 345, 170, 30);
        lblNetwork.frame=CGRectMake(230, 632, 170, 30);
       lblApp.frame=CGRectMake(15, 632, 170, 30);

        
        lblmyInvitation.font=[lblmyInvitation.font fontWithSize:20];
       lblApp.font=[lblApp.font fontWithSize:20];
        lblTotalNetwork.font=[lblTotalNetwork.font fontWithSize:20];
        lblNetwork.font=[lblNetwork.font fontWithSize:20];
        lblviewHeading.font=[lblviewHeading.font fontWithSize:26];
        
        
        //buttons
        
         [Backbtn.titleLabel setFont:[UIFont systemFontOfSize:26]];
        btnAboutApp.titleLabel.font=[btnAboutApp.titleLabel.font fontWithSize:20];
        
        btnLogout.titleLabel.font=[btnLogout.titleLabel.font fontWithSize:20];
        btnnewAppURL.titleLabel.font=[btnnewAppURL.titleLabel.font fontWithSize:20];
       
    }
    if(IS_IPAD_PRO_1366 )
    {
        
        //Count Labels
        
        lblmyInvitationCount.font=[lblmyInvitationCount.font fontWithSize:70];
        lblAppInstallsCount.font=[lblAppInstallsCount.font fontWithSize:70];
        lblNetworkInvitationCount.font=[lblNetworkInvitationCount.font fontWithSize:70];
        lblNetworkReferralCount.font=[lblNetworkReferralCount.font fontWithSize:70];
        
        //Simple Labels
        
        lblmyInvitation.font=[lblmyInvitation.font fontWithSize:28];
        lblApp.font=[lblApp.font fontWithSize:28];
        
        lblTotalNetwork.font=[lblTotalNetwork.font fontWithSize:28];
      
        lblNetwork.font=[lblNetwork.font fontWithSize:28];
         lblviewHeading.font=[lblviewHeading.font fontWithSize:26];
        
      //  Referral.font=[Referral.font fontWithSize:28];
      //  Invitation.font=[Invitation.font fontWithSize:28];
      //   Install.font=[Install.font fontWithSize:28];
        
        //Buttons
    
        [Backbtn.titleLabel setFont:[UIFont systemFontOfSize:28]];
        btnAboutApp.titleLabel.font=[btnAboutApp.titleLabel.font fontWithSize:30];
        btnLogout.titleLabel.font=[btnLogout.titleLabel.font fontWithSize:30];
        btnnewAppURL.titleLabel.font=[btnnewAppURL.titleLabel.font fontWithSize:30];
      }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}
@end
