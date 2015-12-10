
//
//  LoginViewController.m
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 10/08/15.
//  Copyright (c) 2015 Krishna_Mac_2. All rights reserved.
//

#import "LoginViewController.h"
#import "ForgotPasswordViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "dashboardViewController.h"
#import "JSON.h"
#import "SBJson.h"
#import "ASIHTTPRequest.h"

@interface LoginViewController (){
    IBOutlet UIImageView *imagelogo;
    CGPoint svos;
    IBOutlet UIScrollView *scrollView;
    IBOutlet UILabel *lblPass;
    IBOutlet UILabel *lblAlreadyHaveAnAccount;
    IBOutlet UILabel *lblEmail;
    IBOutlet UIButton *btnForgotPassword;
    IBOutlet UIButton *btnSignUp;
    IBOutlet UIButton *btnFacebookLogin;
    SignUpViewController *SUvc;
    IBOutlet UIButton *btnLogin;
    IBOutlet UIButton *btnCheckbox;
    BOOL checkbox_Value;
    UIImage *btnImage;
    IBOutlet UITextField *txtEmail;
    IBOutlet UITextField *txtPassword;
    NSMutableData *webData;
    NSString *status;
}
//- (IBAction)btnCheckbox:(id)sender;
//- (IBAction)btnForgotPassword:(id)sender;
//- (IBAction)btnSignUp:(id)sender;
//- (IBAction)btnFacebookLogin:(id)sender;
//- (IBAction)btnLogin:(id)sender;


@end

@implementation LoginViewController

