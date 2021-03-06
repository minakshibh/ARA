//
//  SubmitReferralViewController.m
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 12/08/15.
//  Copyright (c) 2015 Krishna_Mac_2. All rights reserved.
//

#import "SubmitReferralViewController.h"
#import <AddressBook/AddressBook.h>
#import "ASIHTTPRequest.h"
#import "dashboardViewController.h"
#import "PopupTableViewCell.h"
#import "UIView+Toast.h"

//#import "UIView+Toast.h"

@interface SubmitReferralViewController ()
{
    
    ABPeoplePickerNavigationController *picker;
    UIActivityIndicatorView *activityIndicatorObject1;
}

@end

@implementation SubmitReferralViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    noShowOnPopUp = false;
    popupActive = false;
    
    [txtFirstname enterOnlyLetters];
    [txtLastname enterOnlyLetters];
    
    selectedContactDict = [[NSMutableDictionary alloc]init];
    email_checked = @"no";
    
    activityIndicatorObject1 = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    picker = [[ABPeoplePickerNavigationController alloc] init];
    
    
    //--hide navigation bar
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    lblComments.layer.cornerRadius = 5.0;
    [lblComments setClipsToBounds:YES];
    
    lblCommentsBackground.layer.cornerRadius = 5.0;
    lblCommentsBackground.layer.borderWidth = 1.0;
    lblCommentsBackground.layer.borderColor = [UIColor colorWithRed:144.0f/255.0f green:184.0f/255.0f blue:218.0f/255.0f alpha:1.0f].CGColor;
    [lblCommentsBackground setClipsToBounds:YES];
    
    lblEmail.layer.cornerRadius = 5.0;
    lblEmail.layer.borderWidth = 1.0;
    lblEmail.layer.borderColor = [UIColor colorWithRed:144.0f/255.0f green:184.0f/255.0f blue:218.0f/255.0f alpha:1.0f].CGColor;
    [lblEmail setClipsToBounds:YES];
    
    lblFirstname.layer.cornerRadius = 5.0;
    lblFirstname.layer.borderWidth = 1.0;
    lblFirstname.layer.borderColor = [UIColor colorWithRed:144.0f/255.0f green:184.0f/255.0f blue:218.0f/255.0f alpha:1.0f].CGColor;
    [lblFirstname setClipsToBounds:YES];
    
    lblLastname.layer.cornerRadius = 5.0;
    lblLastname.layer.borderWidth = 1.0;
    lblLastname.layer.borderColor = [UIColor colorWithRed:144.0f/255.0f green:184.0f/255.0f blue:218.0f/255.0f alpha:1.0f].CGColor;
    [lblLastname setClipsToBounds:YES];
    
    lblMEA.layer.cornerRadius = 5.0;
    lblMEA.layer.borderWidth = 1.0;
    lblMEA.layer.borderColor = [UIColor colorWithRed:144.0f/255.0f green:184.0f/255.0f blue:218.0f/255.0f alpha:1.0f].CGColor;
    [lblMEA setClipsToBounds:YES];
    
    lblPhoneno.layer.cornerRadius = 5.0;
    lblPhoneno.layer.borderWidth = 1.0;
    lblPhoneno.layer.borderColor = [UIColor colorWithRed:144.0f/255.0f green:184.0f/255.0f blue:218.0f/255.0f alpha:1.0f].CGColor;
    [lblPhoneno setClipsToBounds:YES];
    
    btnSubmitReferral.layer.cornerRadius = 7.0;
    [btnSubmitReferral setClipsToBounds:YES];
    
    btnImportContacts.layer.cornerRadius = 5.0;
    btnImportContacts.layer.borderWidth = 2.0;
    btnImportContacts.layer.borderColor = [UIColor colorWithRed:144.0f/255.0f green:184.0f/255.0f blue:218.0f/255.0f alpha:1.0f].CGColor;
    [btnImportContacts setClipsToBounds:YES];
    
    [txtFirstname setValue:[UIColor colorWithRed:144.0f/255.0f green:184.0f/255.0f blue:218.0f/255.0f alpha:1.0f] forKeyPath:@"_placeholderLabel.textColor"];
    [txtLastname setValue:[UIColor colorWithRed:144.0f/255.0f green:184.0f/255.0f blue:218.0f/255.0f alpha:1.0f] forKeyPath:@"_placeholderLabel.textColor"];
    [txtPhoneno setValue:[UIColor colorWithRed:144.0f/255.0f green:184.0f/255.0f blue:218.0f/255.0f alpha:1.0f] forKeyPath:@"_placeholderLabel.textColor"];
    [txtEmail setValue:[UIColor colorWithRed:144.0f/255.0f green:184.0f/255.0f blue:218.0f/255.0f alpha:1.0f] forKeyPath:@"_placeholderLabel.textColor"];
    [txtmea setValue:[UIColor colorWithRed:144.0f/255.0f green:184.0f/255.0f blue:218.0f/255.0f alpha:1.0f] forKeyPath:@"_placeholderLabel.textColor"];
    
    
    
    //    if(NSNotFound == anIndex) {
    //        NSLog(@"not found");
    //    }
    NSString *role_name = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"l_roleName"]];
    
    //    if([role_name isEqualToString:@"AAI - MEA"])
    //    {
    //        NSString *first = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"l_firstName"]];
    //        NSString *last = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"l_lastName"]];
    //
    //        txtmea.text =[NSString stringWithFormat:@"%@ %@",first,last];
    //        [btnMEA setTitle:@"" forState:UIControlStateNormal];
    //    }else{
    //        NSString *compare =[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"l_meaName"]];
    //        if([compare isEqualToString:@"<null>"]){
    //            txtmea.text = @"Any Member Experience Advisor (Sales)";
    //        }else{
    //            txtmea.text =compare;
    //        }
    //        [btnMEA setTitle:@"" forState:UIControlStateNormal];
    //    }
    
    [self getMEA];
    
    if (!IS_IPAD){
        UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
        numberToolbar.barStyle = UIBarStyleBlackTranslucent;
        numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                                [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                [[UIBarButtonItem alloc]initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
        [numberToolbar sizeToFit];
        txtPhoneno.inputAccessoryView = numberToolbar;
    }
    
    
    [self iPadDesignInitialization];
    
    
    viewPopUp_h = viewHeaderPOPUP.frame.size.height;
    tableviewPopup_h = tableViewPopup.frame.size.height;
}
-(void) iPadDesignInitialization{
    if (IS_IPAD)
    {
        lblheading.font = [lblheading.font fontWithSize:24];
        btnback.titleLabel.font = [btnback.titleLabel.font fontWithSize:24];
        btnImportContacts.titleLabel.font = [btnImportContacts.titleLabel.font fontWithSize:24];
        btnSubmitReferral.titleLabel.font = [btnSubmitReferral.titleLabel.font fontWithSize:24];
        txtFirstname.font = [txtFirstname.font fontWithSize:20];
        txtLastname.font = [txtLastname.font fontWithSize:20];
        txtPhoneno.font = [txtPhoneno.font fontWithSize:20];
        txtEmail.font = [txtEmail.font fontWithSize:20];
        txtmea.font = [txtmea.font fontWithSize:20];
        txtComment.font = [txtComment.font fontWithSize:20];
        lblCommentsPlaceholder.font = [lblCommentsPlaceholder.font fontWithSize:20];
        
        
        if(IS_IPAD_PRO_1366)
        {
            
            lblheading.font = [lblheading.font fontWithSize:30];
            btnback.titleLabel.font = [btnback.titleLabel.font fontWithSize:30];
            btnImportContacts.titleLabel.font = [btnImportContacts.titleLabel.font fontWithSize:30];
            btnSubmitReferral.titleLabel.font = [btnSubmitReferral.titleLabel.font fontWithSize:30];
            txtFirstname.font = [txtFirstname.font fontWithSize:28];
            txtLastname.font = [txtLastname.font fontWithSize:28];
            txtPhoneno.font = [txtPhoneno.font fontWithSize:28];
            txtEmail.font = [txtEmail.font fontWithSize:28];
            txtmea.font = [txtmea.font fontWithSize:28];
            txtComment.font = [txtComment.font fontWithSize:28];
            lblCommentsPlaceholder.font = [lblCommentsPlaceholder.font fontWithSize:28];
        }
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    lblCommentsCount.hidden = YES;
    
    
    
    [self iPadDesignInitialization];
    [[UIApplication sharedApplication] setStatusBarHidden:NO animated:NO];
    if(txtEmail.text.length >0)
    {
        [txtEmail becomeFirstResponder];
    }
    
    [txtComment resignFirstResponder];
    [txtEmail resignFirstResponder];
    [txtFirstname resignFirstResponder];
    [txtLastname resignFirstResponder];
    [txtmea resignFirstResponder];
    [txtPhoneno resignFirstResponder];
}
-(void)viewWillDisappear:(BOOL)animated
{
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Text Delegate Methods
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField==txtFirstname) {
        [txtLastname becomeFirstResponder];
    }else if (textField==txtLastname)
    {
        [txtPhoneno becomeFirstResponder];
        
    }else if (textField==txtPhoneno)
    {
        [txtEmail becomeFirstResponder];
        
    }else if (textField==txtEmail)
    {
        [txtComment becomeFirstResponder];
        return YES;
    }
    [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    
    [textField resignFirstResponder];
    
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    scrollView.scrollEnabled = NO;
    
    if (textField==txtEmail)
    {
        
        if(textField == txtEmail)
        {
            imagecheckforemailView.hidden = YES;
            if(txtEmail.text.length>0){
                if (![txtEmail emailValidation]==YES) {
                    lblemailerror.text = @"Enter a valid email";
                }
                //                else{
                //
                //                    activityIndicatorObject1.transform = CGAffineTransformMakeScale(0.50, 0.50);
                //                    activityIndicatorObject1.color=[UIColor grayColor ];
                //                    [viewEmailindicator addSubview:activityIndicatorObject1];
                //                    [activityIndicatorObject1 startAnimating];
                //
                //                    CGRect frame = viewEmailindicator.frame;
                //                    frame.origin.x = txtEmail.frame.origin.x + txtEmail.frame.size.width;
                //                    frame.origin.y = txtEmail.frame.origin.y +1;
                //                    viewEmailindicator.frame = frame;
                //                    [self checkforavailability];
                //                }
            }
        }
    }
    if(textField==txtPhoneno)
    {
        phoneStr1 = [NSString stringWithFormat:@"%@",txtPhoneno.text];
        
        
        NSArray *phoneStrArr = [phoneStr1 componentsSeparatedByString:@" "];
        
        
        
        if (phoneStr1.length>0) {
            
            
            NSLog(@"%@----%@",phoneStr1,[phoneStrArr objectAtIndex:0]);
            
            
            if ([[NSString stringWithFormat:@"%@",[phoneStrArr objectAtIndex:0]]isEqualToString:@"1"]) {
                
                if (phoneStr1.length<16 || phoneStr1.length>16){
                    lblphonenoerror.text = @"Enter a valid phone no.";
                }else{
                    lblphonenoerror.text=@"";
                }
                
            }else{
                if (phoneStr1.length<14 || phoneStr1.length>14){
                    lblphonenoerror.text = @"Enter a valid phone no.";
                }else{
                    lblphonenoerror.text=@"";
                }
            }
            
        }
    }
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if (popupActive) {
        [txtFirstname resignFirstResponder];
        [txtLastname resignFirstResponder];
        [txtPhoneno resignFirstResponder];
        
        return;
    }
    
    if(textField==txtPhoneno)
    {
        
        //[txtPhoneno setText:@""];
        lblphonenoerror.text = @"";
    }
    scrollView.scrollEnabled = YES;
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(350, 700);
    
    
    
    svos = scrollView.contentOffset;
    tableView.hidden = YES;
    
    if(textField == txtEmail)
    {
        lblemailerror.text = @"";
        //        email_checked = @"no";
        //        imagecheckforemailView.image=nil;
    }
    if(textField == txtEmail || textField == txtPhoneno ) {
        
        CGPoint pt;
        CGRect rc = [textField bounds];
        rc = [textField convertRect:rc toView:scrollView];
        pt = rc.origin;
        pt.x = 0;
        pt.y -=180;
        [scrollView setContentOffset:pt animated:YES];
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        return NO;
    }
    
    
    
    return YES;
}
-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{   [textView resignFirstResponder];
    return  YES;
}
-(void)textViewDidEndEditing:(UITextField *)textField
{
    scrollView.scrollEnabled = NO;
    lblCommentsCount.hidden = YES;
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    scrollView.scrollEnabled = YES;
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(350, 730);
    
    svos = scrollView.contentOffset;
    
    if(textView == txtComment) {
        [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        CGPoint pt;
        CGRect rc = [textView bounds];
        rc = [textView convertRect:rc toView:scrollView];
        pt = rc.origin;
        pt.x = 0;
        pt.y -=180;
        [scrollView setContentOffset:pt animated:YES];
        lblCommentsPlaceholder.hidden = YES;
    }
    
}
//code for disable copy paste in textfield

//- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
//{
//    if (action == @selector(paste:))
//        return NO;
//    if (action == @selector(select:))
//        return NO;
//    if (action == @selector(selectAll:))
//        return NO;
//    return [super canPerformAction:action withSender:sender];
//}

//-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
//{
//
//    return NO;
//    return [super canPerformAction:action withSender:sender];
//}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField==txtPhoneno)
    {
        
        NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if(newString.length==0)
        {   txtPhoneno.text=@"";
            return YES;
        }
        NSArray *components = [newString componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]];
        NSString *decimalString = [components componentsJoinedByString:@""];
        
        NSUInteger length = decimalString.length;
        BOOL hasLeadingOne = length > 1 && [decimalString characterAtIndex:0] == '1';
        
        if (length == 0  || (length > 10 && !hasLeadingOne) || (length ==12)) {
            if (length == 0  || (length > 10 && !hasLeadingOne) || (length ==12)) {
                [txtPhoneno becomeFirstResponder];
                
                return NO;
            }
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
        
        
        if (txtPhoneno.text.length>16){
            txtPhoneno.text = string;
            //  lblphonenoerror.text=@""
        }
        return NO;
        
        
        
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView{
    
    lblCommentsCount.hidden = NO;
    NSInteger restrictedLength=249;
    
    NSString *temp=textView.text;
    if (temp.length==0) {
        lblCommentsCount.hidden = YES;
    }
    NSInteger remainingCount = 250 - temp.length;
    NSLog(@"%lu",(unsigned long)temp.length);
    NSString *tempStr;
    
    if (temp.length > 250) {
        tempStr =  [temp substringToIndex:249];
        NSLog(@"%lu",(unsigned long)tempStr.length);
        remainingCount = 0;
        textView.text = tempStr;
    }
    
    lblCommentsCount.text = [NSString stringWithFormat:@"%ld characters remaining",(long)remainingCount];
    
    if([[textView text] length] > restrictedLength){
        textView.text=[temp substringToIndex:[temp length]-1];
        [HelperAlert alertWithOneBtn:AlertTitle description:@"Limit of 250 characters reached" okBtn:OkButtonTitle];
    }
}

#pragma mark Buttons
- (IBAction)btnBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnShowEmailPopup:(id)sender {
    if ([selectedContactDict objectForKey:@"phone_no"]){
        
        [[KGModal sharedInstance] hideAnimated:YES];
        
        txtFirstname.text = selectedPersonFName;
        txtLastname.text = selectedPersonLName;
        aTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(aTime) userInfo:nil repeats:NO];
        
        
        
    }else{
        [self.view makeToast:@"Kindly select a phone number first..."];
    }
    
}

- (IBAction)btnDonePOPUPemail:(id)sender {
    
    NSString *str =    [selectedContactDict valueForKey:@"email"];
    if (str == nil) {
        [self.view makeToast:@"Kindly select an email first..."];
        return;
    }
    
    [[KGModal sharedInstance] hideAnimated:YES];
    
    NSArray *name = [lblNamePOPUPEmail.text componentsSeparatedByString:@" "];
    
    txtFirstname.text = [name objectAtIndex:0];
    if([name count]>1)
    {
        txtLastname.text = [name objectAtIndex:1];
    }
    
    
    txtPhoneno.text = [selectedContactDict valueForKey:@"phone_no"];
    txtEmail.text = [selectedContactDict valueForKey:@"email"];
    //   [self checkforavailability];
    txtFirstname.userInteractionEnabled = YES;
    txtLastname.userInteractionEnabled = YES;
    txtPhoneno.userInteractionEnabled = YES;
    
    //  [self checkforavailability];
}
-(void)aTime
{
    txtPhoneno.text = [selectedContactDict valueForKey:@"phone_no"];
    
    
    NSArray *emailArray = [contactDict valueForKey:@"contact_email"];
    
    if([emailArray count]){
        
        if ([emailArray count] ==0 ) {
            NSString* select = @"email";
            
            [selectedContactDict setObject:@"" forKey:select];
            txtFirstname.text = selectedPersonFName;
            txtLastname.text = selectedPersonLName;
            txtEmail.text = @"";
        }else if ([emailArray count] ==1 ){
            NSString* select = @"email";
            [selectedContactDict setObject:[[contactDict valueForKey:@"contact_email"]objectAtIndex:0] forKey:select];
            
            txtFirstname.text = selectedPersonFName;
            txtLastname.text = selectedPersonLName;
            NSString *emailStr =[NSString stringWithFormat:@"%@",[[contactDict valueForKey:@"contact_email"]objectAtIndex:0]];
            
            if (![self validateEmailWithString:emailStr]==YES) {
                NSString* msgstr = @"Selected contact does't have a valid email address.";
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:AlertTitle message:msgstr delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [alert show];
                [txtEmail becomeFirstResponder];
                return;
            }
            txtEmail.text = [NSString stringWithFormat:@"%@",[[contactDict valueForKey:@"contact_email"]objectAtIndex:0]];
            //   [self checkforavailability];
        }else if([emailArray count] >1){
            [self showEmailPopup];
        }
    }
    
    txtFirstname.userInteractionEnabled = YES;
    txtLastname.userInteractionEnabled = YES;
    txtPhoneno.userInteractionEnabled = YES;
}
- (IBAction)btnSubmitReferral:(id)sender {
    NSString* firstNameStr = [txtFirstname.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString* lastNameStr = [txtLastname.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    phoneStr1 = [txtPhoneno.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSString* phoneStr = @"";
    if(![phoneStr1 isEqualToString: @""])
    {
        NSCharacterSet *unwantedStr = [NSCharacterSet characterSetWithCharactersInString:@"+() -"];
        phoneStr = [[phoneStr1 componentsSeparatedByCharactersInSet: unwantedStr] componentsJoinedByString: @""];
    }
    
    NSString* emailStr = [txtEmail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString* commentsStr = [txtComment.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString* meaStr = [txtmea.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    
    
    
    
    
    NSString *msgstr;
    [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    [txtFirstname resignFirstResponder];
    [txtLastname resignFirstResponder];
    [txtEmail resignFirstResponder];
    [txtComment resignFirstResponder];
    [txtmea resignFirstResponder];
    [txtPhoneno resignFirstResponder];
    
    if([txtFirstname isEmpty])
    {
        msgstr = @"Please enter first name";
        [HelperAlert  alertWithOneBtn:AlertTitle description:msgstr okBtn:OkButtonTitle];
        
        
        return;
    }else if([txtLastname isEmpty])
    {
        msgstr = @"Please enter last name";
        [HelperAlert  alertWithOneBtn:AlertTitle description:msgstr okBtn:OkButtonTitle];
        
        
        return;
    }
    if ([txtPhoneno isEmpty])
    {
        if([txtEmail isEmpty])
        {
            [HelperAlert  alertWithOneBtn:AlertTitle description:@"Please enter either phone number or email." okBtn:OkButtonTitle];
            return;
        }
    }
    
    if (![txtPhoneno isEmpty]) {
        
        if (phoneStr.length<10 ) {
            [HelperAlert  alertWithOneBtn:AlertTitle description:@"Please enter a valid phone number." okBtn:OkButtonTitle];
            
            
            return;
        }else if (phoneStr.length==10 ) {
            if([[NSString stringWithFormat:@"%C",[phoneStr characterAtIndex:0]] isEqual:@"1"])
            {
                [HelperAlert  alertWithOneBtn:AlertTitle description:@"Please enter a valid phone number." okBtn:OkButtonTitle];
                
                
                return;
            }
        }
    }
    if (phoneStr.length>10 ) {
        if([[NSString stringWithFormat:@"%C",[phoneStr characterAtIndex:0]] isEqual:@"1"])
        {
            
        }else{
            
            msgstr = @"Please enter phone no. of atmost 10 digits";
            [HelperAlert  alertWithOneBtn:AlertTitle description:msgstr okBtn:OkButtonTitle];
            
            return;
        }
    }
    if (txtEmail.text.length > 0) {
        if (![txtEmail emailValidation]==YES) {
            [HelperAlert  alertWithOneBtn:AlertTitle description:@"Please check your email address" okBtn:OkButtonTitle];
            
            
            [txtEmail becomeFirstResponder];
            return;
        }
    }
    
    if(txtEmail.text.length>0){
        if (![txtEmail emailValidation]==YES) {
            lblemailerror.text = @"Enter a valid email";
        }
    }
    
    if ([txtEmail isEmpty])
    {
        if ([txtPhoneno isEmpty])
        {
            [HelperAlert  alertWithOneBtn:AlertTitle description:@"Please enter either phone number or email." okBtn:OkButtonTitle];
            return;
        }
    }
    //    if([email_checked isEqualToString:@"no"])
    //    {
    //        [HelperAlert  alertWithOneBtn:AlertTitle description:@"Please wait a moment while we check your email." okBtn:OkButtonTitle];
    
    
    
    //        if (webservice!=5) {
    
    
    //            imagecheckforemailView.hidden = YES;
    //            if(txtEmail.text.length>0){
    //                if (![txtEmail emailValidation]==YES) {
    //                    lblemailerror.text = @"Enter a valid email";
    //                }
    //                else{
    //
    //                    activityIndicatorObject1.transform = CGAffineTransformMakeScale(0.50,   0.50);
    //                    activityIndicatorObject1.color=[UIColor whiteColor];
    //                    [viewEmailindicator addSubview:activityIndicatorObject1];
    //                    [activityIndicatorObject1 startAnimating];
    //
    //                    CGRect frame = viewEmailindicator.frame;
    //                    frame.origin.x = txtEmail.frame.origin.x + txtEmail.frame.size.width;
    //                    frame.origin.y = txtEmail.frame.origin.y +1;
    //                    viewEmailindicator.frame = frame;
    //                    [self checkforavailability];
    //                }
    //            }
    
    //        }
    
    
    
    //        [txtEmail resignFirstResponder];
    //        return;
    //    }
    
    if([txtmea isEmpty])
    {
        msgstr = @"Please select mea";
        [HelperAlert  alertWithOneBtn:AlertTitle description:msgstr okBtn:OkButtonTitle];
        
        return;
    }
    if([lblemailerror.text isEqualToString:@"Email already exist"])
    {
        
        msgstr =  @"Unable to add user--email address already exists.";
        [HelperAlert  alertWithOneBtn:AlertTitle description:msgstr okBtn:OkButtonTitle];
        return;
    }
    NSString *mea_id;
    NSString *role_name = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"l_roleName"]];
    if([role_name isEqualToString:@"AAI - MEA"])
    {
        if([[[NSUserDefaults standardUserDefaults]valueForKey:@"MEAName"] isEqualToString:txtmea.text])
        {
            mea_id = [[NSUserDefaults standardUserDefaults] valueForKey:@"l_roleId"]    ;
        }else{
            mea_id = selected_text_id;
        }
    }else{
        NSLog(@"%lu",[NSString stringWithFormat:@"%@",selected_text_id ].length);
        
        NSString *code =[NSString stringWithFormat:@"%@",selected_text_id ];
        if ([code rangeOfString:@"null" options:NSCaseInsensitiveSearch].location != NSNotFound)
        {
            mea_id = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"l_meaId"]];
            if ([[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"l_meaName"]] isEqualToString:@"<null>"])
            {
                mea_id = @"221";
            }
        }
        else
        {
            mea_id = selected_text_id;
        }
    }
    
    NSLog(@"%lu",(unsigned long)phoneStr.length);
    NSLog(@"%@",phoneStr);
    if (phoneStr == @""){
        NSLog(@"~~~~%@~~~~~",phoneStr);
    }
    
    [self submitReferral:firstNameStr lastname:lastNameStr phoneno:phoneStr email:emailStr mea:mea_id comment:commentsStr];
}

- (IBAction)btnMEA:(id)sender {
    
    if(status == true)
    {
        tableView.hidden=YES;
        status =false;
        return;
    }
    status=true;
    tableView.hidden=NO;
    
    tableView.layer.borderColor = [UIColor grayColor].CGColor;
    tableView.layer.borderWidth = 1.0;
    tableView.layer.cornerRadius = 4.0;
    [tableView setClipsToBounds:YES];
    
    [tableView reloadData];
    if(id_mea_array.count==0)
    {
        tableView.hidden = YES;
    }
    
}

- (IBAction)btnImportContacts:(id)sender {
    
    ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(nil, nil);
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined) {
        ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error) {
            if (granted) {
                picker.peoplePickerDelegate = self;
                
                [self presentModalViewController:picker animated:YES];
                [picker setPeoplePickerDelegate:self];
                [picker setDisplayedProperties:[NSArray arrayWithObject:[NSNumber numberWithInt:kABPersonPhoneProperty]]];
            } else {
                // Show an alert here if user denies access telling that the contact cannot be added because you didn't allow it to access the contacts
            }
        });
    }else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized) {
        // If the user user has earlier provided the access, then add the contact
        picker.peoplePickerDelegate = self;
        
        [self presentModalViewController:picker animated:YES];
        [picker setPeoplePickerDelegate:self];
        [picker setDisplayedProperties:[NSArray arrayWithObject:[NSNumber numberWithInt:kABPersonPhoneProperty]]];
    }
    else {
        // If the user user has NOT earlier provided the access, create an alert to tell the user to go to Settings app and allow access
        NSString *msgStr = @"You've disabled access to contacts. To re-enable, please go to Settings and enable Contacts for ARA.";
        [HelperAlert alertWithOneBtn:AlertTitle description:msgStr okBtn:OkButtonTitle];
    }
}

#pragma mark - AddressBook Delegate Methods

- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    [self peoplePickerNavigationController:peoplePicker shouldContinueAfterSelectingPerson:person property:property identifier:identifier];
}
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker {
    
    　[picker dismissModalViewControllerAnimated:YES];
}
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person;
{
    ABMultiValueRef fnameProperty = ABRecordCopyValue(person, kABPersonFirstNameProperty);
    ABMultiValueRef lnameProperty = ABRecordCopyValue(person, kABPersonLastNameProperty);
    
    if (lnameProperty != nil) {
        lblNamePOPUPView.text= [NSString stringWithFormat:@"%@ %@",fnameProperty,lnameProperty];
        lblNamePOPUPEmail.text = [NSString stringWithFormat:@"%@ %@",fnameProperty,lnameProperty];
    }else{
        lblNamePOPUPView.text= [NSString stringWithFormat:@"%@",fnameProperty];
        lblNamePOPUPEmail.text = [NSString stringWithFormat:@"%@",fnameProperty];
    }
    
    
    ABMultiValueRef phoneProperty = ABRecordCopyValue(person, kABPersonPhoneProperty);
    ABMultiValueRef emailProperty = ABRecordCopyValue(person, kABPersonEmailProperty);
    
    
    NSArray *emailArray = (__bridge NSArray *)ABMultiValueCopyArrayOfAllValues(emailProperty);
    NSArray *phoneArray = (__bridge NSArray *)ABMultiValueCopyArrayOfAllValues(phoneProperty);
    
    
    ABMultiValueRef phones = phoneProperty;
    ABMultiValueRef email = emailProperty;
    selectedIndex = 20;
    [selectedContactDict removeAllObjects];
    
    NSMutableArray *phonelbl = [[NSMutableArray alloc]init];
    NSMutableArray *emaillbl = [[NSMutableArray alloc]init];
    for(CFIndex j = 0; j < ABMultiValueGetCount(phones); j++)
    {
        CFStringRef locLabel = ABMultiValueCopyLabelAtIndex(phones, j);
        NSString *phoneLabel =(__bridge NSString*) ABAddressBookCopyLocalizedLabel(locLabel);
        [phonelbl addObject:phoneLabel];
    }
    for(CFIndex j = 0; j < ABMultiValueGetCount(email); j++)
    {
        
        CFStringRef emailLabel = ABMultiValueCopyLabelAtIndex(email, j);
        NSString *emailLabel1 =(__bridge NSString*) ABAddressBookCopyLocalizedLabel(emailLabel);
        NSLog(@"%@",emailLabel1);
        if (j==0) {
            [emaillbl addObject:@"email"];
            continue;
        }
        [emaillbl addObject:emailLabel1];
    }
    
    contactDict =  [[NSMutableDictionary alloc] init];
    
    if([emailArray count]==0)
    {
        emailArray = @[];
    }
    if([phoneArray count]==0)
    {
        phoneArray = @[];
    }
    [contactDict setObject:phoneArray forKey:@"contact_phone"];
    [contactDict setObject:emailArray forKey:@"contact_email"];
    [contactDict setObject:phonelbl forKey:@"contact_lbl"];
    [contactDict setObject:emaillbl forKey:@"contact_emaillbl"];
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    if (fnameProperty != nil) {
        selectedPersonFName = [NSString stringWithFormat:@"%@",fnameProperty];
    }else{
        selectedPersonFName = @"";
    }
    
    if (lnameProperty != nil) {
        selectedPersonLName = [NSString stringWithFormat:@"%@",lnameProperty];
    }else {
        selectedPersonLName = @"";
    }
    
    if([phoneArray count]){
        
        if ([phoneArray count] ==0 ) {
            NSString* select = @"phone_no";
            txtFirstname.text = selectedPersonFName;
            txtLastname.text = selectedPersonLName;
            [selectedContactDict setObject:@"" forKey:select];
            txtPhoneno.text = @"";
            popupActive = false;
        }else if ([phoneArray count] ==1 ){
            NSString* select = @"phone_no";
            
            txtFirstname.text = selectedPersonFName;
            txtLastname.text = selectedPersonLName;
            
            popupActive = false;
            
            /// --- put mask on number
            
            NSString *phoneNoStr = [[NSString stringWithFormat:@"%@",[[contactDict valueForKey:@"contact_phone"]objectAtIndex:0]] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            
            
            
            NSCharacterSet *unwantedStr = [NSCharacterSet characterSetWithCharactersInString:@"+() -"];
            phoneNoStr = [[phoneNoStr componentsSeparatedByCharactersInSet: unwantedStr] componentsJoinedByString: @""];
            
            if (phoneNoStr.length>0) {
                
                
                if (phoneNoStr.length<10 ) {
                    [HelperAlert  alertWithOneBtn:AlertTitle description:@"Selected contact does't have a valid phone number." okBtn:OkButtonTitle];
                    txtPhoneno.text=@"";
                    
                    
                }else if (phoneNoStr.length>10 ) {
                    if([[NSString stringWithFormat:@"%C",[phoneNoStr characterAtIndex:0]] isEqual:@"1"]  && phoneNoStr.length==10)
                    {
                        
                        
                        
                        noShowOnPopUp = false;
                        if(phoneNoStr.length >10){
                            noShowOnPopUp = true;
                        }
                        NSMutableString *mutStr = [[NSMutableString alloc]init];
                        NSString *returnedStr;
                        for (int i = 0; i<phoneNoStr.length; i++)
                        {
                            NSString *abc = [NSString stringWithFormat:@"%C",[phoneNoStr characterAtIndex:i]];
                            if(i==0){
                                mutStr =[NSMutableString stringWithFormat:@"%@",abc];
                            }else{
                                mutStr = [NSMutableString stringWithFormat:@"%@%@",mutStr,abc];
                            }
                            txtPhoneno.text =   [self showmaskonnumber:mutStr];
                            
                        }
                        [selectedContactDict setObject:txtPhoneno.text forKey:select];
                    }else{
                        
                        if([[NSString stringWithFormat:@"%C",[phoneNoStr characterAtIndex:0]] isEqual:@"1"]  && phoneNoStr.length==11)
                        {
                            noShowOnPopUp = false;
                            if(phoneNoStr.length >10){
                                noShowOnPopUp = true;
                            }
                            NSMutableString *mutStr = [[NSMutableString alloc]init];
                            NSString *returnedStr;
                            for (int i = 0; i<phoneNoStr.length; i++)
                            {
                                NSString *abc = [NSString stringWithFormat:@"%C",[phoneNoStr characterAtIndex:i]];
                                if(i==0){
                                    mutStr =[NSMutableString stringWithFormat:@"%@",abc];
                                }else{
                                    mutStr = [NSMutableString stringWithFormat:@"%@%@",mutStr,abc];
                                }
                                txtPhoneno.text =   [self showmaskonnumber:mutStr];
                                
                            }
                            [selectedContactDict setObject:txtPhoneno.text forKey:select];
                        }else{
                            NSString* msgstr = @"Selected contact does't have a valid phone number.";
                            [HelperAlert  alertWithOneBtn:AlertTitle description:msgstr okBtn:OkButtonTitle];
                            txtPhoneno.text=@"";
                        }
                    }
                }else{
                    
                    
                    
                    phoneNoStr = [phoneNoStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                    
                    NSCharacterSet *unwantedStr = [NSCharacterSet characterSetWithCharactersInString:@"+() -"];
                    phoneNoStr = [[phoneNoStr componentsSeparatedByCharactersInSet: unwantedStr] componentsJoinedByString: @""];
                    
                    noShowOnPopUp = false;
                    if(phoneNoStr.length >10){
                        noShowOnPopUp = true;
                    }
                    NSMutableString *mutStr = [[NSMutableString alloc]init];
                    NSString *returnedStr;
                    for (int i = 0; i<phoneNoStr.length; i++)
                    {
                        NSString *abc = [NSString stringWithFormat:@"%C",[phoneNoStr characterAtIndex:i]];
                        if(i==0){
                            mutStr =[NSMutableString stringWithFormat:@"%@",abc];
                        }else{
                            mutStr = [NSMutableString stringWithFormat:@"%@%@",mutStr,abc];
                        }
                        txtPhoneno.text =   [self showmaskonnumber:mutStr];
                        
                    }
                    [selectedContactDict setObject:txtPhoneno.text forKey:select];
                }
            }
            //-----//-----check if email exist
            if ([emailArray count] ==0 ) {
                NSString* select = @"email";
                
                [selectedContactDict setObject:@"" forKey:select];
                txtFirstname.text = selectedPersonFName;
                txtLastname.text = selectedPersonLName;
                txtEmail.text = @"";
            }else if ([emailArray count] ==1 ){
                NSString* select = @"email";
                [selectedContactDict setObject:[[contactDict valueForKey:@"contact_email"]objectAtIndex:0] forKey:select];
                
                txtFirstname.text = selectedPersonFName;
                txtLastname.text = selectedPersonLName;
                NSString *emailStr = [NSString stringWithFormat:@"%@",[[contactDict valueForKey:@"contact_email"]objectAtIndex:0]];
                
                if (![self validateEmailWithString:emailStr]==YES) {
                    NSString* msgstr = @"Selected contact does't have a valid email address.";
                    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:AlertTitle message:msgstr delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                    [alert show];
                    [txtEmail becomeFirstResponder];
                    return;
                }
                
                txtEmail.text = [NSString stringWithFormat:@"%@",[[contactDict valueForKey:@"contact_email"]objectAtIndex:0]];
                //   [self checkforavailability];
            }else if([emailArray count] >1){
                [self showEmailPopup];
            }
            
            
            
            
        }else if([phoneArray count]>1){
            [self showPhoneNoPOPUP];
        }
        
        txtFirstname.userInteractionEnabled = YES;
        txtLastname.userInteractionEnabled = YES;
        txtPhoneno.userInteractionEnabled = YES;
    }else{
        NSString* select = @"phone_no";
        txtFirstname.text = selectedPersonFName;
        txtLastname.text = selectedPersonLName;
        [selectedContactDict setObject:@"" forKey:select];
        txtPhoneno.text = @"";
        popupActive = false;
        
        
        if([emailArray count]){
            
            if ([emailArray count] ==0 ) {
                NSString* select = @"email";
                
                [selectedContactDict setObject:@"" forKey:select];
                txtFirstname.text = selectedPersonFName;
                txtLastname.text = selectedPersonLName;
                txtEmail.text = @"";
            }else if ([emailArray count] ==1 ){
                NSString* select = @"email";
                [selectedContactDict setObject:[[contactDict valueForKey:@"contact_email"]objectAtIndex:0] forKey:select];
                
                txtFirstname.text = selectedPersonFName;
                txtLastname.text = selectedPersonLName;
                NSString *emailStr =[NSString stringWithFormat:@"%@",[[contactDict valueForKey:@"contact_email"]objectAtIndex:0]];
                
                if (![self validateEmailWithString:emailStr]==YES) {
                    NSString* msgstr = @"Selected contact does't have a valid email address.";
                    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:AlertTitle message:msgstr delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                    [alert show];
                    [txtEmail becomeFirstResponder];
                    return;
                }
                txtEmail.text = [NSString stringWithFormat:@"%@",[[contactDict valueForKey:@"contact_email"]objectAtIndex:0]];
                //   [self checkforavailability];
            }else if([emailArray count] >1){
                [self showEmailPopup];
            }
        }else{
            NSString* select = @"email";
            
            [selectedContactDict setObject:@"" forKey:select];
            txtFirstname.text = selectedPersonFName;
            txtLastname.text = selectedPersonLName;
            txtEmail.text = @"";
            
        }
        
    }
    
    
    [txtPhoneno resignFirstResponder];
    
    
    popupActive = false;
    lblemailerror.text = @"";
    email_checked = @"no";
    imagecheckforemailView.image=nil;
    
    
}
- (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
-(void)showPhoneNoPOPUP
{
    popupActive = true;
    isPhoneNo = true;
    unSelected = true;
    [txtPhoneno resignFirstResponder];
    NSArray *value = [contactDict valueForKey:@"contact_phone"];
    
    [self popupTableViewreloadHeight];
    
    lblTypeheaderpopup.text = @"Select Phone Number";
    
    if (IS_IPHONE_4_OR_LESS || IS_IPHONE_5) {
        [lblheaderbackgroungPopup setFrame:CGRectMake(lblheaderbackgroungPopup.frame.origin.x,lblheaderbackgroungPopup.frame.origin.y,lblheaderbackgroungPopup.frame.size.width-20, lblheaderbackgroungPopup.frame.size.height)];
        
        [btnShowEmailPopup setFrame:CGRectMake(btnShowEmailPopup.frame.origin.x-20,btnShowEmailPopup.frame.origin.y,btnShowEmailPopup.frame.size.width, btnShowEmailPopup.frame.size.height)];
        
        [viewHeaderPOPUP setFrame:CGRectMake(viewHeaderPOPUP.frame.origin.x,viewHeaderPOPUP.frame.origin.y,viewHeaderPOPUP.frame.size.width-20, viewHeaderPOPUP.frame.size.height)];
        tableViewPopup.frame=CGRectMake(tableViewPopup.frame.origin.x, tableViewPopup.frame.origin.y, viewHeaderPOPUP.frame.size.width, tableViewPopup.frame.size.height);
    }
    
    
    
    if([value count]<=3)
    {
        
        float height_table =  tableViewPopup.frame.size.height+79*[value count];
        tableViewPopup.frame=CGRectMake(0, tableViewPopup.frame.origin.y, tableViewPopup.frame.size.width, height_table);
        
        [viewHeaderPOPUP setFrame:CGRectMake(self.view.frame.size.width/2-viewHeaderPOPUP.frame.size.width/2, self.view.frame.size.height/2-viewHeaderPOPUP.frame.size.height/2-tableViewPopup.frame.size.height/2, viewHeaderPOPUP.frame.size.width, viewHeaderPOPUP.frame.size.height + tableViewPopup.frame.size.height)];
        tableViewPopup.scrollEnabled = NO;
    }else{
        float height_table =  tableViewPopup.frame.size.height+79*3;
        tableViewPopup.frame=CGRectMake(0, tableViewPopup.frame.origin.y, tableViewPopup.frame.size.width, height_table);
        
        [viewHeaderPOPUP setFrame:CGRectMake(self.view.frame.size.width/2-viewHeaderPOPUP.frame.size.width/2, self.view.frame.size.height/2-viewHeaderPOPUP.frame.size.height/2-tableViewPopup.frame.size.height/2, viewHeaderPOPUP.frame.size.width, viewHeaderPOPUP.frame.size.height + tableViewPopup.frame.size.height)];
        tableViewPopup.scrollEnabled = YES;
    }
    
    [[KGModal sharedInstance] showWithContentView:viewHeaderPOPUP andAnimated:YES];
    [tableViewPopup reloadData];
    
}
-(void)showEmailPopup
{
    [self.view endEditing:YES];
    viewHeaderPOPUPemail.frame = CGRectMake(viewHeaderPOPUPemail.frame.origin.x, viewHeaderPOPUPemail.frame.origin.y, viewHeaderPOPUPemail.frame.size.width, viewPopUp_h);
    tableViewPopupEmail.frame = CGRectMake(tableViewPopupEmail.frame.origin.x, tableViewPopupEmail.frame.origin.y, tableViewPopupEmail.frame.size.width, tableviewPopup_h);
    
    isPhoneNo = false;
    unSelected = true;
    selectedIndex = 20;
    
    NSArray *value = [contactDict valueForKey:@"contact_email"];
    lblTypePOPUPEmail.text = @"Select Email";
    
    if (IS_IPHONE_4_OR_LESS || IS_IPHONE_5) {
        [lblheaderbackgroungPopupEmail setFrame:CGRectMake(lblheaderbackgroungPopupEmail.frame.origin.x,lblheaderbackgroungPopupEmail.frame.origin.y,lblheaderbackgroungPopupEmail.frame.size.width-20, lblheaderbackgroungPopupEmail.frame.size.height)];
        
        [btnDonePOPUPemail setFrame:CGRectMake(btnDonePOPUPemail.frame.origin.x-20,btnDonePOPUPemail.frame.origin.y,btnDonePOPUPemail.frame.size.width, btnDonePOPUPemail.frame.size.height)];
        
        [viewHeaderPOPUPemail setFrame:CGRectMake(viewHeaderPOPUPemail.frame.origin.x,viewHeaderPOPUPemail.frame.origin.y,viewHeaderPOPUPemail.frame.size.width-20, viewHeaderPOPUPemail.frame.size.height)];
        tableViewPopupEmail.frame=CGRectMake(tableViewPopupEmail.frame.origin.x, tableViewPopupEmail.frame.origin.y, viewHeaderPOPUPemail.frame.size.width, tableViewPopupEmail.frame.size.height);
    }
    
    
    
    if([value count]<=3)
    {
        float height_table =  tableViewPopupEmail.frame.size.height+79*[value count];
        tableViewPopupEmail.frame=CGRectMake(0, tableViewPopupEmail.frame.origin.y, tableViewPopupEmail.frame.size.width, height_table);
        
        [viewHeaderPOPUPemail setFrame:CGRectMake(self.view.frame.size.width/2-viewHeaderPOPUPemail.frame.size.width/2, self.view.frame.size.height/2-viewHeaderPOPUPemail.frame.size.height/2-tableViewPopupEmail.frame.size.height/2, viewHeaderPOPUPemail.frame.size.width, viewHeaderPOPUPemail.frame.size.height + tableViewPopupEmail.frame.size.height)];
        
        tableViewPopupEmail.scrollEnabled = NO;
    }else{
        float height_table =  tableViewPopupEmail.frame.size.height+79*3;
        tableViewPopupEmail.frame=CGRectMake(0, tableViewPopupEmail.frame.origin.y, tableViewPopupEmail.frame.size.width, height_table);
        
        [viewHeaderPOPUPemail setFrame:CGRectMake(self.view.frame.size.width/2-viewHeaderPOPUPemail.frame.size.width/2, self.view.frame.size.height/2-viewHeaderPOPUPemail.frame.size.height/2-tableViewPopupEmail.frame.size.height/2, viewHeaderPOPUPemail.frame.size.width, viewHeaderPOPUPemail.frame.size.height + tableViewPopupEmail.frame.size.height)];
        tableViewPopupEmail.scrollEnabled = YES;
        
    }
    
    [[KGModal sharedInstance] showWithContentView:viewHeaderPOPUPemail andAnimated:YES];
    
    
    [tableViewPopupEmail reloadData];
}
-(void)popupTableViewreloadHeight
{
    viewHeaderPOPUP.frame = CGRectMake(viewHeaderPOPUP.frame.origin.x, viewHeaderPOPUP.frame.origin.y, viewHeaderPOPUP.frame.size.width, viewPopUp_h);
    tableViewPopup.frame = CGRectMake(tableViewPopup.frame.origin.x, tableViewPopup.frame.origin.y, tableViewPopup.frame.size.width, tableviewPopup_h);
}
- (BOOL)peoplePickerNavigationController: (ABPeoplePickerNavigationController *)peoplePicker
      shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property
　　　　　　　　　　  identifier:(ABMultiValueIdentifier)identifier
{
    if([[NSString stringWithFormat:@"%d",property] isEqualToString:@"999"])
    {
        [HelperAlert alertWithOneBtn:AlertTitle description:@"Kindly select phone number" okBtn:OkButtonTitle];
        
        return YES;
    }
    if([[NSString stringWithFormat:@"%d",property] isEqualToString:@"14"])
    {
        [HelperAlert alertWithOneBtn:AlertTitle description:@"Kindly select phone number" okBtn:OkButtonTitle];
        
        
        return YES;
    }
    ABMutableMultiValueRef multi = ABRecordCopyValue(person, property);
    CFStringRef phone1 = ABMultiValueCopyValueAtIndex(multi, identifier);
    NSLog(@"phone %@", (__bridge NSString *)phone1);
    CFRelease(phone1);
    
    
    
    ABMultiValueRef fnameProperty = ABRecordCopyValue(person, kABPersonFirstNameProperty);
    ABMultiValueRef lnameProperty = ABRecordCopyValue(person, kABPersonLastNameProperty);
    
    ABMultiValueRef phoneProperty = ABRecordCopyValue(person, kABPersonPhoneProperty);
    ABMultiValueRef emailProperty = ABRecordCopyValue(person, kABPersonEmailProperty);
    
    NSArray *emailArray = (__bridge NSArray *)ABMultiValueCopyArrayOfAllValues(emailProperty);
    NSArray *phoneArray = (__bridge NSArray *)ABMultiValueCopyArrayOfAllValues(phoneProperty);
    
    NSString *name,*phone,*email;
    phone = [[NSString alloc]init];
    email = [[NSString alloc]init];
    name = [[NSString alloc]init];
    
    
    if (fnameProperty != nil) {
        name = [NSString stringWithFormat:@"%@", fnameProperty];
    }
    if (lnameProperty != nil) {
        name = [name stringByAppendingString:[NSString stringWithFormat:@" %@", lnameProperty]];
    }
    
    if ([phoneArray count] > 0) {
        if ([phoneArray count] > 1) {
            for (int i = 0; i < [phoneArray count]; i++) {
                phone = [phone stringByAppendingString:[NSString stringWithFormat:@"%@,", [phoneArray objectAtIndex:i]]];
            }
        }else {
            phone = [NSString stringWithFormat:@"%@", [phoneArray objectAtIndex:0]];
        }
    }
    
    if ([emailArray count] > 0) {
        if ([emailArray count] > 1) {
            for (int i = 0; i < [emailArray count]; i++) {
                email = [email stringByAppendingString:[NSString stringWithFormat:@"%@\n", [emailArray objectAtIndex:i]]];
            }
        }else {
            email = [NSString stringWithFormat:@"%@", [emailArray objectAtIndex:0]];
        }
    }
    
    //----setting txt field values
    NSArray *f_name = [name componentsSeparatedByString:@" "];
    if(f_name.count>1)
    {
        txtFirstname.text = [f_name objectAtIndex:0];
        txtLastname.text = [f_name objectAtIndex:1];
    }else{
        txtFirstname.text = [f_name objectAtIndex:0];
    }
    
    NSArray *only_1_no = [phone componentsSeparatedByString:@","];
    NSString *str = [only_1_no objectAtIndex:identifier];
    NSCharacterSet *unwantedStr = [NSCharacterSet characterSetWithCharactersInString:@"+() -"];
    str = [[str componentsSeparatedByCharactersInSet: unwantedStr] componentsJoinedByString: @""];
    NSArray *ar = [email componentsSeparatedByString:@"\n"];
    
    
    NSMutableString *mutStr = [[NSMutableString alloc]init];
    for (int i = 0; i<str.length; i++)
    {
        NSString *abc = [NSString stringWithFormat:@"%C",[str characterAtIndex:i]];
        if(i==0){
            mutStr =[NSMutableString stringWithFormat:@"%@",abc];
        }else{
            mutStr = [NSMutableString stringWithFormat:@"%@%@",mutStr,abc];
        }
        NSString *returnedStr =   [self showmaskonnumber:mutStr];
        txtPhoneno.text = returnedStr;
    }
    
    
    txtEmail.text = [ar objectAtIndex:0];
    //   [self checkforavailability];
    
    ABPeoplePickerNavigationController *peoplePicker1 = (ABPeoplePickerNavigationController *)peoplePicker.navigationController;
    [peoplePicker1 dismissModalViewControllerAnimated:YES];
    [txtEmail becomeFirstResponder];
    return YES;
}
-(NSString*)showmaskonnumber:(NSString*)number
{
    
    NSString *newString = number;
    
    NSArray *components = [newString componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]];
    NSString *decimalString = [components componentsJoinedByString:@""];
    
    NSUInteger length = decimalString.length;
    BOOL hasLeadingOne = length > 1 && [decimalString characterAtIndex:0] == '1';
    
    if (noShowOnPopUp) {
        
    }else{
        if (length == 0 || (length > 10 && !hasLeadingOne) || (length > 10)) {
            [txtPhoneno becomeFirstResponder];
            
            return number;
        }
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
    
    return  formattedString;
    
}

#pragma mark - connection delegate

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
        response_status = @"passed";
        
    }else if ((long)[httpResponse statusCode] == ResultFailed)
    {
        response_status = @"failed";
    }
    
    if(webservice==5)
    {
        if((long)[httpResponse statusCode] == ResultOk)
        {
            
            response_status = @"passed";
            
            NSLog(@"Received Response");
            [webData setLength: 0];
            
        }else if ((long)[httpResponse statusCode] == ResultFailed)
        {
            response_status = @"failed";
            
            
        }
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
    
    if([response_status isEqualToString:@"passed"])
    {
        SBJsonParser *json = [[SBJsonParser alloc] init];
        NSMutableDictionary *userDetailDict=[json objectWithString:responseString error:&error];
        if(webservice==1)
        {
            id_mea_array = [userDetailDict valueForKey:@"ID"];
            name_mea_array= [userDetailDict valueForKey:@"Name"];
            
            NSString *meaid = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"l_meaId"]];
            if ([meaid isEqualToString:@"<null>"]) {
                if ([name_mea_array containsObject:@"Any Member Experience Advisor (Sales)"]) {
                    NSInteger anIndex=[name_mea_array indexOfObject:@"Any Member Experience Advisor (Sales)"];
                    int indexOfArray = (int)anIndex;
                    txtmea.text = [name_mea_array objectAtIndex:indexOfArray];
                    selected_text_id = [NSString stringWithFormat:@"%@",[id_mea_array objectAtIndex:indexOfArray]];
                    [btnMEA setTitle:@"" forState:UIControlStateNormal];
                }
            } else {
                NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
                f.numberStyle = NSNumberFormatterDecimalStyle;
                NSNumber *meaIdVal = [f numberFromString:meaid];
                
                if ([id_mea_array containsObject:meaIdVal]) {
                    NSInteger anIndex=[id_mea_array indexOfObject:meaIdVal];
                    int indexOfArray = (int)anIndex;
                    txtmea.text = [name_mea_array objectAtIndex:indexOfArray];
                    selected_text_id = [NSString stringWithFormat:@"%@",[id_mea_array objectAtIndex:anIndex]];
                    [btnMEA setTitle:@"" forState:UIControlStateNormal];
                }
            }
            //
            //            //---------29th dec modification Start
            //
            //            //showing only previously selected mea and any membor advisor
            //            twoValueArray = [[NSMutableArray alloc]init];
            //            twoValueArrayID = [[NSMutableArray alloc]init];
            //
            //            //to add any membor advisior as first option in dropdown
            //            for (int i=0; i<name_mea_array.count; i++) {
            //
            //                if ([[NSString stringWithFormat:@"%@",[name_mea_array objectAtIndex:i]] rangeOfString:@"Any Member" options:NSCaseInsensitiveSearch].location != NSNotFound){
            //                    [twoValueArray addObject:[NSString stringWithFormat:@"%@",[name_mea_array objectAtIndex:i]]];
            //                }
            //
            //            }
            //
            //            // Check if user already selected the any member advisor other wise add the value selected at the time of signup
            //            if (![[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"l_meaName"]] isEqualToString:[twoValueArray objectAtIndex:0]]){
            //                if([[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"l_meaName"]] isEqualToString:@"<null>"]){
            //
            //                }else{
            //                    [twoValueArray addObject:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"l_meaName"]]];
            //                }
            //            }
            //
            //
            //            //getting objects id
            //            for (int j=0; j<twoValueArray.count; j++) {
            //                NSInteger indexValue1;
            //                if ([name_mea_array containsObject:[twoValueArray objectAtIndex:j]]) {
            //                    indexValue1 = [name_mea_array indexOfObject:[twoValueArray objectAtIndex:j]];
            //                }else {
            //                    [twoValueArray removeObjectAtIndex:j];
            //                    continue;
            //                }
            //
            //                [twoValueArrayID addObject:[NSString stringWithFormat:@"%@",[id_mea_array objectAtIndex:indexValue1]]];
            //            }
            //
            //            id_mea_array = [[NSArray alloc]init];
            //            name_mea_array = [[NSArray alloc]init];
            //
            //            id_mea_array = twoValueArrayID;
            //            name_mea_array = twoValueArray;
            //
            //            NSString *meaDefaultStr =[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"l_meaName"]];
            //
            //            if (![name_mea_array containsObject:meaDefaultStr]){
            //                txtmea.text = @"";
            //                [btnMEA setTitle:@"Select MEA" forState:UIControlStateNormal];
            //            }
            //
            //            //---------29th dec modification end
        }else if(webservice==2)
        {
            
            if ([responseString rangeOfString:@"Ref" options:NSCaseInsensitiveSearch].location != NSNotFound)
            {
                
                NSString *msg = [NSString stringWithFormat:@"Your referral has been submitted successfully."];
                
                [HelperAlert alertWithOneBtn:@"Thanks!" description:msg okBtn:OkButtonTitle withTag:3 forController:self];
                //                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Thanks!!"  message:msg delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                //
                //                alert.tag=3;
                //                [alert show];
                return;
            }
        }else if (webservice==5)
        {
            
            email_checked = @"yes";
            if ([responseString rangeOfString:@"Email address not exist" options:NSCaseInsensitiveSearch].location != NSNotFound)
            {
                
                imagecheckforemailView.hidden =NO;
                
                
                CGRect frame = viewEmailindicator.frame;
                frame.origin.x = txtEmail.frame.origin.x + txtEmail.frame.size.width+3;
                frame.origin.y = txtEmail.frame.origin.y +txtEmail.frame.size.height/4;
                viewEmailindicator.frame = frame;
                lblemailerror.text=@"";
                imagecheckforemailView.image = [UIImage imageNamed:@"tick2.png"];
                [activityIndicatorObject1 stopAnimating];
                
                
                return;
            }else if ([responseString rangeOfString:@"User Not Found" options:NSCaseInsensitiveSearch].location != NSNotFound)
            {
                return;
            }
            NSString *usertype = [userDetailDict valueForKey:@"UserType"];
            if([usertype isEqualToString:@"Client"])
            {
                
                [HelperAlert alertWithTwoBtns:AlertTitle description:@"One of our client already referred this person. Do you want to refer this person again." okBtn:@"No" cancelBtn:@"Yes" withTag:8 forController:self];
                
                //                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:AlertTitle message:@"One of our client already referred this person. Do you want to refer this person again." delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes",nil];
                //                [alert show];
                //                alert.tag =8;
                
                [txtEmail resignFirstResponder];
                [txtComment resignFirstResponder];
                [txtPhoneno resignFirstResponder];
                [txtLastname resignFirstResponder];
                [txtFirstname resignFirstResponder];
                [txtmea resignFirstResponder];
                [scrollView setContentOffset:CGPointMake(0, -20) animated:YES];
                
                firstname = [NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"FirstName"]];
                lastname = [NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"LastName"]];
                phoneno = [NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"PhoneNumber"]];
                
                //                 txtEmail.text = [NSString stringWithFormat:@"%@",[[contactDict valueForKey:@"contact_email"]objectAtIndex:0]];
                
                
                UserDetailId = [NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"UserDetailId"]];
                [activityIndicatorObject1 stopAnimating];
                
                
                return;
            }
            
            lblemailerror.text =@"The email you entered is already exist in Autoaves system Please Try with another email address";
            [activityIndicatorObject1 stopAnimating];
            
        }
    }else{
        if(webservice==5)
        {
            email_checked = @"yes";
            if ([responseString rangeOfString:@"Email address not exist" options:NSCaseInsensitiveSearch].location != NSNotFound)
            {
                
                imagecheckforemailView.hidden =NO;
                
                
                CGRect frame = viewEmailindicator.frame;
                frame.origin.x = txtEmail.frame.origin.x + txtEmail.frame.size.width+3;
                frame.origin.y = txtEmail.frame.origin.y +txtEmail.frame.size.height/4;
                viewEmailindicator.frame = frame;
                lblemailerror.text=@"";
                imagecheckforemailView.image = [UIImage imageNamed:@"tick2.png"];
                [activityIndicatorObject1 stopAnimating];
                
                
                
                return;
            }else if ([responseString rangeOfString:@"User Not Found" options:NSCaseInsensitiveSearch].location != NSNotFound)
            {
                [activityIndicatorObject1 stopAnimating];
                
                return;
            }
            
        }
        [HelperAlert alertWithOneBtn:AlertTitle description:responseString okBtn:OkButtonTitle];
        
        
    }
    [kappDelegate HideIndicator];
    
}


