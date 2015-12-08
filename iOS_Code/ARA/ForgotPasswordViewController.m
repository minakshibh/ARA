//
//  ForgotPasswordViewController.m
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 10/08/15.
//  Copyright (c) 2015 Krishna_Mac_2. All rights reserved.
//

#import "ForgotPasswordViewController.h"
#import "SignUpViewController.h"
#import "JSON.h"
#import "SBJson.h"
#import "ASIHTTPRequest.h"

@interface ForgotPasswordViewController ()

@end

@implementation ForgotPasswordViewController

- (void)viewDidLoad {
    txtEmail.text = _email;
    [super viewDidLoad];
    
    
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)btnSingUp:(id)sender {
    SignUpViewController *SUvc = [[SignUpViewController alloc]initWithNibName:@"SignUpViewController" bundle:nil];
    [self.navigationController pushViewController:SUvc animated:YES];
}

- (IBAction)btnLogIn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [scrollView setContentOffset:CGPointMake(0, -20) animated:YES];
    
    [textField resignFirstResponder];
    scrollView.scrollEnabled = YES;
    
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    svos = scrollView.contentOffset;
    scrollView.scrollEnabled = YES;
    if ([[ UIScreen mainScreen ] bounds ].size.width == 320 )
    {
        
        
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
}
-(void)forgotPassword:(NSString*)email
{
    [kappDelegate ShowIndicator];
    NSMutableURLRequest *request ;
    NSString*_postData ;
    
    _postData = [NSString stringWithFormat:@""];
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/users/forgetpassword",Kwebservices]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
    
    
    
    NSLog(@"data post >>> %@",_postData);
    
    [request setHTTPMethod:@"GET"];
    [request addValue:email forHTTPHeaderField:@"useremail"];
    //[request addValue:password forHTTPHeaderField:@"userpassword"];
    
    
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
    
    SBJsonParser *json = [[SBJsonParser alloc] init];
    NSMutableDictionary *userDetailDict=[json objectWithString:responseString error:&error];
    NSLog(@"%@",userDetailDict);
     if ([responseString rangeOfString:@"Email address not found" options:NSCaseInsensitiveSearch].location != NSNotFound)
     {
         UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"ARA" message:responseString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
         [alert show];
         return;
     }
    if ([responseString rangeOfString:@"Please check your email for further instructions." options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"ARA" message:responseString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    if ([responseString rangeOfString:@"Failure sending mail" options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"ARA" message:responseString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"ARA" message:responseString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
    return;
}

- (IBAction)btnResetPassword:(id)sender {
    
    NSString* emailStr = [txtEmail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if(emailStr.length==0)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"ARA" message:@"Kindly enter an email address" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    if (![self validateEmailWithString:emailStr]==YES) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"ARA" message:@"Please check your email address" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        [txtEmail becomeFirstResponder];
        return;
    }
    
    [self forgotPassword:emailStr];
}
- (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
@end
