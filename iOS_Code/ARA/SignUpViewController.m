//
//  SignUpViewController.m
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 10/08/15.
//  Copyright (c) 2015 Krishna_Mac_2. All rights reserved.
//

#import "SignUpViewController.h"
#import "dashboardViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "ASIHTTPRequest.h"
#import "LoginViewController.h"
#import "UIView+Toast.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    txtMEA.text = @" ";
    [super viewDidLoad];
    
    imagecheckforemailView.hidden = YES;
    imagecheckforuseridView.hidden = YES;
    
        activityIndicatorObject = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];activityIndicatorObject1 = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    //--setting checkbox initial value
    checkbox_Value = false;

   //--scrolview initialization
    scrollView.scrollEnabled = YES;
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(200, 450);
    scrollView.backgroundColor=[UIColor clearColor];
    
    //---doing corner radious of all objects
    
    lblMEA.layer.cornerRadius = 2.0;  [lblMEA setClipsToBounds:YES];
    lblPassword.layer.cornerRadius = 2.0;  [lblPassword setClipsToBounds:YES];
    lblpreview.layer.cornerRadius = 2.0;  [lblpreview setClipsToBounds:YES];
    lblFirstname.layer.cornerRadius = 2.0;  [lblFirstname setClipsToBounds:YES];
    lbllastname.layer.cornerRadius = 2.0;  [lblFirstname setClipsToBounds:YES];
    lblUserId.layer.cornerRadius = 2.0;  [lblUserId setClipsToBounds:YES];
    lblPhoneNo.layer.cornerRadius = 2.0;  [lblPhoneNo setClipsToBounds:YES];
    lblEmail.layer.cornerRadius = 2.0;  [lblEmail setClipsToBounds:YES];
    btnCheckBox.layer.cornerRadius = 2.0;  [btnCheckBox setClipsToBounds:YES];
    btnSignup.layer.cornerRadius = 2.0;  [btnSignup setClipsToBounds:YES];

    
    //checking if coming to this view throudh facebook
    if([_from_fb_button isEqualToString:@"yes"])
    {
        NSUserDefaults *user_details = [NSUserDefaults standardUserDefaults];
        NSArray *name = [[user_details valueForKey:@"user_name"] componentsSeparatedByString:@" "];
        if(name.count >0)
        {
            txtFirstName.text = [name objectAtIndex:0];
            txtLastName.text = [name objectAtIndex:1];
        }
        txtFirstName.text = [name objectAtIndex:0];
        
        txtEmail.text = [user_details valueForKey:@"user_email"];
        NSArray *array = [[user_details valueForKey:@"user_email"] componentsSeparatedByString:@"@"];
        txtUserId.text = [array objectAtIndex:0];
        txtPhoneNo.text = [user_details valueForKey:@" "];
        
        txtPassword.hidden = YES;
        lblPassword.hidden = YES;
        imageIconPassword.hidden = YES;
        lblStickPassword.hidden = YES;
    }
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureHandlerMethod2:)];
    UITapGestureRecognizer *tapRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureHandlerMethod2:)];
    [loweView addGestureRecognizer:tapRecognizer1];
    [leftview addGestureRecognizer:tapRecognizer];
    
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    
    [numberToolbar sizeToFit];
    txtPhoneNo.inputAccessoryView = numberToolbar;
    
    
    if (IS_IPAD)
    {
        btnCheckBox.titleLabel.font = [btnCheckBox.titleLabel.font fontWithSize:20];
        btnSignup.titleLabel.font = [btnSignup.titleLabel.font fontWithSize:24];
        
        lblAlready.font = [lblAlready.font fontWithSize:20];
        btnLogIn.titleLabel.font = [btnLogIn.titleLabel.font fontWithSize:20];
        
        
        btnMEA.titleLabel.font = [btnMEA.titleLabel.font fontWithSize:20];
        btnPreviewCustomer.titleLabel.font = [btnPreviewCustomer.titleLabel.font fontWithSize:20];
        
        
        txtFirstName.font = [txtFirstName.font fontWithSize:20];
        txtLastName.font = [txtLastName.font fontWithSize:20];
        txtUserId.font = [txtUserId.font fontWithSize:20];
        txtPhoneNo.font = [txtPhoneNo.font fontWithSize:20];
        txtEmail.font = [txtEmail.font fontWithSize:20];
        txtPassword.font = [txtPassword.font fontWithSize:20];
        txtPreviousCoustomer.font = [txtPreviousCoustomer.font fontWithSize:20];
        txtMEA.font = [txtMEA.font fontWithSize:20];
        
        btnCheckBox.frame = CGRectMake(btnCheckBox.frame.origin.x, btnCheckBox.frame.origin.y-3, btnCheckBox.frame.size.width, btnCheckBox.frame.size.height);
        
        if(IS_IPAD_PRO_1366)
        {
            btnCheckBox.titleLabel.font = [btnCheckBox.titleLabel.font fontWithSize:24];
            btnSignup.titleLabel.font = [btnSignup.titleLabel.font fontWithSize:30];
            
            lblAlready.font = [lblAlready.font fontWithSize:24];
            btnLogIn.titleLabel.font = [btnLogIn.titleLabel.font fontWithSize:24];
            
            
            btnMEA.titleLabel.font = [btnMEA.titleLabel.font fontWithSize:30];
            btnPreviewCustomer.titleLabel.font = [btnPreviewCustomer.titleLabel.font fontWithSize:30];
            
            
            txtFirstName.font = [txtFirstName.font fontWithSize:30];
            txtLastName.font = [txtLastName.font fontWithSize:30];
            txtUserId.font = [txtUserId.font fontWithSize:30];
            txtPhoneNo.font = [txtPhoneNo.font fontWithSize:30];
            txtEmail.font = [txtEmail.font fontWithSize:30];
            txtPassword.font = [txtPassword.font fontWithSize:30];
            txtPreviousCoustomer.font = [txtPreviousCoustomer.font fontWithSize:30];
            txtMEA.font = [txtMEA.font fontWithSize:30];

            
        }
    }
}


