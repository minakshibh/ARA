//
//  PaypalAccountsViewController.m
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 18/08/15.
//  Copyright (c) 2015 Krishna_Mac_2. All rights reserved.
//

#import "PaypalAccountsViewController.h"
#import "PaypalAccountsTableViewCell.h"
#import "JSON.h"
#import "SBJson.h"
#import "AFHTTPRequestOperationManager.h"
#import "ASIHTTPRequest.h"
#import "paypalObj.h"
#import "addpaypalemailViewController.h"
//#import "UIView+Toast.h"

@interface PaypalAccountsViewController ()
{
    NSMutableArray *paypalListArray;
    paypalObj *obj;
}
@end

@implementation PaypalAccountsViewController

- (void)viewDidLoad {
    
    count=0;
    
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    int c = 0; // standard display
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2.0) {
        c = 1; // is retina display
    }
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        c += 2;
    }
    
    if (c==0) {
        headerImage.image = [UIImage imageNamed:@"320X480.png"];
    }
    if (c==1) {
        headerImage.image = [UIImage imageNamed:@"320X568.png"];
    }
    if (c==2) {
        headerImage.image = [UIImage imageNamed:@"480X800.png"];
    }
    if (c==3) {
        headerImage.image = [UIImage imageNamed:@"640X1136.png"];
    }
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        btnheading.font=[btnheading.font fontWithSize:24];
        btnback.titleLabel.font = [btnback.titleLabel.font fontWithSize:24];
        btnAdd.titleLabel.font = [btnback.titleLabel.font fontWithSize:24];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)viewWillAppear:(BOOL)animated    
{
    [self getlist];
}


