//
//  APIDetailsViewController.m
//  AUTOAVES_REFERRAL
//
//  Created by Mac on 19/08/16.
//  Copyright © 2016 Krishna_Mac_2. All rights reserved.
//

#import "APIDetailsViewController.h"
#import "APIDetailTableViewCell.h"
@interface APIDetailsViewController ()
{
    APIDetailTableViewCell *TableCell;
    UIRefreshControl *refreshControl;
    int t; UIButton *aButton;int m;
    int total; NSString *counts;
}
@end

@implementation APIDetailsViewController
-(IBAction)returnBack:(id)sender
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"TITLE"];
 

    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"NETWORK_TITLE"];
  

    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"APP_TITLE"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"REFERRAL_TITLE"];
    
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"myInvitationBtn"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"networkInvitationBtn"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"appInstallationBtn"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"networkReferralBtn"];
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *getTitle= [[NSUserDefaults standardUserDefaults]
                         stringForKey:@"TITLE"];
    NSString *network_Title= [[NSUserDefaults standardUserDefaults]stringForKey:@"NETWORK_TITLE"];
    NSString *app_Title= [[NSUserDefaults standardUserDefaults]stringForKey:@"APP_TITLE"];
    
    NSString *referral_Title= [[NSUserDefaults standardUserDefaults]stringForKey:@"REFERRAL_TITLE"];
    
    
    
    if ([getTitle isEqualToString:@"MY INVITATIONS"])
    {
       
        lblCount.text=[NSString stringWithFormat:@"%@ [%@]",getTitle, counts];
        
    }
    else if ([network_Title isEqualToString:@"TOTAL NETWORK INVITATIONS"])
    {
       
        lblCount.text=[NSString stringWithFormat:@"%@ [%@]",network_Title, counts];
        
    }
    else if ([app_Title isEqualToString:@"TOTAL APPLICATION INSTALLS"])
    {
       
        lblCount.text=[NSString stringWithFormat:@"%@ [%@]",app_Title, counts];
        
        
    }
    else if ([referral_Title isEqualToString:@"TOTAL NETWORK REFERRALS"])
    {
      
        lblCount.text=[NSString stringWithFormat:@"%@ [%@]",referral_Title, counts];
        
        
    }
    
  
     [aButton setHidden:YES];
    
   