#pragma mark - TableView Delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [txtPhoneno resignFirstResponder];
    [txtmea resignFirstResponder];
    [txtLastname resignFirstResponder];
    [txtFirstname resignFirstResponder];
    [txtEmail resignFirstResponder];
    [txtComment resignFirstResponder];
    [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    
    
    
    
    if (tableView == tableViewPopup || tableView==tableViewPopupEmail) {
        NSArray *value;
        if(isPhoneNo)
        {
            value = [contactDict valueForKey:@"contact_phone"];
        }else{
            value = [contactDict valueForKey:@"contact_email"];
        }
        return [value count];
    }
    
    return id_mea_array.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == tableViewPopup || tableView==tableViewPopupEmail) {
        return 79;
    }
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        if (id_mea_array.count<=3) {
            tableView.frame = CGRectMake(tableView.frame.origin.x, tableView.frame.origin.y, tableView.frame.size.width, 57*id_mea_array.count);
        }
        return 57;
    }
    if (id_mea_array.count<=3) {
        tableView.frame = CGRectMake(tableView.frame.origin.x, tableView.frame.origin.y, tableView.frame.size.width, 35*id_mea_array.count);
    }
    return 35;
}
- (UITableViewCell *)tableView:(UITableView *)atableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (atableView == tableViewPopup ||  atableView==tableViewPopupEmail) {
        
        static NSString *simpleTableIdentifier = @"ArticleCellID";
        
        PopupTableViewCell *cell = (PopupTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PopupTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            
        }
        NSMutableArray *valueToSet,*valueLbl;
        valueToSet = [[NSMutableArray alloc]init];
        valueLbl = [[NSMutableArray alloc]init];
        
        if (isPhoneNo) {
            valueToSet = [contactDict valueForKey:@"contact_phone"];
            valueLbl = [contactDict valueForKey:@"contact_lbl"];
            
            NSMutableArray *savedStrArray = [[NSMutableArray alloc]init];
            for (int i=0; i<valueToSet.count; i++) {
                NSString *phoneNoStr = [NSString stringWithFormat:@"%@",[valueToSet objectAtIndex:i]];
                
                phoneNoStr = [phoneNoStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                
                NSCharacterSet *unwantedStr = [NSCharacterSet characterSetWithCharactersInString:@"+() -"];
                phoneNoStr = [[phoneNoStr componentsSeparatedByCharactersInSet: unwantedStr] componentsJoinedByString: @""];
                
                noShowOnPopUp = false;
                if(phoneNoStr.length >10){
                    noShowOnPopUp = true;
                }
                
                NSMutableString *mutStr = [[NSMutableString alloc]init];
                NSString *returnedStr;
                for (int i = 0; i<phoneNoStr.length; i++)
                {
                    NSString *abc = [NSString stringWithFormat:@"%C",[phoneNoStr characterAtIndex:i]];
                    if(i==0){
                        mutStr =[NSMutableString stringWithFormat:@"%@",abc];
                    }else{
                        mutStr = [NSMutableString stringWithFormat:@"%@%@",mutStr,abc];
                    }
                    returnedStr =   [self showmaskonnumber:mutStr];
                    
                }
                [savedStrArray addObject:returnedStr];
                
            }
            
            valueToSet = [[NSMutableArray alloc]init];
            valueToSet = savedStrArray;
            
            [contactDict removeObjectForKey:@"contact_phone"];
            [contactDict setObject:valueToSet forKey:@"contact_phone"];
            
        }else{
            valueToSet = [contactDict valueForKey:@"contact_email"];
            valueLbl = [contactDict valueForKey:@"contact_emaillbl"];
        }
        
        NSString *imageName;
        if (selectedIndex ==indexPath.row) {
            imageName = @"radio-checked.png";
        }else{
            imageName = @"radio-unchecked.png";
        }
        
        if (indexPath.row==selectedIndex) {
            imageName =@"radio-checked.png";
        }
        
        
        
        [cell setLabelText:imageName :[valueLbl objectAtIndex:indexPath.row] :[valueToSet objectAtIndex:indexPath.row] :&(isPhoneNo)];
        
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        return  cell;
    }
    
    
    
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [name_mea_array objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:13.0];
    cell.textLabel.textColor = [UIColor colorWithRed:25.0f/255.0f green:93.0f/255.0f blue:172.0f/255.0f alpha:1.0f];
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if ( IS_IPAD )
    {
        cell.textLabel.font = [UIFont systemFontOfSize:20.0];
    }
    return  cell;
}

