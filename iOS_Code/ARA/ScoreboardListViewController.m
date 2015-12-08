//
//  ScoreboardListViewController.m
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 17/08/15.
//  Copyright (c) 2015 Krishna_Mac_2. All rights reserved.
//

#import "ScoreboardListViewController.h"
#import "ReferralTableViewCell.h"
#import "JSON.h"
#import "SBJson.h"
#import "AFHTTPRequestOperationManager.h"
#import "ASIHTTPRequest.h"

@interface ScoreboardListViewController ()

@end

@implementation ScoreboardListViewController

- (void)viewDidLoad {
    [super viewDidLoad];    
    
    if([_timestamp isEqualToString:@"quaterly"])
    {
        [btnQuater setBackgroundColor:[UIColor colorWithRed:255.0f/255.0f green:209.0f/255.0f blue:28.0f/255.0f alpha:1.0f]];
        [btnQuater setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    }else if([_timestamp isEqualToString:@"yearly"])
    {
        [btnYear setBackgroundColor:[UIColor colorWithRed:255.0f/255.0f green:209.0f/255.0f blue:28.0f/255.0f alpha:1.0f]];
        [btnYear setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    }else if([_timestamp isEqualToString:@"all"])
    {
        [btnAllTime setBackgroundColor:[UIColor colorWithRed:255.0f/255.0f green:209.0f/255.0f blue:28.0f/255.0f alpha:1.0f]];
        [btnAllTime setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    }
    
    
    
    
    if([_trigger isEqualToString:@"HighestReferral"])
    {
       _lblHeader.text = @"HIGHEST REFERRALS";
        
    }else if([_trigger isEqualToString:@"HighestSoldReferral"])
    {
        _lblHeader.text = [NSString stringWithFormat:@"HIGHEST SOLD REFERRALS"];;
        
    }else if([_trigger isEqualToString:@"HighestEarner"])
    {
        _lblHeader.text = @"HIGHEST EARNER";
    }
    
    [self displayData];
    
    
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
    
    
    self.lblHeader.font = [self.lblHeader.font fontWithSize:24];
        
        btnQuater.titleLabel.font = [btnQuater.titleLabel.font fontWithSize:24];
        btnYear.titleLabel.font = [btnYear.titleLabel.font fontWithSize:24];
        btnAllTime.titleLabel.font = [btnAllTime.titleLabel.font fontWithSize:24];
        btnback.titleLabel.font = [btnback.titleLabel.font fontWithSize:24];

        

    }
}
-(void)viewDidAppear:(BOOL)animated
{
    tableView.allowsSelection = NO;
    [tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - tableview Delegates
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
         return 70;
    }
    return 50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return UserName.count;
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

    if ([_trigger isEqualToString:@"HighestEarner"]) {
        
        [cell setLabelTextforScoreboard:[NSString stringWithFormat:@"%@",[UserName objectAtIndex:indexPath.row]] :[NSString stringWithFormat:@"$%@",[Earning objectAtIndex:indexPath.row]] :_trigger];
    }else{
        [cell setLabelTextforScoreboard:[NSString stringWithFormat:@"%@",[UserName objectAtIndex:indexPath.row]] :[NSString stringWithFormat:@"%@",[ReferralCount objectAtIndex:indexPath.row]] :_trigger];
    
    }
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
   
    return  cell;
}
- (void)tableView:(UITableView *)atableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (IBAction)btnBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnAllTime:(id)sender {
    [btnQuater setBackgroundColor:[UIColor blackColor]];
    [btnQuater setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [btnYear setBackgroundColor:[UIColor blackColor]];
    [btnYear setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [btnAllTime setBackgroundColor:[UIColor colorWithRed:255.0f/255.0f green:209.0f/255.0f blue:28.0f/255.0f alpha:1.0f]];
    [btnAllTime setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _timestamp = @"all";
    [self displayData];
}

- (IBAction)btnYear:(id)sender {
    [btnQuater setBackgroundColor:[UIColor blackColor]];
    [btnQuater setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [btnYear setBackgroundColor:[UIColor colorWithRed:255.0f/255.0f green:209.0f/255.0f blue:28.0f/255.0f alpha:1.0f]];
    [btnYear setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [btnAllTime setBackgroundColor:[UIColor blackColor]];
    [btnAllTime setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    _timestamp = @"yearly";
    [self displayData];

}

- (IBAction)btnQuater:(id)sender {
    [btnQuater setBackgroundColor:[UIColor colorWithRed:255.0f/255.0f green:209.0f/255.0f blue:28.0f/255.0f alpha:1.0f]];
    [btnQuater setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [btnYear setBackgroundColor:[UIColor blackColor]];
    [btnYear setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [btnAllTime setBackgroundColor:[UIColor blackColor]];
    [btnAllTime setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _timestamp = @"quaterly";
    [self displayData];

}
-(void)displayData
{
    [kappDelegate ShowIndicator];
    NSMutableURLRequest *request ;
    NSString*_postData ;
    _postData = [NSString stringWithFormat:@""];
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/scoreboard/%@/timestamp/%@",Kwebservices,_trigger,_timestamp]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
        
    NSLog(@"data post >>> %@",request);
    
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
        
    }else if ((long)[httpResponse statusCode] == 404)
    {
        response_status = @"failed";
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"ARA" message:@"No data to display." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];

        return [httpResponse statusCode];
    }
    return  YES;
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
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"ARA" message:[NSString stringWithFormat:@"%@",error] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
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
       SBJsonParser *json = [[SBJsonParser alloc] init];
    NSMutableDictionary *userDetailDict=[json objectWithString:responseString error:&error];
    if([response_status isEqualToString:@"passed"])
    {
        Earning = [[NSMutableArray alloc]init];
        ReferralCount = [[NSMutableArray alloc]init];
        UserName = [[NSMutableArray alloc]init];
    
        Earning = [userDetailDict valueForKey:@"Earning"];
        ReferralCount = [userDetailDict valueForKey:@"ReferralCount"];
        UserName = [userDetailDict valueForKey:@"UserName"];
        [tableView reloadData];
    }else{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"ARA" message:responseString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];

    }
}
@end
