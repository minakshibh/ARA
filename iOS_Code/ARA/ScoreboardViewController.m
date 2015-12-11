//
//  ScoreboardViewController.m
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 17/08/15.
//  Copyright (c) 2015 Krishna_Mac_2. All rights reserved.
//

#import "ScoreboardViewController.h"
#import "ScoreboardListViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "ASIHTTPRequest.h"


@interface ScoreboardViewController ()
{
    ScoreboardListViewController *SLvc;
}
@end

@implementation ScoreboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    timestamp = [[NSString alloc]init];
    
    lblHighestEarningPrice.text = @"$0";
    lblReferralCount.text = @"0";
    lblSoldReferralCount.text = @"0";
    
    SLvc = [[ScoreboardListViewController alloc]initWithNibName:@"ScoreboardListViewController" bundle:nil];

    lblBackgroundEarning.layer.borderColor = [UIColor colorWithRed:237.0f/255.0f green:116.0f/255.0f blue:85.0f/255.0f alpha:1.0f].CGColor;
    lblBackgroundEarning.layer.borderWidth = 0.7;
    
    lblbackgroundReferral.layer.borderColor = [UIColor colorWithRed:98.0f/255.0f green:167.0f/255.0f blue:237.0f/255.0f alpha:1.0f].CGColor;
    lblbackgroundReferral.layer.borderWidth = 0.5;
    
    lblbackgroundSoldReferrals.layer.borderColor = [UIColor colorWithRed:168.0f/255.0f green:214.0f/255.0f blue:65.0f/255.0f alpha:1.0f].CGColor;
    lblbackgroundSoldReferrals.layer.borderWidth = 0.5;
    
    
    
    [btnQuater setBackgroundColor:[UIColor colorWithRed:255.0f/255.0f green:209.0f/255.0f blue:28.0f/255.0f alpha:1.0f]];
     [btnQuater setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self getDataToDisplay:@"quaterly"];
    timestamp = @"quaterly";
    
    
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
    
    if (IS_IPAD)
    {
        btnBack.titleLabel.font = [btnBack.titleLabel.font fontWithSize:24];
        lblHeading.font = [lblHeading.font fontWithSize:24];
        
        lblhighest.font = [lblhighest.font fontWithSize:20];
        lblEarning.font = [lblEarning.font fontWithSize:24];
        lblhighestReferral.font = [lblhighestReferral.font fontWithSize:24];
        lblhighestref.font = [lblhighestref.font fontWithSize:20];
        lblHighestSOLDReferral.font = [lblHighestSOLDReferral.font fontWithSize:20];
        lblHighestsoldreferral.font = [lblHighestsoldreferral.font fontWithSize:24];
        
        
        btnQuater.titleLabel.font = [btnQuater.titleLabel.font fontWithSize:24];
        btnYear.titleLabel.font = [btnYear.titleLabel.font fontWithSize:24];
        btnAllTime.titleLabel.font = [btnAllTime.titleLabel.font fontWithSize:24];
        
        
        lblHighestEarningPrice.font = [lblHighestEarningPrice.font fontWithSize:50];
        lblReferralCount.font = [lblReferralCount.font fontWithSize:50];
        lblSoldReferralCount.font = [lblSoldReferralCount.font fontWithSize:50];
        
        lblBackgroundEarning.layer.borderWidth = 1;
        lblbackgroundReferral.layer.borderWidth = 1;
        lblbackgroundSoldReferrals.layer.borderWidth = 1;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma  mark - Buttons
- (IBAction)btnAllTime:(id)sender {
    [btnQuater setBackgroundColor:[UIColor blackColor]];
    [btnQuater setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [btnYear setBackgroundColor:[UIColor blackColor]];
    [btnYear setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [btnAllTime setBackgroundColor:[UIColor colorWithRed:255.0f/255.0f green:209.0f/255.0f blue:28.0f/255.0f alpha:1.0f]];
    [btnAllTime setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self getDataToDisplay:@"all"];
    timestamp = @"all";

}

- (IBAction)btnYear:(id)sender {
    [btnQuater setBackgroundColor:[UIColor blackColor]];
    [btnQuater setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [btnYear setBackgroundColor:[UIColor colorWithRed:255.0f/255.0f green:209.0f/255.0f blue:28.0f/255.0f alpha:1.0f]];
    [btnYear setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    [btnAllTime setBackgroundColor:[UIColor blackColor]];
    [btnAllTime setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    [self getDataToDisplay:@"yearly"];
    timestamp = @"yearly";

}

- (IBAction)btnQuater:(id)sender {
    [btnQuater setBackgroundColor:[UIColor colorWithRed:255.0f/255.0f green:209.0f/255.0f blue:28.0f/255.0f alpha:1.0f]];
    [btnQuater setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [btnYear setBackgroundColor:[UIColor blackColor]];
    [btnYear setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [btnAllTime setBackgroundColor:[UIColor blackColor]];
    [btnAllTime setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    [self getDataToDisplay:@"quaterly"];
    timestamp = @"quaterly";
}

- (IBAction)btnBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnReferrals:(id)sender {
    SLvc = [[ScoreboardListViewController alloc]initWithNibName:@"ScoreboardListViewController" bundle:nil];
    value = [NSString stringWithFormat:@"Highest Referrals (%@)",lblReferralCount.text];
    SLvc.lblHeader.text = value;
    SLvc.trigger = @"HighestReferral";
    SLvc.timestamp = timestamp;
    [self.navigationController pushViewController:SLvc animated:YES];
}

- (IBAction)btnSoldReferrals:(id)sender {
    SLvc = [[ScoreboardListViewController alloc]initWithNibName:@"ScoreboardListViewController" bundle:nil];
    value = [NSString stringWithFormat:@"Highest Sold Referrals (%@)",lblSoldReferralCount.text];
    SLvc.trigger = @"HighestSoldReferral";
    SLvc.lblHeader.text = value;
    SLvc.timestamp = timestamp;
    [self.navigationController pushViewController:SLvc animated:YES];
}

- (IBAction)btnEarning:(id)sender {
    SLvc = [[ScoreboardListViewController alloc]initWithNibName:@"ScoreboardListViewController" bundle:nil];
    value = [NSString stringWithFormat:@"Highest Earnings (%@)",lblHighestEarningPrice.text];
    
    SLvc.trigger = @"HighestEarner";
    SLvc.lblHeader.text = value;
    SLvc.timestamp = timestamp;
    [self.navigationController pushViewController:SLvc animated:YES];
}
#pragma  mark - Other Buttons
-(void)getDataToDisplay:(NSString*)period
{
    
    [kappDelegate ShowIndicator];
    NSMutableURLRequest *request ;
    NSString*_postData ;
   // period = @"all";
    _postData = [NSString stringWithFormat:@""];
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/scoreboard/%@",Kwebservices,period]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
    
    
    
    NSLog(@"data post >>> %@",request);
    
    [request setHTTPMethod:@"GET"];
//    [request addValue:email forHTTPHeaderField:@"username"];
//    [request addValue:password forHTTPHeaderField:@"userpassword"];
    [request addValue:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"UserToken"]] forHTTPHeaderField:@"token"];

    
    [request setHTTPBody: [_postData dataUsingEncoding:NSUTF8StringEncoding]];
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
#pragma mark - Connection Delegates

-(NSInteger)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
    NSLog(@"response status code: %ld", (long)[httpResponse statusCode]);
    
        if((long)[httpResponse statusCode] == ResultOk)
        {
            NSLog(@"Received Response");
            [webData setLength: 0];
            response_status = @"passed";
            
        }else if ((long)[httpResponse statusCode] == ResultFailed)
        {
            response_status = @"failed";
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
    //    if([status isEqualToString:@"failed"])
    //    {
    //        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"ARA" message:responseString delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    //        [alert show];
    //        return;
    //    }
    SBJsonParser *json = [[SBJsonParser alloc] init];
    NSMutableDictionary *userDetailDict=[json objectWithString:responseString error:&error];
    if ([response_status isEqualToString:@"passed"]) {
        
        lblHighestEarningPrice.text = [NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"HighestEarning"]];
        lblReferralCount.text = [NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"HighestReferrals"]];
        lblSoldReferralCount.text = [NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"HighestSoldReferrals"]];
        
    }else{
        [HelperAlert  alertWithOneBtn:AlertTitle description:responseString okBtn:OkButtonTitle];

        

    }

}

@end