- (void)viewDidLoad {
   [super viewDidLoad];
    
    //---initialize checkbox value first tiem with false
    checkbox_Value = false;
    
    [HelperUDLib removeObject:@"self"];

    NSLog(@"%@",[HelperUDLib valueForKey:@"remember_me_status"]);
    
    if([HelperUDLib valueForKey:@"remember_me_status"])
    {
        txtEmail.text = [HelperUDLib valueForKey:@"remember_me_status_email"];
        txtPassword.text = [HelperUDLib valueForKey:@"remember_me_status_pass"];
        [btnCheckbox setImage:[UIImage imageNamed:@"checkbox-checked.png"] forState:UIControlStateNormal];
        checkbox_Value = true;
    }
    
    //--scrolview initialization
    scrollView.scrollEnabled = YES;
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(200, 450);
    scrollView.backgroundColor=[UIColor clearColor];
    
    
   
    //--hide navigation bar
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    //--initialize singup view object
    SUvc = [[SignUpViewController alloc]initWithNibName:@"SignUpViewController" bundle:nil];
    
    
    //---Make cornor round of button and text fields
    btnLogin.layer.cornerRadius = 3.0;
    [btnLogin setClipsToBounds:YES];
     lblEmail.layer.cornerRadius = 2.0;
    [lblEmail setClipsToBounds:YES];
    lblPass.layer.cornerRadius = 2.0;
    [lblPass setClipsToBounds:YES];
    btnCheckbox.layer.cornerRadius = 2.0;
    [btnCheckbox setClipsToBounds:YES];
    
    
    if (IS_IPAD)
    {
        btnCheckbox.titleLabel.font = [btnCheckbox.titleLabel.font fontWithSize:20];
        btnForgotPassword.titleLabel.font = [btnForgotPassword.titleLabel.font fontWithSize:20];
        lblAlreadyHaveAnAccount.font = [lblAlreadyHaveAnAccount.font fontWithSize:20]
        ;
        btnSignUp.titleLabel.font = [btnSignUp.titleLabel.font fontWithSize:20];
        
        btnLogin.titleLabel.font = [btnLogin.titleLabel.font fontWithSize:24];
        btnFacebookLogin.titleLabel.font = [btnFacebookLogin.titleLabel.font fontWithSize:24];
        txtEmail.font = [lblAlreadyHaveAnAccount.font fontWithSize:24]
        ;
        txtPassword.font = [lblAlreadyHaveAnAccount.font fontWithSize:24]
        ;
    }
    [self.view endEditing:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    if([[HelperUDLib valueForKey:@"remember_me_status"] isEqualToString:@"yes"])
    {
        txtEmail.text = [HelperUDLib valueForKey:@"remember_me_status_email"];
        txtPassword.text = [HelperUDLib valueForKey:@"remember_me_status_pass"];
        [btnCheckbox setImage:[UIImage imageNamed:@"checkbox-checked.png"] forState:UIControlStateNormal];
    }
    
    [txtEmail resignFirstResponder];
    [txtPassword resignFirstResponder];
    
    
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
-(void)viewWillDisappear:(BOOL)animated
{
    txtPassword.text =@"";
    txtEmail.text =@"";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark UITextField Delegate Methods
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField ==txtEmail){
        [txtPassword becomeFirstResponder];
        return YES; 
    }
    
    [self checkLogin];

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
     

    if( textField == txtPassword ) {
        
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
#pragma mark Button Actions
- (IBAction)btnCheckbox:(id)sender {
    
    
    //---toggle functionality of checkbox
    if(checkbox_Value == true)
    {
        checkbox_Value = false;
        btnImage = [UIImage imageNamed:@"checkbox-unchecked.png"];
        [btnCheckbox setImage:btnImage forState:UIControlStateNormal];
        return;
    }
        checkbox_Value = true;
    btnImage = [UIImage imageNamed:@"checkbox-checked.png"];
    [btnCheckbox setImage:btnImage forState:UIControlStateNormal];
}

- (IBAction)btnForgotPassword:(id)sender {
    ForgotPasswordViewController *FPvc = [[ForgotPasswordViewController alloc]initWithNibName:@"ForgotPasswordViewController" bundle:nil];
    FPvc.email = txtEmail.text;
    [self.navigationController pushViewController:FPvc animated:YES];
}

- (IBAction)btnSignUp:(id)sender {
    [self.navigationController pushViewController:SUvc animated:YES];
}

- (IBAction)btnFacebookLogin:(id)sender {
  
    [self facebookLogin];
}
- (IBAction)btnLogin:(id)sender {
    
    [self checkLogin];
}
//- (BOOL)validateEmailWithString:(NSString*)email
//{
//    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
//    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
//    return [emailTest evaluateWithObject:email];
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
        status = @"passed";
        
    }else if ((long)[httpResponse statusCode] == ResultFailed)
    {
        status = @"failed";
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
    if([status isEqualToString:@"failed"])
    {
        [HelperAlert alertWithOneBtn:AlertTitle description:responseString okBtn:OkButtonTitle];
       
        return;
    }
    SBJsonParser *json = [[SBJsonParser alloc] init];
    NSMutableDictionary *userDetailDict=[json objectWithString:responseString error:&error];
    
    if([status isEqualToString:@"passed"])
    {
    NSString *email = [NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"Email"]];
    NSString *first_name = [NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"FirstName"]];
    NSString *last_name = [NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"LastName"]];
    NSString *facebook_user = [NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"IsFacebookUser"]];
    NSString *mea_id = [NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"MEAID"]];
    NSString *mea_name = [NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"MEAName"]];
    NSString *phone_no = [NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"PhoneNumber"]];
    NSString *user_name = [NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"UserName"]];
    NSString *user_id = [NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"UserId"]];
    NSString *password = [NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"Password"]];
    NSString *role_name = [NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"RoleName"]];
    NSString *role_id = [NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"RoleID"]];
    NSString *purchased_before = [NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"PurchasedBefore"]];
    NSString *profile_picture = [NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"ProfilePicName"]];
        
        
        
    [HelperUDLib setObject:email forKey:@""];
    [HelperUDLib setObject:email forKey:@"l_email"];
    [HelperUDLib setObject:first_name forKey:@"l_firstName"];
    [HelperUDLib setObject:last_name forKey:@"l_lastName"];
    [HelperUDLib setObject:facebook_user forKey:@"l_facebookUser"];
    [HelperUDLib setObject:mea_id forKey:@"l_meaId"];
    [HelperUDLib setObject:mea_name forKey:@"l_meaName"];
    [HelperUDLib setObject:phone_no forKey:@"l_phoneNo"];
    [HelperUDLib setObject:user_name forKey:@"l_userName"];
    [HelperUDLib setObject:user_id forKey:@"l_userid"];
    [HelperUDLib setObject:role_name forKey:@"l_roleName"];
    [HelperUDLib setObject:role_id forKey:@"l_roleId"];
    [HelperUDLib setObject:purchased_before forKey:@"l_purchasedBefore"];
    [HelperUDLib setObject:password forKey:@"l_password"];
    [HelperUDLib setObject:@"yes" forKey:@"l_loggedin"];
    [HelperUDLib setObject:profile_picture forKey:@"l_image"];
        
        
       
    [HelperUDLib setObject:[NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"UserToken"]] forKey:@"UserToken"];
    NSLog(@"%@",[NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"UserToken"]]);
        
    if(checkbox_Value == true)
    {
        [HelperUDLib setObject:@"yes" forKey:@"remember_me_status"];
        [HelperUDLib setObject:email forKey:@"remember_me_status_email"];
        [HelperUDLib setObject:password forKey:@"remember_me_status_pass"];
    }else{
        [HelperUDLib removeObject:@"remember_me_status"];
        [HelperUDLib removeObject:@"remember_me_status_email"];
        [HelperUDLib removeObject:@"remember_me_status_pass"];
    }
    
    
    [kappDelegate HideIndicator];
    dashboardViewController *obj = [[dashboardViewController alloc]initWithNibName:@"dashboardViewController" bundle:nil];
    obj.from_login = @"yes";
    
    [self.navigationController pushViewController:obj animated:YES];
    }else{
        [HelperAlert alertWithOneBtn:AlertTitle description:responseString okBtn:OkButtonTitle];
    }
    [kappDelegate HideIndicator];

}

