//
//  RecoveryViewController.m
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 20/04/16.
//  Copyright © 2016 Krishna_Mac_2. All rights reserved.
//

#import "RecoveryViewController.h"
#import "LoginViewController.h"
#import "dashboardViewController.h"

@interface RecoveryViewController ()

@end

@implementation RecoveryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (IS_IPAD)
    {
        btnlogin.titleLabel.font = [btnlogin.titleLabel.font fontWithSize:20];
        txtConfirmPassword.font = [txtConfirmPassword.font fontWithSize:20]
        ;
        txtNewPassword.font = [txtNewPassword.font fontWithSize:20]
        ;
        ;
        btnChangePassword.titleLabel.font = [btnChangePassword.titleLabel.font fontWithSize:24];

        lblAlreadyhaveavalidpwd.font = [lblAlreadyhaveavalidpwd.font fontWithSize:20]
        ;
        btnlogin.titleLabel.font = [btnlogin.titleLabel.font fontWithSize:20];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- Action Buttons
- (IBAction)btnLogin:(id)sender{
    LoginViewController *loginVC = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    [self.navigationController pushViewController:loginVC animated:YES];
}

- (IBAction)btnChangePassword:(id)sender
{
    [scrollView setContentOffset:CGPointMake(0, -20) animated:YES];
    
    NSCharacterSet *validChars = [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"];

    NSString* newPasswordStr = [txtNewPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString* confirmPasswordStr = [txtConfirmPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    UIAlertView *alert;
    NSString *message;

    if([txtNewPassword isEmpty])
    {
        message = @"Please enter your new password";
        [HelperAlert alertWithOneBtn:AlertTitle description:message okBtn:OkButtonTitle];
        
        return;
    }
    
    if(txtNewPassword.text.length < 6)
    {
        message = @"Password should have atleast 6 characters and a number without whitespaces.";
        [HelperAlert  alertWithOneBtn:AlertTitle description:message okBtn:OkButtonTitle];
        return;
    }
    else if(txtNewPassword.text.length >= 6 && [txtNewPassword.text rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]].location == NSNotFound)
    {
        message = @"Password should have atleast 6 characters and a number without whitespaces.";
        
        [HelperAlert  alertWithOneBtn:AlertTitle description:message okBtn:OkButtonTitle];
        return;
    }
    else if (txtNewPassword.text.length >= 6 && [txtNewPassword.text rangeOfCharacterFromSet:validChars].location == NSNotFound )
    {
        message = @"Password should have atleast 6 characters and a number without whitespaces.";
        
        [HelperAlert  alertWithOneBtn:AlertTitle description:message okBtn:OkButtonTitle];
        return;
    }
    else if(![txtNewPassword.text isEqualToString:txtConfirmPassword.text])
    {
        message = @"New password and confirm password should be same.";
        [HelperAlert alertWithOneBtn:AlertTitle description:message okBtn:OkButtonTitle];
        return;
    }

    
    [self.view endEditing:YES];
    [self resetPassword:confirmPasswordStr :self.email];
}

-(void)resetPassword:(NSString*)pwd :(NSString*)email
{
    [kappDelegate ShowIndicator];
    
    NSMutableURLRequest *request ;
    NSString*_postData ;
    
    _postData = [NSString stringWithFormat:@""];
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/user/updatePassword",Kwebservices]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
    
    NSLog(@"data post >>> %@",_postData);
    
    [request setHTTPMethod:@"GET"];
    [request addValue:email forHTTPHeaderField:@"username"];
    [request addValue:pwd forHTTPHeaderField:@"userpassword"];
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

#pragma mark UITextField Delegate Methods
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    scrollView.scrollEnabled = YES;
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(350, 700);
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    scrollView.scrollEnabled = NO;
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField ==txtNewPassword){
        [txtConfirmPassword becomeFirstResponder];
        return YES;
    }
    
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
        if( textField == txtConfirmPassword ) {
            
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
    if([status isEqualToString:@"failed"])
    {
        UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:AlertTitle  message:responseString  preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            [self.navigationController popViewControllerAnimated:true];
            [self.navigationController dismissViewControllerAnimated:true completion:nil];
            
            [self dismissViewControllerAnimated:YES completion:nil];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
        
        return;
    }

    
    if([status isEqualToString:@"passed"])
    {
        UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:AlertTitle  message:@"Your password has been changed"  preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            LoginViewController *loginVC = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
            [self.navigationController pushViewController:loginVC animated:YES];
            
            [self dismissViewControllerAnimated:YES completion:nil];
            

        }]];
        [self presentViewController:alertController animated:YES completion:nil];
       
    }
}
@end
