//
//  SubmitReferralViewController.m
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 12/08/15.
//  Copyright (c) 2015 Krishna_Mac_2. All rights reserved.
//

#import "SubmitReferralViewController.h"
#import <AddressBook/AddressBook.h>
#import "JSON.h"
#import "SBJson.h"
#import "ASIHTTPRequest.h"
#import "dashboardViewController.h"
//#import "UIView+Toast.h"

@interface SubmitReferralViewController ()
{
    ABPeoplePickerNavigationController *picker;
    UIActivityIndicatorView *activityIndicatorObject1;
}
@end

@implementation SubmitReferralViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    email_checked = @"no";
    
    activityIndicatorObject1 = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
       picker = [[ABPeoplePickerNavigationController alloc] init];
    
    
    //--hide navigation bar
    //--hide navigation bar
   [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    
    
    lblComments.layer.cornerRadius = 2.0;
    [lblComments setClipsToBounds:YES];
    
    lblEmail.layer.cornerRadius = 2.0;
    [lblEmail setClipsToBounds:YES];
    
    lblFirstname.layer.cornerRadius = 2.0;
    [lblFirstname setClipsToBounds:YES];
    
    lblLastname.layer.cornerRadius = 2.0;
    [lblLastname setClipsToBounds:YES];
    
    lblMEA.layer.cornerRadius = 2.0;
    [lblMEA setClipsToBounds:YES];
    
    lblPhoneno.layer.cornerRadius = 2.0;
    [lblPhoneno setClipsToBounds:YES];
    
    btnSubmitReferral.layer.cornerRadius = 2.0;
    [btnSubmitReferral setClipsToBounds:YES];
    
    btnImportContacts.layer.cornerRadius = 2.0;
    [btnImportContacts setClipsToBounds:YES];
    NSString *role_name = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"l_roleName"]];
    
    if([role_name isEqualToString:@"AAI - MEA"])
    {
        NSString *first = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"l_firstName"]];
        NSString *last = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"l_lastName"]];
        
        txtmea.text =[NSString stringWithFormat:@"%@ %@",first,last];
        [btnMEA setTitle:@"" forState:UIControlStateNormal];
    }else{
        NSString *compare =[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"l_meaName"]];
        txtmea.text =compare;
        [btnMEA setTitle:@"" forState:UIControlStateNormal];
    }
    
    [self getMEA];
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbar sizeToFit];
    txtPhoneno.inputAccessoryView = numberToolbar;
    
    
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
        lblheading.font = [lblheading.font fontWithSize:24];
        btnback.titleLabel.font = [btnback.titleLabel.font fontWithSize:24];
        btnImportContacts.titleLabel.font = [btnImportContacts.titleLabel.font fontWithSize:24];
        btnSubmitReferral.titleLabel.font = [btnSubmitReferral.titleLabel.font fontWithSize:24];
        txtFirstname.font = [txtFirstname.font fontWithSize:24];
        txtLastname.font = [txtLastname.font fontWithSize:24];
        txtPhoneno.font = [txtPhoneno.font fontWithSize:24];
        txtEmail.font = [txtEmail.font fontWithSize:24];
        txtmea.font = [txtmea.font fontWithSize:24];
        txtComment.font = [txtComment.font fontWithSize:24];
        
    }
}
-(void)cancelNumberPad{
    [txtPhoneno resignFirstResponder];
    txtPhoneno.text = @"";
    [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    scrollView.scrollEnabled = YES;
}

-(void)doneWithNumberPad{
    [txtEmail becomeFirstResponder];
    
}
-(void)viewWillAppear:(BOOL)animated

{
    [[UIApplication sharedApplication] setStatusBarHidden:NO animated:NO];
    if(txtEmail.text.length >0)
{
    [txtEmail becomeFirstResponder];
}
    
    [txtComment resignFirstResponder];
    [txtEmail resignFirstResponder];
    [txtFirstname resignFirstResponder];
    [txtLastname resignFirstResponder];
    [txtmea resignFirstResponder];
    [txtPhoneno resignFirstResponder];
}
-(void)viewWillDisappear:(BOOL)animated
{
    txtComment.text =@"";
    txtEmail.text =@"";
    txtFirstname.text =@"";
    txtLastname.text =@"";
    txtPhoneno.text =@"";
    txtEmail.text =@"";
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getMEA
{
    
    // [kappDelegate ShowIndicator];
    NSMutableURLRequest *request ;
    NSString*_postData ;
    webservice=1;
    _postData = [NSString stringWithFormat:@""];
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/users/mea",Kwebservices]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
    
    
    
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
#pragma mark - text Delegate Methods
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField==txtFirstname) {
        [txtLastname becomeFirstResponder];
    }else if (textField==txtLastname)
    {
        [txtPhoneno becomeFirstResponder];
        
    }else if (textField==txtPhoneno)
    {
        [txtEmail becomeFirstResponder];
        
    }else if (textField==txtEmail)
    {
        [txtComment becomeFirstResponder];
        return YES;
    }
    [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    
    [textField resignFirstResponder];
    
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    scrollView.scrollEnabled = NO;
    
    if (textField==txtEmail)
    {
        
        if(textField == txtEmail)
        {
            imagecheckforemailView.hidden = YES;
            if(txtEmail.text.length>0){
                if (![self validateEmailWithString:txtEmail.text]==YES) {
                    lblemailerror.text = @"Enter a valid email";
                }else{
                    //activityIndicatorObject.center = CGPointMake(0, 0);
                    activityIndicatorObject1.transform = CGAffineTransformMakeScale(0.50, 0.50);
                    activityIndicatorObject1.color=[UIColor whiteColor];
                    [viewEmailindicator addSubview:activityIndicatorObject1];
                    [activityIndicatorObject1 startAnimating];
                    
                    CGRect frame = viewEmailindicator.frame;
                    frame.origin.x = txtEmail.frame.origin.x + txtEmail.frame.size.width;
                    frame.origin.y = txtEmail.frame.origin.y +1;
                    viewEmailindicator.frame = frame;
                    [self checkforavailability];
                }
            }
        }
    }
    if(textField==txtPhoneno)
    {
         NSString *phoneStr = [NSString stringWithFormat:@"%@",txtPhoneno.text];
        
        
        NSArray *phoneStrArr = [phoneStr componentsSeparatedByString:@" "];
        
        
        
        if (phoneStr.length>0) {
            
           
            NSLog(@"%@----%@",phoneStr,[phoneStrArr objectAtIndex:0]);
            
           
            if ([[NSString stringWithFormat:@"%@",[phoneStrArr objectAtIndex:0]]isEqualToString:@"1"]) {
                
                if (phoneStr.length<16 || phoneStr.length>16){
                    lblphonenoerror.text = @"Enter a valid phone no.";
                }else{
                    lblphonenoerror.text=@"";
                }
                
            }else{
                if (phoneStr.length<14 || phoneStr.length>14){
                    lblphonenoerror.text = @"Enter a valid phone no.";
                }else{
                     lblphonenoerror.text=@"";
                }
            }
    
        }
    }
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
   if(textField==txtPhoneno)
   {
       lblphonenoerror.text = @"";
   }
    scrollView.scrollEnabled = YES;
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(350, 700);
    
    
    
    svos = scrollView.contentOffset;
    tableView.hidden = YES;
    //    if(textField == txtFirstname ||textField == txtLastname)
    //    {
    //        [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    //        return;
    //    }
    if(textField == txtEmail)
    {
        lblemailerror.text = @"";
        email_checked = @"no";
        imagecheckforemailView.image=nil;
    }
    if(textField == txtEmail || textField == txtPhoneno ) {
        
        CGPoint pt;
        CGRect rc = [textField bounds];
        rc = [textField convertRect:rc toView:scrollView];
        pt = rc.origin;
        pt.x = 0;
        pt.y -=180;
        [scrollView setContentOffset:pt animated:YES];
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        return NO;
    }
    
    return YES;
}
-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{   [textView resignFirstResponder];
    return  YES;
}
-(void)textViewDidEndEditing:(UITextField *)textField
{
    scrollView.scrollEnabled = NO;
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    scrollView.scrollEnabled = YES;
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(350, 730);
    
    svos = scrollView.contentOffset;
    
    if(textView == txtComment) {
        [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        CGPoint pt;
        CGRect rc = [textView bounds];
        rc = [textView convertRect:rc toView:scrollView];
        pt = rc.origin;
        pt.x = 0;
        pt.y -=180;
        [scrollView setContentOffset:pt animated:YES];
        lblCommentsPlaceholder.hidden = YES;
    }
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField==txtPhoneno)
    {
       
        
        
        
        
        NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if(newString.length==0)
        {   txtPhoneno.text=@"";
            return YES;
        }
        NSArray *components = [newString componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]];
        NSString *decimalString = [components componentsJoinedByString:@""];
        
        NSUInteger length = decimalString.length;
        BOOL hasLeadingOne = length > 1 && [decimalString characterAtIndex:0] == '1';
        
        if (length == 0  || (length > 10 && !hasLeadingOne) || (length > 11)) {
            [txtPhoneno becomeFirstResponder];
            
            return NO;
        }
        
        NSUInteger index = 0;
        NSMutableString *formattedString = [NSMutableString string];
        
        if (hasLeadingOne) {
            [formattedString appendString:@"1 "];
            index += 1;
        }
        
        if (length - index > 3) {
            NSString *areaCode = [decimalString substringWithRange:NSMakeRange(index, 3)];
            [formattedString appendFormat:@"(%@) ",areaCode];
            index += 3;
        }
        
        if (length - index > 3) {
            NSString *prefix = [decimalString substringWithRange:NSMakeRange(index, 3)];
            [formattedString appendFormat:@"%@-",prefix];
            index += 3;
        }
        
        NSString *remainder = [decimalString substringFromIndex:index];
        [formattedString appendString:remainder];
        
        textField.text = formattedString;
        return NO;
        
    }
    return YES;
}

- (IBAction)btnSubmitReferral:(id)sender {
    NSString* firstNameStr = [txtFirstname.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString* lastNameStr = [txtLastname.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString* phoneStr = [txtPhoneno.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSCharacterSet *unwantedStr = [NSCharacterSet characterSetWithCharactersInString:@"+() -"];
    phoneStr = [[phoneStr componentsSeparatedByCharactersInSet: unwantedStr] componentsJoinedByString: @""];
    NSString* emailStr = [txtEmail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString* commentsStr = [txtComment.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString* meaStr = [txtmea.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    
    
       
    
    UIAlertView *alert;
    NSString *msgstr;
    [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    [txtFirstname resignFirstResponder];
    [txtLastname resignFirstResponder];
    [txtEmail resignFirstResponder];
    [txtComment resignFirstResponder];
    [txtmea resignFirstResponder];
    [txtPhoneno resignFirstResponder];
    
    if(firstNameStr.length == 0)
    {
        msgstr = @"Please enter first name";
        alert = [[UIAlertView alloc]initWithTitle:@"ARA" message:msgstr delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        return;
    }else if(lastNameStr.length == 0)
    {
        msgstr = @"Please enter last name";
        alert = [[UIAlertView alloc]initWithTitle:@"ARA" message:msgstr delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        return;
    }
    //    else if (phoneStr.length==0 ) {
    //        msgstr = @"Please enter phone no.";
    //        alert = [[UIAlertView alloc]initWithTitle:@"ARA" message:msgstr delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    //        [alert show];
    //        return;
    //    }
    if (phoneStr.length>0) {
        
    
        if (phoneStr.length<10 ) {
            alert = [[UIAlertView alloc]initWithTitle:@"ARA" message:@"Please enter a valid phone number." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        return;
        }
    }
    if (phoneStr.length>10 ) {
        if([[NSString stringWithFormat:@"%C",[phoneStr characterAtIndex:0]] isEqual:@"1"])
        {
            
        }else{
            msgstr = @"Please enter phone no. of atmost 10 digits";
            alert = [[UIAlertView alloc]initWithTitle:@"ARA" message:msgstr delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
            return;
        }
    }
    if (![self validateEmailWithString:emailStr]==YES) {
        msgstr = @"Please enter email address";
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"ARA" message:@"Please check your email address" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        [txtEmail becomeFirstResponder];
        return;
    }
    if([email_checked isEqualToString:@"no"])
    {
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"ARA" message:@"Just wait a movement we are checking your email." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [alert show];
        
    //    [self.view makeToast:@"Just wait a movement we are verifying your email address."];
        
        [txtEmail resignFirstResponder];
        return;
    }

    //    dispatch_sync( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
    //
    //        [self checkforavailability];
    //    });
    
//    if(commentsStr.length == 0)
//    {
//        msgstr = @"Please enter some comments";
//        alert = [[UIAlertView alloc]initWithTitle:@"ARA" message:msgstr delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//        [alert show];
//        return;
//    }
    if(meaStr.length == 0)
    {
        msgstr = @"Please select mea";
        alert = [[UIAlertView alloc]initWithTitle:@"ARA" message:msgstr delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        return;
    }
    if([lblemailerror.text isEqualToString:@"Email already exist"])
    {
        msgstr = @"Email already exist";
        alert = [[UIAlertView alloc]initWithTitle:@"ARA" message:msgstr delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        return;
    }
    NSString *mea_id;
    NSString *role_name = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"l_roleName"]];
    if([role_name isEqualToString:@"AAI - MEA"])
    {   if([[[NSUserDefaults standardUserDefaults]valueForKey:@"MEAName"] isEqualToString:txtmea.text])
    {
        mea_id = [[NSUserDefaults standardUserDefaults] valueForKey:@"l_roleId"];
    }else{
        mea_id = selected_text_id;
    }
    }else{
        NSLog(@"%lu",[NSString stringWithFormat:@"%@",selected_text_id ].length);
        //if([NSString stringWithFormat:@"%@",selected_text_id ].length==6)
        NSString *code =[NSString stringWithFormat:@"%@",selected_text_id ];
        if ([code rangeOfString:@"null" options:NSCaseInsensitiveSearch].location != NSNotFound)
        {
            mea_id = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"l_meaId"]];
        }else{
            mea_id = selected_text_id;
        }
    }
    
   // btnSubmitReferral.userInteractionEnabled = NO;
    [self submitReferral:firstNameStr lastname:lastNameStr phoneno:phoneStr email:emailStr mea:mea_id comment:commentsStr];
    
}
- (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

-(void)submitReferral:(NSString*)firstname1 lastname:(NSString*)lastname1 phoneno:(NSString*)phoneno1 email:(NSString*)email mea:(NSString*)mea comment:(NSString*)comment
{
    
    [kappDelegate ShowIndicator];
    NSMutableURLRequest *request ;
    NSString*_postData ;
    webservice=2;
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSLog(@"%@",[user valueForKey:@"l_userid"]);
    
    _postData = [NSString stringWithFormat:@"ReferrerID=%@&FirstName=%@&LastName=%@&PhoneNumber=%@&Email=%@&Comments=%@&MeaId=%@",[NSString stringWithFormat:@"%@",[user valueForKey:@"l_userid"]],firstname1,lastname1,phoneno1,email,comment,mea];
    
    if([found_client isEqualToString:@"yes"])
    {   found_client = @"no";
        _postData = [NSString stringWithFormat:@"ReferrerID=%@&FirstName=%@&LastName=%@&PhoneNumber=%@&Email=%@&Comments=%@&MeaId=%@&UserDetailId=%@",[NSString stringWithFormat:@"%@",[user valueForKey:@"l_userid"]],firstname1,lastname1,phoneno1,email,comment,mea,UserDetailId];
    }
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/referrals",Kwebservices]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
    
    NSLog(@"data post >>> %@",_postData);
    
    [request setHTTPMethod:@"POST"];
    //[request addValue:mea forHTTPHeaderField:@"MEAId"];
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
    NSString *objStr = @"self";
    [[NSUserDefaults standardUserDefaults]setObject:objStr forKey:@"self"];
}

- (IBAction)btnMEA:(id)sender {
    
    if(status == true)
    {
        tableView.hidden=YES;
        status =false;
        return;
    }
    status=true;
    tableView.hidden=NO;
    
    tableView.layer.borderColor = [UIColor grayColor].CGColor;
    tableView.layer.borderWidth = 1.0;
    tableView.layer.cornerRadius = 4.0;
    [tableView setClipsToBounds:YES];
    
    [tableView reloadData];
    if(id_mea_array.count==0)
    {
        tableView.hidden = YES;
    }
    
}

- (IBAction)btnImportContacts:(id)sender {
    
    ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(nil, nil);
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined) {
        ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error) {
            if (granted) {
                picker.peoplePickerDelegate = self;
                
                [self presentModalViewController:picker animated:YES];
                [picker setPeoplePickerDelegate:self];
                [picker setDisplayedProperties:[NSArray arrayWithObject:[NSNumber numberWithInt:kABPersonPhoneProperty]]];
            } else {
                // Show an alert here if user denies access telling that the contact cannot be added because you didn't allow it to access the contacts
            }
        });
    }else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized) {
        // If the user user has earlier provided the access, then add the contact
        picker.peoplePickerDelegate = self;
        
        [self presentModalViewController:picker animated:YES];
        [picker setPeoplePickerDelegate:self];
        [picker setDisplayedProperties:[NSArray arrayWithObject:[NSNumber numberWithInt:kABPersonPhoneProperty]]];
    }
    else {
        // If the user user has NOT earlier provided the access, create an alert to tell the user to go to Settings app and allow access
    }
}
-(void)checkforavailability
{
    NSMutableURLRequest *request ;
    NSString*_postData ;
    email_checked = @"no";
    webservice=5;
    _postData = [NSString stringWithFormat:@"Email=%@",txtEmail.text];
    
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/users/confirm",Kwebservices]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
    
    NSLog(@"data post >>> %@",_postData);
    [request setHTTPMethod:@"POST"];
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

#pragma mark - AddressBook Delegate Methods

- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    [self peoplePickerNavigationController:peoplePicker shouldContinueAfterSelectingPerson:person property:property identifier:identifier];
}
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker {
    
    　[picker dismissModalViewControllerAnimated:YES];
}

- (BOOL)peoplePickerNavigationController: (ABPeoplePickerNavigationController *)peoplePicker
      shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property
　　　　　　　　　　  identifier:(ABMultiValueIdentifier)identifier
{
    if([[NSString stringWithFormat:@"%d",property] isEqualToString:@"999"])
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"ARA" message:@"Kindly select phone number" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        return YES;
    }
    if([[NSString stringWithFormat:@"%d",property] isEqualToString:@"14"])
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"ARA" message:@"Kindly select a phone number" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        return YES;
    }
    ABMutableMultiValueRef multi = ABRecordCopyValue(person, property);
    CFStringRef phone1 = ABMultiValueCopyValueAtIndex(multi, identifier);
    NSLog(@"phone %@", (__bridge NSString *)phone1);
    CFRelease(phone1);
    
    //    if ([[NSString stringWithFormat:@"%@",phone1] rangeOfString:@"null" options:NSCaseInsensitiveSearch].location != NSNotFound)
    //    {
    //        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"ARA" message:@"Kindly select phone no only" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    //        [alert show];
    //        [self peoplePickerNavigationController:peoplePicker didSelectPerson:person property:property identifier:identifier];
    //        return  YES;
    //    }
    
    
    ABMultiValueRef fnameProperty = ABRecordCopyValue(person, kABPersonFirstNameProperty);
    ABMultiValueRef lnameProperty = ABRecordCopyValue(person, kABPersonLastNameProperty);
    
    ABMultiValueRef phoneProperty = ABRecordCopyValue(person, kABPersonPhoneProperty);
    ABMultiValueRef emailProperty = ABRecordCopyValue(person, kABPersonEmailProperty);
    
    NSArray *emailArray = (__bridge NSArray *)ABMultiValueCopyArrayOfAllValues(emailProperty);
    NSArray *phoneArray = (__bridge NSArray *)ABMultiValueCopyArrayOfAllValues(phoneProperty);
    
    NSString *name,*phone,*email;
    phone = [[NSString alloc]init];
    email = [[NSString alloc]init];
    name = [[NSString alloc]init];
    
    
    if (fnameProperty != nil) {
        name = [NSString stringWithFormat:@"%@", fnameProperty];
    }
    if (lnameProperty != nil) {
        name = [name stringByAppendingString:[NSString stringWithFormat:@" %@", lnameProperty]];
    }
    
    if ([phoneArray count] > 0) {
        if ([phoneArray count] > 1) {
            for (int i = 0; i < [phoneArray count]; i++) {
                phone = [phone stringByAppendingString:[NSString stringWithFormat:@"%@,", [phoneArray objectAtIndex:i]]];
            }
        }else {
            phone = [NSString stringWithFormat:@"%@", [phoneArray objectAtIndex:0]];
        }
    }
    
    if ([emailArray count] > 0) {
        if ([emailArray count] > 1) {
            for (int i = 0; i < [emailArray count]; i++) {
                email = [email stringByAppendingString:[NSString stringWithFormat:@"%@\n", [emailArray objectAtIndex:i]]];
            }
        }else {
            email = [NSString stringWithFormat:@"%@", [emailArray objectAtIndex:0]];
        }
    }
    
    //----setting txt field values
    NSArray *f_name = [name componentsSeparatedByString:@" "];
    if(f_name.count>1)
    {
        txtFirstname.text = [f_name objectAtIndex:0];
        txtLastname.text = [f_name objectAtIndex:1];
    }else{
        txtFirstname.text = [f_name objectAtIndex:0];
    }
    
    NSArray *only_1_no = [phone componentsSeparatedByString:@","];
    NSString *str = [only_1_no objectAtIndex:identifier];
    NSCharacterSet *unwantedStr = [NSCharacterSet characterSetWithCharactersInString:@"+() -"];
    str = [[str componentsSeparatedByCharactersInSet: unwantedStr] componentsJoinedByString: @""];
    NSArray *ar = [email componentsSeparatedByString:@"\n"];
    
    
    NSMutableString *mutStr = [[NSMutableString alloc]init];
    for (int i = 0; i<str.length; i++)
    {   
        NSString *abc = [NSString stringWithFormat:@"%C",[str characterAtIndex:i]];
        if(i==0){
            mutStr =[NSMutableString stringWithFormat:@"%@",abc];
        }else{
            mutStr = [NSMutableString stringWithFormat:@"%@%@",mutStr,abc];
        }
        [self showmaskonnumber:mutStr];
    }
    
    //txtPhoneno.text = str;
    txtEmail.text = [ar objectAtIndex:0];
    
    
    ABPeoplePickerNavigationController *peoplePicker1 = (ABPeoplePickerNavigationController *)peoplePicker.navigationController;
    [peoplePicker1 dismissModalViewControllerAnimated:YES];
    [txtEmail becomeFirstResponder];
    return YES;
}
-(void)showmaskonnumber:(NSString*)number
{
    
    NSString *newString = number;
    
    NSArray *components = [newString componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]];
    NSString *decimalString = [components componentsJoinedByString:@""];
    
    NSUInteger length = decimalString.length;
    BOOL hasLeadingOne = length > 1 && [decimalString characterAtIndex:0] == '1';
    
    if (length == 0 || (length > 10 && !hasLeadingOne) || (length > 10)) {
        [txtPhoneno becomeFirstResponder];
        
        return;
    }
    
    NSUInteger index = 0;
    NSMutableString *formattedString = [NSMutableString string];
    
    if (hasLeadingOne) {
        [formattedString appendString:@"1 "];
        index += 1;
    }
    
    if (length - index > 3) {
        NSString *areaCode = [decimalString substringWithRange:NSMakeRange(index, 3)];
        [formattedString appendFormat:@"(%@) ",areaCode];
        index += 3;
    }
    
    if (length - index > 3) {
        NSString *prefix = [decimalString substringWithRange:NSMakeRange(index, 3)];
        [formattedString appendFormat:@"%@-",prefix];
        index += 3;
    }
    
    NSString *remainder = [decimalString substringFromIndex:index];
    [formattedString appendString:remainder];
    
   // NSString *abc = formattedString;
    txtPhoneno.text = formattedString;
}

#pragma mark - connection delegate

-(NSInteger)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
    NSLog(@"response status code: %ld", (long)[httpResponse statusCode]);
    
    NSLog(@"Received Response");
    [webData setLength: 0];
    if((long)[httpResponse statusCode] == ResultOk)
    {
        NSLog(@"Received Response");
        [webData setLength: 0];
        response_status = @"passed";
        
    }else if ((long)[httpResponse statusCode] == ResultFailed)
    {
        response_status = @"failed";
    }
    
    if(webservice==5)
    {
        if((long)[httpResponse statusCode] == ResultOk)
        {
            
            response_status = @"passed";
            
            NSLog(@"Received Response");
            [webData setLength: 0];
            
        }else if ((long)[httpResponse statusCode] == ResultFailed)
        {
            response_status = @"failed";
            
            
        }
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
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"ARA" message:@"Intenet connection failed.. Try again later." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
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
    
    if([response_status isEqualToString:@"passed"])
    {
        SBJsonParser *json = [[SBJsonParser alloc] init];
        NSMutableDictionary *userDetailDict=[json objectWithString:responseString error:&error];
        if(webservice==1)
        {
            id_mea_array = [userDetailDict valueForKey:@"ID"];
            name_mea_array= [userDetailDict valueForKey:@"Name"];
        }else if(webservice==2)
        {
            
            if ([responseString rangeOfString:@"Ref" options:NSCaseInsensitiveSearch].location != NSNotFound)
            {
               // NSString *msg = [NSString stringWithFormat:@"Your referral has been submitted. You can track the same by referral id %@",responseString];
                  NSString *msg = [NSString stringWithFormat:@"Your referral has been submitted successfully."];
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Thanks!!" message:msg delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [alert show];
                alert.tag =3;
                return;
            }
        }else if (webservice==5)
        {
            email_checked = @"yes";
            if ([responseString rangeOfString:@"Email address not exist" options:NSCaseInsensitiveSearch].location != NSNotFound)
            {
                
                imagecheckforemailView.hidden =NO;
                
                
                CGRect frame = viewEmailindicator.frame;
                frame.origin.x = txtEmail.frame.origin.x + txtEmail.frame.size.width+3;
                frame.origin.y = txtEmail.frame.origin.y +txtEmail.frame.size.height/4;
                viewEmailindicator.frame = frame;
                lblemailerror.text=@"";
                imagecheckforemailView.image = [UIImage imageNamed:@"tick2.png"];
                [activityIndicatorObject1 stopAnimating];
                return;
            }else if ([responseString rangeOfString:@"User Not Found" options:NSCaseInsensitiveSearch].location != NSNotFound)
            {
                return;
            }
            NSString *usertype = [userDetailDict valueForKey:@"UserType"];
            if([usertype isEqualToString:@"Client"])
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"ARA" message:@"One of our client already referred this person. Do you want to refer this person again." delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes",nil];
                [alert show];
                alert.tag =8;
                [txtEmail resignFirstResponder];
                [txtComment resignFirstResponder];
                [txtPhoneno resignFirstResponder];
                [txtLastname resignFirstResponder];
                [txtFirstname resignFirstResponder];
                [txtmea resignFirstResponder];
                [scrollView setContentOffset:CGPointMake(0, -20) animated:YES];
                
                firstname = [NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"FirstName"]];
                lastname = [NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"LastName"]];
                phoneno = [NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"PhoneNumber"]];
                UserDetailId = [NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"UserDetailId"]];
                [activityIndicatorObject1 stopAnimating];
                
                return;
            }
            // NSString *usertype = [userDetailDict valueForKey:@"UserType"];
            lblemailerror.text =@"Email already exist";
            [activityIndicatorObject1 stopAnimating];
            
        }
    }else{
        if(webservice==5)
        {
            email_checked = @"yes";
            if ([responseString rangeOfString:@"Email address not exist" options:NSCaseInsensitiveSearch].location != NSNotFound)
            {
                
                imagecheckforemailView.hidden =NO;
                
                
                CGRect frame = viewEmailindicator.frame;
                frame.origin.x = txtEmail.frame.origin.x + txtEmail.frame.size.width+3;
                frame.origin.y = txtEmail.frame.origin.y +txtEmail.frame.size.height/4;
                viewEmailindicator.frame = frame;
                lblemailerror.text=@"";
                imagecheckforemailView.image = [UIImage imageNamed:@"tick2.png"];
                [activityIndicatorObject1 stopAnimating];
                return;
            }else if ([responseString rangeOfString:@"User Not Found" options:NSCaseInsensitiveSearch].location != NSNotFound)
            {
                [activityIndicatorObject1 stopAnimating];
                
                return;
            }
            
        }
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"ARA" message:responseString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    [kappDelegate HideIndicator];
    
}