-(void)getlist
{
    // [self.view makeToast:@"Fetching data..."];
    if (count==0) {
        [kappDelegate ShowIndicator];
        count++;
    }

    
    webservice=1;
    NSMutableURLRequest *request ;
    NSString*_postData ;
    NSString * userid =  [[NSUserDefaults standardUserDefaults]valueForKey:@"l_userid"];
    
    _postData = [NSString stringWithFormat:@""];
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/paymentaccountinfo/%@",Kwebservices,userid]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
    
    
    
    NSLog(@"data post >>> %@",_postData);
    
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
-(void)deleateData:(NSString*)accountInfo
{
    
    [kappDelegate ShowIndicator];
    webservice=2;
    NSMutableURLRequest *request ;
    NSString*_postData ;
    NSString * userid =  [[NSUserDefaults standardUserDefaults]valueForKey:@"l_userid"];
    
    _postData = [NSString stringWithFormat:@"PaymentAccountInfoId=%@&UserId=%@",accountInfo,userid];
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/paymentaccountinfo/delete",Kwebservices]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
    
    NSLog(@"data post >>> %@",_postData);
    
    [request setHTTPMethod:@"POST"];
    //    [request addValue:email forHTTPHeaderField:@"username"];
    //    [request addValue:password forHTTPHeaderField:@"userpassword"];
    
    
    [request setHTTPBody: [_postData dataUsingEncoding:NSUTF8StringEncoding]];
     [request addValue:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"UserToken"]] forHTTPHeaderField:@"token"];
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
#pragma mark - tableview Delegates
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return paypalListArray.count;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
    }
    
}
-(NSArray *)tableView:(UITableView *)atableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Edit" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        
        addpaypalemailViewController *APvc = [[addpaypalemailViewController alloc]initWithNibName:@"addpaypalemailViewController" bundle:nil];
        obj = [[paypalObj alloc]init];
        obj = [paypalListArray objectAtIndex:indexPath.row];
        APvc.obj = obj;
        APvc.trigger = @"edit";
        APvc.email_array = email_array;
        APvc.paypalListCount = (int)paypalListArray.count ;
        [self.navigationController pushViewController:APvc animated:YES];

        
    }];
    editAction.backgroundColor = [UIColor colorWithRed:105.0f/255.0f green:210.0f/255.0f blue:109.0f/255.0f alpha:1.0f];
    
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Delete"  handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
    {
        
        obj = [[paypalObj alloc]init];
        obj = [paypalListArray objectAtIndex: indexPath.row];
        
        if([obj.IsDefault integerValue] ==1)
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"This account cannot be deleted" message:@"This payment account has been set as 'Default' so it cannot be deleted. Set some other account as 'Default' in order to continue." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
            alert.tag = 11;
            [alert show];

        }else{
        
        
            if(paypalListArray.count==1)
            {
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Delete this account." message:@"You wont be able to recieve any payment. Are you sure you want to continue.." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [alert show];
                alert.tag = 10;
                [alert show];
                
            }else{
        
        
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Delete this account." message:@"Are you sure?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes", nil];
            alert.tag = 10;
            [alert show];

            }
        
        }
    }];
     deleteAction.backgroundColor = [UIColor colorWithRed:224.0f/255.0f green:80.0f/255.0f blue:85.0f/255.0f alpha:1.0f];
    return @[deleteAction,editAction];
}
- (UITableViewCell *)tableView:(UITableView *)atableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"ArticleCellID";
    
    PaypalAccountsTableViewCell *cell = (PaypalAccountsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PaypalAccountsTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
   
    obj = [[paypalObj alloc]init];
    obj = [paypalListArray objectAtIndex:indexPath.row];
    
    [cell setLabelText:obj.PaymentModeName :obj.PaypalEmail :obj.IsDefault];

    
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    return cell;
}
- (void)tableView:(UITableView *)atableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    obj = [[paypalObj alloc]init];
    obj = [paypalListArray objectAtIndex:indexPath.row];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if([obj.IsDefault isEqualToString:@"1"])
    {
//        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"ARA" message:@"This email is already a default email address" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//        [alert show];
        return;
    }
    if([obj.IsDefault isEqualToString:@"0"])
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Set As Default" message:@"Are you sure?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
        alert.tag=8;
        [alert show];

    }
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex              {
    if(alertView.tag==8){
        
        if(buttonIndex == 0)//OK button pressed
        {
            
        }
        else if(buttonIndex == 1)//Annul button pressed.
        {
            [self makeasDefault:obj];
            return;
        }
    }
    if(alertView.tag==10){
        
        if(buttonIndex == 0)//OK button pressed
        {
            
        }
        else if(buttonIndex == 1)//Annul button pressed.
        {
            [self deleateData:obj.PaymentAccountInfoId];
            return;
        }
    }
     if(alertView.tag==11){
         [tableView reloadData];
     }
}
-(void)makeasDefault:(paypalObj*)obj1
{
    [kappDelegate ShowIndicator];
    webservice=3;
    NSMutableURLRequest *request ;
    NSString*_postData ;
     NSString * userid =  [[NSUserDefaults standardUserDefaults]valueForKey:@"l_userid"];
    
    _postData = [NSString stringWithFormat:@"UserId=%@&PaymentAccountInfoId=%@&IsDefault=%@",userid,obj1.PaymentAccountInfoId,@"true"];
    
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/paymentaccountinfo/mark",Kwebservices]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
    
    [request addValue:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"UserToken"]] forHTTPHeaderField:@"token"];
    
    NSLog(@"data post >>> %@",_postData);
    
    [request setHTTPMethod:@"POST"];
    //    [request addValue:email forHTTPHeaderField:@"username"];
    //    [request addValue:password forHTTPHeaderField:@"userpassword"];
    
    
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
- (IBAction)btnAdd:(id)sender {
    addpaypalemailViewController *apVC = [[addpaypalemailViewController alloc]initWithNibName:@"addpaypalemailViewController" bundle:nil];
    apVC.trigger = @"add";
    apVC.email_array = email_array;
    apVC.paypalListCount = (int)paypalListArray.count;
    [self.navigationController pushViewController:apVC animated:YES];
}

