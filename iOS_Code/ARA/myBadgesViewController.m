//
//  myBadgesViewController.m
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 14/08/15.
//  Copyright (c) 2015 Krishna_Mac_2. All rights reserved.
//

#import "myBadgesViewController.h"
#import "myBadgesTableViewCell.h"
#import "AFHTTPRequestOperationManager.h"
#import "ASIHTTPRequest.h"
#import "badges.h"

@interface myBadgesViewController ()


@end

@implementation myBadgesViewController

- (void)viewDidLoad {
    
    count=0;
    
    [super viewDidLoad];
    [self getData:@"local"];
    
//    btnallBadges.hidden = YES;
//    [self getData:@"all"];
//   // status = @"yes";
    
    
    
    
    mybadges = @"no";
    
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
        lblheading.font=[lblheading.font fontWithSize:24];
        btnBack.titleLabel.font = [btnBack.titleLabel.font fontWithSize:24];
        
        if(IS_IPAD_PRO_1366)
        {
            lblheading.font=[lblheading.font fontWithSize:30];
            btnBack.titleLabel.font = [btnBack.titleLabel.font fontWithSize:30];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - tableView Delegates

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (IS_IPAD)
    {
        return 130;
    }
    return 93;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
    {
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        return badgesArray.count;
    }
- (UITableViewCell *)tableView:(UITableView *)atableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"ArticleCellID";
    
    myBadgesTableViewCell *cell = (myBadgesTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"myBadgesTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
    
    badges * obj = [[badges alloc]init];
    obj = [badgesArray objectAtIndex:indexPath.row];
    
    NSString *badgeUrl_str = [NSString stringWithFormat:@"%@",obj.BadgeUrl];
    NSString *joinedStr ;
    NSString *random = [NSString stringWithFormat:@"%@",obj.IsBadgeEarned];
    
    
    if([random isEqualToString:@"0"])
    {
        
        joinedStr= [NSString stringWithFormat:@"%@ %@ Referrals",obj.MinimumReferralsRequired,obj.BadgeStatus] ;
            
        
    }else{
        
        joinedStr= [NSString stringWithFormat:@"%@ %@ %@ with in %@ days",obj.MinimumReferralsRequired,obj.BadgeStatus,obj.BadgeType,obj.ApplicableTimeFrameInDays];
        
    }
    
//    if (indexPath.row==0) {
//        random = @"1";
//    }else{
//        random= @"2";
//    }
    
    
    if ([mybadges isEqualToString:@"no"]) {
        [cell setLabelText:[NSString stringWithFormat:@"%@",obj.BadgeName] :joinedStr :@"" :badgeUrl_str :random];
    }else{
        [cell setLabelText:[NSString stringWithFormat:@"%@",obj.BadgeName] :joinedStr :[NSString stringWithFormat:@"%@",obj.EarnedDate] :badgeUrl_str :random];
    }
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)atableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        badges * obj = [[badges alloc]init];
    
        obj = [badgesArray objectAtIndex:indexPath.row];
        NSString *random = [NSString stringWithFormat:@"%@",obj.IsBadgeEarned];
    
    
 //     NSString *badgeName = [NSString stringWithFormat:@"%@",obj.BadgeName];
        
        NSString *msg;
        if ([random isEqualToString:@"1"]) {
             msg = [NSString stringWithFormat:@"You already earned a %@ badge.",obj.BadgeName];
            [HelperAlert alertWithOneBtn:AlertTitle description:msg okBtn:OkButtonTitle];


        }else{
            msg = [NSString stringWithFormat:@"You haven't earned any %@ badges yet.",obj.BadgeName];
            [HelperAlert alertWithOneBtn:AlertTitle description:msg okBtn:OkButtonTitle];


        }
        

    
[tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma  mark - Buttons
- (IBAction)btnallBadges:(id)sender {
    btnallBadges.hidden = YES;
    [self getData:@"all"];
    status = @"yes";
}

- (IBAction)btnback:(id)sender {
    if([status isEqualToString:@"yes"])
    {
        status = @"no";
        btnallBadges.hidden = NO;

        [self getData:@"local"];
        
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)getData:(NSString*)status1
{
    
    [kappDelegate ShowIndicator];
    
    
    NSMutableURLRequest *request ;
    NSString*_postData ;
    
     NSString * userid =  [[NSUserDefaults standardUserDefaults]valueForKey:@"l_userid"];

    
    _postData = [NSString stringWithFormat:@""];
    
    if([status1 isEqualToString:@"all"])
    {
        webservices=1;
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/badges",Kwebservices]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
    }else{
        webservices=2;
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/badges/%@",Kwebservices,userid]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
    }
    
    NSLog(@"data post >>> %@",request);
    
    [request setHTTPMethod:@"GET"];
    
    [request addValue:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"UserToken"]] forHTTPHeaderField:@"token"];

    [request setHTTPBody: [_postData dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if(connection)
    {
        if(webData==nil)
        {
            webData = [NSMutableData data];
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
        
    }else if ((long)[httpResponse statusCode] == 404){
        [HelperAlert alertWithOneBtn:AlertTitle description:@"Error" okBtn:OkButtonTitle];


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
  
    SBJsonParser *json = [[SBJsonParser alloc] init];
    NSMutableDictionary *userDetailDict=[json objectWithString:responseString error:&error];
    NSLog(@"%@",userDetailDict);
        if([response_status isEqualToString:@"passed"])
        {
            if(webservices==1)
            {   mybadges = @"no";
                badgesArray = [[NSMutableArray alloc]init];
                NSArray *array_;
                if(userDetailDict.count<1)
                {
                    [tableView reloadData];
                    return;
                }
              //lblheading.text =[NSString stringWithFormat:@"ALL BADGES (%lu)",(unsigned long)userDetailDict.count];
               lblheading.text =[NSString stringWithFormat:@"ALL BADGES"];
                for (int i=0; i<userDetailDict.count; i++) {
                    badges *obj = [[badges alloc]init];
                    
                    obj.BadgeId = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"BadgeId"]objectAtIndex:i]];
                    obj.BadgeName = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"BadgeName"]objectAtIndex:i]];
                    obj.BadgeUrl = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"BadgeUrl"]objectAtIndex:i]];
                    array_ = [userDetailDict valueForKey:@"BadgesCrieteria"];
                    
                    obj.ApplicableTimeFrameInDays = [NSString stringWithFormat:@"%@",[[array_ valueForKey:@"ApplicableTimeFrameInDays"]objectAtIndex:i]];
                    obj.BadgeCriteriaId = [NSString stringWithFormat:@"%@",[[array_ valueForKey:@"BadgeCriteriaId"]objectAtIndex:i]];
                    obj.BadgeStatus = [NSString stringWithFormat:@"%@",[[array_ valueForKey:@"BadgeStatus"]objectAtIndex:i]];
                    obj.BadgeType = [NSString stringWithFormat:@"%@",[[array_ valueForKey:@"BadgeType"]objectAtIndex:i]];
                    obj.CreatedDate = [NSString stringWithFormat:@"%@",[[array_ valueForKey:@"CreatedDate"]objectAtIndex:i]];
                    obj.MinimumReferralsRequired = [NSString stringWithFormat:@"%@",[[array_ valueForKey:@"MinimumReferralsRequired"]objectAtIndex:i]];
                    obj.CreatedDate1 = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"CreatedDate"]objectAtIndex:i]];
                    obj.EarnedDate = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"EarnedDate"]objectAtIndex:i]];
                    [badgesArray addObject:obj];
                    
                }
                                [tableView reloadData];