- (IBAction)btnBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(alertView.tag==3){
        if(buttonIndex == 0)//OK button pressed
        {
            dashboardViewController *obj  =[[dashboardViewController alloc]initWithNibName:@"dashboardViewController" bundle:nil];
            [self.navigationController pushViewController:obj animated:YES];
        }
    }else if(alertView.tag==8){
        
        if(buttonIndex == 0)//OK button pressed
        {
            lblemailerror.text = @"Email already registered.";
            txtFirstname.text = @"";
            txtLastname.text = @"";
            txtPhoneno.text = @"";
        }
        else if(buttonIndex == 1)//Annul button pressed.
        {
            txtFirstname.text = firstname;
            txtLastname.text = lastname;
            if ([phoneno isEqualToString:@"<null>"]) {
                txtPhoneno.text = @"";
            }else{
                txtPhoneno.text = phoneno;
            }
            found_client = @"yes";
            imagecheckforemailView.image = [UIImage imageNamed:@"tick2.png"];
        }
    }
}
#pragma mark - TableView Delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [txtPhoneno resignFirstResponder];
    [txtmea resignFirstResponder];
    [txtLastname resignFirstResponder];
    [txtFirstname resignFirstResponder];
    [txtEmail resignFirstResponder];
    [txtComment resignFirstResponder];
    [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    
    return id_mea_array.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 35;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [name_mea_array objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:13.0];
    
    return  cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    txtmea.text = [name_mea_array objectAtIndex:indexPath.row];
    txtmea.font=[txtmea.font fontWithSize:13];
    
    selected_text_id = [NSString stringWithFormat:@"%@",[id_mea_array objectAtIndex:indexPath.row]];
    [btnMEA setTitle:@"" forState:UIControlStateNormal];
    tableView.hidden =YES;
}
@end
