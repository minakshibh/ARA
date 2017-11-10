//
//  SignupEmailCheckViewController.m
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 29/12/15.
//  Copyright © 2015 Krishna_Mac_2. All rights reserved.
//

#import "SignupEmailCheckViewController.h"
#import "SignUpViewController.h"
#import "LoginViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "OTPViewController.h"
#import "RecoveryViewController.h"

@interface SignupEmailCheckViewController ()
{
    IBOutlet UITextField *txtEmail;
    NSMutableData *webData;
    NSString *getValue;
    NSString *response_status,*firstname,*lastname,*phoneno,*UserDetailId,*mEAName,*mEAID;
    IBOutlet UIScrollView *scrollView;
    IBOutlet UIButton *btnVerifyEmail;
    IBOutlet UIButton *btnLogin;
    IBOutlet UIButton *lblAlreadyhaveanaccount;
    IBOutlet UIImageView *topImage;
    
    NSMutableDictionary *dataValuesDict;
    
    NSString *status;
}
@end

@implementation SignupEmailCheckViewController

- (void)viewDidLoad {
    dataValuesDict = [[NSMutableDictionary alloc] init];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"fromOTPView"];
   // [txtEmail resignFirstResponder];
    [txtEmail becomeFirstResponder];
     txtEmail.delegate=self;
    
 getValue   = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]stringForKey:@"subValue"]];
    if ([getValue isEqualToString:@"1"])
    {
        topImage.image=[UIImage imageNamed:@"step_a_icon"];
        lblEnteremailaddress.text=@"Enter your invitation code";
        txtEmail.placeholder=@"Enter your invitation code";
        icon.image=[UIImage imageNamed:@"referrenceCode"];
        icon.alpha = 0.2;
    }else{
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            NSString *valCheck = [NSString stringWithFormat:@"%@",[user valueForKey:@"from_fb"]];
            
            
            if ([valCheck isEqualToString:@"yes"]) {
                txtEmail.text = [NSString stringWithFormat:@"%@",[user valueForKey:@"user_email"]];
                [self checkEmail];
            }
    }

   
    [super viewDidLoad];
    
    

}
-(void)viewDidDisappear:(BOOL)animated{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"subValue"];
}
- (IBAction)step2btnAction:(id)sender {
    if ([getValue isEqualToString:@"1"])
    {
        [self checkForParameter];
        NSString *variable=@"1";
        NSUserDefaults *storeData=[NSUserDefaults standardUserDefaults];
        [storeData setObject:variable forKey:@"data"];
        [storeData synchronize];

        return;
    }
     [self checkEmail];
}

-(void)viewWillAppear:(BOOL)animated{
    
    if (IS_IPHONE_5) {
        lblEnteremailaddress.font = [lblEnteremailaddress.font fontWithSize:9];
        lblComposeyourprofile.font = [lblEnteremailaddress.font fontWithSize:8];
    }
    if (IS_IPAD) {
        lblEnteremailaddress.font = [lblEnteremailaddress.font fontWithSize:16];
        lblComposeyourprofile.font = [lblEnteremailaddress.font fontWithSize:14];
        
        
        txtEmail.font = [lblEnteremailaddress.font fontWithSize:20];

        btnVerifyEmail.titleLabel.font = [btnVerifyEmail.titleLabel.font fontWithSize:24];
        lblAlreadyhaveanaccount.font = [lblEnteremailaddress.font fontWithSize:20];
        btnLogin.titleLabel.font = [btnLogin.titleLabel.font fontWithSize:20];


        lblEnteremailaddress.frame = CGRectMake(lblEnteremailaddress.frame.origin.x+12, lblEnteremailaddress.frame.origin.y, lblEnteremailaddress.frame.size.width, lblEnteremailaddress.frame.size.height);
        lblComposeyourprofile.frame = CGRectMake(lblComposeyourprofile.frame.origin.x-15, lblComposeyourprofile.frame.origin.y, lblComposeyourprofile.frame.size.width, lblComposeyourprofile.frame.size.height);
        
    }
    
[[NSUserDefaults standardUserDefaults]setObject:@"yes" forKey:@"OTPFacebookLogout"];    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"fromOTPView"] != nil)
    {
        NSString *fromOTPView = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"fromOTPView"]];

        if([fromOTPView isEqualToString:@"yes"])
        {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"fromOTPView"];
            
            if([status isEqualToString:@"resetPwd"])
            {
                status = @"";
                
                RecoveryViewController *recoveryView = [[RecoveryViewController alloc]initWithNibName:@"RecoveryViewController" bundle:nil];
                recoveryView.email = txtEmail.text;
                
                [self.navigationController pushViewController:recoveryView animated:YES];
            }
            else
            {
                SignUpViewController *signUpView = [[SignUpViewController alloc]initWithNibName:@"SignUpViewController" bundle:nil];
                signUpView.fromEmailView = [dataValuesDict valueForKey:@"fromEmailView"];;
                signUpView.isClient = [dataValuesDict valueForKey:@"isClient"];;
                signUpView.valuesArray = [dataValuesDict valueForKey:@"valuesArray"];
                
                [self.navigationController pushViewController:signUpView animated:YES];
  
            }
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
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnVerifyEmail:(id)sender {
    
    [self textFieldShouldReturn:txtEmail];
    if ([getValue isEqualToString:@"1"])
    {
        [self checkForParameter];
       
        NSString *variable=@"1";
        NSUserDefaults *storeData=[NSUserDefaults standardUserDefaults];
        [storeData setObject:variable forKey:@"data"];
        [storeData synchronize];
        
        
        
        return;
    }
    [self checkEmail];
   
}