-(void)viewWillAppear:(BOOL)animated
{
    //--assigning values to label
    if([_from_fb_button isEqualToString:@"yes"])
    {
        CGRect pwd_lbl_height = lblPassword.frame;
        float lbl_height = pwd_lbl_height.size.height;
        float lbl_y = pwd_lbl_height.origin.y;
        float total = lbl_height+lbl_y;
        
        CGRect passwordView_frame = passwordView.frame;
        float lbl_y_passwordView = passwordView_frame.origin.y;
        
        float spacing = lbl_y_passwordView-total;
        
    //--shift buttons upward
    CGRect frame_passwordView = passwordView.frame;
    float y_passwordView = frame_passwordView.origin.y - lbl_height-spacing;
    frame_passwordView.origin.y = y_passwordView;
    passwordView.frame = frame_passwordView;

    }
    // [self getMeaInformation];
    tableViewMEA.hidden=YES;
    tableViewPreviousCustomer.hidden=YES;
    
    //--resign first responder
    [txtEmail resignFirstResponder];
    [txtFirstName resignFirstResponder];
    [txtLastName resignFirstResponder];
    //[txtMEA resignFirstResponder];
    [txtPassword resignFirstResponder];
    [txtPhoneNo resignFirstResponder];
    [txtPreviousCoustomer resignFirstResponder];
    [txtUserId resignFirstResponder];
    
    
    //---get tableview data
    [self getPreviousCustomer];
    
    if ([_fromEmailView isEqualToString:@"yes"]) {
        if (_valuesArray.count>0) {
            if ([_isClient isEqualToString:@"yes"]) {
                found_client = @"yes";
            }
            txtFirstName.text = [_valuesArray objectAtIndex:0];
            txtLastName.text = [_valuesArray objectAtIndex:1];
            if ([[_valuesArray objectAtIndex:2] rangeOfString:@"<null>" options:NSCaseInsensitiveSearch].location != NSNotFound){
                txtPhoneNo.text = @"";
            }else{
                txtPhoneNo.text = [_valuesArray objectAtIndex:2];

            }
            UserDetailId = [NSString stringWithFormat:@"%@",[_valuesArray objectAtIndex:3]];
            txtEmail.text = [_valuesArray objectAtIndex:4];
            webserviceStatus = @"checked" ;
        }
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    imagecheckforemailView.image = nil;
    imagecheckforuseridView.image = nil;
    btnMEA.hidden=NO;
    
    lblemailerror.text =@"";
    lbluseriderror.text = @"";
    txtEmail.text =@"";
    txtFirstName.text =@"";
    txtLastName.text =@"";
    txtMEA.text =@" ";
    txtPreviousCoustomer.text =@" ";
    txtPassword.text =@"";
    txtPhoneNo.text =@"";
    txtUserId.text =@"";
     checkbox_Value = false;
     btnImage = [UIImage imageNamed:@"checkbox-unchecked.png"];
    [btnCheckBox setImage:btnImage forState:UIControlStateNormal];
//   txtMEA.text = @"Select MEA";
//    txtPreviousCoustomer.text = @"Select Role";
    [btnMEA setTitle:@"Select MEA" forState:UIControlStateNormal];
    [btnPreviewCustomer setTitle:@"Select Role" forState:UIControlStateNormal];
    
    found_client = [[NSString alloc]init];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark - Buttons
- (IBAction)btnMEA:(id)sender {
    
    if (status == true)
    {
        tableViewMEA.hidden=YES;
        status=false;
        return;
    }
    status=true;
    status1 =false;
    
    tableViewMEA.hidden=NO;
    tableViewPreviousCustomer.hidden=YES;
    
    tableViewMEA.layer.borderColor = [UIColor grayColor].CGColor;
    tableViewMEA.layer.borderWidth = 1.0;
    tableViewMEA.layer.cornerRadius = 4.0;
    [tableViewMEA setClipsToBounds:YES];
    
   
    [tableViewMEA reloadData];
    if(name_array_Mea.count==0)
    {
        tableViewMEA.hidden = YES;
    }

}

- (IBAction)btnPreviewCustomer:(id)sender {
    
    if (status1 == true)
    {
        tableViewPreviousCustomer.hidden=YES;
        status1=false;
        return;
    }
    status1=true;
    status=false;
    tableViewPreviousCustomer.hidden=NO;
    tableViewMEA.hidden=YES;
    
    tableViewPreviousCustomer.layer.borderColor = [UIColor grayColor].CGColor;
    tableViewPreviousCustomer.layer.borderWidth = 1.0;
    tableViewPreviousCustomer.layer.cornerRadius = 4.0;
    [tableViewPreviousCustomer setClipsToBounds:YES];
    
//    CGRect frame = tableViewPreviousCustomer.frame;
//    frame.size.height = name_array_prev_cust.count*35+5;
//    tableViewPreviousCustomer.frame = frame;
    [tableViewPreviousCustomer reloadData];
    
    if(name_array_prev_cust.count==0)
    {
        tableViewPreviousCustomer.hidden = YES;
    }
}

- (IBAction)btnLogIn:(id)sender {
    if([_from_fb_button isEqualToString:@"yes"])
    {
        LoginViewController *obj = [[LoginViewController alloc]init];
        [obj facebookLogin];
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnSignup:(id)sender {
    
    NSString* firstNameStr = [txtFirstName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString* lastNameStr = [txtLastName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString* userIdstr = [txtUserId.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString* phoneNostr = [txtPhoneNo.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSCharacterSet *unwantedStr = [NSCharacterSet characterSetWithCharactersInString:@"+() -"];
    phoneNostr = [[phoneNostr componentsSeparatedByCharactersInSet: unwantedStr] componentsJoinedByString: @""];

    
    NSString* emailAddressStr = [txtEmail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString* passwordStr = [txtPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
   
    NSString *message;
    if ([txtFirstName isEmpty] ) {
        message = @"Please Enter First Name";
        [HelperAlert  alertWithOneBtn:AlertTitle description:message okBtn:OkButtonTitle];

        
        return;
    } if (firstNameStr.length>25 ) {
        message = @"First name limit exceeds. Kindly enter a valid First name";
        [HelperAlert  alertWithOneBtn:AlertTitle description:message okBtn:OkButtonTitle];
        return;
    }else if ([txtLastName isEmpty]) {
        message = @"Please Enter Last Name";
        [HelperAlert  alertWithOneBtn:AlertTitle description:message okBtn:OkButtonTitle];
        return;
    }if (firstNameStr.length>25 ) {
        message = @"Last name limit exceeds. Kindly enter a valid Last name";
        [HelperAlert  alertWithOneBtn:AlertTitle description:message okBtn:OkButtonTitle];        return;
    }else if ([txtUserId isEmpty]) {
        message = @"Please Enter User ID";
        [HelperAlert  alertWithOneBtn:AlertTitle description:message okBtn:OkButtonTitle];
        return;
    }else if ([txtPhoneNo isEmpty] ) {
        message = @"Please Enter a valid phone no";
        [HelperAlert  alertWithOneBtn:AlertTitle description:message okBtn:OkButtonTitle];
        return;
    }
    if (phoneNostr.length>10 ) {
        if([[NSString stringWithFormat:@"%C",[phoneNostr characterAtIndex:0]] isEqual:@"1"])
        {
            
        }else{
        message = @"Please Enter a phone no with atmost 10 digits";
        [HelperAlert  alertWithOneBtn:AlertTitle description:message okBtn:OkButtonTitle];
        
            return;
        }
    }
    
    
    
    if (![txtEmail emailValidation]) {
        message = @"Please check your email address";
        [HelperAlert  alertWithOneBtn:AlertTitle description:message okBtn:OkButtonTitle];
        
        [txtEmail becomeFirstResponder];
        return;
    }else if ([txtPassword isEmpty] ) {
        int i=0;
        if([_from_fb_button isEqualToString:@"yes"])
        {
            i++;
        }
        if(i==0){
        message = @"Please Enter Password";
            [HelperAlert  alertWithOneBtn:AlertTitle description:message okBtn:OkButtonTitle];
        return;
        }
    }else if([txtPreviousCoustomer.text isEqualToString:@"Select Role"])
    {
        message = @"Please Select Any Role";
        [HelperAlert  alertWithOneBtn:AlertTitle description:message okBtn:OkButtonTitle];

        return;
        
    }else if ([txtPreviousCoustomer isEmpty] ) {
        message = @"Please Select Any Role";
        [HelperAlert  alertWithOneBtn:AlertTitle description:message okBtn:OkButtonTitle];

        return;
    }else if([txtMEA.text isEqual:@"Select MEA"])
    {
        message = @"Please Select a MEA";
        [HelperAlert  alertWithOneBtn:AlertTitle description:message okBtn:OkButtonTitle];

        return;
    }else if ([txtMEA isEmpty] ) {
        message = @"Please Select MEA";
        [HelperAlert  alertWithOneBtn:AlertTitle description:message okBtn:OkButtonTitle];

        return;
    }
    
    if([lbluseriderror.text isEqualToString:@"This userId already exists"])
    {
        message = @"Please select a different userid";
        [HelperAlert  alertWithOneBtn:AlertTitle description:message okBtn:OkButtonTitle];

        return;
    }

    if([lblemailerror.text isEqualToString:@"Email already registered."])
    {
        message = @"Unable to add user--email address already exists.";
        [HelperAlert  alertWithOneBtn:AlertTitle description:message okBtn:OkButtonTitle];

        return;
    }
    if([lblemailerror.text isEqualToString:@"Email not register with AAI - MEA account"])
    {
        message = @"Please select a different email address.";
        [HelperAlert  alertWithOneBtn:AlertTitle description:message okBtn:OkButtonTitle];
        return;
    }
    
    if (![webserviceStatus isEqualToString:@"checked"])
    {
        [self.view makeToast:@"Please wait a moment while we check your email."];
        internal=2;
        [txtEmail resignFirstResponder];
        [self checkforAvailability];
        [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        return;
    }
    
    NSString *fb_status,*value;
    //--check if user came from facebook
    if ([_from_fb_button isEqualToString: @"yes"]) {
        fb_status = @"true";
    }else{
        fb_status = @"false";
    }
    
    if(checkbox_Value == true)
    {
        value = @"true";
    }else{
        value = @"false";
    }
    
    //---to get role id
    NSString *role_id = selected_previousid;
//    for (int i=0; i<name_array_prev_cust.count; i++) {
//       if([[name_array_prev_cust objectAtIndex:i] isEqualToString:txtPreviousCoustomer.text])
//       {
//           role_id =  [NSString stringWithFormat:@"%@",[id_array_prev_cust objectAtIndex:i-1]];
//           break;
//       }
//    }
    //----to get mea id
    NSString *mea_id = selected_meaid;
//    for (int i=0; i<name_array_Mea.count; i++) {
//        if([[name_array_Mea objectAtIndex:i] isEqualToString:txtMEA.text])
//        {
//            mea_id = [NSString stringWithFormat:@"%@",[id_array_Mea objectAtIndex:i-1]];
//            break;
//        }
//    }
    
    NSString *userID = @"0";
    
    //---to hide everything
    tableViewMEA.hidden = YES;
    tableViewPreviousCustomer.hidden = YES;
    
    [txtEmail resignFirstResponder];
    [txtFirstName resignFirstResponder];
    [txtLastName resignFirstResponder];
    //[txtMEA resignFirstResponder];
    [txtPassword resignFirstResponder];
    [txtPhoneNo resignFirstResponder];
    [txtPreviousCoustomer resignFirstResponder];
    [txtUserId resignFirstResponder];
    
    [scrollView setContentOffset:CGPointMake(0, -20) animated:YES];
    scrollView.scrollEnabled = YES;
//--
    
    
        [self userRegestration:firstNameStr LastName:lastNameStr RoleID:role_id PhoneNumber:phoneNostr Emailid:emailAddressStr Password:passwordStr PurchasedBefore:value IsFacebookUser:fb_status MEAID:mea_id UserName:userIdstr userid:userID];
    
}
- (IBAction)btnCheckBox:(id)sender {
    if(checkbox_Value == true)
    {
     //   [self.view makeToast:@"unchecked...."];

        checkbox_Value = false;
        btnImage = [UIImage imageNamed:@"checkbox-unchecked.png"];
        [btnCheckBox setImage:btnImage forState:UIControlStateNormal];
        return;
    }
   // [self.view makeToast:@"checked...."];

    checkbox_Value = true;
    btnImage = [UIImage imageNamed:@"checkbox-checked.png"];
    [btnCheckBox setImage:btnImage forState:UIControlStateNormal];
}

#pragma mark - Textfield Delegates
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField == txtFirstName)
    {
        [txtLastName becomeFirstResponder];
        return YES;
    }else if(textField == txtLastName)
    {
        [txtUserId becomeFirstResponder];
        return YES;
    }else if(textField == txtUserId)
    {
        [txtPhoneNo becomeFirstResponder];
        return YES;
    }else if(textField == txtPhoneNo)
    {
        [txtEmail becomeFirstResponder];
        return YES;
    }else if(textField == txtEmail)
    {
        [txtPassword becomeFirstResponder];
        return YES;
    }
    
    [textField resignFirstResponder];
    [scrollView setContentOffset:CGPointMake(0, -20) animated:YES];

    [textField resignFirstResponder];
    scrollView.scrollEnabled = YES;
    
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if(textField ==txtMEA)
    return NO;
    
    return  YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if(textField==txtMEA){
        return ;
    }
    tableViewPreviousCustomer.hidden = YES;
    tableViewMEA.hidden =YES;
    
    if(textField==txtUserId)
    {
        lbluseriderror.text =@"";
        imagecheckforuseridView.image=nil;
    }
    if(textField==txtEmail){
        lblemailerror.text = @"";
        webserviceStatus = nil;
        imagecheckforemailView.image=nil;

    }
    tableViewPreviousCustomer.hidden = YES;
    svos = scrollView.contentOffset;
    scrollView.scrollEnabled = YES;
     if(textField == txtEmail|| textField == txtPassword || textField == txtPhoneNo || textField == txtUserId  || textField==txtUserId) {
            
            CGPoint pt;
            CGRect rc = [textField bounds];
            rc = [textField convertRect:rc toView:scrollView];
            pt = rc.origin;
            pt.x = 0;
            pt.y -=200;
            [scrollView setContentOffset:pt animated:YES];
     }
   // NSString *path = [NSString stringWithFormat:@"%@/users/%@/profilepic",Kwebservices,[[NSUserDefaults standardUserDefaults] valueForKey:@"l_userid"]];

}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField == txtUserId)
    {
     //   UIAlertView *alert;
        if(txtUserId.text.length==0)
        {
//            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"ARA" message:@"Please enter userId" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//            [alert show];
            
            return;
        }
        //activityIndicatorObject.center = CGPointMake(0, 0);
        activityIndicatorObject.transform = CGAffineTransformMakeScale(0.50, 0.50);
        activityIndicatorObject.color=[UIColor whiteColor];
        [viewUserIdindicator addSubview:activityIndicatorObject];
        [activityIndicatorObject startAnimating];
        
        CGRect frame = viewUserIdindicator.frame;
        frame.origin.x = txtUserId.frame.origin.x + txtUserId.frame.size.width;
        frame.origin.y = txtUserId.frame.origin.y +1;
        viewUserIdindicator.frame = frame;
      
       
        internal=1;
        
        [self checkforAvailability];
        
    }
    
    if(textField == txtEmail)
    {
        if(txtEmail.text.length==0)
        {
            return;
        }
        if (![txtEmail emailValidation]==YES) {
            lblemailerror.text = @"Enter a valid email";
            //[txtEmail becomeFirstResponder];
            return;
        }
        //activityIndicatorObject.center = CGPointMake(0, 0);
        activityIndicatorObject1.transform = CGAffineTransformMakeScale(0.50, 0.50);
        activityIndicatorObject1.color=[UIColor whiteColor];
        [viewEmailindicator addSubview:activityIndicatorObject1];
        
        
        CGRect frame = viewEmailindicator.frame;
        frame.origin.x = txtEmail.frame.origin.x + txtEmail.frame.size.width;
        frame.origin.y = txtEmail.frame.origin.y +1;
        viewEmailindicator.frame = frame;
     
        

        internal=2;
         flag = false;
        for (int k =0; k<email_array_Mea.count ; k++) {
            if([txtEmail.text caseInsensitiveCompare:[email_array_Mea objectAtIndex:k]] == NSOrderedSame)
            {
                
                flag = true;
                break;
            }
        }
        if(flag ==false)
        {
            
            [self checkforAvailability];
            [activityIndicatorObject1 startAnimating];
        }
        
        NSString *client_email = [NSString stringWithFormat:@"%@",txtEmail.text];
        
        if([txtPreviousCoustomer.text isEqualToString:@"AAI - MEA"] || [btnPreviewCustomer.titleLabel.text isEqualToString:@"AAI - MEA"])
            
        {
            //====
            
            bool  check_for_meaEmail = false;
            if([txtPreviousCoustomer.text isEqualToString:@"AAI - MEA"] || [btnPreviewCustomer.titleLabel.text isEqualToString:@"AAI - MEA"])
            {
                //check if email not exist
                for (int i=0; i<email_array_Mea.count; i++) {
                    
                    if([[email_array_Mea objectAtIndex:i]  caseInsensitiveCompare:client_email] == NSOrderedSame)
                    {
                        check_for_meaEmail=true;
                        break;
                    }
                }
                if (check_for_meaEmail !=true) {
                    [HelperAlert  alertWithOneBtn:AlertTitle description:@"This email is not registered with AAI - MEA account." okBtn:OkButtonTitle];

                    
                    lblemailerror.text = @"Email not register with AAI - MEA account";
                    imagecheckforemailView.image=nil;
                    return;
                    
                }
                
                
            }else{
                lblemailerror.text = @"";
            }
            //====
            
            for (int i=0; i<email_array_Mea.count; i++) {
                
                
                    if([[email_array_Mea objectAtIndex:i] caseInsensitiveCompare:client_email] == NSOrderedSame)
                {
                    txtMEA.text = [name_array_Mea objectAtIndex:i+1];
                    btnMEA.hidden = YES;
                    imageMEAdropdown.hidden = YES;
                    break;
                }else
                {
                    imageMEAdropdown.hidden = NO;
                    txtMEA.text = @"";
                    btnMEA.hidden = NO;
                    [btnMEA setTitle:@"Select MEA" forState:UIControlStateNormal];
                }
            }
        
        }
        
    }

}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField==txtPhoneNo)
    {
        
        NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if(newString.length==0)
        {   txtPhoneNo.text=@"";
            return YES;
        }
        NSArray *components = [newString componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]];
        NSString *decimalString = [components componentsJoinedByString:@""];
        
        NSUInteger length = decimalString.length;
        BOOL hasLeadingOne = length > 1 && [decimalString characterAtIndex:0] == '1';
        
        if (length == 0 || (length > 10 && !hasLeadingOne) || (length > 11)) {
            [txtPhoneNo becomeFirstResponder];

            return NO;
        }
        
        NSUInteger index = 0;
        NSMutableString *formattedString = [NSMutableString string];
        
        if (hasLeadingOne) {
            [formattedString appendString:@"1 "];
            index += 1;
        }
        
        if (length - index > 3) {
            NSString *areaCode = [decimalString substringWithRange:NSMakeRange(index, 3)];
            [formattedString appendFormat:@"(%@) ",areaCode];
            index += 3;
        }
        
        if (length - index > 3) {
            NSString *prefix = [decimalString substringWithRange:NSMakeRange(index, 3)];
            [formattedString appendFormat:@"%@-",prefix];
            index += 3;
        }
        
        NSString *remainder = [decimalString substringFromIndex:index];
        [formattedString appendString:remainder];
        
        textField.text = formattedString;
        return NO;
    }
    return YES;
}

#pragma mark - Connection Delegates

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
    
    if ((long)[httpResponse statusCode] == 204)
    {
        if(webservice==2)
        {
            
            [HelperAlert  alertWithOneBtn:AlertTitle description:@"MEA Data not found" okBtn:OkButtonTitle];

       
        }
        if (webservice==1)
        {
            [HelperAlert  alertWithOneBtn:AlertTitle description:@"Role Data not found" okBtn:OkButtonTitle];

            
        }
    }
    
    if(webservice==5 || webservice==6)
    {
        
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
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [kappDelegate HideIndicator];
    [activityIndicatorObject1 stopAnimating];
    [activityIndicatorObject stopAnimating];

    
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
    if ([responseString rangeOfString:@"User name already exist" options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        [HelperAlert alertWithOneBtn:AlertTitle description:responseString okBtn:OkButtonTitle];
        
        [kappDelegate HideIndicator];
        return;
    }
    if ([responseString rangeOfString:@"Validation failed for one or more entities" options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        [HelperAlert alertWithOneBtn:AlertTitle description:responseString okBtn:OkButtonTitle];

        
        [kappDelegate HideIndicator];
        return;
    }
    NSError *error;
    
    
    SBJsonParser *json = [[SBJsonParser alloc] init];
    NSMutableDictionary *userDetailDict=[json objectWithString:responseString error:&error];
    [kappDelegate HideIndicator];
    if (![userDetailDict isKindOfClass:[NSNull class]])
    {
        if (webservice==1) {
            webservice=0;
            id_array_prev_cust = [userDetailDict valueForKey:@"ID"];
            name_array_prev_cust = [userDetailDict valueForKey:@"Name"];
            NSArray *array = [[NSArray alloc]init];
            array = name_array_prev_cust;
            NSMutableArray *mutable = [[NSMutableArray alloc]init];
            for (int i=0; i<array.count; i++) {
                if (i==0)
                {
                    [mutable addObject:@"Select Role"];
                    [mutable addObject:[array objectAtIndex:i]];
                    continue;
                }
                [mutable addObject:[array objectAtIndex:i]];
            }
            name_array_prev_cust = mutable;
            [self getMeaInformation];
            
        }else if (webservice==2)
        {   webservice=0;
            id_array_Mea = [userDetailDict valueForKey:@"ID"];
            name_array_Mea = [userDetailDict valueForKey:@"Name"];
            email_array_Mea = [userDetailDict valueForKey:@"Email"];
            
            NSArray *array = [[NSArray alloc]init];
            array = name_array_Mea;
            NSMutableArray *mutable = [[NSMutableArray alloc]init];
            for (int i=0; i<array.count; i++) {
                if (i==0)
                {
                    [mutable addObject:@"Select MEA"];
                    [mutable addObject:[array objectAtIndex:i]];
                    continue;
                }
                [mutable addObject:[array objectAtIndex:i]];
            }
            name_array_Mea = mutable;
          //  [tableViewMEA reloadData];
        }else if (webservice==4)
        {   webservice=0;
            if([response_status isEqualToString:@"passed"])
            {
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            
            [user setObject:[NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"Email"]] forKey:@"l_email"];
            [user setObject:[NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"FirstName"]] forKey:@"l_firstName"];
            [user setObject:[NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"LastName"]] forKey:@"l_lastName"];
            NSLog(@"%@",[NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"LastName"]]);
            [user setObject:[NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"IsFacebookUser"]] forKey:@"l_facebookUser"];
            [user setObject:[NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"MEAID"]] forKey:@"l_meaId"];
            
            [user setObject:[NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"MEAName"]] forKey:@"l_meaName"];
            
            [user setObject:[NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"PhoneNumber"]] forKey:@"l_phoneNo"];
            [user setObject:[NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"UserName"]] forKey:@"l_userName"];
            [user setObject:[NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"UserId"]] forKey:@"l_userid"];
            
            [user setObject:[NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"RoleName"]] forKey:@"l_roleName"];
            
            [user setObject:[NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"RoleID"]] forKey:@"l_roleId"];
            [user setObject:[NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"PurchasedBefore"]] forKey:@"l_purchasedBefore"];
            [user setObject:@"yes" forKey:@"l_loggedin"];
            [user setObject:[NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"Password"]] forKey:@"l_password"];
                
                if(internal1==11){
                  
                }else{
                      [user setObject:[NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"UserToken"]] forKey:@"UserToken"];
                }
            
            NSLog(@"%@",[NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"Password"]]);
            
            [user setObject:[NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"ProfilePicName"]] forKey:@"l_image"];
            
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            if(internal1==11){
                [HelperAlert alertWithOneBtn:AlertTitle description:@"Profile updated successfully" okBtn:OkButtonTitle];

               
            }else{
                
                [HelperAlert alertWithOneBtn:@"Thank You" description:@"You are sucessfully registered with us." okBtn:@"Ok" withTag:3 forController:self];

                
//                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Thank You" message:@"You are sucessfully registered with us." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//                
//                alert.tag=3;
//                [alert show];
                return;
            }
            }else{
                [HelperAlert alertWithOneBtn:AlertTitle description:@"Not able to communate to the server. kindly try again." okBtn:OkButtonTitle];


            }
        }else if(webservice==5)
        {   webservice=0;
            [activityIndicatorObject stopAnimating];
           
            NSString *firstname6 = [userDetailDict valueForKey:@"FirstName"];
            NSString *lastname6 = [userDetailDict valueForKey:@"LastName"];
            NSString *phoneno6 = [userDetailDict valueForKey:@"PhoneNumber"];
            if ([responseString rangeOfString:@"User Name not exist" options:NSCaseInsensitiveSearch].location != NSNotFound)
            {
                imagecheckforuseridView.hidden =NO;
                
                
                CGRect frame = viewUserIdindicator.frame;
                frame.origin.x = txtUserId.frame.origin.x + txtUserId.frame.size.width+3;
                frame.origin.y = txtUserId.frame.origin.y +txtUserId.frame.size.height/4;
                viewUserIdindicator.frame = frame;

                imagecheckforuseridView.image = [UIImage imageNamed:@"tick2.png"];
                return;
            }
            if (firstname6.length >0 || lastname6.length >0 || phoneno6.length >0) {
               lbluseriderror.text = @"This userId already exists";
                return;
            }
            
        }else if (webservice==6) {
            webservice=0;
            
            if ([responseString rangeOfString:@"Email address not exist" options:NSCaseInsensitiveSearch].location != NSNotFound)
            {
                
                imagecheckforemailView.hidden =NO;
                
                
                CGRect frame = viewEmailindicator.frame;
                frame.origin.x = txtEmail.frame.origin.x + txtEmail.frame.size.width+3;
                frame.origin.y = txtEmail.frame.origin.y +txtEmail.frame.size.height/4;
                viewEmailindicator.frame = frame;
                 webserviceStatus = @"checked";
                imagecheckforemailView.image = [UIImage imageNamed:@"tick2.png"];
                [activityIndicatorObject1 stopAnimating];
                return;
            }
            NSString *usertype = [userDetailDict valueForKey:@"UserType"];
            if([usertype isEqualToString:@"Client"])
               {
                   [HelperAlert alertWithTwoBtns:AlertTitle description:@"Are you a previous client of Automotive Avenues?" okBtn:@"No" cancelBtn:@"Yes" withTag:2 forController:self];

                   
//                   UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"ARA" message:@"We already have your details. Are you a previous client of ARA ?" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Yes i am",nil];
//                   [alert show];
//                   alert.tag =2;
                   [txtEmail resignFirstResponder];
                   [txtPassword resignFirstResponder];
                     [scrollView setContentOffset:CGPointMake(0, -20) animated:YES];
                   
                   firstname = [NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"FirstName"]];
                   lastname = [NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"LastName"]];
                   phoneno = [NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"PhoneNumber"]];
                   UserDetailId = [NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"UserDetailId"]];
                   [activityIndicatorObject1 stopAnimating];

                   return;
               }
               lblemailerror.text =@"Email already exist";
            
            [activityIndicatorObject1 stopAnimating];
            
        }

    }
}else{
    
    if (webservice==5) {
       
        if ([responseString rangeOfString:@"User Name not exist" options:NSCaseInsensitiveSearch].location != NSNotFound)
        {
            imagecheckforuseridView.hidden =NO;
            
            
            CGRect frame = viewUserIdindicator.frame;
            frame.origin.x = txtUserId.frame.origin.x + txtUserId.frame.size.width+3;
            frame.origin.y = txtUserId.frame.origin.y +txtUserId.frame.size.height/4;
            viewUserIdindicator.frame = frame;
            [activityIndicatorObject stopAnimating];

            imagecheckforuseridView.image = [UIImage imageNamed:@"tick2.png"];
            return;
        }
    }
    if (webservice==6) {
        if ([responseString rangeOfString:@"Email address not exist" options:NSCaseInsensitiveSearch].location != NSNotFound)
        {
            
            imagecheckforemailView.hidden =NO;
            
            
            CGRect frame = viewEmailindicator.frame;
            frame.origin.x = txtEmail.frame.origin.x + txtEmail.frame.size.width+3;
            frame.origin.y = txtEmail.frame.origin.y +txtEmail.frame.size.height/4;
            viewEmailindicator.frame = frame;
             webserviceStatus = @"checked";
            imagecheckforemailView.image = [UIImage imageNamed:@"tick2.png"];
            [activityIndicatorObject1 stopAnimating];
            return;
        }
    }
    
    if ([responseString isEqualToString:@"Email address already exist"]) {
        [HelperAlert alertWithOneBtn:AlertTitle description:@"Unable to add user--email address already exists." okBtn:OkButtonTitle];
    }else{
    [HelperAlert alertWithOneBtn:AlertTitle description:responseString okBtn:OkButtonTitle];
    }
   

}
    [kappDelegate HideIndicator];
    [activityIndicatorObject1 stopAnimating];
    [activityIndicatorObject stopAnimating];
}


