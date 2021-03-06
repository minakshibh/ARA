//
//  ForgotPasswordViewController.m
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 10/08/15.
//  Copyright (c) 2015 Krishna_Mac_2. All rights reserved.
//

#import "ForgotPasswordViewController.h"
#import "SignupEmailCheckViewController.h"
#import "ASIHTTPRequest.h"
#import "LoginViewController.h"
#import "OTPViewController.h"
#import "RecoveryViewController.h"

@interface ForgotPasswordViewController ()

@end

@implementation ForgotPasswordViewController

- (void)viewDidLoad {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"fromOTPView"];

    txtEmail.text = _email;
    [super viewDidLoad];
    
    if ( IS_IPAD)
    {
        txtEmail.font=[txtEmail.font fontWithSize:24];
        
        btnLogIn.titleLabel.font = [btnLogIn.titleLabel.font fontWithSize:20];
        btnSingUp.titleLabel.font = [btnSingUp.titleLabel.font fontWithSize:20];
        btnResetPassword.titleLabel.font = [btnSingUp.titleLabel.font fontWithSize:24];
        lblOr.font = [lblOr.font fontWithSize:20];
        
        if(IS_IPAD_PRO_1366)
        {
            txtEmail.font=[txtEmail.font fontWithSize:30];
            
            btnLogIn.titleLabel.font = [btnLogIn.titleLabel.font fontWithSize:24];
            btnSingUp.titleLabel.font = [btnSingUp.titleLabel.font fontWithSize:24];
            btnResetPassword.titleLabel.font = [btnSingUp.titleLabel.font fontWithSize:30];
            lblOr.font = [lblOr.font fontWithSize:24];
        }
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"fromOTPView"] != nil)
    {
        NSString *fromOTPView = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"fromOTPView"]];
        
        if([fromOTPView isEqualToString:@"yes"])
        {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"fromOTPView"];
            
            RecoveryViewController *recoveryView = [[RecoveryViewController alloc]initWithNibName:@"RecoveryViewController" bundle:nil];
            recoveryView.email = txtEmail.text;
//            signUpView.fromEmailView = [dataValuesDict valueForKey:@"fromEmailView"];;
//            signUpView.isClient = [dataValuesDict valueForKey:@"isClient"];;
//            signUpView.valuesArray = [dataValuesDict valueForKey:@"valuesArray"];
            
            [self.navigationController pushViewController:recoveryView animated:YES];
            
        }
        
        if([fromOTPView isEqualToString:@"backtologin"])
        {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"fromOTPView"];
            for(UIViewController *viewController in self.navigationController.viewControllers)
            {
                if([viewController isKindOfClass:[LoginViewController class]])
                {
                    [self.navigationController popToViewController:viewController animated:YES];
                }
            }

        }
    }
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma  mark Buttons
- (IBAction)btnSingUp:(id)sender {
    SignupEmailCheckViewController *SUvc = [[SignupEmailCheckViewController alloc]initWithNibName:@"SignupEmailCheckViewController" bundle:nil];
    [self.navigationController pushViewController:SUvc animated:YES];
}

