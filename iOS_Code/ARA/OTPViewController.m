//
//  OTPViewController.m
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 20/06/17.
//  Copyright © 2017 Krishna_Mac_2. All rights reserved.
//

#import "OTPViewController.h"
#import "LoginViewController.h"
#import <FacebookSDK/FacebookSDK.h>

@interface OTPViewController ()

@end

@implementation OTPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self viewCustomizationForIPad];
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(cancelNumberPad)],
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    
    [numberToolbar sizeToFit];
    txtOTP.inputAccessoryView = numberToolbar;
}

-(void)viewWillAppear:(BOOL)animated
{
    if([[[NSUserDefaults standardUserDefaults]valueForKey:@"from_fb"] isEqualToString:@"yes"])
    {
        if (FBSession.activeSession.state == FBSessionStateOpen
            || FBSession.activeSession.state == FBSessionStateOpenTokenExtended)
        {
            [[NSUserDefaults standardUserDefaults]setObject:@"yes" forKey:@"OTPFacebookLogout"];
            
            [FBSession.activeSession closeAndClearTokenInformation];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"from_fb"];
            
            return;
        }
    }
}

-(void)viewCustomizationForIPad
{
    if ( IS_IPAD)
    {
        txtOTP.font=[txtOTP.font fontWithSize:24];
        
        btnResendOTP.titleLabel.font = [btnResendOTP.titleLabel.font fontWithSize:20];
        btnVerify.titleLabel.font = [btnVerify.titleLabel.font fontWithSize:24];
        
        lblAlreadyhaveAnAccount.font = [lblAlreadyhaveAnAccount.font fontWithSize:20];
        btnLogin.titleLabel.font = [btnLogin.titleLabel.font fontWithSize:20];

        if(IS_IPAD_PRO_1366)
        {
            txtOTP.font=[txtOTP.font fontWithSize:30];
            
            btnResendOTP.titleLabel.font = [btnResendOTP.titleLabel.font fontWithSize:24];
            btnVerify.titleLabel.font = [btnVerify.titleLabel.font fontWithSize:30];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnResendOTP:(id)sender {
    [self resendOTP:self.userEmail];
}

- (IBAction)btnVerify:(id)sender
{
    if ([txtOTP isEmpty] )
    {
        NSString *message = @"Please Enter Security Code";
        [HelperAlert  alertWithOneBtn:AlertTitle description:message okBtn:OkButtonTitle];
        
        return;
    }
    
    [self verifyOTP:txtOTP.text email:self.userEmail];
}

- (IBAction)btnLogin:(id)sender
{
    [[NSUserDefaults standardUserDefaults] setObject:@"backtologin" forKey:@"fromOTPView"];
    
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)verifyOTP:(NSString *)otp email:(NSString *)email
{
    [kappDelegate ShowIndicator];
    
    NSMutableURLRequest *request;
    NSString*_postData;
    
     webservice=5;
    
    _postData = [NSString stringWithFormat:@"uniqueID=%@&OTP=%@",email,otp];
    
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/account/VerifyOTP",Kwebservices]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
    
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

- (void)resendOTP:(NSString *)email
{
    [kappDelegate ShowIndicator];
    
    NSMutableURLRequest *request;
    NSString*_postData;
    
    webservice=6;
    
    _postData = [NSString stringWithFormat:@"Email=%@&PhoneNumber=%@",email,@""];
    
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/account/SendOTP",Kwebservices]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
    
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
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:AlertTitle message:@"Intenet connection failed.. Try again later." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
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
    
    
    if ([recieved_status isEqualToString:@"passed"])
    {
        if(webservice==5)
        {
            if ([responseString rangeOfString:@"true" options:NSCaseInsensitiveSearch].location != NSNotFound)
            {
                NSLog(@"%@", responseString);
                
                [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"fromOTPView"];
                
                [self dismissViewControllerAnimated:true completion:nil];
            }
            else if ([responseString.lowercaseString rangeOfString:@"invalid" options:NSCaseInsensitiveSearch].location != NSNotFound)
            {
                
                [HelperAlert alertWithOneBtn:AlertTitle description:responseString okBtn:OkButtonTitle];
                    txtOTP.text = @"";
            }
            else
            {
                [HelperAlert alertWithOneBtn:AlertTitle description:responseString okBtn:OkButtonTitle];
            }
        }
        else if(webservice==6)
        {
            if ([responseString rangeOfString:@"true" options:NSCaseInsensitiveSearch].location != NSNotFound)
            {
                NSLog(@"%@", responseString);
                
                [HelperAlert alertWithOneBtn:AlertTitle description:@"A security code was sent to your email. Please check to complete process." okBtn:OkButtonTitle];

            }
        }
        else
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:AlertTitle message:responseString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            
 
        }
        

    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:AlertTitle message:responseString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    return;
}

#pragma mark - Textfield delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField.text.length >3 && range.length == 0)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

#pragma mark - Other

-(void)cancelNumberPad{
    [txtOTP resignFirstResponder];
    txtOTP.text = @"";
}

-(void)doneWithNumberPad{
    [txtOTP resignFirstResponder];
}

@end
