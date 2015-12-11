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

@interface addpaypalemailViewController ()

@end

@implementation addpaypalemailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getpaymentmedia];
    
    lblDropdown.layer.borderColor = [UIColor grayColor].CGColor;
    lblDropdown.layer.borderWidth = 1.0;
    lblDropdown.layer.cornerRadius = 4.0;
    [lblDropdown setClipsToBounds:YES];
    
    btnSavechanges.layer.borderColor = [UIColor grayColor].CGColor;
    btnSavechanges.layer.borderWidth = 1.0;
    btnSavechanges.layer.cornerRadius = 4.0;
    [btnSavechanges setClipsToBounds:YES];
    
    lblemailback.layer.borderColor = [UIColor grayColor].CGColor;
    lblemailback.layer.borderWidth = 1.0;
    lblemailback.layer.cornerRadius = 4.0;
    [lblemailback setClipsToBounds:YES];
    
    
    int d = 0; // standard display
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2.0) {
        d = 1; // is retina display
    }
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        d += 2;
    }
    
    if (d==0) {
        imagelogo.image = [UIImage imageNamed:@"inner-logo_320.png"];
    }
    if (d==1) {
        imagelogo.image = [UIImage imageNamed:@"inner-logo_480.png"];
    }
    if (d==2) {
        imagelogo.image = [UIImage imageNamed:@"inner-logo_600.png"];
    }
    if (d==3) {
        imagelogo.image = [UIImage imageNamed:@"inner-logo_640.png"];
    }

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
    
    
    if (IS_IPAD)
    {
        lblheading.font=[lblheading .font fontWithSize:24];
        btnback.titleLabel.font = [btnback.titleLabel.font fontWithSize:24];
        txtEmail.font=[txtEmail .font fontWithSize:24];
        btnSavechanges.titleLabel.font = [btnSavechanges.titleLabel.font fontWithSize:24];
        btnCheckbox.titleLabel.font = [btnCheckbox.titleLabel.font fontWithSize:24];
        selectPaymentMode.titleLabel.font = [selectPaymentMode.titleLabel.font fontWithSize:24];
        txtDropDown.font=[txtEmail .font fontWithSize:24];
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
    
    if([_trigger isEqualToString:@"edit"])
    {
        for (int l=0; l<_email_array.count; l++) {
            
            if([_obj.PaypalEmail isEqualToString:[_email_array objectAtIndex:l]])
            {
                continue;
            }
            if ([emailstr isEqualToString:[_email_array objectAtIndex:l]]) {
                [HelperAlert alertWithOneBtn:AlertTitle description:@"Email already exists in the list" okBtn:OkButtonTitle];
              
                return;
            }
        }
        
    }else{
        
        if(_email_array.count>0)
        {
            for (int l=0; l<_email_array.count; l++) {
                if ([emailstr isEqualToString:[_email_array objectAtIndex:l]]) {
                     [HelperAlert alertWithOneBtn:AlertTitle description:@"Email already exists in the list" okBtn:OkButtonTitle];
                   
                    return;
                }
            }
        }
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
    
    [self verifyEmail:emailstr];
    
    
    
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
   // NSString * userid =  [[NSUserDefaults standardUserDefaults]valueForKey:@"l_userid"];
    
        _postData = [NSString stringWithFormat:@""];
    
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/paymentmodes",Kwebservices]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
    
    [request addValue:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"UserToken"]] forHTTPHeaderField:@"token"];
    
    NSLog(@"data post >>> %@",_postData);
    
    [request setHTTPMethod:@"GET"];
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
-(void)verifyEmail:email
{
    [kappDelegate ShowIndicator];
    NSMutableURLRequest *request ;
    NSString*_postData ;
    webservice=1;

    //      NSLog(@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"userid"]);
    //--sample email for testing @"parvbhaskar-facilitator@krishnais.com"
    
    _postData = [NSString stringWithFormat:@"emailAddress=%@&matchCriteria=%@",email,@"NONE"];
    
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://svcs.sandbox.paypal.com/AdaptiveAccounts/GetVerifiedStatus"]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
    //NSString *responce= GetVerifiedStatus:@"dfdfdfdf" :@"":@"":@"";
    //customer and upcoming
    NSLog(@"data post >>> %@",_postData);
    
    [request setHTTPMethod:@"POST"];
    [request addValue:@"jb-us-seller_api1.paypal.com" forHTTPHeaderField:@"X-PAYPAL-SECURITY-USERID"];
    [request addValue:@"WX4WTU3S8MY44S7F" forHTTPHeaderField:@"X-PAYPAL-SECURITY-PASSWORD"];
    [request addValue:@"AFcWxV21C7fd0v3bYYYRCpSSRl31A7yDhhsPUU2XhtMoZXsWHFxu-RWy" forHTTPHeaderField:@"X-PAYPAL-SECURITY-SIGNATURE"];
    [request addValue:@"APP-80W284485P519543T" forHTTPHeaderField:@"X-PAYPAL-APPLICATION-ID"];
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
    [kappDelegate ShowIndicator];
    webservice=2;
    NSMutableURLRequest *request ;
    NSString*_postData ;
    NSString * userid =  [[NSUserDefaults standardUserDefaults]valueForKey:@"l_userid"];
    if([_trigger isEqualToString:@"edit"])
    {
    _postData = [NSString stringWithFormat:@"PaymentAccountInfoId=%@&UserId=%@&IsDefault=%@&PaymentModeID=%@&PaypalEmail=%@",_obj.PaymentAccountInfoId,userid,value,_obj.PaymentModeID,txtEmail.text];
    }
    if([_trigger isEqualToString:@"add"])
    {
         _postData = [NSString stringWithFormat:@"UserId=%@&IsDefault=%@&PaymentModeID=%@&PaypalEmail=%@",userid,value,selected_id,txtEmail.text];
    }
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/paymentaccountinfo",Kwebservices]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
    
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


#pragma mark - textView Delegates
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [scrollView setContentOffset:CGPointMake(0, -20) animated:YES];
    
    [textField resignFirstResponder];
    scrollView.scrollEnabled = YES;
    
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
            NSArray *data = [userDetailDict valueForKey:@"responseEnvelope"];
            NSString *response = [data valueForKey:@"ack"];
    
            if ([response isEqualToString:@"Failure"]) {
                [HelperAlert  alertWithOneBtn:AlertTitle description:@"This email is not a valid paypal email" okBtn:OkButtonTitle];

               
            return;
            }
        }else{
            [HelperAlert  alertWithOneBtn:AlertTitle description:responseString okBtn:OkButtonTitle];

            

        }
    }else if(webservice==2)
    {
        if([response_status isEqualToString:@"passed"])
        {
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }else{
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
            [HelperAlert  alertWithOneBtn:AlertTitle description:responseString okBtn:OkButtonTitle];

           
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
    
//    [txtEmail resignFirstResponder];
//    [txtFirstName resignFirstResponder];
//    [txtLastName resignFirstResponder];
//    //[txtMEA resignFirstResponder];
//    [txtPassword resignFirstResponder];
//    [txtPhoneNo resignFirstResponder];
//    [txtPreviousCoustomer resignFirstResponder];
//    [txtUserId resignFirstResponder];
//    [scrollView setContentOffset:CGPointMake(0, -20) animated:YES];
//    scrollView.scrollEnabled = YES;
    
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
@end
