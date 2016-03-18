//
//  rewardListViewController.m
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 14/08/15.
//  Copyright (c) 2015 Krishna_Mac_2. All rights reserved.
//

#import "rewardListViewController.h"
#import "ReferralTableViewCell.h"
#import "AFHTTPRequestOperationManager.h"
#import "ASIHTTPRequest.h"
#import "PaypalAccountsViewController.h"
#import "rewardDetailViewController.h"

@interface rewardListViewController ()

@end

@implementation rewardListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //---makeing button round
//    btnSold.layer.cornerRadius = 2.0;  [btnSold setClipsToBounds:YES];
//    btnUpcoming.layer.cornerRadius = 2.0; [btnUpcoming setClipsToBounds:YES];
    
    
    [btnSold setBackgroundColor:[UIColor colorWithRed:255.0f/255.0f green:209.0f/255.0f blue:28.0f/255.0f alpha:1.0f]];
    [btnSold setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    lblheading.text = @"PAID PAYMENT";
    
    [self getList:@"earned"];
    
   /*
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
    }*/
    
    if (IS_IPAD)
    {
        lblheading.font=[lblheading.font fontWithSize:24];
        btnSold.titleLabel.font=[lblheading.font fontWithSize:24];
        btnUpcoming.titleLabel.font=[lblheading.font fontWithSize:24];
        btnback.titleLabel.font=[lblheading.font fontWithSize:24];
        btnPaymentAccounts.titleLabel.font=[btnPaymentAccounts.font fontWithSize:20];
        if(IS_IPAD_PRO_1366)
        {
            lblheading.font=[lblheading.font fontWithSize:30];
            btnSold.titleLabel.font=[lblheading.font fontWithSize:30];
            btnUpcoming.titleLabel.font=[lblheading.font fontWithSize:30];
            btnback.titleLabel.font=[lblheading.font fontWithSize:30];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Buttons
- (IBAction)btnPaymentAccounts:(id)sender{
    PaypalAccountsViewController *PayPalAccountsVC = [[PaypalAccountsViewController alloc]initWithNibName:@"PaypalAccountsViewController" bundle:nil];
    [self.navigationController pushViewController:PayPalAccountsVC animated:YES];
}
- (IBAction)btnBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnSold:(id)sender {
    [btnUpcoming setBackgroundColor:[UIColor blackColor]];
    [btnUpcoming setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [btnSold setBackgroundColor:[UIColor colorWithRed:255.0f/255.0f green:209.0f/255.0f blue:28.0f/255.0f alpha:1.0f]];
    [btnSold setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    lblheading.text = @"PAID PAYMENT";
    
    [self getList:@"earned"];
    [tableView reloadData];
}

- (IBAction)btnUpcoming:(id)sender {
    [btnUpcoming setBackgroundColor:[UIColor colorWithRed:255.0f/255.0f green:209.0f/255.0f blue:28.0f/255.0f alpha:1.0f]];
    [btnUpcoming setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    if ( btnSold.userInteractionEnabled == NO) {
        
    }else{
    [btnSold setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    [btnSold setBackgroundColor:[UIColor blackColor]];
    
    
    lblheading.text = @"PENDING PAYMENT";

    [self getList:@"upcoming"];
    [tableView reloadData];

}

#pragma  mark - TableView delegates
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (IS_IPAD)
    {
          return 80;
    }
    return 60;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if(rewardListArray.count==0)
    {
        return 0;
    }

    return rewardListArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)atableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"ArticleCellID";
    
    ReferralTableViewCell *cell = (ReferralTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ReferralTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
    obj = [[ReferralObj alloc]init];
   // rewardListArray = [[NSMutableArray alloc] init];
    obj = [rewardListArray objectAtIndex:indexPath.row];
    
    NSString *name = [NSString stringWithFormat:@"%@ %@",obj.first_name,obj.last_name];
    
    NSString *datee = [NSString stringWithFormat:@"%@",obj.SoldDate];
//    NSArray *dateArr = [datee componentsSeparatedByString:@" "];
//    NSString *date = [NSString stringWithFormat:@"%@",[dateArr objectAtIndex:0]];
//    NSString *timeAMPM =[NSString stringWithFormat:@"%@ %@",[dateArr objectAtIndex:1],[dateArr objectAtIndex:2]];
//    
//    NSArray *semidate = [date componentsSeparatedByString:@"-"];
//    NSString *finalDate = [NSString stringWithFormat:@"%@-%@-%@ %@",[semidate objectAtIndex:2],[semidate objectAtIndex:1],[semidate objectAtIndex:0],timeAMPM];
    
    
    
    
    
    
        [cell setLabelTextforReward:name :obj.UniqueReferralNumber :obj.RewardAmount :datee];
    
        tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    rewardDetailViewController *RDvc = [[rewardDetailViewController alloc]initWithNibName:@"rewardDetailViewController" bundle:nil];
    obj = [[ReferralObj alloc]init];
    
    
    obj = [rewardListArray objectAtIndex:indexPath.row];
    RDvc.obj =obj;
   // RDvc.from_RewardList = @"yes";
    [self.navigationController pushViewController:RDvc animated:YES];
}
-(void)getList:(NSString*)status
{
    NSMutableURLRequest *request;
    NSString*_postData ;
    
    [kappDelegate ShowIndicator];
    _postData = [NSString stringWithFormat:@""];
    
    NSString *user_id = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"l_userid"]];
    NSString *val;
    NSString *urlStr = [NSString stringWithFormat:@"%@/rewards/%@/rewardType/%@?pageNumber=0&pageSize=0&sorting=%@",Kwebservices,user_id,status,val];
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
    
    
    
    NSLog(@"data post >>> %@",_postData);
    
    [request setHTTPMethod:@"GET"];
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

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"Received Response");
    [webData setLength: 0];
    
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
        
    }
    else if ((long)[httpResponse statusCode] == 405)
    {
        //response_status = @"failed";
        [HelperAlert  alertWithOneBtn:AlertTitle description:@"Method name has been changed at backed" okBtn:OkButtonTitle];

    }

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
    [HelperAlert  alertWithOneBtn:@"ERROR" description:error okBtn:OkButtonTitle];
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
    if([response_status isEqualToString:@"passed"])
    {
        SBJsonParser *json = [[SBJsonParser alloc] init];
        NSMutableDictionary *data = [json objectWithString:responseString error:&error];
        NSMutableDictionary *userDetailDict=[data valueForKey:@"lstRewardEarnedData"];
        
        if([response_status isEqualToString:@"passed"])
        { rewardListArray = [[NSMutableArray alloc] init];
            
            
            if (userDetailDict.count<1) {
                
                NSString *status = [NSString stringWithFormat:@"%@",lblheading.text];
                
//                if([status isEqualToString:@"PAYMENT EARNED"])
//                {
//                    [btnSold setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
//                    btnSold.userInteractionEnabled = NO;
                [HelperAlert  alertWithOneBtn:AlertTitle description:@"There is no data to display" okBtn:OkButtonTitle];

                
                    [tableView reloadData];
//                    return;
//                    
//                }else if([status isEqualToString:@"PAYMENT UPCOMING"])
//                {
//                    [btnUpcoming setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
//                    btnUpcoming.userInteractionEnabled = NO;
//                    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"ARA" message:@"There is no data to display" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//                    [alert show];
//                    [tableView reloadData];
                    return;
//                }
            }
            
            
            
            for (int i=0; i<userDetailDict.count; i++)
            {
                obj = [[ReferralObj alloc] init];
                NSDictionary *dict = [[NSDictionary alloc]init];
                dict = [[userDetailDict valueForKey:@"Referral"]objectAtIndex:i];
                
                obj.first_name = [NSString stringWithFormat:@"%@",[dict valueForKey:@"FirstName"]];
                obj.last_name = [NSString stringWithFormat:@"%@",[dict valueForKey:@"LastName"]];
                obj.email = [NSString stringWithFormat:@"%@",[dict valueForKey:@"Email"]];
//                if([NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"PhoneNumber"]objectAtIndex:i]].length==6)
//                {
//                    obj.phone_no = @" ";
//                }else{
                    obj.phone_no = [NSString stringWithFormat:@"%@",[dict valueForKey:@"PhoneNumber"]];
//                }
               
                obj.MEAid = [NSString stringWithFormat:@"%@",[dict valueForKey:@"MeaId"]];
                obj.comments=[NSString stringWithFormat:@"%@",[dict valueForKey:@"Comments"]];
                obj.createDate = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"CreatedDate"]objectAtIndex:i]];
                obj.referralID = [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@",[dict valueForKey:@"ReferralId"]]];
                obj.ReferralStatus = [NSString stringWithFormat:@"%@",[dict valueForKey:@"ReferralStatus"]];
                obj.ReferrerEmail = [NSString stringWithFormat:@"%@",[dict   valueForKey:@"ReferrerEmail"]];
                obj.ReferrerID = [NSString stringWithFormat:@"%@",[dict valueForKey:@"ReferrerID"]];
                obj.ReferrerName = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"ReferrerName"]objectAtIndex:i]];
                obj.ReferrerUserName = [NSString stringWithFormat:@"%@",[dict valueForKey:@"ReferrerUserName"]];
                obj.SoldDate = [NSString stringWithFormat:@"%@",[dict valueForKey:@"SoldDate"]];
                obj.UniqueReferralNumber = [NSString stringWithFormat:@"%@",[dict valueForKey:@"UniqueReferralNumber"]];
                obj.UserDetailId = [NSString stringWithFormat:@"%@",[dict valueForKey:@"UserDetailId"]];
                obj.MeaName = [NSString stringWithFormat:@"%@",[dict valueForKey:@"MeaName"]];
                obj.ReferralType = [NSString stringWithFormat:@"%@",[dict valueForKey:@"ReferralType"]];
               // obj.tag = [[userDetailDict valueForKey:@"FirstName"]objectAtIndex:i];
                
                
                
                obj.RewardAmount = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"RewardAmount"]objectAtIndex:i]];
                obj.RewardDescription = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"RewardDescription"]objectAtIndex:i]];
                obj.RewardName = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"RewardName"]objectAtIndex:i]];
                obj.RewardType = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"RewardType"]objectAtIndex:i]];
                obj.Rewardlevel = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"Rewardlevel"]objectAtIndex:i]];
                obj.TransactionID = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"TransactionID"]objectAtIndex:i]];
                 obj.IsReceived = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"IsReceived"]objectAtIndex:i]];
                
                [rewardListArray addObject:obj];
            }
            [tableView reloadData];
        }
    }
    [kappDelegate HideIndicator];
}
@end