-(void)checkEmail
{
    NSString* emailStr = [txtEmail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    txtEmail.text = emailStr;
    if(emailStr.length==0) {
        [HelperAlert alertWithOneBtn:AlertTitle description:@"Kindly enter email address" okBtn:OkButtonTitle];
        return;
    }else  if (![txtEmail emailValidation]) {
        NSString* message = @"Please check your email address";
        [HelperAlert  alertWithOneBtn:AlertTitle description:message okBtn:OkButtonTitle];
        
        [txtEmail becomeFirstResponder];
        return;
    }
    [self.view endEditing:YES];
   
    
    [self checkforAvailability:emailStr];
        
    
    
    [scrollView setContentOffset:CGPointMake(0, -20) animated:YES];
}
- (IBAction)btnLogin:(id)sender {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Value"];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - functions
-(void)checkForParameter
{
    
    NSString* emailStr = [txtEmail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    txtEmail.text = emailStr;
    if(emailStr.length==0) {
        [HelperAlert alertWithOneBtn:AlertTitle description:@"Kindly enter your invitation code." okBtn:OkButtonTitle];
        return;
    }    [self.view endEditing:YES];
    
    NSMutableURLRequest *request;
    NSString*_getData ;
    [kappDelegate ShowIndicator];
    webservice=8;
    _getData = [NSString stringWithFormat:@""];
    
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/invitation/referrence/%@",Kwebservices,txtEmail.text]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
    // http://69.164.149.164:801/api/invitation/referrence/4457bb49

    NSLog(@"data post >>> %@",_getData);
    [request setHTTPMethod:@"GET"];
    [request setHTTPBody: [_getData dataUsingEncoding:NSUTF8StringEncoding]];
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
-(void)checkforAvailability:(NSString*)email
{
    NSMutableURLRequest *request;
    NSString*_postData ;
    [kappDelegate ShowIndicator];
    webservice=6;
    _postData = [NSString stringWithFormat:@"Email=%@",email];
    
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/users/confirm",Kwebservices]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
    
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

-(void)sendOTP:(NSString*)email
{
    NSMutableURLRequest *request;
    NSString*_postData ;
    
    [kappDelegate ShowIndicator];
    
    webservice=22;
    
    _postData = [NSString stringWithFormat:@"Email=%@&PhoneNumber=%@", email, @""];
    
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

-(void)forgotPassword:(NSString*)email
{
    [kappDelegate ShowIndicator];
    NSMutableURLRequest *request ;
    NSString*_postData ;
    webservice =7;
    _postData = [NSString stringWithFormat:@""];
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/users/forgetpassword/app",Kwebservices]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
    
    
    
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
#pragma  mark- connection delegate
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"Received Response");
    [webData setLength: 0];
    
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
    NSLog(@"response status code: %ld", (long)[httpResponse statusCode]);
    
        if((long)[httpResponse statusCode] == ResultOk)
        {
            NSLog(@"Received Response");
            [webData setLength: 0];
            response_status = @"passed";
        }else if ((long)[httpResponse statusCode] == ResultFailed)
        {
            response_status = @"failed";
            
        }
    
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
    NSLog(@"DONE. Received Bytes: %lu", (unsigned long)[webData length]);
    
    if ([webData length]==0)
        return;
    
    NSString *responseString = [[NSString alloc] initWithData:webData encoding:NSUTF8StringEncoding];
    NSLog(@"responseString:%@",responseString);
    if (![response_status isEqualToString:@"passed"]) {
        if ([responseString rangeOfString:@"Email address not exist" options:NSCaseInsensitiveSearch].location != NSNotFound)
        {

        }else{
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"The Referrence code does not exist." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        }
    }
    [kappDelegate HideIndicator];
    if ([response_status isEqualToString:@"passed"])
    {
        if ([responseString rangeOfString:@"Please check your" options:NSCaseInsensitiveSearch].location != NSNotFound)
        {
            [kappDelegate HideIndicator];
            UIAlertController * alert= [UIAlertController
                                          alertControllerWithTitle:AlertTitle
                                          message:responseString
                                          preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* okButton = [UIAlertAction
                                        actionWithTitle:@"Ok"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action)
                                        {
                                            //Handel your yes please button action here
                                            [alert dismissViewControllerAnimated:YES completion:nil];
                                            [self.navigationController popViewControllerAnimated:YES];
                                           

                                        }];
            [alert addAction:okButton];
            [self presentViewController:alert animated:YES completion:nil];

            return;
        }
        
        NSError *error;
        SBJsonParser *json = [[SBJsonParser alloc] init];
        NSMutableDictionary *userDetailDict=[json objectWithString:responseString error:&error];
        [kappDelegate HideIndicator];
        //Invitaionstatus = Accepted;
        
        
        if (![userDetailDict isKindOfClass:[NSNull class]])
        {
            if (webservice==8)
            {
                if ([responseString rangeOfString:@"No record" options:NSCaseInsensitiveSearch].location != NSNotFound){
                   
                
                    UIAlertView *ARAalert=[[UIAlertView alloc]initWithTitle:AlertTitle message:@"The referrence code do not exist." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                    
                    [ARAalert show];
                    return;
                }
                
                
                  NSString *invitationStatus = [NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"Invitaionstatus"]];
                
                if ([invitationStatus.lowercaseString isEqualToString:@"installed"]){
                    
                    UIAlertView *ARAalert=[[UIAlertView alloc]initWithTitle:AlertTitle message:@"The referrence code is either expired or already used." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                    
                    [ARAalert show];
                    return;
                    
                }
                
                
                [scrollView setContentOffset:CGPointMake(0, -20) animated:YES];
                
                firstname = [NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"FirstName"]];
                lastname = [NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"LastName"]];
                phoneno = [NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"PhoneNo"]];
                UserDetailId = [NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"UserDetailID"]];
                
                if(![[[userDetailDict valueForKey:@"MEAID"] stringValue] isEqualToString:@"0"])
                {
                    mEAName = [NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"MEAName"]];
                    mEAID = [NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"MEAID"]];
                }
                else
                {
                    mEAName = @"";
                    mEAID = @"0";
                }
                
                NSString *InvitationId = [NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"InvitationId"]];
                NSString* emailStr =  [NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"Email"]];
                
//                mEAName = [NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"MEAName"]];
//                mEAID = [NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"MEAID"]];
                
                NSArray *values = [[NSArray alloc]initWithObjects:firstname,lastname,phoneno,UserDetailId,emailStr,mEAName,mEAID,nil];
                  NSLog(@"get data %@",values);
                NSString *usertype = [userDetailDict valueForKey:@"UserType"];
                
                SignUpViewController *signUpView = [[SignUpViewController alloc]initWithNibName:@"SignUpViewController" bundle:nil];
                signUpView.fromEmailView = @"yes";
                signUpView.valuesArray = values;
                signUpView.userReference=@"True";
                signUpView.InvitationId = InvitationId;
                
                if([usertype isEqualToString:@"Client"])
                {
                signUpView.isClient = @"yes";
                }
                [self.navigationController pushViewController:signUpView animated:YES];
              

                return;
                
            
            }
            
            
            if (webservice==6) {
                webservice=0;
                
                if ([responseString rangeOfString:@"Email address not exist" options:NSCaseInsensitiveSearch].location != NSNotFound)
                {
                    
                    
                    NSLog(@"----2-----");
                    
                    return;
                }
                NSString *usertype = [userDetailDict valueForKey:@"UserType"];
                if([usertype isEqualToString:@"Client"])
                {
                   
                    NSLog(@"---1----");
                    
               
                    
                    
                    [scrollView setContentOffset:CGPointMake(0, -20) animated:YES];
                    
                    firstname = [NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"FirstName"]];
                    lastname = [NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"LastName"]];
                    phoneno = [NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"PhoneNumber"]];
                    UserDetailId = [NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"UserDetailId"]];
                    mEAName = [NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"MEAName"]];
                    mEAID = [NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"MEAID"]];
                    NSString* emailStr = [txtEmail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

                    NSArray *values = [[NSArray alloc]initWithObjects: firstname, lastname, phoneno, UserDetailId, emailStr, mEAName, mEAID, nil];
                    
                    
//                    SignUpViewController *signUpView = [[SignUpViewController alloc]initWithNibName:@"SignUpViewController" bundle:nil];
//                    OTPViewController *otpView = [[OTPViewController alloc]initWithNibName:@"OTPViewController" bundle:nil];
                    [dataValuesDict setObject:@"yes" forKey:@"fromEmailView"];
                    [dataValuesDict setObject:@"yes" forKey:@"isClient"];
                    [dataValuesDict setObject:values forKey:@"valuesArray"];
//                    [self presentViewController:otpView animated:true completion:nil];
//                    [self.navigationController pushViewController:signUpView animated:YES];
                    [self sendOTP:txtEmail.text];
                    return;
                }else{
                    UIAlertController * alert=   [UIAlertController
                                                  alertControllerWithTitle:AlertTitle
                                                  message:@"You are already registered. Would you like to reset your password?"
                                                  preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction* yesButton = [UIAlertAction
                                                actionWithTitle:@"Yes"
                                                style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * action)
                                                {
                                                    
//                                                    [alert dismissViewControllerAnimated:YES completion:nil];
                                                     NSString* emailStr = [txtEmail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                                                    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//                                                    if ([[NSString stringWithFormat:@"%@",[user valueForKey:@"from_fb"]] isEqualToString:@"yes"]) {
//                                                        LoginViewController *obj = [[LoginViewController alloc]init];
//                                                        [obj facebookLogin];
//                                                    }
//            if (FBSession.activeSession.state == FBSessionStateOpen
//                                                        || FBSession.activeSession.state == FBSessionStateOpenTokenExtended) {
//                                                        
//                // Close the session and remove the access token from the cache
//            // The session state handler (in the app delegate) will be called automatically
//            [FBSession.activeSession closeAndClearTokenInformation];
//                                                        
//        // If the session state is not any of the two "open" states when the button is clicked
//        }
                                                    status = @"resetPwd";
                                                    [self sendOTP:emailStr];
//                                                    [self forgotPassword:emailStr];
                                                }];
                    UIAlertAction* noButton = [UIAlertAction
                                               actionWithTitle:@"No"
                                               style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action)
                                               {
                                                   NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                                                   if ([[NSString stringWithFormat:@"%@",[user valueForKey:@"from_fb"]] isEqualToString:@"yes"]) {
                                                       LoginViewController *obj = [[LoginViewController alloc]init];
                                                       [obj facebookLogin];
                                                   }else{
                                                        [self.navigationController popViewControllerAnimated:YES];
                                                   }
                                                   
                                                   [alert dismissViewControllerAnimated:YES completion:nil];
                                                  
                                               }];
                    
                    [alert addAction:yesButton];
                    [alert addAction:noButton];
                    
                    [self presentViewController:alert animated:YES completion:nil];
                }
            }
            
            if(webservice==22)
            {
                NSLog(@"%@",responseString);
                
                if ([responseString rangeOfString:@"true" options:NSCaseInsensitiveSearch].location != NSNotFound)
                {
                    UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:AlertTitle  message:@"A security code was sent to your email. Please check to complete process."  preferredStyle:UIAlertControllerStyleAlert];
                    [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                        
                        OTPViewController *OTPView = [[OTPViewController alloc]initWithNibName:@"OTPViewController" bundle:nil];
                        OTPView.userEmail = txtEmail.text;
                        [self presentViewController:OTPView animated:true completion:nil];
                        
                    }]];
                    [self presentViewController:alertController animated:YES completion:nil];
                }
            }

            
        }
    }else{
        
        if (webservice==6) {
            if ([responseString rangeOfString:@"Email address not exist" options:NSCaseInsensitiveSearch].location != NSNotFound)
            {
                NSString* emailStr = [txtEmail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                mEAName = [NSString stringWithFormat:@""];
                mEAID = [NSString stringWithFormat:@""];
                
                
//                SignUpViewController *signupView = [[SignUpViewController   alloc]initWithNibName:@"SignUpViewController" bundle:nil];
//                OTPViewController *otpView = [[OTPViewController alloc]initWithNibName:@"OTPViewController" bundle:nil];
                /// facebook check
                NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                NSString *valCheck = [NSString stringWithFormat:@"%@",[user valueForKey:@"from_fb"]];
                
                NSArray *value = [[NSArray alloc]initWithObjects:@"",@"",@"",@"",emailStr,mEAName,mEAID, nil];
                
                if ([valCheck isEqualToString:@"yes"])
                {
                   NSString *name = [NSString stringWithFormat:@"%@",[user valueForKey:@"user_name"]];
                    NSArray *nam = [name componentsSeparatedByString:@" "];
                    
                    if(nam.count > 1)
                    {
                       value = [[NSArray alloc]initWithObjects:[nam objectAtIndex:0],[nam objectAtIndex:1],@"",@"",emailStr,mEAName,mEAID, nil];
                    }
                    else
                    {
                        value = [[NSArray alloc]initWithObjects:[nam objectAtIndex:0],@"",@"",@"",emailStr,mEAName,mEAID, nil];
                    }
                    
                }
                
                
                
                
                
                
                [dataValuesDict setObject:@"yes" forKey:@"fromEmailView"];
                [dataValuesDict setObject:@"" forKey:@"isClient"];
                [dataValuesDict setObject:value forKey:@"valuesArray"];
//                [self.navigationController pushViewController:signupView animated:YES];
//                [self presentViewController:otpView animated:true completion:nil];

                [self sendOTP:txtEmail.text];
                
                return;
            }
        }else if(webservice==7)
            {
                [kappDelegate HideIndicator];
                 if ([responseString rangeOfString:@"Failure sending mail" options:NSCaseInsensitiveSearch].location != NSNotFound) {
                     UIAlertController * alert=   [UIAlertController
                                                   alertControllerWithTitle:AlertTitle
                                                   message:@"Something went wrong. Please try after some time."
                                                   preferredStyle:UIAlertControllerStyleAlert];
                     
                     UIAlertAction* noButton = [UIAlertAction
                                                actionWithTitle:@"Ok"
                                                style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * action)
                                                {
                                                    [alert dismissViewControllerAnimated:YES completion:nil];
                                                    
                                                }];
                     
                     [alert addAction:noButton];
                     
                     [self presentViewController:alert animated:YES completion:nil];
                }
               
        }
    
    }
    [kappDelegate HideIndicator];
}
#pragma  mark- textView Delegates
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [txtEmail resignFirstResponder ];
    [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    
//    [self textFieldShouldReturn:txtEmail];
    
//    if ([getValue isEqualToString:@"1"])
//    {
//        [self checkForParameter];
//        
//        NSString *variable=@"1";
//        NSUserDefaults *storeData=[NSUserDefaults standardUserDefaults];
//        [storeData setObject:variable forKey:@"data"];
//        [storeData synchronize];
//       
//        return YES;
//    }
//    [self checkEmail];
//    
   
    return  YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    svos = scrollView.contentOffset;
    if(textField == txtEmail) {
        
        if (IS_IPHONE_4_OR_LESS ){
            CGPoint pt;
            CGRect rc = [textField bounds];
            rc = [textField convertRect:rc toView:scrollView];
            pt = rc.origin;
            pt.x = 0;
            pt.y -= 200;
            [scrollView setContentOffset:pt animated:YES];
        }
    }
}
@end