#pragma mark Methods
-(void)getFacebookProfile:(NSString *)token
{
    NSString *urlString1 = [NSString stringWithFormat:@"https://graph.facebook.com/me?access_token=%@&fields=email,first_name,last_name",token];
      NSURL *url1 = [NSURL URLWithString:[urlString1 stringByReplacingOccurrencesOfString:@" " withString:@"%20"]];
     NSData *dataURL1 =  [NSData dataWithContentsOfURL:url1];
    if (dataURL1)
    {
        NSDictionary* dict1=[NSJSONSerialization JSONObjectWithData:dataURL1 options:NSJSONReadingMutableContainers error:Nil];
        NSString *emailstr = [dict1 valueForKey:@"email"];
        NSString *firstnamestr = [dict1 valueForKey:@"first_name"];
        NSString *lastnamestr = [dict1 valueForKey:@"last_name"];
        [HelperUDLib setObject:emailstr forKey:@"user_email"];
        [HelperUDLib setObject:[NSString stringWithFormat:@"%@ %@",firstnamestr,lastnamestr]   forKey:@"user_name"];

    }
    
    NSString *urlString =[NSString stringWithFormat:@"https://graph.facebook.com/me?access_token=%@",token];
    NSURL *url = [NSURL URLWithString:[urlString stringByReplacingOccurrencesOfString:@" " withString:@"%20"]];
    NSData *dataURL =  [NSData dataWithContentsOfURL:url];
    if (dataURL)
    {
        NSDictionary* dict=[NSJSONSerialization JSONObjectWithData:dataURL options:NSJSONReadingMutableContainers error:Nil];
        
        NSString *facebookID= [dict valueForKey:@"id"];
        [HelperUDLib setObject:facebookID forKey:@"user_fb_id"];

        NSURL *pictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", facebookID]];
        [HelperUDLib setObject:[NSString stringWithFormat:@"%@",pictureURL] forKey:@"l_image"];

        NSData *imageData = [NSData dataWithContentsOfURL:pictureURL];
        [HelperUDLib setObject:imageData forKey:@"user_image"];
    }
}
- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error
{
    // If the session was opened successfully
    if (!error && state == FBSessionStateOpen){
        NSLog(@"Session opened");
        
        NSString * fbToken = [[FBSession activeSession] accessToken];
        [self getFacebookProfile:fbToken];
        [HelperUDLib setValue:fbToken forKey:@"TokenData"];
        // Show the user the logged-in UI
        SUvc.from_fb_button = @"yes";
        [HelperUDLib setObject:@"yes" forKey:@"from_fb"];
        [self.navigationController pushViewController:SUvc animated:YES];

        return;
    }
    if (state == FBSessionStateClosed || state == FBSessionStateClosedLoginFailed){
        // If the session is closed
        NSLog(@"Session closed");
        // Show the user the logged-out UI
        [HelperUDLib removeObject:@"l_email"];
        [HelperUDLib removeObject:@"l_firstName"];
        [HelperUDLib removeObject:@"l_lastName"];
        [HelperUDLib removeObject:@"l_facebookUser"];
        [HelperUDLib removeObject:@"l_meaId"];
        [HelperUDLib removeObject:@"l_meaName"];
        [HelperUDLib removeObject:@"l_phoneNo"];
        [HelperUDLib removeObject:@"l_userName"];
        [HelperUDLib removeObject:@"l_userid"];
        [HelperUDLib removeObject:@"l_roleName"];
        [HelperUDLib removeObject:@"l_roleId"];
        [HelperUDLib removeObject:@"l_purchasedBefore"];
        [HelperUDLib removeObject:@"l_image"];
        [HelperUDLib removeObject:@"l_loggedin"];
        [HelperUDLib removeObject:@"from_fb"];

        LoginViewController *LIvc = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
        [self.navigationController pushViewController:LIvc animated:YES];
        
        NSLog(@"----------------------------");

        // [self userLoggedOut];
    }
    
    // Handle errors
    if (error){
        NSLog(@"Error");
        NSString *alertText;
        NSString *alertTitle;
        // If the error requires people using an app to make an action outside of the app in order to recover
        if ([FBErrorUtility shouldNotifyUserForError:error] == YES){
            alertTitle = @"Something went wrong";
            NSLog(@"%@",alertTitle);

            alertText = [FBErrorUtility userMessageForError:error];
            //[self showMessage:alertText withTitle:alertTitle];
        } else {
            
            // If the user cancelled login, do nothing
            if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
                NSLog(@"User cancelled login");
                
                // Handle session closures that happen outside of the app
            } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession){
                alertTitle = @"Session Error";
                alertText = @"Your current session is no longer valid. Please log in again.";
                NSLog(@"%@",alertText);
                // [self showMessage:alertText withTitle:alertTitle];
                
                // Here we will handle all other errors with a generic error message.
                // We recommend you check our Handling Errors guide for more information
                // https://developers.facebook.com/docs/ios/errors/
            } else {
                //Get more error information from the error
                NSDictionary *errorInformation = [[[error.userInfo objectForKey:@"com.facebook.sdk:ParsedJSONResponseKey"] objectForKey:@"body"] objectForKey:@"error"];
                
                // Show the user an error message
                alertTitle = @"Something went wrong";
                alertText = [NSString stringWithFormat:@"Please retry. \n\n If the problem persists contact us and mention this error code: %@", [errorInformation objectForKey:@"message"]];
                //[self showMessage:alertText withTitle:alertTitle];
                
                NSLog(@"%@",[NSString stringWithFormat:@"Please retry. \n\n If the problem persists contact us and mention this error code: %@", [errorInformation objectForKey:@"message"]]);
            }
        }
        // Clear this token
        [FBSession.activeSession closeAndClearTokenInformation];
        // Show the user the logged-out UI
        //[self userLoggedOut];
    }
    
    [kappDelegate HideIndicator];
}