value = false;
    count = 1;
    
    if(IS_IPAD){
        pageCountIPAD = 20;
    }else{
        pageCountIPAD = 10;
    }
    allData = [[NSMutableArray alloc]init];
    
    [self setContentSize];
    [self loadData];
    
    [_table setDelegate:self];
    [_table setDataSource:self];

}
-(void)loadData
{
     [kappDelegate ShowIndicator];
    NSMutableURLRequest *request ;
    NSString*_postData ;
    NSURLConnection *connection;
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSLog(@"%@",[user valueForKey:@"l_userid"]);
    NSString *userid = [NSString stringWithFormat: @"%@",[user valueForKey:@"l_userid"]];
    
    NSString *getValue1 = [[NSUserDefaults standardUserDefaults]
                           stringForKey:@"myInvitationBtn"];
    NSString *getValue2 = [[NSUserDefaults standardUserDefaults]stringForKey:@"networkInvitationBtn"];
    
    NSString *getValue3 = [[NSUserDefaults standardUserDefaults]stringForKey:@"appInstallationBtn"];
    
    NSString *getValue4 = [[NSUserDefaults standardUserDefaults]stringForKey:@"networkReferralBtn"];
    
    if ([getValue1 isEqualToString:@"myInvitation"])
    {
        
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/Dashboard/DistributorInvitations",Kwebservices]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
        NSLog(@"Request is %@ ",request);
    }
    else if ([getValue2 isEqualToString:@"networkInvitation"])
    {
        
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@//Dashboard/DistributorNetworkInvitations",Kwebservices]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
        NSLog(@"Request is %@ ",request);
        
    }
    else if ([getValue3 isEqualToString:@"appInstallation"])
    {
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/Dashboard/DistributorInstalledApplication",Kwebservices]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
        NSLog(@"Request is %@ ",request);
    }
    else if ([getValue4 isEqualToString:@"networkReferral"])
    {
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/Dashboard/DistributorNewtworkReferral",Kwebservices]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
        NSLog(@"Request is %@ ",request);
        Pagetag =1;
        
    }
    
    
    
    _postData = [NSString stringWithFormat:@"PageNumber=%d&PageSize=%d",count,pageCountIPAD];
    
    
    
    //  PageNumber,PageSize
    
    NSLog(@"data post >>> %@",_postData);
    
    [request setHTTPMethod:@"POST"];
    [request addValue:userid forHTTPHeaderField:@"userid"];
    
    
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
         // [HelperAlert  alertWithOneBtn:@"ERROR" description:@"The Internet connection appears to be offline." okBtn:OkButtonTitle];
        
//        UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"ARA"  message:@"No data to display"  preferredStyle:UIAlertControllerStyleAlert];
//        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//           [self.navigationController popViewControllerAnimated:YES];
//        }]];
//        [self presentViewController:alertController animated:YES completion:nil];
//               return;
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
    [kappDelegate HideIndicator];
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
    
    if ([responseString rangeOfString:@"Not Found" options:NSCaseInsensitiveSearch].location != NSNotFound){
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"ARA" message:@"There is no data to display." preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            [self.navigationController popViewControllerAnimated:YES];
//        }];
//        [alert addAction:okAction];
//        [self presentViewController:alert animated:YES completion:nil];
//        return;
    }
    
    
    NSError *error;
    SBJsonParser *json = [[SBJsonParser alloc] init];
    NSMutableDictionary *userDetailDict=[json objectWithString:responseString error:&error];
    
    NSLog(@"Dictionary data %@",userDetailDict);
    NSMutableArray *arrrrrr= [userDetailDict valueForKey:@"lstInvitationData"];
    NSLog(@"Dara is %@",arrrrrr);
    counts=[NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"totalCount"]];
    
    total = arrrrrr.count + allData.count;
    
 
    if (total == [counts integerValue]){

        value = true;
        [aButton setHidden:YES];
   
    }
    
    
    
    if (allData.count >0){
        
        for(int i=0;i<arrrrrr.count;i++){
            [allData addObject:arrrrrr[i]];
        }
    }else{
        allData = [userDetailDict valueForKey:@"lstInvitationData"];
 
    }
    
    
    
    
    
    NSString *getTitle= [[NSUserDefaults standardUserDefaults]
                         stringForKey:@"TITLE"];
    NSString *network_Title= [[NSUserDefaults standardUserDefaults]stringForKey:@"NETWORK_TITLE"];
     NSString *app_Title= [[NSUserDefaults standardUserDefaults]stringForKey:@"APP_TITLE"];
    
    NSString *referral_Title= [[NSUserDefaults standardUserDefaults]stringForKey:@"REFERRAL_TITLE"];
    

    
    if ([getTitle isEqualToString:@"MY INVITATIONS"])
    {
        myInvitation=1;
       lblCount.text=[NSString stringWithFormat:@"%@ [%@]",getTitle, counts];
        
    }
    else if ([network_Title isEqualToString:@"TOTAL NETWORK INVITATIONS"])
    {
        networkInstalls=2;
        lblCount.text=[NSString stringWithFormat:@"%@ [%@]",network_Title, counts];
        
    }
    else if ([app_Title isEqualToString:@"TOTAL APPLICATION INSTALLS"])
    {
        appInstalls=3;
        lblCount.text=[NSString stringWithFormat:@"%@ [%@]",app_Title, counts];
        
       
    }
    else if ([referral_Title isEqualToString:@"TOTAL NETWORK REFERRALS"])
    {
        networkReferral=4;
        lblCount.text=[NSString stringWithFormat:@"%@ [%@]",referral_Title, counts];
        
        
    }
    

    
    [_table reloadData];
    return;
   
    
}
-(void)setContentSize
{
    if ( IS_IPHONE_4_OR_LESS )
    {
       TableCell.lblFullName.font=[TableCell.lblFullName.font fontWithSize:10];
       
        TableCell.lblinvitationStatus.font=[TableCell.lblinvitationStatus.font fontWithSize:10];
        
    }
    if ( IS_IPAD )
    {
        [backBtn.titleLabel setFont:[UIFont systemFontOfSize:26]];
        lblVIewHeading.font=[lblVIewHeading.font fontWithSize:26];
        lblCount.font=[lblCount.font fontWithSize:26];


        
    }
    if(IS_IPAD_PRO_1366 )
    {
        [backBtn.titleLabel setFont:[UIFont systemFontOfSize:28]];
        lblVIewHeading.font=[lblVIewHeading.font fontWithSize:28];
        lblCount.font=[lblCount.font fontWithSize:28];


    }
}


