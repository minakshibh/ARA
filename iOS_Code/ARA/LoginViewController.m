
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
#import "ASIHTTPRequest.h"
#import <Crittercism/Crittercism.h>
#import "SignupEmailCheckViewController.h"
#import "DBManager.h"

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

//- (IBAction)btnForgotPassword:(id)sender;
//- (IBAction)btnSignUp:(id)sender;
//- (IBAction)btnFacebookLogin:(id)sender;
//- (IBAction)btnLogin:(id)sender;


@end

@implementation LoginViewController

- (void)viewDidLoad {
   [super viewDidLoad];

    NSLog(@"login view");

//    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured:)];
//    [self.view addGestureRecognizer:singleTap];
    
    //---initialize checkbox value first tiem with false
    checkbox_Value = false;
    
//    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"self"];

    NSLog(@"remember_me_status---%@",[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"remember_me_status"]]);
    
    if ([[NSUserDefaults standardUserDefaults]valueForKey:@"remember_me_status"] != nil) {
        
        if([[[NSUserDefaults standardUserDefaults]valueForKey:@"remember_me_status"] isEqualToString:@"yes"])
        {
            txtEmail.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"remember_me_status_email"];
            txtPassword.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"remember_me_status_pass"];
            [btnCheckbox setImage:[UIImage imageNamed:@"checkbox-checked.png"] forState:UIControlStateNormal];
            checkbox_Value = true;
        }
        
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
        txtEmail.font = [lblAlreadyHaveAnAccount.font fontWithSize:20]
        ;
        txtPassword.font = [lblAlreadyHaveAnAccount.font fontWithSize:20]
        ;

        if(IS_IPAD_PRO_1366)
        {
            btnCheckbox.titleLabel.font = [btnCheckbox.titleLabel.font fontWithSize:24];
            btnForgotPassword.titleLabel.font = [btnForgotPassword.titleLabel.font fontWithSize:24];
            lblAlreadyHaveAnAccount.font = [lblAlreadyHaveAnAccount.font fontWithSize:24]
            ;
            btnSignUp.titleLabel.font = [btnSignUp.titleLabel.font fontWithSize:24];
            
            btnLogin.titleLabel.font = [btnLogin.titleLabel.font fontWithSize:30];
            btnFacebookLogin.titleLabel.font = [btnFacebookLogin.titleLabel.font fontWithSize:30];
            txtEmail.font = [lblAlreadyHaveAnAccount.font fontWithSize:30]
            ;
            txtPassword.font = [lblAlreadyHaveAnAccount.font fontWithSize:30]
            ;
        }
        
    }
}
-(void)viewWillAppear:(BOOL)animated
{
  if ([[NSUserDefaults standardUserDefaults]valueForKey:@"remember_me_status"] != nil) {
    
    if([[[NSUserDefaults standardUserDefaults]valueForKey:@"remember_me_status"] isEqualToString:@"yes"])
    {
        txtEmail.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"remember_me_status_email"];
        txtPassword.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"remember_me_status_pass"];
        [btnCheckbox setImage:[UIImage imageNamed:@"checkbox-checked.png"] forState:UIControlStateNormal];
    }
    
  }
    [txtEmail resignFirstResponder];
    [txtPassword resignFirstResponder];
    

//    int d = 0; // standard display
//    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2.0) {
//        d = 1; // is retina display
//    }
//    
//    if (IS_IPAD) {
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
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == txtEmail)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardDidShowNotification object:nil];
        
    }
    if (textField == txtPassword)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardDidShowNotification object:nil];
        
    }
    scrollView.scrollEnabled = YES;
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(350, 700);
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if (textField == txtEmail)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardDidHideNotification object:nil];
    }
    
    if (textField == txtPassword)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardDidShowNotification object:nil];
    }
    scrollView.scrollEnabled = NO;
     [scrollView setContentOffset:CGPointMake(0, -20) animated:YES];
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField ==txtEmail){
        [txtPassword becomeFirstResponder];
        return YES; 
    }
    
    [self checkLogin];

   
    
    [textField resignFirstResponder];
//    scrollView.scrollEnabled = YES;
    
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    svos = scrollView.contentOffset;
//    scrollView.scrollEnabled = YES;
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
    }else{
        checkbox_Value = true;
        btnImage = [UIImage imageNamed:@"checkbox-checked.png"];
        [btnCheckbox setImage:btnImage forState:UIControlStateNormal];
    }
    
}

- (IBAction)btnForgotPassword:(id)sender {
    ForgotPasswordViewController *FPvc = [[ForgotPasswordViewController alloc]initWithNibName:@"ForgotPasswordViewController" bundle:nil];
    FPvc.email = txtEmail.text;
    [self.view endEditing:YES];
    [self.navigationController pushViewController:FPvc animated:YES];
}