- (IBAction)btnBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnEdit:(id)sender {
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
            result_status = @"passed";
            return  [httpResponse statusCode];

        }else if ((long)[httpResponse statusCode] == ResultFailed)
        {
            result_status = @"failed";
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
//    if([status isEqualToString:@"failed"])
//    {
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"ARA" message:responseString delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//        [alert show];
//        return;
//    }
    
    SBJsonParser *json = [[SBJsonParser alloc] init];
    NSMutableDictionary *userDetailDict=[json objectWithString:responseString error:&error];
    
    if(webservice==1){
        if([result_status isEqualToString:@"passed"])
        {
            if(userDetailDict.count==0)
            {
               // [self.view makeToast:@"No email is added yet. Kindly add an email."];
//                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"ARA" message:@"" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//                [alert show];
                return;
            }
            paypalListArray = [[NSMutableArray alloc] init];
            for (int i=0; i<userDetailDict.count; i++)
            {
                obj = [[paypalObj alloc]init];
                NSString *CreatedDate = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"CreatedDate"] objectAtIndex:i]];
                obj.CreatedDate = CreatedDate;
                NSString *IsDefault = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"IsDefault"] objectAtIndex:i]];
                obj.IsDefault = IsDefault;
                NSString *PaymentAccountInfoId = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"PaymentAccountInfoId"] objectAtIndex:i]];
                obj.PaymentAccountInfoId = PaymentAccountInfoId;
                NSString *PaymentModeID = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"PaymentModeID"] objectAtIndex:i]];
                obj.PaymentModeID=PaymentModeID;
                NSString *PaymentModeName = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"PaymentModeName"] objectAtIndex:i]];
                obj.PaymentModeName=PaymentModeName;
                NSString *PaypalEmail = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"PaypalEmail"] objectAtIndex:i]];
                obj.PaypalEmail=PaypalEmail;
                NSString *UserId = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"UserId"] objectAtIndex:i]];
                obj.UserId = UserId;
                [paypalListArray addObject:obj];
            }
            email_array = [[NSArray alloc]init];
            email_array = [userDetailDict valueForKey:@"PaypalEmail"];
            [tableView reloadData];
        }else{
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"ARA" message:responseString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            
        }

    }else if (webservice==2)
    {
        if([result_status isEqualToString:@"passed"])
        {
            email_array = [[NSArray alloc]init];
            email_array = [userDetailDict valueForKey:@"PaypalEmail"];
            
            paypalListArray = [[NSMutableArray alloc] init];
            for (int i=0; i<userDetailDict.count; i++)
            {
                obj = [[paypalObj alloc]init];
                NSString *CreatedDate = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"CreatedDate"] objectAtIndex:i]];
                obj.CreatedDate = CreatedDate;
                NSString *IsDefault = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"IsDefault"] objectAtIndex:i]];
                obj.IsDefault = IsDefault;
                NSString *PaymentAccountInfoId = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"PaymentAccountInfoId"] objectAtIndex:i]];
                obj.PaymentAccountInfoId = PaymentAccountInfoId;
                NSString *PaymentModeID = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"PaymentModeID"] objectAtIndex:i]];
                obj.PaymentModeID=PaymentModeID;
                NSString *PaymentModeName = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"PaymentModeName"] objectAtIndex:i]];
                obj.PaymentModeName=PaymentModeName;
                NSString *PaypalEmail = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"PaypalEmail"] objectAtIndex:i]];
                obj.PaypalEmail=PaypalEmail;
                NSString *UserId = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"UserId"] objectAtIndex:i]];
                obj.UserId = UserId;
                [paypalListArray addObject:obj];
            }
            
            [tableView reloadData];
        }else{
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"ARA" message:responseString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            
        }

    }else if (webservice==3)
    {
        if([result_status isEqualToString:@"passed"])
        {
            paypalListArray = [[NSMutableArray alloc] init];
            for (int i=0; i<userDetailDict.count; i++)
            {
                obj = [[paypalObj alloc]init];
                NSString *CreatedDate = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"CreatedDate"] objectAtIndex:i]];
                obj.CreatedDate = CreatedDate;
                NSString *IsDefault = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"IsDefault"] objectAtIndex:i]];
                obj.IsDefault = IsDefault;
                NSString *PaymentAccountInfoId = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"PaymentAccountInfoId"] objectAtIndex:i]];
                obj.PaymentAccountInfoId = PaymentAccountInfoId;
                NSString *PaymentModeID = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"PaymentModeID"] objectAtIndex:i]];
                obj.PaymentModeID=PaymentModeID;
                NSString *PaymentModeName = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"PaymentModeName"] objectAtIndex:i]];
                obj.PaymentModeName=PaymentModeName;
                NSString *PaypalEmail = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"PaypalEmail"] objectAtIndex:i]];
                obj.PaypalEmail=PaypalEmail;
                NSString *UserId = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"UserId"] objectAtIndex:i]];
                obj.UserId = UserId;
                [paypalListArray addObject:obj];
            }
            [tableView reloadData];
        }else{
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"ARA" message:responseString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];

        }
    }
}
@end