#define Tableview Delegate Mhds

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.row == total)
    {
        if (total == [counts integerValue]) {
            return 0 ;
        }
        return 50 - 10*IS_IPHONE_6P ;
    }
    return 63;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger numOfSections = 0;
    if (allData.count>0)
    {
        _table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        numOfSections                = 1;
        _table.backgroundView = nil;
    }
    else
    {
        UILabel *noDataLabel         = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _table.bounds.size.width, _table.bounds.size.height)];
        noDataLabel.text             = @"No record found";
        noDataLabel.textColor        = [UIColor blackColor];
        noDataLabel.textAlignment    = NSTextAlignmentCenter;
        _table.backgroundView = noDataLabel;
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return numOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
//     NSString *count=[[NSUserDefaults standardUserDefaults]stringForKey:@"Total_Count"];
    
    if (allData.count == 0) {
        return 0;
    }
        else
    {
        NSLog(@"data %lu",allData.count+1);
        return allData.count+1;
    }
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([indexPath row] == ((NSIndexPath*)[[tableView indexPathsForVisibleRows] lastObject]).row){
       
       
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentityy = @"ArticleCellID";
    static NSString *CellIdentity = @"lastobject";
 
    TableCell = (APIDetailTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentityy];
    
    if (TableCell == nil)
    {
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"APIDetailTableViewCell" owner:self options:nil];
    TableCell = [nib objectAtIndex:0];
    }
    
    
    NSLog(@"all data count %ld",(long)indexPath.row);
    if(indexPath.row == allData.count) {
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentity];
        
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentity];
        }
        if (total == [counts integerValue]) {
            return cell;
        }
        else
        {
         
       cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentity];
            CGRect frame;
            if (IS_IPAD) {
                
                
            frame = CGRectMake(0,0,self.view.frame.size.width,cell.contentView.frame.size.height);
                
            }
            
            else
            {
                //cell.contentView.frame.size.width
           frame = CGRectMake(0,0,self.view.frame.size.width,cell.contentView.frame.size.height);
            }
                aButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
            [aButton addTarget:self action:@selector(btnAddRowTapped:) forControlEvents:UIControlEventTouchUpInside];
            aButton.frame = frame;
            
        [aButton setTitleColor:[UIColor colorWithRed:105.0f/255.0f green:160.0f/255.0f blue:208.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        [aButton setTitle:@"Load more" forState:UIControlStateNormal];
            
        [cell.contentView addSubview:aButton];
        
        return cell;
        }
}

    else
    {
    NSString *emailid=[allData valueForKey:@"Email"][indexPath.row];
    NSString *firstname=[allData valueForKey:@"FirstName"][indexPath.row];
    NSString *lastname=[allData valueForKey:@"LastName"][indexPath.row];
    NSString *fullname=[NSString stringWithFormat:@"%@ %@",firstname,lastname];
    NSString *invitationid=[allData valueForKey:@"InvitationId"][indexPath.row];
    NSString *invitaionstatus=[allData valueForKey:@"Invitaionstatus"][indexPath.row];
    NSString*referralstatus=[allData valueForKey:@"ReferralStatus"][indexPath.row];
    NSString*uniqueReferralNo=[allData valueForKey:@"UniqueReferralNumber"][indexPath.row];
    
    
    if (Pagetag ==1)
    {
        
        
         [TableCell setvalue:fullname Email:uniqueReferralNo InvitationStatus:referralstatus];
        
        
        if ([referralstatus isEqualToString:@"Open"]){
            TableCell.lblinvitationStatus.textColor=[UIColor colorWithRed:98/255.0 green:180/255.0 blue:95/255.0 alpha:1.0];//green
        }

        
        if([[referralstatus lowercaseString] isEqualToString:@"sold"])
        {
             TableCell.lblinvitationStatus.textColor=[UIColor colorWithRed:105.0f/255.0f green:160.0f/255.0f blue:208.0f/255.0f alpha:1.0f];
           
        } else if([[referralstatus lowercaseString] isEqualToString:@"lost sale"] || [[referralstatus lowercaseString] isEqualToString:@"deleted from crm"] || [[referralstatus lowercaseString] isEqualToString:@"reversed"])
//        if([referralstatus isEqualToString:@"Call Intiated"])
        {
            TableCell.lblinvitationStatus.textColor= [UIColor colorWithRed:224.0f/255.0f green:120.0f/255.0f blue:85.0f/255.0f alpha:1.0f]; //Red color
        }
        else
        {
          TableCell.lblinvitationStatus.textColor=[UIColor colorWithRed:95.0f/255.0f green:204.0f/255.0f blue:87.0f/255.0f alpha:1.0f];//green  
        }
        TableCell.lblinvitationStatus.font = [UIFont fontWithName:@"Roboto-Bold" size:12];
        
        if([referralstatus isEqualToString:@"Inactive"])
        {
            TableCell.lblinvitationStatus.textColor= [UIColor colorWithRed:224.0f/255.0f green:120.0f/255.0f blue:85.0f/255.0f alpha:1.0f]; //Red color
        }

        return TableCell;
    }
    
    
    
     NSLog(@"all strings %@ %@ %@ %@ %@",emailid,firstname,lastname,invitaionstatus,invitationid);
    
    [TableCell setvalue:fullname Email:emailid InvitationStatus:invitaionstatus];
    

    
        if (myInvitation ==1)
        {
            if ([invitaionstatus isEqualToString:@"Accepted"]){
                TableCell.lblinvitationStatus.textColor=[UIColor colorWithRed:98/255.0 green:180/255.0 blue:95/255.0 alpha:1.0];
              
                }
            if ([invitaionstatus isEqualToString:@"Installed"]){
                TableCell.lblinvitationStatus.textColor=[UIColor colorWithRed:98/255.0 green:180/255.0 blue:95/255.0 alpha:1.0];
                
            }
            if ([invitaionstatus isEqualToString:@"Pending"]){
                TableCell.lblinvitationStatus.textColor=[UIColor colorWithRed:105.0f/255.0f green:160.0f/255.0f blue:208.0f/255.0f alpha:1.0f];
                
            }
            if ([invitaionstatus isEqualToString:@"Sent"]){
                TableCell.lblinvitationStatus.textColor=[UIColor colorWithRed:105.0f/255.0f green:160.0f/255.0f blue:208.0f/255.0f alpha:1.0f];
                
            }
        }
        else if (networkInstalls==2)
        {
            if ([invitaionstatus isEqualToString:@"Accepted"])
            {
                TableCell.lblinvitationStatus.textColor=[UIColor colorWithRed:98/255.0 green:180/255.0 blue:95/255.0 alpha:1.0];
            }
            if ([invitaionstatus isEqualToString:@"Installed"]){
                TableCell.lblinvitationStatus.textColor=[UIColor colorWithRed:98/255.0 green:180/255.0 blue:95/255.0 alpha:1.0];
                
            }
            if ([invitaionstatus isEqualToString:@"Pending"]){
                 TableCell.lblinvitationStatus.textColor=[UIColor colorWithRed:105.0f/255.0f green:160.0f/255.0f blue:208.0f/255.0f alpha:1.0f];
                
            }
            if ([invitaionstatus isEqualToString:@"Sent"]){
                 TableCell.lblinvitationStatus.textColor=[UIColor colorWithRed:105.0f/255.0f green:160.0f/255.0f blue:208.0f/255.0f alpha:1.0f];
                
            }

        }

    else if (appInstalls==3)
    {
     if ([invitaionstatus isEqualToString:@"Installed"])
    {
        TableCell.lblinvitationStatus.textColor=[UIColor colorWithRed:98/255.0 green:180/255.0 blue:95/255.0 alpha:1.0];
    }
}
     
    _table.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
       return TableCell;
    }
 
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"AutoAves" message:@"Please visit our site for more information" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
    [_table deselectRowAtIndexPath:indexPath animated:YES];
}


-(IBAction)btnAddRowTapped:(id)sender{
    
    count++;
    
    [self loadData];
    NSLog(@"Your button tapped");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

@end