- (IBAction)btnLogIn:(id)sender {
    LoginViewController *loginView = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    [self.navigationController pushViewController:loginView animated:YES];
}
- (IBAction)btnResetPassword:(id)sender
{
    NSString* emailStr = [txtEmail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if([txtEmail isEmpty])
    {
//        [HelperAlert alertWithOneBtn:AlertTitle description:@"Kindly enter an email address" okBtn:OkButtonTitle];
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:AlertTitle message:@"Kindly enter an email address" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    if (![txtEmail emailValidation]==YES) {
//        [HelperAlert alertWithOneBtn:AlertTitle description:@"Please check your email address" okBtn:OkButtonTitle];
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:AlertTitle message:@"Please check your email address" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        [txtEmail becomeFirstResponder];
        return;
    }
    
    [self forgotPassword:emailStr];
}


//#pragma  mark TextField Delegate methods
//-(BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    [scrollView setContentOffset:CGPointMake(0, -20) animated:YES];
//    
//    [textField resignFirstResponder];
//    scrollView.scrollEnabled = YES;
//    
//    return YES;
//}
//- (void)textFieldDidBeginEditing:(UITextField *)textField {
//    svos = scrollView.contentOffset;
//    scrollView.scrollEnabled = YES;
//    if ([[ UIScreen mainScreen ] bounds ].size.width == 320 )
//    {
//        
//        
//        if( textField == txtEmail ) {
//            
//            CGPoint pt;
//            CGRect rc = [textField bounds];
//            rc = [textField convertRect:rc toView:scrollView];
//            pt = rc.origin;
//            pt.x = 0;
//            pt.y -=150;
//            [scrollView setContentOffset:pt animated:YES];
//        }
//    }
//}

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
    
//    
//    if ([[NSString stringWithFormat:@"%@",error] rangeOfString:@"The Internet connection appears to be offline." options:NSCaseInsensitiveSearch].location != NSNotFound)
//    {
//        [HelperAlert  alertWithOneBtn:@"ERROR" description:@"The Internet connection appears to be offline." okBtn:OkButtonTitle];
//        return;
//    }
//    if ([[NSString stringWithFormat:@"%@",error] rangeOfString:@"The network connection was lost" options:NSCaseInsensitiveSearch].location != NSNotFound)
//    {
//        [HelperAlert  alertWithOneBtn:@"ERROR" description:@"The network connection was lost" okBtn:OkButtonTitle];
//        return;
//    }
//    if ([[NSString stringWithFormat:@"%@",error] rangeOfString:@"Could not connect to the server" options:NSCaseInsensitiveSearch].location != NSNotFound)
//    {
//        [HelperAlert  alertWithOneBtn:@"ERROR" description:@"Internet connection lost. Could not connect to the server" okBtn:OkButtonTitle];
//        return;
//    }
//    
//    if ([[NSString stringWithFormat:@"%@",error] rangeOfString:@"The request timed out" options:NSCaseInsensitiveSearch].location != NSNotFound)
//    {
//        [HelperAlert  alertWithOneBtn:@"ERROR" description:@"The request timed out. Not able to connect to server" okBtn:OkButtonTitle];
//        return;
//    }
//    [HelperAlert  alertWithOneBtn:@"ERROR" description:@"Intenet connection failed.. Try again later." okBtn:OkButtonTitle];
//    NSLog(@"ERROR with the Connection ");
    
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
     if ([responseString rangeOfString:@"Email address not found" options:NSCaseInsensitiveSearch].location != NSNotFound)
     {
//         [HelperAlert  alertWithOneBtn:@"ERROR" description:responseString okBtn:OkButtonTitle];
         UIAlertView *alert=[[UIAlertView alloc] initWithTitle:AlertTitle message:responseString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
         [alert show];

         return;
     }
    if ([responseString rangeOfString:@"Please check your email for further instructions." options:NSCaseInsensitiveSearch].location != NSNotFound)
    {

        UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:AlertTitle  message:@"A security code was sent to your email. Please check to complete process."  preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            OTPViewController *OTPView = [[OTPViewController alloc]initWithNibName:@"OTPViewController" bundle:nil];
            OTPView.userEmail = txtEmail.text;
            [self presentViewController:OTPView animated:true completion:nil];
            
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
        
        return;
    }
    if ([responseString rangeOfString:@"Failure sending mail" options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
//        [HelperAlert  alertWithOneBtn:@"ERROR" description:responseString okBtn:OkButtonTitle];
        
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:AlertTitle message:@"Something went wrong. Please try after some time." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
//    [HelperAlert  alertWithOneBtn:@"ERROR" description:responseString okBtn:OkButtonTitle];
 
    if ([responseString rangeOfString:@"true" options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:AlertTitle  message:@"A security code was sent to your email. Please check to complete process."  preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            OTPViewController *OTPView = [[OTPViewController alloc]initWithNibName:@"OTPViewController" bundle:nil];
            OTPView.userEmail = txtEmail.text;
            [self presentViewController:OTPView animated:true completion:nil];
            
        }]];
        [self presentViewController:alertController animated:YES completion:nil];

        return;
    }
    
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:AlertTitle message:responseString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];


}

#pragma  mark Other Methods
-(void)forgotPassword:(NSString*)email
{
    [kappDelegate ShowIndicator];
    NSMutableURLRequest *request ;
    NSString*_postData ;
    
    _postData = [NSString stringWithFormat:@"Email=%@&PhoneNumber=%@",email,@""];
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/account/SendOTP",Kwebservices]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
    
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

#pragma  mark TextField Delegate methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
//    if (textField == txtEmail)
//    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardDidShowNotification object:nil];
        
//    }
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (textField == txtEmail)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardDidHideNotification object:nil];
    }
    return YES;
}


- (void)keyboardWillShow:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    float newVerticalPosition = -keyboardSize.height + 100 + 50*IS_IPHONE_6 + 50*IS_IPHONE_6P;
    
    [self moveFrameToVerticalPosition:newVerticalPosition forDuration:0.3f];
}


- (void)keyboardWillHide:(NSNotification *)notification
{
//    CGFloat  kNavBarHeight =  self.navigationController.navigationBar.frame.size.height;
    CGFloat  kNavBarHeight =  0;
    [self moveFrameToVerticalPosition:kNavBarHeight forDuration:0.3f];
}

- (void)moveFrameToVerticalPosition:(float)position forDuration:(float)duration
{
    CGRect frame = self.view.frame;
    frame.origin.y = position;
    
    [UIView animateWithDuration:duration animations:^{
        self.view.frame = frame;
    }];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

@end