-(void)facebookLogin
{
    
    if (FBSession.activeSession.state == FBSessionStateOpen
        || FBSession.activeSession.state == FBSessionStateOpenTokenExtended) {
        
        // Close the session and remove the access token from the cache
        // The session state handler (in the app delegate) will be called automatically
        [FBSession.activeSession closeAndClearTokenInformation];
        
        // If the session state is not any of the two "open" states when the button is clicked
    } else {
        // Open a session showing the user the login UI
        // You must ALWAYS ask for public_profile permissions when opening a session
        NSArray *permissions = [[NSArray alloc] initWithObjects:@"public_profile, email", nil];
        
        [FBSession openActiveSessionWithReadPermissions:permissions
                                           allowLoginUI:YES
                                      completionHandler:
         ^(FBSession *session, FBSessionState state, NSError *error) {
             
             // Retrieve the app delegate
             // AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
             // Call the app delegate's sessionStateChanged:state:error method to handle session state changes
             [self sessionStateChanged:session state:state error:error];
         }];
    }
}

-(void) checkLogin
{
    NSString* emailStr = [txtEmail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString* passwordNameStr = [txtPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    UIAlertView *alert;
    NSString *message;
    if ([txtEmail isEmpty] ) {
        message = @"Please enter email address";
        //        alert = [[UIAlertView alloc]initWithTitle:@"ARA" message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        //        [alert show];
        [HelperAlert alertWithOneBtn:AlertTitle description:message okBtn:OkButtonTitle];
        return;
    }else if (passwordNameStr.length==0 ) {
        message = @"Please enter password";
        
        [HelperAlert alertWithOneBtn:AlertTitle description:message okBtn:OkButtonTitle];

        return;
    }
    
    //    if ([emailStr rangeOfString:@"@" options:NSCaseInsensitiveSearch].location != NSNotFound)
    //    {
    //        if (![txtEmail emailValidation]) {
    //
    //            message = @"Please enter email address";
    //            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"ARA" message:@"Please check your email address" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    //            [alert show];
    //            [txtEmail becomeFirstResponder];
    //            return;
    //        }
    //
    //    }
    
    [self.view endEditing:YES];
    
    //    [txtPassword resignFirstResponder];
    //    [txtEmail resignFirstResponder];
    [scrollView setContentOffset:CGPointMake(0, -20) animated:YES];
    
    [self login:emailStr password:passwordNameStr];
}
-(void)login:(NSString*)email password:(NSString*)password
{
    [kappDelegate ShowIndicator];
    NSMutableURLRequest *request ;
    NSString*_postData ;
    
    _postData = [NSString stringWithFormat:@""];
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/accounts/login",Kwebservices]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
    
    
    
    NSLog(@"data post >>> %@",_postData);
    
    [request setHTTPMethod:@"GET"];
    [request addValue:email forHTTPHeaderField:@"username"];
    [request addValue:password forHTTPHeaderField:@"userpassword"];
    
    
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
