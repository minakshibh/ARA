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

@interface SignupEmailCheckViewController ()
{
    IBOutlet UITextField *txtEmail;
    NSMutableData *webData;
    int webservice;
    NSString *response_status,*firstname,*lastname,*phoneno,*UserDetailId;
    IBOutlet UIScrollView *scrollView;
    IBOutlet UIButton *btnVerifyEmail;
    IBOutlet UIButton *btnLogin;
    IBOutlet UIButton *lblAlreadyhaveanaccount;
}
@end

@implementation SignupEmailCheckViewController

- (void)viewDidLoad {
    txtEmail.delegate=self;
    [super viewDidLoad];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *valCheck = [NSString stringWithFormat:@"%@",[user valueForKey:@"from_fb"]];
    
    
    if ([valCheck isEqualToString:@"yes"]) {
      txtEmail.text = [NSString stringWithFormat:@"%@",[user valueForKey:@"user_email"]];
         [self checkEmail];
    }

}
- (IBAction)step2btnAction:(id)sender {
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
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnVerifyEmail:(id)sender {
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
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - functions
-(void)checkforAvailability:(NSString*)email
{
    NSMutableURLRequest *request;
    NSString*_postData ;
    [kappDelegate ShowIndicator];
    webservice=6;
    _postData = [NSString stringWithFormat:@"Email=%@",txtEmail.text];
    
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
-(void)forgotPassword:(NSString*)email
{
    [kappDelegate ShowIndicator];
    NSMutableURLRequest *request ;
    NSString*_postData ;
    webservice =7;
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
        
        
        
        if (![userDetailDict isKindOfClass:[NSNull class]])
        {
            
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
                    NSString* emailStr = [txtEmail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

                    NSArray *values = [[NSArray alloc]initWithObjects:firstname,lastname,phoneno,UserDetailId,emailStr, nil];
                    
                    
                    SignUpViewController *signUpView = [[SignUpViewController alloc]initWithNibName:@"SignUpViewController" bundle:nil];
                    signUpView.fromEmailView = @"yes";
                    signUpView.valuesArray = values;
                    signUpView.isClient = @"yes";
                    [self.navigationController pushViewController:signUpView animated:YES];
                    
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
                                                    
                                                    [alert dismissViewControllerAnimated:YES completion:nil];
                                                     NSString* emailStr = [txtEmail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                                                    [self forgotPassword:emailStr];
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

            
            
            
            
        }
        
        
        
        
    }else{
        
        if (webservice==6) {
            if ([responseString rangeOfString:@"Email address not exist" options:NSCaseInsensitiveSearch].location != NSNotFound)
            {
                NSString* emailStr = [txtEmail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

                SignUpViewController *signupView = [[SignUpViewController   alloc]initWithNibName:@"SignUpViewController" bundle:nil];
                NSArray *value = [[NSArray alloc]initWithObjects:@"",@"",@"",@"",emailStr, nil];
                signupView.fromEmailView = @"yes";
                signupView.valuesArray = value;
                [self.navigationController pushViewController:signupView animated:YES];
           
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