#pragma mark - TableView Delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
if(tableView == tableViewPreviousCustomer)
{
    return name_array_prev_cust.count;
}else if(tableView==tableViewMEA){
    return name_array_Mea.count;
}
    return YES;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [txtEmail resignFirstResponder];
    [txtFirstName resignFirstResponder];
    [txtLastName resignFirstResponder];
    //[txtMEA resignFirstResponder];
    [txtPassword resignFirstResponder];
    [txtPhoneNo resignFirstResponder];
    [txtPreviousCoustomer resignFirstResponder];
    [txtUserId resignFirstResponder];
    [scrollView setContentOffset:CGPointMake(0, -20) animated:YES];
    scrollView.scrollEnabled = YES;

    if (IS_IPAD) {
        return 50;
    }
    
    
    return 35;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if(tableView == tableViewPreviousCustomer){
        cell.textLabel.text = [name_array_prev_cust objectAtIndex: indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    }else if(tableView == tableViewMEA){
        cell.textLabel.text = [name_array_Mea objectAtIndex: indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:12.0];

    }
    
    cell.textLabel.textColor = [UIColor colorWithRed:33.0f/255.0f green:101.0f/255.0f blue:183.0f/255.0f alpha:1.5f];
//    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [tableView flashScrollIndicators];
    
    
    if ( IS_IPAD )
    {
        cell.textLabel.font = [UIFont systemFontOfSize:25.0];
    }
    tableViewPreviousCustomer.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableViewMEA.separatorStyle = UITableViewCellSeparatorStyleNone;

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == tableViewPreviousCustomer){
        
        if ([txtPreviousCoustomer.text isEqualToString:@"AAI - MEA"]) {
            internal=2;
            //[self checkforAvailability];
        }
        
        
        txtPreviousCoustomer.text = [name_array_prev_cust objectAtIndex:indexPath.row];
        if(indexPath.row>0)
        {
            NSLog(@"%@",[id_array_prev_cust objectAtIndex:indexPath.row-1]);
            selected_previousid = [NSString stringWithFormat:@"%@",[id_array_prev_cust objectAtIndex:indexPath.row-1]];
        }
        [btnPreviewCustomer setTitle:@" " forState:UIControlStateNormal];
        tableViewPreviousCustomer.hidden = YES;
        status1=false;
        
         NSString *client_email = [NSString stringWithFormat:@"%@",txtEmail.text];
        bool check_for_meaEmail =false;
        if([[name_array_prev_cust objectAtIndex:indexPath.row] isEqualToString:@"AAI - MEA"])
        {
           //check if email not exist
            if (txtEmail.text.length  !=0) {
                
            
             for (int i=0; i<email_array_Mea.count; i++) {
            
                  if([[email_array_Mea objectAtIndex:i]  caseInsensitiveCompare:client_email] == NSOrderedSame)
                  {
                      check_for_meaEmail=true;
                      break;
                  }
             }
            if (check_for_meaEmail !=true) {
                
                [HelperAlert alertWithOneBtn:AlertTitle description:@"This email is not registered with AAI - MEA account." okBtn:OkButtonTitle];
                
               
                
                
                lblemailerror.text = @"Email not register with AAI - MEA account";
                imagecheckforemailView.image=nil;

                
                return;

                }
            }
            
           //check for email exist
            for (int i=0; i<email_array_Mea.count; i++) {
                
                
                if([[email_array_Mea objectAtIndex:i]  caseInsensitiveCompare:client_email] == NSOrderedSame)
                {
                    txtMEA.text = [name_array_Mea objectAtIndex:i+1];
                    btnMEA.hidden = YES;
                    imageMEAdropdown.hidden = YES;
                    lblemailerror.text = @"";
                    break;
                }
            }
            
        }else{
           
            if (error==1) {
                
            }else{
                lblemailerror.text = @"";
            }
            
            imageMEAdropdown.hidden = NO;
            txtMEA.text = @"";
            btnMEA.hidden = NO;
            [btnMEA setTitle:@"Select MEA" forState:UIControlStateNormal];
            
        }
        
        if(flag==true && ![txtPreviousCoustomer.text isEqualToString:@"AAI - MEA"])
        {
            internal=2;
         //   [self checkforAvailability];
        }
    }else if(tableView==tableViewMEA)
    {
        txtMEA.text = [name_array_Mea objectAtIndex:indexPath.row];
        if([ txtMEA.text isEqualToString:@"Any Member Experience Advisor (Sales)"])
            
        {
            if(IS_IPAD){
                
            }else{
            txtMEA.font=[txtMEA.font fontWithSize:12];
            }
        }else{
            if(IS_IPAD){
                
            }else{
            txtMEA.font=[txtMEA.font fontWithSize:13];
            }
        }
        
        
        if(indexPath.row>0)
        {
        selected_meaid= [NSString stringWithFormat:@"%@",[id_array_Mea objectAtIndex:indexPath.row-1]];
        }
        [btnMEA setTitle:@" " forState:UIControlStateNormal];
        tableViewMEA.hidden = YES;
         status=false;
        
    }
}

