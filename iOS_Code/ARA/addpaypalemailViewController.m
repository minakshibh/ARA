//
//  addpaypalemailViewController.m
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 08/09/15.
//  Copyright (c) 2015 Krishna_Mac_2. All rights reserved.
//

#import "addpaypalemailViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "ASIHTTPRequest.h"
#import "PaypalAccountsViewController.h"
#import "dashboardViewController.h"
#import "LoginViewController.h"
#import <FacebookSDK/FacebookSDK.h>
@interface addpaypalemailViewController ()

@end

@implementation addpaypalemailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    count_status =0;
    [self getpaymentmedia];
    
    lblDropdown.layer.cornerRadius = 5.0;
    lblDropdown.layer.borderWidth = 1.0;
    lblDropdown.layer.borderColor = [UIColor colorWithRed:144.0f/255.0f green:184.0f/255.0f blue:218.0f/255.0f alpha:1.0f].CGColor;
    [lblDropdown setClipsToBounds:YES];
    
    btnSavechanges.layer.cornerRadius = 7.0;
    [btnSavechanges setClipsToBounds:YES];
    
    lblemailback.layer.cornerRadius = 5.0;
    lblemailback.layer.borderWidth = 1.0;
    lblemailback.layer.borderColor = [UIColor colorWithRed:144.0f/255.0f green:184.0f/255.0f blue:218.0f/255.0f alpha:1.0f].CGColor;
    [lblemailback setClipsToBounds:YES];
    
    lblfirstnameback.layer.cornerRadius = 5.0;
    lblfirstnameback.layer.borderWidth = 1.0;
    lblfirstnameback.layer.borderColor = [UIColor colorWithRed:144.0f/255.0f green:184.0f/255.0f blue:218.0f/255.0f alpha:1.0f].CGColor;
    [lblfirstnameback setClipsToBounds:YES];

    
    lbllastnameback.layer.cornerRadius = 5.0;
    lbllastnameback.layer.borderWidth = 1.0;
    lbllastnameback.layer.borderColor = [UIColor colorWithRed:144.0f/255.0f green:184.0f/255.0f blue:218.0f/255.0f alpha:1.0f].CGColor;
    [lbllastnameback setClipsToBounds:YES];

    
    [txtEmail setValue:[UIColor colorWithRed:144.0f/255.0f green:184.0f/255.0f blue:218.0f/255.0f alpha:1.0f] forKeyPath:@"_placeholderLabel.textColor"];
    [txtDropDown setValue:[UIColor colorWithRed:144.0f/255.0f green:184.0f/255.0f blue:218.0f/255.0f alpha:1.0f] forKeyPath:@"_placeholderLabel.textColor"];
    [txtFirstName setValue:[UIColor colorWithRed:144.0f/255.0f green:184.0f/255.0f blue:218.0f/255.0f alpha:1.0f] forKeyPath:@"_placeholderLabel.textColor"];
    [txtLastName setValue:[UIColor colorWithRed:144.0f/255.0f green:184.0f/255.0f blue:218.0f/255.0f alpha:1.0f] forKeyPath:@"_placeholderLabel.textColor"];

    
    if (IS_IPAD)
    {
        lblheading.font=[lblheading .font fontWithSize:24];
        btnback.titleLabel.font = [btnback.titleLabel.font fontWithSize:24];
        txtEmail.font=[txtEmail .font fontWithSize:20];
        btnSavechanges.titleLabel.font = [btnSavechanges.titleLabel.font fontWithSize:24];
        btnCheckbox.titleLabel.font = [btnCheckbox.titleLabel.font fontWithSize:24];
        selectPaymentMode.titleLabel.font = [selectPaymentMode.titleLabel.font fontWithSize:24];
        txtDropDown.font=[txtEmail .font fontWithSize:20];
        
        if(IS_IPAD_PRO_1366)
        {
            lblheading.font=[lblheading .font fontWithSize:30];
            btnback.titleLabel.font = [btnback.titleLabel.font fontWithSize:30];
            txtEmail.font=[txtEmail .font fontWithSize:28];
            btnSavechanges.titleLabel.font = [btnSavechanges.titleLabel.font fontWithSize:30];
            btnCheckbox.titleLabel.font = [btnCheckbox.titleLabel.font fontWithSize:30];
            selectPaymentMode.titleLabel.font = [selectPaymentMode.titleLabel.font fontWithSize:30];
            txtDropDown.font=[txtEmail .font fontWithSize:28];
        }
    }
}
-(void)viewWillAppear:(BOOL)animated{
    if(self.paypalListCount > 0)
    {
        [btnCheckbox setImage:[UIImage imageNamed:@"checkbox-unchecked.png"] forState:UIControlStateNormal];
        status = false;
        btnCheckbox.userInteractionEnabled = YES;
    }

    if([_trigger isEqualToString:@"edit"])
    {
        if([_obj.IsDefault isEqualToString:@"1"])
        {
            btnCheckbox.userInteractionEnabled = NO;
        }
        
        NSString *fnameStr = [NSString stringWithFormat:@"%@",_obj.FirstName];
        NSString *lnameStr = [NSString stringWithFormat:@"%@",_obj.LastName];
        
        if (![fnameStr   isEqual: @"(null)"]) {
            txtFirstName.text = fnameStr;
        }
        if (![lnameStr  isEqual: @"(null)"]) {
            txtLastName.text = lnameStr;
        }
        
        txtEmail.text = _obj.PaypalEmail;
        emailview.hidden = NO;
        [selectPaymentMode setTitle:@"" forState:UIControlStateNormal];
        txtDropDown.text = _obj.PaymentModeName;
        
        if([_obj.IsDefault isEqualToString:@"1"] || self.paypalListCount == 0)
        {
            [btnCheckbox setImage:[UIImage imageNamed:@"checkbox-checked.png"] forState:UIControlStateNormal];
            status = true;
        }
    }
}
#pragma  mark - Buttons
- (IBAction)btnBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnSavechanges:(id)sender {
    NSString* emailstr = [txtEmail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString* firstNameStr = [txtFirstName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString* lastNameStr = [txtLastName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if([_trigger isEqualToString:@"edit"])
    {
        if (_email_array.count == 1)
        {
            //Email already exists in the list
            if ([emailstr isEqualToString:[_email_array objectAtIndex:0]]) {
                [HelperAlert alertWithOneBtn:AlertTitle description:@"The email you entered is already exist in Autoaves system Please Try with another email address" okBtn:OkButtonTitle];
                
                return;
            }
        }else{
            for (int l=0; l<_email_array.count; l++) {
                //Email already exists in the list
                if ([emailstr isEqualToString:[_email_array objectAtIndex:l]]) {
                    [HelperAlert alertWithOneBtn:AlertTitle description:@"The email you entered is already exist in Autoaves system Please Try with another email address" okBtn:OkButtonTitle];
                    
                    return;
                }
                if([_obj.PaypalEmail isEqualToString:[_email_array objectAtIndex:l]])
                {
                    continue;
                }
            }
        }
        
    }else{
        
        if(_email_array.count>0)
        {
            for (int l=0; l<_email_array.count; l++) {
                if ([emailstr isEqualToString:[_email_array objectAtIndex:l]]) {
                     [HelperAlert alertWithOneBtn:AlertTitle description:@"The email you entered is already exist in Autoaves system Please Try with another email address" okBtn:OkButtonTitle];
                   
                    return;
                }
            }
        }
    }
    if([txtFirstName isEmpty])
    {
        [HelperAlert alertWithOneBtn:AlertTitle description:@"Please enter first name" okBtn:OkButtonTitle];
        return;
    }else if([txtLastName isEmpty])
    {
        [HelperAlert alertWithOneBtn:AlertTitle description:@"Please enter last name" okBtn:OkButtonTitle];
        return;
    }
    
    
    
    if([txtEmail isEmpty])
    {
        [HelperAlert alertWithOneBtn:AlertTitle description:@"Please enter an email address" okBtn:OkButtonTitle];
        return;
    }else if (![self validateEmailWithString:emailstr]==YES) {
        [HelperAlert alertWithOneBtn:AlertTitle description:@"Please check your email address" okBtn:OkButtonTitle];

        [txtEmail becomeFirstResponder];
        return;
    }
    
    if([_trigger isEqualToString:@"edit"])
    {
    }else{
        
        if ([_obj.PaypalEmail isEqualToString:emailstr])
        {
            [HelperAlert alertWithOneBtn:AlertTitle description:@"Entered email is already in the list" okBtn:OkButtonTitle];

            
            [txtEmail becomeFirstResponder];
            return;
        }
    }
    
    [txtEmail resignFirstResponder];
    if(status==true)
    {
        value=@"true";
    }else{
        value=@"false";
    }
    
    [self verifyEmail:emailstr fName:firstNameStr lName:lastNameStr];
    
    
}
- (IBAction)btnCheckbox:(id)sender {
    
    //---toggle functionality of checkbox
    if (self.paypalListCount != 0) {
        
        if(status == true)
        {
            status = false;
            UIImage *btnImage = [UIImage imageNamed:@"checkbox-unchecked.png"];
            [btnCheckbox setImage:btnImage forState:UIControlStateNormal];
            return;
        }
        status = true;
        UIImage* btnImage = [UIImage imageNamed:@"checkbox-checked.png"];
        [btnCheckbox setImage:btnImage forState:UIControlStateNormal];
    }
}
#pragma  mark - Other Methods
-(void)viewWillDisappear:(BOOL)animated
{
    [btnCheckbox setImage:[UIImage imageNamed:@"checkbox-unchecked.png"] forState:UIControlStateNormal];
    status = false;
}
-(void)getpaymentmedia
{
    
    [kappDelegate ShowIndicator];
    webservice=3;
    NSMutableURLRequest *request ;
    NSString*_postData ;
  
    
        _postData = [NSString stringWithFormat:@""];
    
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/paymentmodes",Kwebservices]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
    
    [request addValue:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"UserToken"]] forHTTPHeaderField:@"token"];
    
    NSLog(@"data post >>> %@",_postData);
    
    [request setHTTPMethod:@"GET"];
    
    
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)selectPaymentMode:(id)sender {
    
     if (array_payment_name.count==1)
     {
         return;
     }
    
    
    
    
    if (status_dropdown == true)
    {
        tableView.hidden=YES;
        status_dropdown=false;
        return;
    }
    status_dropdown=true;
    
    tableView.hidden=NO;
    
    tableView.layer.borderColor = [UIColor grayColor].CGColor;
    tableView.layer.borderWidth = 1.0;
    tableView.layer.cornerRadius = 4.0;
    [tableView setClipsToBounds:YES];
    
    
    [tableView reloadData];
    if(array_payment_name.count==0)
    {
        tableView.hidden = YES;
    }
}

- (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
-(void)verifyEmail:email fName:(NSString*)fName lName:(NSString*)lName
{
    [kappDelegate ShowIndicator];
    NSMutableURLRequest *request ;
    NSString*_postData ;
    webservice=1;
// /*
//    //--sample email for testing @"parvbhaskar-facilitator@krishnais.com"
//     _postData = [NSString stringWithFormat:@"emailAddress=%@&matchCriteria=%@",email,@"NONE"];
//
// request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://svcs.sandbox.paypal.com/AdaptiveAccounts/GetVerifiedStatus"]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
// //NSString *responce= GetVerifiedStatus:@"dfdfdfdf" :@"":@"":@"";
// //customer and upcoming
// NSLog(@"data post >>> %@",_postData);
// 
// [request setHTTPMethod:@"POST"];
// [request addValue:@"jb-us-seller_api1.paypal.com" forHTTPHeaderField:@"X-PAYPAL-SECURITY-USERID"];
// [request addValue:@"WX4WTU3S8MY44S7F" forHTTPHeaderField:@"X-PAYPAL-SECURITY-PASSWORD"];
// [request addValue:@"AFcWxV21C7fd0v3bYYYRCpSSRl31A7yDhhsPUU2XhtMoZXsWHFxu-RWy" forHTTPHeaderField:@"X-PAYPAL-SECURITY-SIGNATURE"];
// [request addValue:@"APP-80W284485P519543T" forHTTPHeaderField:@"X-PAYPAL-APPLICATION-ID"];
// [request addValue:@"NV" forHTTPHeaderField:@"X-PAYPAL-REQUEST-DATA-FORMAT"];
// [request addValue:@"JSON" forHTTPHeaderField:@"X-PAYPAL-RESPONSE-DATA-FORMAT"];
// 
// [request setHTTPBody: [_postData dataUsingEncoding:NSUTF8StringEncoding]];
// NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
//   */
    //      NSLog(@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"userid"]);

    
    _postData = [NSString stringWithFormat:@"emailAddress=%@&firstName=%@&lastName=%@&matchCriteria=%@",email,fName,lName,@"NAME"];
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://svcs.paypal.com/AdaptiveAccounts/GetVerifiedStatus"]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
   
    NSLog(@"data post >>> %@",_postData);
    
    [request setHTTPMethod:@"POST"];
    [request addValue:@"Robert.Seeley_api1.autoaves.com" forHTTPHeaderField:@"X-PAYPAL-SECURITY-USERID"];
    [request addValue:@"2VHLF2W76S5R9GXV" forHTTPHeaderField:@"X-PAYPAL-SECURITY-PASSWORD"];
    [request addValue:@"AnWfP5X33cXzORYDXlcKLQpjJFuNAtiPGLTpiIpibiF7xaYk5k6irjfB" forHTTPHeaderField:@"X-PAYPAL-SECURITY-SIGNATURE"];
    [request addValue:@"APP-5MK05104KD7930901" forHTTPHeaderField:@"X-PAYPAL-APPLICATION-ID"];
    [request addValue:@"NV" forHTTPHeaderField:@"X-PAYPAL-REQUEST-DATA-FORMAT"];
    [request addValue:@"JSON" forHTTPHeaderField:@"X-PAYPAL-RESPONSE-DATA-FORMAT"];
    
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
-(void)editwebservice
{
    NSString* emailstr = [txtEmail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString* firstNameStr = [txtFirstName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString* lastNameStr = [txtLastName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    
    
    [kappDelegate ShowIndicator];
    webservice=2;
    NSMutableURLRequest *request ;
    NSString*_postData ;
    NSString * userid =  [[NSUserDefaults standardUserDefaults]valueForKey:@"l_userid"];
    if([_trigger isEqualToString:@"edit"])
    {
    _postData = [NSString stringWithFormat:@"PaymentAccountInfoId=%@&UserId=%@&IsDefault=%@&PaymentModeID=%@&PaypalEmail=%@&FirstName=%@&LastName=%@",_obj.PaymentAccountInfoId,userid,value,_obj.PaymentModeID,emailstr,firstNameStr,lastNameStr];
    }
    if([_trigger isEqualToString:@"add"])
    {
         _postData = [NSString stringWithFormat:@"UserId=%@&IsDefault=%@&PaymentModeID=%@&PaypalEmail=%@&FirstName=%@&LastName=%@",userid,value,selected_id,emailstr,firstNameStr,lastNameStr];
    }
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/paymentaccountinfo",Kwebservices]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
    
    [request addValue:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"UserToken"]] forHTTPHeaderField:@"token"];
    
    NSLog(@"data post >>> %@",_postData);
    
    [request setHTTPMethod:@"POST"];
    
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


#pragma mark - textView Delegates
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [scrollView setContentOffset:CGPointMake(0, -20) animated:YES];
    
    [textField resignFirstResponder];
    scrollView.scrollEnabled = YES;
    
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    scrollView.scrollEnabled = YES;
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(350, 700);
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    scrollView.scrollEnabled = NO;
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    tableView.hidden = YES;
    svos = scrollView.contentOffset;
    scrollView.scrollEnabled = YES;
    
            if( textField == txtEmail ) {
            
            CGPoint pt;
            CGRect rc = [textField bounds];
            rc = [textField convertRect:rc toView:scrollView];
            pt = rc.origin;
            pt.x = 0;
            pt.y -=150;
            [scrollView setContentOffset:pt animated:YES];
        }
    
}
#pragma mark - Connection Delegates

-(NSInteger)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
    NSLog(@"response status code: %ld", (long)[httpResponse statusCode]);
    if(webservice==1)
    {
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
    }
    if(webservice==2)
    {
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
    }
    if(webservice==3)
    {
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
    [scrollView setContentOffset:CGPointMake(0, -20) animated:YES];
    [kappDelegate HideIndicator];
    
    NSLog(@"DONE. Received Bytes: %lu", (unsigned long)[webData length]);
    
    if ([webData length]==0)
        return;
    
    NSString *responseString = [[NSString alloc] initWithData:webData encoding:NSUTF8StringEncoding];
    NSLog(@"responseString:%@",responseString);
    NSError *error;

    SBJsonParser *json = [[SBJsonParser alloc] init];
    NSMutableDictionary *userDetailDict=[json objectWithString:responseString error:&error];
    
    if(webservice==1)
    {
        if([response_status isEqualToString:@"passed"])
        {
            NSString *acount_status = [userDetailDict valueForKey:@"accountStatus"];
    
            if([acount_status isEqualToString:@"VERIFIED"])
            {
                [self editwebservice];
                return;
            }
            if([acount_status isEqualToString:@"UNVERIFIED"])
            {
                [HelperAlert  alertWithOneBtn:AlertTitle description:@"This email is not a valid paypal email" okBtn:OkButtonTitle];

                
                return;
            }
            if([acount_status isEqualToString:@"UNVERIFIED"])
            {
                [HelperAlert  alertWithOneBtn:AlertTitle description:@"This email is not a valid paypal email" okBtn:OkButtonTitle];
                
                
                return;
            }
            NSArray *data = [userDetailDict valueForKey:@"responseEnvelope"];
            NSString *response = [data valueForKey:@"ack"];
    
            if ([response isEqualToString:@"Failure"])
            {
                [HelperAlert  alertWithOneBtn:AlertTitle description:@"This email is not a valid paypal email" okBtn:OkButtonTitle];
            
                return;
            }
        }
        else
        {
            [HelperAlert  alertWithOneBtn:AlertTitle description:responseString okBtn:OkButtonTitle];
        }
    }
    else if(webservice==2)
    {
        if([response_status isEqualToString:@"passed"])
        {
            [self.navigationController popViewControllerAnimated:YES];
            
            return;
        }
        else
        {
            [HelperAlert  alertWithOneBtn:AlertTitle description:responseString okBtn:OkButtonTitle];

            return;
            }
    }else if(webservice==3)
    {
        if([response_status isEqualToString:@"passed"])
        {
            array_payment_id = [userDetailDict valueForKey:@"ID"];
            array_payment_name = [userDetailDict valueForKey:@"Name"];
            
            
            if (array_payment_name.count==1) {
                imageDropDownIcon.hidden = YES;
                txtDropDown.text = [array_payment_name objectAtIndex:0];
                [selectPaymentMode setTitle:@"" forState:UIControlStateNormal];
                selected_id = [NSString stringWithFormat:@"%@",[array_payment_id objectAtIndex:0]];
                emailview.hidden = NO;
                tableView.hidden = YES;
                if(self.paypalListCount == 0)
                {
                    [btnCheckbox setImage:[UIImage imageNamed:@"checkbox-checked.png"] forState:UIControlStateNormal];
                    status = true;
                    btnCheckbox.userInteractionEnabled = NO;
                }
            }
          //  [tableView reloadData];
        }else{
            
            if ([responseString rangeOfString:@"Invalid token provided" options:NSCaseInsensitiveSearch].location != NSNotFound)
            {
                UIAlertController *alert= [UIAlertController
                                           alertControllerWithTitle:@"Error"
                                           message:@"Your session has expired. Please log in again."
                                           preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* ok = [UIAlertAction actionWithTitle:@"Log in" style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * action){
                                                               //Do Some action here
                                                               
            dashboardViewController *dashBoardVC = [[dashboardViewController alloc]init];
                                                               
                    [dashBoardVC logoutFunction];
            if([[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"user_logout"]] isEqualToString:@"yes"]  ){
                    LoginViewController* loginVC = [[LoginViewController alloc]init];
                            [self.navigationController pushViewController:loginVC animated:YES];
                    }else{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"AutoAves" message:@"Not able to  logout. Try again" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                    [alert show];

                                                               }
                                                           }];
                UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                               handler:^(UIAlertAction * action) {
                                                                   
                                                                   NSLog(@"cancel btn");
                                                                   
                                                                   [alert dismissViewControllerAnimated:YES completion:nil];
                                                                   
                                                               }];
                
                [alert addAction:ok];
                [alert addAction:cancel];
                
                
                [self presentViewController:alert animated:YES completion:nil];
            }else if (webservice==7)
            {
                //[self.view makeToast:[NSString stringWithFormat:@"%@",responseString]];
                //            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"AutoAves" message:responseString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                //            [alert show];
                [kappDelegate HideIndicator];
                if (count_status==0) {
                    [[NSUserDefaults standardUserDefaults]setObject:@"yes" forKey:@"user_logout"];
                    LoginViewController *LIvc = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
                    [self.navigationController pushViewController:LIvc animated:YES];
//                    NSLog(@"-----webservice------");
                    count_status++;
                }
                
                return;
            }else{
            
            [HelperAlert  alertWithOneBtn:AlertTitle description:responseString okBtn:OkButtonTitle];

            }
        }
    }
    [kappDelegate HideIndicator];

}

#pragma mark - tableview Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{   [scrollView setContentOffset:CGPointMake(0, -20) animated:YES];
    [txtEmail resignFirstResponder];
    
    if(array_payment_name.count<=3 && array_payment_name.count>0)
    {
        CGRect frame = tableView.frame;
        frame.size.height = 35*array_payment_name.count;
        tableView.frame=frame;
    }
    return array_payment_name.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 35;
    
}
- (UITableViewCell *)tableView:(UITableView *)atableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    static NSString *CellIdentifier = @"Cell";
    
   cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [array_payment_name objectAtIndex:indexPath.row];
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    return cell;
}
- (void)tableView:(UITableView *)atableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    txtDropDown.text = [array_payment_name objectAtIndex:indexPath.row];
    [selectPaymentMode setTitle:@"" forState:UIControlStateNormal];
    selected_id = [NSString stringWithFormat:@"%@",[array_payment_id objectAtIndex:indexPath.row]];
    emailview.hidden = NO;
    tableView.hidden = YES;
    if(self.paypalListCount == 0)
    {
        [btnCheckbox setImage:[UIImage imageNamed:@"checkbox-checked.png"] forState:UIControlStateNormal];
        status = true;
        btnCheckbox.userInteractionEnabled = NO;
    }
}
-(void)logoutFunction{
    dispatch_async(dispatch_get_main_queue(), ^{
        dashboardViewController *dashVC = [[dashboardViewController alloc]init];
        [dashVC.timerDashboard invalidate];
    });
    
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
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"profile_picture"];
        
        
        
        
    }
}
-(void)logout
{
    [kappDelegate ShowIndicator];
    webservice=7;
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
@end