//                [self getData:@"local"];
            }else if(webservices==2)
            {
                mybadges = @"yes";
          //     lblheading.text =[NSString stringWithFormat:@"BADGES (%lu)",(unsigned long)userDetailDict.count];
                lblheading.text =[NSString stringWithFormat:@"BADGES"];
                
                if(userDetailDict.count<1)
                {
                    [HelperAlert  alertWithOneBtn:AlertTitle description:@"No badges to display yet." okBtn:OkButtonTitle];

                    
                    return;

                }
                
                 badgesArray = [[NSMutableArray alloc]init];
                 NSArray *array_;
                earnedBadgesNames = [[NSMutableArray alloc]init];
                
                for (int i=0; i<userDetailDict.count; i++) {
                    badges *obj = [[badges alloc]init];

                    obj.BadgeId = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"BadgeId"]objectAtIndex:i]];
    obj.BadgeName = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"BadgeName"]objectAtIndex:i]];
                    obj.BadgeUrl = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"BadgeUrl"]objectAtIndex:i]];
                    array_ = [userDetailDict valueForKey:@"BadgesCrieteria"];
                    
                    obj.ApplicableTimeFrameInDays = [NSString stringWithFormat:@"%@",[[array_ valueForKey:@"ApplicableTimeFrameInDays"]objectAtIndex:i]];
                    obj.BadgeCriteriaId = [NSString stringWithFormat:@"%@",[[array_ valueForKey:@"BadgeCriteriaId"]objectAtIndex:i]];
                    obj.BadgeStatus = [NSString stringWithFormat:@"%@",[[array_ valueForKey:@"BadgeStatus"]objectAtIndex:i]];
                    obj.BadgeType = [NSString stringWithFormat:@"%@",[[array_ valueForKey:@"BadgeType"]objectAtIndex:i]];
                    obj.CreatedDate = [NSString stringWithFormat:@"%@",[[array_ valueForKey:@"CreatedDate"]objectAtIndex:i]];
                    obj.MinimumReferralsRequired = [NSString stringWithFormat:@"%@",[[array_ valueForKey:@"MinimumReferralsRequired"]objectAtIndex:i]];
                    obj.CreatedDate1 = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"CreatedDate"]objectAtIndex:i]];
                    obj.EarnedDate = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"EarnedDate"]objectAtIndex:i]];
                    obj.IsBadgeEarned = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"IsBadgeEarned"]objectAtIndex:i]];
                    
                    [earnedBadgesNames addObject:obj.BadgeName];