- (IBAction)btnSignUp:(id)sender {
    SignupEmailCheckViewController *signupEmail = [[SignupEmailCheckViewController alloc]initWithNibName:@"SignupEmailCheckViewController" bundle:nil];
    [self.view endEditing:YES];
    [self.navigationController pushViewController:signupEmail animated:YES];
   // [self.navigationController pushViewController:SUvc animated:YES];
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
    if([status isEqualToString:@"failed"])
    {
//        [HelperAlert alertWithOneBtn:AlertTitle description:responseString okBtn:OkButtonTitle];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"ARA" message:responseString delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
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
        
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];

        
    [user setObject:email forKey:@""];
    [user setObject:email forKey:@"l_email"];
    [user setObject:first_name forKey:@"l_firstName"];
    [user setObject:last_name forKey:@"l_lastName"];
    [user setObject:facebook_user forKey:@"l_facebookUser"];
    [user setObject:mea_id forKey:@"l_meaId"];
    [user setObject:mea_name forKey:@"l_meaName"];
    [user setObject:phone_no forKey:@"l_phoneNo"];
    [user setObject:user_name forKey:@"l_userName"];
    [user setObject:user_id forKey:@"l_userid"];
    [user setObject:role_name forKey:@"l_roleName"];
    [user setObject:role_id forKey:@"l_roleId"];
    [user setObject:purchased_before forKey:@"l_purchasedBefore"];
    [user setObject:password forKey:@"l_password"];
    [user setObject:@"yes" forKey:@"l_loggedin"];
    [user setObject:profile_picture forKey:@"l_image"];
        
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        NSString* dateStr = [dateFormatter stringFromDate:[NSDate date]];
        
        NSMutableDictionary *saveDateDict = [[NSMutableDictionary alloc]init];
        
        if ([user valueForKey:@"loginDateSaved"]!=nil) {
            NSData *data = [user objectForKey:@"loginDateSaved"];
            NSMutableDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            
            saveDateDict  = dict;
            if ([saveDateDict valueForKey:[user valueForKey:@"l_userid"]]) {
                
            }else{
                 [saveDateDict setObject:[NSString stringWithFormat:@"%@",dateStr] forKey:user_id];
            }
        }else{
            [saveDateDict setObject:[NSString stringWithFormat:@"%@",dateStr] forKey:[user valueForKey:@"l_userid"]];
        }
        
        NSData *data1 = [NSKeyedArchiver archivedDataWithRootObject:saveDateDict];
        [user setObject:data1 forKey:@"loginDateSaved"];
        
       
    [user setObject:[NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"UserToken"]] forKey:@"UserToken"];
    NSLog(@"%@",[NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"UserToken"]]);
        
    if(checkbox_Value == true)
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"remember_me_status"];
        [[NSUserDefaults standardUserDefaults] setObject:email forKey:@"remember_me_status_email"];
        [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"remember_me_status_pass"];
    }else{
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"remember_me_status"];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"remember_me_status_email"];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"remember_me_status_pass"];
    }
    
        DBManager *db = [[DBManager alloc]init];
        bool createDB = [db createDB];
        
        
    [kappDelegate HideIndicator];
    dashboardViewController *obj = [[dashboardViewController alloc]initWithNibName:@"dashboardViewController" bundle:nil];
    obj.from_login = @"yes";
    
    [self.navigationController pushViewController:obj animated:YES];
        
        
        
    }else{
//        [HelperAlert alertWithOneBtn:AlertTitle description:responseString okBtn:OkButtonTitle];
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"ARA" message:responseString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    [kappDelegate HideIndicator];

}

#pragma mark Methods
- (void)singleTapGestureCaptured:(UITapGestureRecognizer *)gesture
{
    [self.view endEditing:YES];
    
}
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
        [[NSUserDefaults standardUserDefaults] setObject:emailstr forKey:@"user_email"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@ %@",firstnamestr,lastnamestr]   forKey:@"user_name"];

    }
    
    NSString *urlString =[NSString stringWithFormat:@"https://graph.facebook.com/me?access_token=%@",token];
    NSURL *url = [NSURL URLWithString:[urlString stringByReplacingOccurrencesOfString:@" " withString:@"%20"]];
    NSData *dataURL =  [NSData dataWithContentsOfURL:url];
    if (dataURL)
    {
        NSDictionary* dict=[NSJSONSerialization JSONObjectWithData:dataURL options:NSJSONReadingMutableContainers error:Nil];
        
        NSString *facebookID= [dict valueForKey:@"id"];
        [[NSUserDefaults standardUserDefaults] setObject:facebookID forKey:@"user_fb_id"];

        NSURL *pictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", facebookID]];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",pictureURL] forKey:@"l_image"];

        NSData *imageData = [NSData dataWithContentsOfURL:pictureURL];
        [[NSUserDefaults standardUserDefaults] setObject:imageData forKey:@"user_image"];
    }
}
- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error
{
    // If the session was opened successfully
    if (!error && state == FBSessionStateOpen){
        NSLog(@"Session opened");
        
        NSString * fbToken = [[FBSession activeSession] accessToken];
        [self getFacebookProfile:fbToken];
        [[NSUserDefaults standardUserDefaults] setValue:fbToken forKey:@"TokenData"];
        // Show the user the logged-in UI
        SUvc.from_fb_button = @"yes";
        [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"from_fb"];
        
        SignupEmailCheckViewController *SignupEmailCheck = [[SignupEmailCheckViewController alloc]initWithNibName:@"SignupEmailCheckViewController" bundle:nil];
        [self.navigationController pushViewController:SignupEmailCheck animated:YES];

        return;
    }
    if (state == FBSessionStateClosed || state == FBSessionStateClosedLoginFailed){
        // If the session is closed
        NSLog(@"Session closed");
        // Show the user the logged-out UI
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

        LoginViewController *LIvc = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
         NSLog(@"-----facebokk111------");
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
    if (emailStr.length==0) {
        message = @"Please enter email address";
                alert = [[UIAlertView alloc]initWithTitle:@"ARA" message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [alert show];
//        [HelperAlert alertWithOneBtn:AlertTitle description:message okBtn:OkButtonTitle];
        return;
    }else if (passwordNameStr.length==0) {
        message = @"Please enter password";
        
        alert = [[UIAlertView alloc]initWithTitle:@"ARA" message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
//        [HelperAlert alertWithOneBtn:AlertTitle description:message okBtn:OkButtonTitle];

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
    
//    [self.view endEditing:YES];
    
        [txtPassword resignFirstResponder];
        [txtEmail resignFirstResponder];
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
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}
- (void)keyboardWillShow:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    float newVerticalPosition = -keyboardSize.height + 100;
    
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
@end