#pragma mark - Other Methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex              {
    if(alertView.tag==2){
        
        if(buttonIndex == 0)//OK button pressed
        {
            lblemailerror.text = @"Email already registered.";
            error = 1;
            
          //  [HelperAlert alertWithOneBtn:AlertTitle description:@"Unable to add user--email address already exists." okBtn:OkButtonTitle];
        }
        else if(buttonIndex == 1)//Annul button pressed.
        {
            txtFirstName.text = firstname;
            txtLastName.text = lastname;
            if([phoneno isEqualToString:@"<null>"])
            {
                txtPhoneNo.text = @"";
            }else{
                txtPhoneNo.text = phoneno;
            }
            found_client = @"yes";
             webserviceStatus = @"checked";
            imagecheckforemailView.image = [UIImage imageNamed:@"tick2.png"];
        }
    }
    if(alertView.tag==3) {
        dashboardViewController *obj = [[dashboardViewController alloc]initWithNibName:@"dashboardViewController" bundle:nil];
        [self.navigationController pushViewController:obj animated:YES];
    }
}
-(void)checkforAvailability
{
    NSMutableURLRequest *request ;
    NSString*_postData ;
    if (internal==1) {
        webservice=5;
        _postData = [NSString stringWithFormat:@"UserName=%@",txtUserId.text];
    }
    if(internal==2){
        webservice=6;
        webserviceStatus = @"checking";
        _postData = [NSString stringWithFormat:@"Email=%@",txtEmail.text];
        
    }
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

-(void)userRegestration:(NSString*)firstName LastName:(NSString*)lastName RoleID:(NSString *)roleId PhoneNumber:(NSString*)phoneNo Emailid:(NSString*)emailid Password:(NSString *)password PurchasedBefore:(NSString*)purchasedBefore  IsFacebookUser:(NSString*)isFacebookUser  MEAID:(NSString*)meaID UserName:(NSString*)userName userid:(NSString*)userid
{
    [kappDelegate ShowIndicator];
    NSMutableURLRequest *request ;
    NSString*_postData ;
    
    if([userid intValue]>=1){
        internal1= 11;
    }
    
    
    webservice=4;
    _postData = [NSString stringWithFormat:@"UserName=%@&Password=%@&RoleID=%@&FirstName=%@&LastName=%@&PhoneNumber=%@&Email=%@&IsFacebookUser=%@&PurchasedBefore=%@&MEAID=%@&ProfilePicName=%@&userId=%@",userName,password,roleId,firstName,lastName,phoneNo,emailid,isFacebookUser,purchasedBefore,meaID,@"",userid];
    
    if([found_client isEqualToString:@"yes"])
    {
        _postData = [NSString stringWithFormat:@"UserName=%@&Password=%@&RoleID=%@&FirstName=%@&LastName=%@&PhoneNumber=%@&Email=%@&IsFacebookUser=%@&PurchasedBefore=%@&MEAID=%@&ProfilePicName=%@&userId=%@&UserDetailId=%@",userName,password,roleId,firstName,lastName,phoneNo,emailid,isFacebookUser,purchasedBefore,meaID,@"",userid,UserDetailId];
        
    }
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/users",Kwebservices]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
    
    
    NSLog(@"data post >>> %@",_postData);
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[_postData length]];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    if([userid intValue]>=1)
    {
        [request addValue:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"UserToken"]] forHTTPHeaderField:@"token"];
    }
    
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
-(void)getPreviousCustomer
{
    webservice=1;
    NSMutableURLRequest *request ;
    NSString*_postData ;
    
    _postData = [NSString stringWithFormat:@""];
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/roles",Kwebservices]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
    
    
    
    NSLog(@"data post >>> %@",_postData);
    NSLog(@"%@",[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"UserToken"]]);
    
    [request setHTTPMethod:@"GET"];
    //[request addValue:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"UserToken"]] forHTTPHeaderField:@"token"];
    
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
-(void)getMeaInformation
{
    webservice=2;
    NSMutableURLRequest *request ;
    NSString*_postData ;
    
    _postData = [NSString stringWithFormat:@""];
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/users/mea",Kwebservices]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
    
    
    
    NSLog(@"data post >>> %@",_postData);
    
    [request setHTTPMethod:@"GET"];
    //    [request addValue:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"UserToken"]] forHTTPHeaderField:@"token"];
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
-(void)cancelNumberPad{
    [txtPhoneNo resignFirstResponder];
    txtPhoneNo.text = @"";
    [scrollView setContentOffset:CGPointMake(0, -20) animated:YES];
    scrollView.scrollEnabled = YES;
}

-(void)doneWithNumberPad{
    [txtEmail becomeFirstResponder];
}
-(void)gestureHandlerMethod2:(UITapGestureRecognizer*)sender {
    
    tableViewMEA.hidden = YES;
    tableViewPreviousCustomer.hidden = YES;
    status=false;status1 = false;
    
    [txtEmail resignFirstResponder];
    [txtFirstName resignFirstResponder];
    [txtLastName resignFirstResponder];
    //[txtMEA resignFirstResponder];
    [txtPassword resignFirstResponder];
    [txtPhoneNo resignFirstResponder];
    [txtPreviousCoustomer resignFirstResponder];
    [txtUserId resignFirstResponder];
    
    [scrollView setContentOffset:CGPointMake(0, -20) animated:YES];
    scrollView.scrollEnabled = YES;
    
}
@end