//
                    [badgesArray addObject:obj];
                }
                
                
                badges *obj = [[badges alloc]init];
                NSArray *sortedStrings =
                [earnedBadgesNames sortedArrayUsingSelector:@selector(compare:)];
                NSMutableArray *finalarray = [[NSMutableArray alloc]init];
                
                for (int h=0; h<sortedStrings.count; h++) {
                    
                    for (int g=0; g<badgesArray.count; g++) {
                        obj = [badgesArray objectAtIndex:g];
                        
                        if ([[sortedStrings objectAtIndex:h] isEqualToString:obj.BadgeName]) {
                            
                            [finalarray addObject:[badgesArray objectAtIndex:g]];
                            
                        }
                        
                        
                    }
                }
                
//                NSMutableArray *array1,*array2;
//                array1 = [[NSMutableArray alloc]init];
//                array2 = [[NSMutableArray alloc]init];
//                for (int j=0; j<finalarray.count; j++) {
//                    badges *obj = [[badges alloc]init];
//
//                    obj = [finalarray objectAtIndex:j];
//                    if ([obj.IsBadgeEarned isEqualToString:@"1"]) {
//                        array1 = [finalarray objectAtIndex:j];
//                    }else {
//                        array2 = [finalarray objectAtIndex:j];
//                    }
//                    
//                }
//                [finalarray removeAllObjects];
//                [finalarray addObject:array1];
//                 [finalarray addObject:array2];
//                

                NSArray *sortedArray = [finalarray sortedArrayUsingComparator:^NSComparisonResult(badges* p1, badges* p2){
                    
                    if(([p1.IsBadgeEarned  isEqual: @"1"] && [p2.IsBadgeEarned  isEqual: @"1"]) || ([p1.IsBadgeEarned  isEqual: @"0"] && [p2.IsBadgeEarned  isEqual:@"0"]))
                    {
                        
                        NSLog(@"1");
                        return [p1.BadgeName compare:p2.BadgeName];

                    }else if([p1.IsBadgeEarned isEqual:@"1"]){                        return NSOrderedAscending;
                    }else {
                        return NSOrderedDescending;
                    }
                    
                                        
                }];
                
                [badgesArray removeAllObjects];
                for (int i=0; i<sortedArray.count; i++) {
                    
                    badges *obj = [[badges alloc]init];
                    obj =[sortedArray objectAtIndex:i];
                     NSLog(@"%@",obj.BadgeName);
                    [badgesArray addObject:obj];
                }
               [tableView reloadData];
            }
        }
}
@end
