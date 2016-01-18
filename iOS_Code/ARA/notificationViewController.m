//
//  notificationViewController.m
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 14/01/16.
//  Copyright © 2016 Krishna_Mac_2. All rights reserved.
//

#import "notificationViewController.h"
#import "AboutAppViewController.h"
#import "LoginViewController.h"

@interface notificationViewController ()

@end

@implementation notificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
    
    modified = [[NSArray alloc]initWithObjects:@"this si asd as dasdasdsdasd asd asd asd as dasdasdasd asd asdasd asdasd asdasdasdad this si asd as dasdasdsdasd asd asd asd as dasdasdasd asd asdasd asdasd asdasdasdad this si asd as dasdasdsdasd asd asd asd as dasdasdasd asd asdasd asdasd asdasdasdad",@"this si asd as dasdasdsdasd asd asd asd as dasdasdasd asd asdasd asdasd asdasdasdadthis si asd as dasdasdsdasd asd asd asd as dasdasdasd asd asdasd asdasd asdasdasdadthis si asd as dasdasdsdasd asd asd asd as dasdasdasd asd asdasd asdasd asdasdasdad",@"this si asd as dasdasdsdasd asd asd asd as dasdasdasd asd asdasd asdasd asdasdasdad",@"this si asd as dasdasdsdasd asd asd asd as dasdasdasd asd asdasd asdasd asdasdasdadthis si asd as dasdasdsdasd asd asd asd as dasdasdasd asd asdasd asdasd asdasdasdad", nil];
    
    if (IS_IPAD_PRO_1366) {
        btnBack.titleLabel.font = [btnBack.titleLabel.font fontWithSize:24];
         btnAboutApp.titleLabel.font = [btnAboutApp.titleLabel.font fontWithSize:20];
        btnLogOut.titleLabel.font = [btnLogOut  .titleLabel.font fontWithSize:20];
         btnAutoAvesURL.titleLabel.font = [btnLogOut  .titleLabel.font fontWithSize:20];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableview Delegates
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath isEqual:self.expandedIndexPath])
    {
        UILabel * Description = [[UILabel alloc]  initWithFrame: CGRectMake(15, 0, 250+450*IS_IPAD+50*IS_IPHONE_6+85*IS_IPHONE_6P+250*IS_IPAD_PRO_1366, 18)];
        Description.text= @"this si asd as dasdas dsdasd asdthis si asd as dasdas dsdasd asdthis si asd as dasdas dsdasd asd asdthis si asd as dasdas dsdasd asd asd asdthis si asd as dasdas dsdasd asd si asd as dasdas dsdasd asd asd asdthis si asd as dasdas dsdasd asd this si asd as dasdas dsdasd asdthis si asd as dasdas dsdasd asdthis si asd as dasdas dsdasd asd asdthis si asd as dasdas dsdasd asd asd asdthis si asd as dasdas dsdasd asd si asd as dasdas dsdasd asd asd asdthis si asd as dasdas dsdasd asd";
        [Description autosizeForWidth];
        
        return Description.frame.size.height+70;
    }
    
    UILabel * Description = [[UILabel alloc]  initWithFrame: CGRectMake(15, 0, 250+450*IS_IPAD+50*IS_IPHONE_6+85*IS_IPHONE_6P+250*IS_IPAD_PRO_1366, 18)] ;
    Description.text = @"this si asd as dasdas dsdasd asdthis si asd as dasdas dsdasd asdthis si asd";
    int lines = [Description getNoOflines];
    if (lines == 1 || lines == 2 || lines == 3) {
        [Description autosizeForWidth];
        return Description.frame.size.height+70;
    }else{
         return 133-15*IS_IPHONE_4_OR_LESS-15*IS_IPHONE_5-15*IS_IPHONE_6-15*IS_IPHONE_6P-8*IS_IPAD+30*IS_IPAD_PRO_1366;
    }
 //   return 133-15*IS_IPHONE_4_OR_LESS-15*IS_IPHONE_5-15*IS_IPHONE_6-15*IS_IPHONE_6P-8*IS_IPAD+30*IS_IPAD_PRO_1366;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return modified.count;
}
- (UITableViewCell *)tableView:(UITableView *)atableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    for(UIView *view in cell.contentView.subviews){
        if ([view isKindOfClass:[UIView class]]) {
            [view removeFromSuperview];
        }
    }
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    if ([indexPath isEqual:self.expandedIndexPath])
    {
        
        
        UIImageView * notificationImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 15, 18)];
        if (IS_IPHONE_6P) {
            notificationImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 12, 15, 16)];
        }
        notificationImage.image = [UIImage imageNamed:@"1bell_read.png"];
        [cell.contentView addSubview:notificationImage];

        UILabel * TitleLabel = [[UILabel alloc]  initWithFrame: CGRectMake(notificationImage.frame.origin.x+notificationImage.frame.size.width+15, 5, 200, 30)];
         TitleLabel.font = (IS_IPAD) ? [UIFont fontWithName:@"Roboto-Regular" size:17] : [UIFont fontWithName:@"Roboto-Regular" size:15];
        TitleLabel.font = (IS_IPAD_PRO_1366) ? [UIFont fontWithName:@"Roboto-Regular" size:22] : TitleLabel.font;
        TitleLabel.text= @"Notification Title";
        
        [cell.contentView addSubview:TitleLabel];
        
        UILabel * Description = [[UILabel alloc]  initWithFrame: CGRectMake(TitleLabel.frame.origin.x, TitleLabel.frame.origin.y+TitleLabel.frame.size.height, 250+450*IS_IPAD+50*IS_IPHONE_6+85*IS_IPHONE_6P+250*IS_IPAD_PRO_1366, 18)];
        Description.text= @"this si asd as dasdas dsdasd asdthis si asd as dasdas dsdasd asdthis si asd as dasdas dsdasd asd asdthis si asd as dasdas dsdasd asd asd asdthis si asd as dasdas dsdasd asd si asd as dasdas dsdasd asd asd asdthis si asd as dasdas dsdasd asd this si asd as dasdas dsdasd asdthis si asd as dasdas dsdasd asdthis si asd as dasdas dsdasd asd asdthis si asd as dasdas dsdasd asd asd asdthis si asd as dasdas dsdasd asd si asd as dasdas dsdasd asd asd asdthis si asd as dasdas dsdasd asd";
        Description.font = (IS_IPAD) ? [UIFont fontWithName:@"Roboto-Regular" size:15] : [UIFont fontWithName:@"Roboto-Regular" size:13];
        Description.font = (IS_IPAD_PRO_1366) ? [UIFont fontWithName:@"Roboto-Regular" size:19] : Description.font;
        [Description autosizeForWidth];
        [cell.contentView addSubview:Description];
        
        UILabel * DateDay = [[UILabel alloc]  initWithFrame: CGRectMake(Description.frame.origin.x, Description.frame.origin.y+Description.frame.size.height-5, 200, 40)];
        DateDay.text= @"Monday 12-04-2015";
        DateDay.font = (IS_IPAD) ? [UIFont fontWithName:@"Roboto-Regular" size:14] : [UIFont fontWithName:@"Roboto-Regular" size:12];
        DateDay.font = (IS_IPAD_PRO_1366) ? [UIFont fontWithName:@"Roboto-Regular" size:18] : DateDay.font;
        DateDay.textColor = [UIColor lightGrayColor];
        [cell.contentView addSubview:DateDay];
        
        UIImageView * dropDownImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-35, DateDay.frame.origin.y+10, 22, 12)];
        dropDownImage.image = [UIImage imageNamed:@"1collapse_icon.png"];
        [cell.contentView addSubview:dropDownImage];
        
        UILabel * partitionlabel = [[UILabel alloc]  initWithFrame: CGRectMake(notificationImage.frame.origin.x, DateDay.frame.origin.y+DateDay.frame.size.height-5, tableView.frame.size.width-2*notificationImage.frame.origin.x, 1)];
        partitionlabel.backgroundColor= [UIColor lightGrayColor];
        [cell.contentView addSubview:partitionlabel];
        
    }
    else{
        
        UIImageView * notificationImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 15, 18)];
        if (IS_IPHONE_6P) {
            notificationImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 12, 15, 16)];
            }
        notificationImage.image = [UIImage imageNamed:@"1bell_unread.png"];
        [cell.contentView addSubview:notificationImage];
        
        UILabel * TitleLabel = [[UILabel alloc]  initWithFrame: CGRectMake(notificationImage.frame.origin.x+notificationImage.frame.size.width+15, 5, 200, 30)];
        TitleLabel.font = (IS_IPAD) ? [UIFont fontWithName:@"Roboto-Regular" size:17] : [UIFont fontWithName:@"Roboto-Regular" size:15];
        TitleLabel.font = (IS_IPAD_PRO_1366) ? [UIFont fontWithName:@"Roboto-Regular" size:22] : TitleLabel.font;
        TitleLabel.text= @"Notification Title";
        [cell.contentView addSubview:TitleLabel];
        
        
        UILabel * Description = [[UILabel alloc]  initWithFrame: CGRectMake(TitleLabel.frame.origin.x, TitleLabel.frame.origin.y+TitleLabel.frame.size.height, 250+450*IS_IPAD+50*IS_IPHONE_6+85*IS_IPHONE_6P+250*IS_IPAD_PRO_1366, 65+20*IS_IPAD_PRO_1366)];
        Description.text= @"this si asd as dasdas dsdasd asdthis si asd as dasdas dsdasd asdthis si asd";
        Description.font = (IS_IPAD) ? [UIFont fontWithName:@"Roboto-Regular" size:15] : [UIFont fontWithName:@"Roboto-Regular" size:13];
        Description.font = (IS_IPAD_PRO_1366) ? [UIFont fontWithName:@"Roboto-Regular" size:19] : Description.font;
        int lines = [Description getNoOflines];
        if (lines == 1 || lines == 2 || lines == 3) {
            Description.frame = CGRectMake(Description.frame.origin.x, Description.frame.origin.y, Description.frame.size.width, 18);
            [Description autosizeForWidth];
        }else{
            Description.numberOfLines = 3;
        }
        if (IS_IPHONE_4_OR_LESS){
            if (lines == 1 || lines == 2 || lines == 3) {
                 Description.frame = CGRectMake(Description.frame.origin.x, Description.frame.origin.y, Description.frame.size.width, Description.frame.size.height);
            }else{
                Description.frame = CGRectMake(Description.frame.origin.x, Description.frame.origin.y-7, Description.frame.size.width, Description.frame.size.height);
            }
        }else if(IS_IPHONE_5){
             if (lines == 1 || lines == 2 || lines == 3) {
                  Description.frame = CGRectMake(Description.frame.origin.x, Description.frame.origin.y, Description.frame.size.width, Description.frame.size.height);
             }else{
                  Description.frame = CGRectMake(Description.frame.origin.x, Description.frame.origin.y-7, Description.frame.size.width, Description.frame.size.height);
             }
        }else if(IS_IPHONE_6){
            if (lines == 1 || lines == 2 || lines == 3) {
                Description.frame = CGRectMake(Description.frame.origin.x, Description.frame.origin.y, Description.frame.size.width, Description.frame.size.height);
            }else{
           Description.frame = CGRectMake(Description.frame.origin.x, Description.frame.origin.y-7, Description.frame.size.width, Description.frame.size.height);
            }
        }else if(IS_IPHONE_6P){
            if (lines == 1 || lines == 2 || lines == 3) {
                Description.frame = CGRectMake(Description.frame.origin.x, Description.frame.origin.y, Description.frame.size.width, Description.frame.size.height);
            }else{
            Description.frame = CGRectMake(Description.frame.origin.x, Description.frame.origin.y-7, Description.frame.size.width, Description.frame.size.height);
            }
        }else if(IS_IPAD){
            if (lines == 1 || lines == 2 || lines == 3) {
                Description.frame = CGRectMake(Description.frame.origin.x, Description.frame.origin.y, Description.frame.size.width, Description.frame.size.height);
            }else{
          Description.frame = CGRectMake(Description.frame.origin.x, Description.frame.origin.y-2, Description.frame.size.width, Description.frame.size.height);
            }
        }
        [cell.contentView addSubview:Description];
        
        
        UILabel * DateDay = [[UILabel alloc]  initWithFrame: CGRectMake(Description.frame.origin.x, Description.frame.origin.y+Description.frame.size.height-5, 200, 40)];
        DateDay.text= @"Monday 12-04-2015";
        DateDay.textColor = [UIColor lightGrayColor];
        DateDay.font = (IS_IPAD) ? [UIFont fontWithName:@"Roboto-Regular" size:14] : [UIFont fontWithName:@"Roboto-Regular" size:12];
        DateDay.font = (IS_IPAD_PRO_1366) ? [UIFont fontWithName:@"Roboto-Regular" size:18] : DateDay.font;
         if (IS_IPHONE_4_OR_LESS){
             if (lines == 1 || lines == 2 || lines == 3) {
                 DateDay.frame = CGRectMake(DateDay.frame.origin.x, DateDay.frame.origin.y, DateDay.frame.size.width, DateDay.frame.size.height);
             }else{
             DateDay.frame = CGRectMake(DateDay.frame.origin.x, DateDay.frame.origin.y-7, DateDay.frame.size.width, DateDay.frame.size.height);
             }
         }else if(IS_IPHONE_5){
             if (lines == 1 || lines == 2 || lines == 3) {
                 DateDay.frame = CGRectMake(DateDay.frame.origin.x, DateDay.frame.origin.y, DateDay.frame.size.width, DateDay.frame.size.height);
             }else{
           DateDay.frame = CGRectMake(DateDay.frame.origin.x, DateDay.frame.origin.y-7, DateDay.frame.size.width, DateDay.frame.size.height);
             }
         }else if(IS_IPHONE_6){
             if (lines == 1 || lines == 2 || lines == 3) {
                 DateDay.frame = CGRectMake(DateDay.frame.origin.x, DateDay.frame.origin.y, DateDay.frame.size.width, DateDay.frame.size.height);
             }else{
           DateDay.frame = CGRectMake(DateDay.frame.origin.x, DateDay.frame.origin.y-7, DateDay.frame.size.width, DateDay.frame.size.height);
             }
         }else if(IS_IPHONE_6P){
             if (lines == 1 || lines == 2 || lines == 3) {
                 DateDay.frame = CGRectMake(DateDay.frame.origin.x, DateDay.frame.origin.y, DateDay.frame.size.width, DateDay.frame.size.height);
             }else{
           DateDay.frame = CGRectMake(DateDay.frame.origin.x, DateDay.frame.origin.y-7, DateDay.frame.size.width, DateDay.frame.size.height);
             }
         }else if(IS_IPAD){
             DateDay.frame = CGRectMake(DateDay.frame.origin.x, DateDay.frame.origin.y-2, DateDay.frame.size.width, DateDay.frame.size.height);
         }
        [cell.contentView addSubview:DateDay];
        
        UIImageView * dropDownImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-35, DateDay.frame.origin.y+12, 22, 12)];
        dropDownImage.image = [UIImage imageNamed:@"1expand_icon.png"];
        [cell.contentView addSubview:dropDownImage];

        UILabel * partitionlabel = [[UILabel alloc]  initWithFrame: CGRectMake(notificationImage.frame.origin.x, DateDay.frame.origin.y+DateDay.frame.size.height-5, tableView.frame.size.width-2*notificationImage.frame.origin.x, 1)];
        if (IS_IPAD) {
            partitionlabel.frame = CGRectMake(partitionlabel.frame.origin.x, partitionlabel.frame.origin.y-2, partitionlabel.frame.size.width, partitionlabel.frame.size.height);
            if (IS_IPAD_PRO_1366) {
                 partitionlabel.frame = CGRectMake(partitionlabel.frame.origin.x, partitionlabel.frame.origin.y+3, partitionlabel.frame.size.width, partitionlabel.frame.size.height);
            }
        }
        partitionlabel.backgroundColor= [UIColor lightGrayColor];
        [cell.contentView addSubview:partitionlabel];
        
    }
    
    UIButton * DeleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    DeleteButton.frame = CGRectMake(self.view.frame.size.width-35, 10, 25, 25);
    [DeleteButton setImage:[UIImage imageNamed:@"1del_icon.png"] forState:UIControlStateNormal];
    [cell.contentView addSubview:DeleteButton];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    
        return  cell;
}
- (void)tableView:(UITableView *)atableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSMutableArray *modifiedRows = [NSMutableArray array];
    if ([indexPath isEqual:self.expandedIndexPath]) {
        [modifiedRows addObject:self.expandedIndexPath];
        self.expandedIndexPath = nil;
    } else {
        if (self.expandedIndexPath)
            [modifiedRows addObject:self.expandedIndexPath];
        
        self.expandedIndexPath = indexPath;
        [modifiedRows addObject:indexPath];
    }
    
    // This will animate updating the row sizes
    [tableView reloadRowsAtIndexPaths:modifiedRows withRowAnimation:UITableViewRowAnimationAutomatic];
    
    // Preserve the deselection animation (if desired)
    [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}