- (void)tableView:(UITableView *)atableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (atableView == tableViewPopup || atableView==tableViewPopupEmail) {
        NSArray *selectedValue;
        NSString *select;
        if (isPhoneNo) {
            selectedValue = [contactDict valueForKey:@"contact_phone"];
            select = @"phone_no";
            
            NSString *phoneStr = [NSString stringWithFormat:@"%@",[selectedValue objectAtIndex:indexPath.row]];
            
            
            phoneStr = [phoneStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            
            NSCharacterSet *unwantedStr = [NSCharacterSet characterSetWithCharactersInString:@"+() -"];
            phoneStr = [[phoneStr componentsSeparatedByCharactersInSet: unwantedStr] componentsJoinedByString: @""];
            
            
            if (phoneStr.length!=0 ) {
                
                
                if (phoneStr.length<10 ) {
                    [HelperAlert  alertWithOneBtn:AlertTitle description:@"Selected phone number is not valid." okBtn:OkButtonTitle];
                    return;
                }
            }
            if (phoneStr.length>10 ) {
                if([[NSString stringWithFormat:@"%C",[phoneStr characterAtIndex:0]] isEqual:@"1"] && phoneStr.length==10)
                {
                    
                }else{
                    
                    NSString* msgstr = @"Selected phone number is not valid.";
                    [HelperAlert  alertWithOneBtn:AlertTitle description:msgstr okBtn:OkButtonTitle];
                    
                    return;
                }
            }
            
            
        }else{
            selectedValue = [contactDict valueForKey:@"contact_email"];
            select = @"email";
        }
        
        
        
        
        [selectedContactDict setObject:[selectedValue objectAtIndex:indexPath.row] forKey:select];
        selectedIndex = indexPath.row;
        if (isPhoneNo) {
            [tableViewPopup reloadData];
        }else{
            
            [tableViewPopupEmail reloadData];
            
        }
        return;
    }
    txtmea.text = [name_mea_array objectAtIndex:indexPath.row];
    
    if (IS_IPHONE_4_OR_LESS || IS_IPHONE_5) {
        if([txtmea.text isEqualToString:@"Any Member Experience Advisor (Sales)"])
        {
            txtmea.font=[txtmea.font fontWithSize:12];
        }else{
            
            txtmea.font=[txtmea.font fontWithSize:13];
            
        }
    }else{
        
        if([txtmea.text isEqualToString:@"Any Member Experience Advisor (Sales)"])
        {
            txtmea.font=[txtmea.font fontWithSize:14];
        }
    }
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        txtmea.font=[txtmea.font fontWithSize:20];
    }
    selected_text_id = [NSString stringWithFormat:@"%@",[id_mea_array objectAtIndex:indexPath.row]];
    [btnMEA setTitle:@"" forState:UIControlStateNormal];
    tableView.hidden =YES;
    status = false;
}
#pragma  mark Other methods
-(void)submitReferral:(NSString*)firstname1 lastname:(NSString*)lastname1 phoneno:(NSString*)phoneno1 email:(NSString*)email mea:(NSString*)mea comment:(NSString*)comment
{
    
    [kappDelegate ShowIndicator];
    NSMutableURLRequest *request ;
    NSString*_postData ;
    webservice=2;
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSLog(@"%@",[user valueForKey:@"l_userid"]);
    
    _postData = [NSString stringWithFormat:@"ReferrerID=%@&FirstName=%@&LastName=%@&PhoneNumber=""%@&Email=%@&Comments=%@&MeaId=%@",[NSString stringWithFormat:@"%@",[user valueForKey:@"l_userid"]],firstname1,lastname1,phoneno1,email,comment,mea];
    
    if([found_client isEqualToString:@"yes"])
    {   found_client = @"no";
        _postData = [NSString stringWithFormat:@"ReferrerID=%@&FirstName=%@&LastName=%@&PhoneNumber=%@&Email=%@&Comments=%@&MeaId=%@&UserDetailId=%@",[NSString stringWithFormat:@"%@",[user valueForKey:@"l_userid"]],firstname1,lastname1,phoneno1,email,comment,mea,UserDetailId];
    }
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/referrals",Kwebservices]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
    
    NSLog(@"data post >>> %@",_postData);
    
    [request setHTTPMethod:@"POST"];
    
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
    NSString *objStr = @"self";
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(alertView.tag==3){
        if(buttonIndex == 0) //OK button pressed
        {
            dashboardViewController *obj  =[[dashboardViewController alloc]initWithNibName:@"dashboardViewController" bundle:nil];
            [self.navigationController pushViewController:obj animated:YES];
        }
    }else if(alertView.tag==8){
        
        if(buttonIndex == 0) //OK button pressed
        {
            // lblemailerror.text = @"Email already registered.";
            txtFirstname.text = @"";
            txtLastname.text = @"";
            txtPhoneno.text = @"";
            txtEmail.text=@"";
            
        }
        else if(buttonIndex == 1) //Annul button pressed.
        {
            
            
            txtFirstname.text = firstname;
            txtLastname.text = lastname;
            if ([phoneno isEqualToString:@"<null>"]) {
                txtPhoneno.text = @"";
            }else{
                txtPhoneno.text = phoneno;
            }
            found_client = @"yes";
            imagecheckforemailView.image = [UIImage imageNamed:@"tick2.png"];
        }
        
    }
}
-(void)cancelNumberPad{
    [txtPhoneno resignFirstResponder];
    txtPhoneno.text = @"";
    [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    scrollView.scrollEnabled = YES;
}

-(void)doneWithNumberPad{
    [txtEmail becomeFirstResponder];
    
}
-(void)getMEA
{
    
    // [kappDelegate ShowIndicator];
    NSMutableURLRequest *request ;
    NSString*_postData ;
    webservice=1;
    _postData = [NSString stringWithFormat:@""];
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/users/mea",Kwebservices]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
    
    
    
    NSLog(@"data post >>> %@",_postData);
    
    [request setHTTPMethod:@"GET"];
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

-(void)checkforavailability
{
    //    btnSubmitReferral.backgroundColor = [UIColor darkGrayColor];
    //    [btnSubmitReferral setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    //    btnSubmitReferral.userInteractionEnabled = NO;
    
    NSMutableURLRequest *request ;
    NSString*_postData ;
    email_checked = @"no";
    webservice=5;
    _postData = [NSString stringWithFormat:@"Email=%@",txtEmail.text];
    
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/users/confirm",Kwebservices]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
    
    NSLog(@"data post >>> %@",_postData);
    [request setHTTPMethod:@"POST"];
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

@end
