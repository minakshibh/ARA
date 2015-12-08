//
//  rewardListViewController.m
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 14/08/15.
//  Copyright (c) 2015 Krishna_Mac_2. All rights reserved.
//

#import "rewardListViewController.h"
#import "ReferralTableViewCell.h"
#import "JSON.h"
#import "SBJson.h"
#import "AFHTTPRequestOperationManager.h"
#import "ASIHTTPRequest.h"

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
    lblheading.text = @"PAYMENT EARNED";
    
    [self getList:@"earned"];
    
    
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
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        lblheading.font=[lblheading.font fontWithSize:24];
        btnSold.titleLabel.font=[lblheading.font fontWithSize:24];
        btnUpcoming.titleLabel.font=[lblheading.font fontWithSize:24];
        btnback.titleLabel.font=[lblheading.font fontWithSize:24];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)btnBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnSold:(id)sender {
    [btnUpcoming setBackgroundColor:[UIColor blackColor]];
    [btnUpcoming setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [btnSold setBackgroundColor:[UIColor colorWithRed:255.0f/255.0f green:209.0f/255.0f blue:28.0f/255.0f alpha:1.0f]];
    [btnSold setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    lblheading.text = @"PAYMENT EARNED";
    
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
    
    
    lblheading.text = @"PAYMENT UPCOMING";

    [self getList:@"upcoming"];
    [tableView reloadData];

}

//---tableview delegates
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
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
        [cell setLabelTextforReward:name :obj.UniqueReferralNumber :obj.RewardAmount :obj.SoldDate];
    
        tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
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
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/rewards/%@/rewardType/%@",Kwebservices,user_id,status];
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
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"ARA" message:@"Method name has been changed at backed" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];

        
    }

}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [kappDelegate HideIndicator];
    
    
    if ([[NSString stringWithFormat:@"%@",error] rangeOfString:@"The Internet connection appears to be offline." options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"ERROR" message:@"The Internet connection appears to be offline." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    if ([[NSString stringWithFormat:@"%@",error] rangeOfString:@"The network connection was lost" options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"ERROR" message:@"The network connection was lost" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    if ([[NSString stringWithFormat:@"%@",error] rangeOfString:@"Could not connect to the server" options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"ERROR" message:@"Internet connection lost. Could not connect to the server" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    if ([[NSString stringWithFormat:@"%@",error] rangeOfString:@"The request timed out" options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"ERROR" message:@"The request timed out. Not able to connect to server" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"ARA" message:@"Intenet connection failed.. Try again later." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    NSLog(@"ERROR with the Connection  >>>>>%@ ",error);
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
        NSMutableDictionary *userDetailDict=[data valueForKey:@"Referral"];
        
        if([response_status isEqualToString:@"passed"])
        { rewardListArray = [[NSMutableArray alloc] init];
            
            
            if (userDetailDict.count<1) {
                
                NSString *status = [NSString stringWithFormat:@"%@",lblheading.text];
                
//                if([status isEqualToString:@"PAYMENT EARNED"])
//                {
//                    [btnSold setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
//                    btnSold.userInteractionEnabled = NO;
                    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"ARA" message:@"There is no data to display" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                    [alert show];
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
                obj.first_name = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"FirstName"]objectAtIndex:i]];
                obj.last_name = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"LastName"]objectAtIndex:i]];
                obj.email = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"Email"]objectAtIndex:i]];
//                if([NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"PhoneNumber"]objectAtIndex:i]].length==6)
//                {
//                    obj.phone_no = @" ";
//                }else{
                    obj.phone_no = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"PhoneNumber"]objectAtIndex:i]];
//                }
               
                obj.MEAid = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"MeaId"]objectAtIndex:i]];
                obj.comments=[NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"Comments"]objectAtIndex:i]];
                obj.createDate = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"CreatedDate"]objectAtIndex:i]];
                obj.referralID = [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"ReferralId"]objectAtIndex:i]]];
                obj.ReferralStatus = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"ReferralStatus"]objectAtIndex:i]];
                obj.ReferrerEmail = [NSString stringWithFormat:@"%@",[[userDetailDict   valueForKey:@"ReferrerEmail"]objectAtIndex:i]];
                obj.ReferrerID = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"ReferrerID"]objectAtIndex:i]];
                obj.ReferrerName = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"ReferrerName"]objectAtIndex:i]];
                obj.ReferrerUserName = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"ReferrerUserName"]objectAtIndex:i]];
                obj.SoldDate = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"SoldDate"]objectAtIndex:i]];
                obj.UniqueReferralNumber = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"UniqueReferralNumber"]objectAtIndex:i]];
                obj.UserDetailId = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"UserDetailId"]objectAtIndex:i]];
                obj.MeaName = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"MeaName"]objectAtIndex:i]];
                obj.ReferralType = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"ReferralType"]objectAtIndex:i]];
               // obj.tag = [[userDetailDict valueForKey:@"FirstName"]objectAtIndex:i];
                
                
                
                obj.RewardAmount = [NSString stringWithFormat:@"%@",[[data valueForKey:@"RewardAmount"]objectAtIndex:i]];
                obj.RewardDescription = [NSString stringWithFormat:@"%@",[[data valueForKey:@"RewardDescription"]objectAtIndex:i]];
                obj.RewardName = [NSString stringWithFormat:@"%@",[[data valueForKey:@"RewardName"]objectAtIndex:i]];
                obj.RewardType = [NSString stringWithFormat:@"%@",[[data valueForKey:@"RewardType"]objectAtIndex:i]];
                obj.Rewardlevel = [NSString stringWithFormat:@"%@",[[data valueForKey:@"Rewardlevel"]objectAtIndex:i]];
                obj.TransactionID = [NSString stringWithFormat:@"%@",[[data valueForKey:@"TransactionID"]objectAtIndex:i]];
                 obj.IsReceived = [NSString stringWithFormat:@"%@",[[data valueForKey:@"IsReceived"]objectAtIndex:i]];
                
                [rewardListArray addObject:obj];
            }
            [tableView reloadData];
        }
    }
    [kappDelegate HideIndicator];
}
@end