#pragma mark- Buttons

- (IBAction)btnBack:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnAboutApp:(id)sender {
    AboutAppViewController *aboutAppVC = [[AboutAppViewController alloc]initWithNibName:@"AboutAppViewController" bundle:nil];
    [self.navigationController pushViewController:aboutAppVC animated:YES];
}

- (IBAction)btnAutoAvesURL:(id)sender {
    NSString *urlStr = [NSString stringWithFormat:@"http://%@",btnAutoAvesURL.titleLabel.text];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
}

- (IBAction)btnLogOut:(id)sender {
    
    
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
    
    SBJsonParser *json = [[SBJsonParser alloc] init];
    NSMutableDictionary *userDetailDict=[json objectWithString:responseString error:&error];
    
    if([recieved_status isEqualToString:@"passed"])
    {
        if (webservice==3)
        {
            //[self.view makeToast:[NSString stringWithFormat:@"%@",responseString]];
            //            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"ARA" message:responseString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            //            [alert show];
            [kappDelegate HideIndicator];
            
            LoginViewController *LIvc = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
            [self.navigationController pushViewController:LIvc animated:YES];
            
            return;
        }

    }else {
    [HelperAlert  alertWithOneBtn:AlertTitle description:responseString okBtn:OkButtonTitle];
    }
}
@end
