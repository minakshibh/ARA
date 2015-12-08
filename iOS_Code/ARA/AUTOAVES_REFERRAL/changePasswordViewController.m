//
//  changePasswordViewController.m
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 31/08/15.
//  Copyright (c) 2015 Krishna_Mac_2. All rights reserved.
//

#import "changePasswordViewController.h"
#import "JSON.h"
#import "SBJson.h"

@interface changePasswordViewController ()

@end

@implementation changePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
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
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        btncahngpassword.titleLabel.font = [btncahngpassword.titleLabel.font fontWithSize:24];
        btnback.titleLabel.font = [btnback.titleLabel.font fontWithSize:24];


        lblheading.font=[lblheading.font fontWithSize:24];

        txtOldpwd.font=[txtOldpwd.font fontWithSize:24];

        txtNewpwd.font=[txtNewpwd.font fontWithSize:24];
        txtConfirmnewpwd.font=[txtConfirmnewpwd.font fontWithSize:24];
        
        

        
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [txtConfirmnewpwd resignFirstResponder];
    [txtNewpwd resignFirstResponder];
    [txtOldpwd resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)btnBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnChangePWD:(id)sender {
    
    NSString* oldPWDstr = [txtOldpwd.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString* newPWDstr = [txtNewpwd.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString* confirmNewPWDstr = [txtConfirmnewpwd.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    UIAlertView *alert;
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
               alert = [[UIAlertView alloc]initWithTitle:@"ARA" message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
               [alert show];
               return;
           }
        message = @"Please enter your old password";
        alert = [[UIAlertView alloc]initWithTitle:@"ARA" message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        return;
    }
    else if(newPWDstr.length==0)
    {
        message = @"Please enter your new password";
        alert = [[UIAlertView alloc]initWithTitle:@"ARA" message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        return;
    }else if(confirmNewPWDstr.length==0)
    {
        message = @"Please confirm your new password";
        alert = [[UIAlertView alloc]initWithTitle:@"ARA" message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        return;
    }else if([oldPWDstr isEqualToString:newPWDstr])
    {
        message = @"Old and new password cannot be same.";
        alert = [[UIAlertView alloc]initWithTitle:@"ARA" message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        return;
    }else if(![newPWDstr isEqualToString:confirmNewPWDstr])
    {
        
        NSLog(@"%@ %@",txtConfirmnewpwd.text, txtNewpwd.text);
        message = @"New password and confirm password should be same.";
        alert = [[UIAlertView alloc]initWithTitle:@"ARA" message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    
        [self ConfirmPWD:oldPWDstr newPwd:newPWDstr confirmPwd:confirmNewPWDstr];

    
}
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
    
    if([recieved_status isEqualToString:@"passed"])
    {
   if([responseString rangeOfString:@"true" options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"ARA" message:@"Password successfully changed" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        [[NSUserDefaults standardUserDefaults]setObject:txtNewpwd.text forKey:@"l_password"];
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
   else  if([responseString rangeOfString:@"Password not match" options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"ARA" message:responseString delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        txtConfirmnewpwd.text = @"";
        txtNewpwd.text = @"";
        return;
    }
    }else{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"ARA" message:responseString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];

    }
    SBJsonParser *json = [[SBJsonParser alloc] init];
    NSMutableDictionary *userDetailDict=[json objectWithString:responseString error:&error];
    [kappDelegate HideIndicator];

}
#pragma mark - textfield Delegates

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
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    svos = scrollView.contentOffset;
    scrollView.scrollEnabled = YES;
    if(textField == txtConfirmnewpwd  || textField == txtNewpwd ) {
        
        CGPoint pt;
        CGRect rc = [textField bounds];
        rc = [textField convertRect:rc toView:scrollView];
        pt = rc.origin;
        pt.x = 0;
        pt.y -=180;
        [scrollView setContentOffset:pt animated:YES];
        }
}

@end
