//
//  changePasswordViewController.m
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 31/08/15.
//  Copyright (c) 2015 Krishna_Mac_2. All rights reserved.
//

#import "changePasswordViewController.h"


@interface changePasswordViewController ()

@end

@implementation changePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    Do any additional setup after loading the view from its nib.
    
//    int d = 0; // standard display
//    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2.0) {
//        d = 1; // is retina display
//    }
//    
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
//        d += 2;
//    }
//    
//    if (d==0) {
//        imagelogo.image = [UIImage imageNamed:@"inner-logo_320.png"];
//    }
//    if (d==1) {
//        imagelogo.image = [UIImage imageNamed:@"inner-logo_480.png"];
//    }
//    if (d==2) {
//        imagelogo.image = [UIImage imageNamed:@"inner-logo_600.png"];
//    }
//    if (d==3) {
//        imagelogo.image = [UIImage imageNamed:@"inner-logo_640.png"];
//    }
   /*
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
    */
    
    if (IS_IPAD)
    {
        btncahngpassword.titleLabel.font = [btncahngpassword.titleLabel.font fontWithSize:24];
        btnback.titleLabel.font = [btnback.titleLabel.font fontWithSize:24];


        lblheading.font=[lblheading.font fontWithSize:24];

        txtOldpwd.font=[txtOldpwd.font fontWithSize:20];

        txtNewpwd.font=[txtNewpwd.font fontWithSize:20];
        txtConfirmnewpwd.font=[txtConfirmnewpwd.font fontWithSize:20];
        
        if(IS_IPAD_PRO_1366)
        {
            btncahngpassword.titleLabel.font = [btncahngpassword.titleLabel.font fontWithSize:30];
            btnback.titleLabel.font = [btnback.titleLabel.font fontWithSize:30];
            
            
            lblheading.font=[lblheading.font fontWithSize:30];
            
            txtOldpwd.font=[txtOldpwd.font fontWithSize:28];
            
            txtNewpwd.font=[txtNewpwd.font fontWithSize:28];
            txtConfirmnewpwd.font=[txtConfirmnewpwd.font fontWithSize:28];
        }

        
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [txtConfirmnewpwd resignFirstResponder];
    [txtNewpwd resignFirstResponder];
    [txtOldpwd resignFirstResponder];
    
    
    lbloldPwd.layer.cornerRadius = 5.0;
    lbloldPwd.layer.borderWidth = 1.0;
    lbloldPwd.layer.borderColor = [UIColor colorWithRed:144.0f/255.0f green:184.0f/255.0f blue:218.0f/255.0f alpha:1.0f].CGColor;
    [lbloldPwd setClipsToBounds:YES];
    
    lblConfirmPwd.layer.cornerRadius = 5.0;
    lblConfirmPwd.layer.borderWidth = 1.0;
    lblConfirmPwd.layer.borderColor = [UIColor colorWithRed:144.0f/255.0f green:184.0f/255.0f blue:218.0f/255.0f alpha:1.0f].CGColor;
    [lblConfirmPwd setClipsToBounds:YES];
    
    lblNewpwd.layer.cornerRadius = 5.0;
    lblNewpwd.layer.borderWidth = 1.0;
    lblNewpwd.layer.borderColor = [UIColor colorWithRed:144.0f/255.0f green:184.0f/255.0f blue:218.0f/255.0f alpha:1.0f].CGColor;
    [lblNewpwd setClipsToBounds:YES];
    
    btncahngpassword.layer.cornerRadius = 5.0;
    btncahngpassword.layer.borderWidth = 1.0;
    btncahngpassword.layer.borderColor = [UIColor colorWithRed:144.0f/255.0f green:184.0f/255.0f blue:218.0f/255.0f alpha:1.0f].CGColor;
    [btncahngpassword setClipsToBounds:YES];
    
    [txtOldpwd setValue:[UIColor colorWithRed:144.0f/255.0f green:184.0f/255.0f blue:218.0f/255.0f alpha:1.0f] forKeyPath:@"_placeholderLabel.textColor"];
    [txtNewpwd setValue:[UIColor colorWithRed:144.0f/255.0f green:184.0f/255.0f blue:218.0f/255.0f alpha:1.0f] forKeyPath:@"_placeholderLabel.textColor"];
    [txtConfirmnewpwd setValue:[UIColor colorWithRed:144.0f/255.0f green:184.0f/255.0f blue:218.0f/255.0f alpha:1.0f] forKeyPath:@"_placeholderLabel.textColor"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark Buttons
- (IBAction)btnBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnChangePWD:(id)sender {
    
     NSCharacterSet *validChars = [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"];
    NSString* oldPWDstr = [txtOldpwd.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString* newPWDstr = [txtNewpwd.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString* confirmNewPWDstr = [txtConfirmnewpwd.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
//    UIAlertView *alert;
    NSString *message;
    
    
    [txtConfirmnewpwd resignFirstResponder];
    [txtNewpwd resignFirstResponder];
    [txtOldpwd resignFirstResponder];
    [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    scrollView.scrollEnabled = YES;

    NSLog(@"old pas:%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"l_password"]);
    if(oldPWDstr.length==0 || !([[[NSUserDefaults standardUserDefaults]valueForKey:@"l_password"]isEqualToString:oldPWDstr]))
    {
        if(!([[[NSUserDefaults standardUserDefaults]valueForKey:@"l_password"]isEqualToString:oldPWDstr]))
           {
               message = @"The old passwords didn't match";
               
               [HelperAlert alertWithOneBtn:AlertTitle description:message okBtn:OkButtonTitle];
               
               return;
           }
        message = @"Please enter your old password";
        [HelperAlert alertWithOneBtn:AlertTitle description:message okBtn:OkButtonTitle];
        
        return;
    }
    else if([txtNewpwd isEmpty])
    {
        message = @"Please enter your new password";
        [HelperAlert alertWithOneBtn:AlertTitle description:message okBtn:OkButtonTitle];
        
        return;
    }
    else if([oldPWDstr isEqualToString:newPWDstr])
    {
        message = @"Old and new password cannot be same.";
        [HelperAlert alertWithOneBtn:AlertTitle description:message okBtn:OkButtonTitle];
        return;
    }

    if(txtNewpwd.text.length < 6){
        message = @"Password should have atleast 6 characters and a number without whitespaces.";
        [HelperAlert  alertWithOneBtn:AlertTitle description:message okBtn:OkButtonTitle];
        return;
    }
    else if(txtNewpwd.text.length >= 6 && [txtNewpwd.text rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]].location == NSNotFound ){
        message = @"Password should have atleast 6 characters and a number without whitespaces.";
        
        [HelperAlert  alertWithOneBtn:AlertTitle description:message okBtn:OkButtonTitle];
        return;
    }
    else if (txtNewpwd.text.length >= 6 && [txtNewpwd.text rangeOfCharacterFromSet:validChars].location == NSNotFound ){
        message = @"Password should have atleast 6 characters and a number without whitespaces.";
        
        [HelperAlert  alertWithOneBtn:AlertTitle description:message okBtn:OkButtonTitle];
        return;
    }
    else if(![newPWDstr isEqualToString:confirmNewPWDstr])
    {
        
        NSLog(@"%@ %@",txtConfirmnewpwd.text, txtNewpwd.text);
        message = @"New password and confirm password should be same.";
        [HelperAlert alertWithOneBtn:AlertTitle description:message okBtn:OkButtonTitle];
        return;
    }
 

    [self ConfirmPWD:oldPWDstr newPwd:newPWDstr confirmPwd:confirmNewPWDstr];

    
}
#pragma mark - Connection Delegates

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
    
    if([recieved_status isEqualToString:@"passed"])
    {
   if([responseString rangeOfString:@"true" options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        [HelperAlert  alertWithOneBtn:AlertTitle description:@"Password successfully changed" okBtn:OkButtonTitle];

        
        [[NSUserDefaults standardUserDefaults]setObject:txtNewpwd.text forKey:@"l_password"];
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
   else  if([responseString rangeOfString:@"Password not match" options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        [HelperAlert  alertWithOneBtn:AlertTitle description:responseString okBtn:OkButtonTitle];
       
        txtConfirmnewpwd.text = @"";
        txtNewpwd.text = @"";
        return;
    }
    }else{
        [HelperAlert  alertWithOneBtn:AlertTitle description:responseString okBtn:OkButtonTitle];
    }
    SBJsonParser *json = [[SBJsonParser alloc] init];
    NSMutableDictionary *userDetailDict=[json objectWithString:responseString error:&error];
    [kappDelegate HideIndicator];

}
#pragma mark - textfield Delegates
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField == txtNewpwd)
    {
        if([string isEqualToString:@" "]){
            // Returning no here to restrict whitespace
            return NO;
        }
    }else if(textField == txtConfirmnewpwd)
    {
        if([string isEqualToString:@" "]){
            // Returning no here to restrict whitespace
            return NO;
        }
    }
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if(textField == txtOldpwd){
        [txtNewpwd becomeFirstResponder];
        return YES;
    }else if(textField == txtNewpwd){
        [txtConfirmnewpwd becomeFirstResponder];
        return  YES;
    }
    [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    
    [textField resignFirstResponder];
    scrollView.scrollEnabled = YES;
    
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    scrollView.scrollEnabled = NO;
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    svos = scrollView.contentOffset;
    scrollView.scrollEnabled = YES;
    scrollView.contentSize = CGSizeMake(350, 700);
    
    if(textField == txtConfirmnewpwd) {
        
        CGPoint pt;
        CGRect rc = [textField bounds];
        rc = [textField convertRect:rc toView:scrollView];
        pt = rc.origin;
        pt.x = 0;
        pt.y -=180;
        [scrollView setContentOffset:pt animated:YES];
        }
}

#pragma  mark OtherMethods
-(void)ConfirmPWD:(NSString*)oldPwd newPwd:(NSString*)newPwd confirmPwd:(NSString*)confirmPwd
{
    [kappDelegate ShowIndicator];
    NSMutableURLRequest *request ;
    NSString*_postData ;
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *userid_str = [NSString stringWithFormat:@"%@",[user valueForKey:@"l_userid"]];
    _postData = [NSString stringWithFormat:@"UserId=%@&CurrentPassword=%@&NewPassword=%@",userid_str,oldPwd,newPwd];
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/users/changepassword",Kwebservices]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
    
    
    
    NSLog(@"data post >>> %@  --->>> %@",_postData ,[[NSUserDefaults standardUserDefaults] valueForKey:@"UserToken"]);
    
    [request setHTTPMethod:@"POST"];
    //[request addValue:userid_str forHTTPHeaderField:@"UserId"];
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

@end
