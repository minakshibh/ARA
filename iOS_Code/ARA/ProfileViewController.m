//
//  ProfileViewController.m
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 11/08/15.
//  Copyright (c) 2015 Krishna_Mac_2. All rights reserved.
//

#import "ProfileViewController.h"
#import "changePasswordViewController.h"
#import "SignUpViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "ASIHTTPRequest.h"
#import "showProfileImageViewController.h"
//#import "UIImageView+WebCache.h"


@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    imageProfile.hidden = YES;
    [super viewDidLoad];
    activityIndicatorObject = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];

    btnCheckBox.hidden = YES;
    checkbox_Value = false;

    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureHandlerMethod:)];
    [viewtohidekeyboard addGestureRecognizer:tapRecognizer];
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbar sizeToFit];
    txtPhoneNo.inputAccessoryView = numberToolbar;
    
//    int d = 0; // standard display
//    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2.0) {
//        d = 1; // is retina display
//    }
//    
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
//        d += 2;
//    }
//    
//    if (d==0) {
//        headerImage.image = [UIImage imageNamed:@"320X480.png"];
//    }
//    if (d==1) {
//        headerImage.image = [UIImage imageNamed:@"320X568.png"];
//    }
//    if (d==2) {
//        headerImage.image = [UIImage imageNamed:@"480X800.png"];
//    }
//    if (d==3) {
//        headerImage.image = [UIImage imageNamed:@"640X1136.png"];
//    }
    
    NSMutableAttributedString *titleString = [[NSMutableAttributedString alloc] initWithString:@"Change Password"];
    // making text property to underline text-
    [titleString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [titleString length])];
    // using text on button
    
    [btnChangePassword setAttributedTitle: titleString forState:UIControlStateNormal];
    [btnChangePassword setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    
    scrollView.scrollEnabled = YES;
    [NSTimer scheduledTimerWithTimeInterval:0.1
                                     target:self
                                   selector:@selector(targetMethod:)
                                   userInfo:nil
                                    repeats:NO];
    
    if ( IS_IPAD )
    {
        
        namelbl.font=[namelbl.font fontWithSize:24];
        lastnamelbl.font=[lastnamelbl.font fontWithSize:24];
        lblName.font=[lblName.font fontWithSize:24];
        lblLastname.font=[lblLastname.font fontWithSize:24];
        lblEmail.font=[lblEmail.font fontWithSize:24];
        lblPhoneno.font=[lblPhoneno.font fontWithSize:24];
        lblRole.font=[lblRole.font fontWithSize:24];
        lblMEAname.font=[lblMEAname.font fontWithSize:24];
        lblPurchased.font=[lblPurchased.font fontWithSize:24];
        txtName.font=[txtName.font fontWithSize:24];
        txtLastname.font=[txtLastname.font fontWithSize:24];
        txtPhoneNo.font=[txtPhoneNo.font fontWithSize:24];
        txtEmail.font=[txtEmail.font fontWithSize:24];
        txtRole.font=[txtRole.font fontWithSize:24];
        txtMEA.font=[txtMEA.font fontWithSize:24];
        lblpassword.font=[lblpassword.font fontWithSize:24];
        lblheading.font=[lblheading.font fontWithSize:24];
        lblemail1.font=[lblemail1.font fontWithSize:24];
        lblphoneno1.font=[lblphoneno1.font fontWithSize:24];
        lblrole1.font=[lblrole1.font fontWithSize:24];
        lblmea1.font=[lblmea1.font fontWithSize:24];
        lblpurchased1.font=[lblpurchased1.font fontWithSize:24];
        lblpassword1.font=[lblpassword1.font fontWithSize:24];
        btnChangePassword.titleLabel.font = [btnChangePassword.titleLabel.font fontWithSize:24];
        
        btnedit.titleLabel.font = [btnedit.titleLabel.font fontWithSize:24];
        btnSave.titleLabel.font = [btnSave.titleLabel.font fontWithSize:24];
         btnback.titleLabel.font = [btnback.titleLabel.font fontWithSize:24];
        btnEditImage.titleLabel.font = [btnback.titleLabel.font fontWithSize:20];
        lblUserID.font=[lblUserID.font fontWithSize:24];

        if(IS_IPAD_PRO_1366)
        {
            namelbl.font=[namelbl.font fontWithSize:30];
            lastnamelbl.font=[lastnamelbl.font fontWithSize:30];
            lblName.font=[lblName.font fontWithSize:30];
            lblLastname.font=[lblLastname.font fontWithSize:30];
            lblEmail.font=[lblEmail.font fontWithSize:30];
            lblPhoneno.font=[lblPhoneno.font fontWithSize:30];
            lblRole.font=[lblRole.font fontWithSize:30];
            lblMEAname.font=[lblMEAname.font fontWithSize:30];
            lblPurchased.font=[lblPurchased.font fontWithSize:30];
            txtName.font=[txtName.font fontWithSize:30];
            txtLastname.font=[txtLastname.font fontWithSize:30];
            txtPhoneNo.font=[txtPhoneNo.font fontWithSize:30];
            txtEmail.font=[txtEmail.font fontWithSize:30];
            txtRole.font=[txtRole.font fontWithSize:30];
            txtMEA.font=[txtMEA.font fontWithSize:30];
            lblpassword.font=[lblpassword.font fontWithSize:30];
            lblheading.font=[lblheading.font fontWithSize:30];
            lblemail1.font=[lblemail1.font fontWithSize:30];
            lblphoneno1.font=[lblphoneno1.font fontWithSize:30];
            lblrole1.font=[lblrole1.font fontWithSize:30];
            lblmea1.font=[lblmea1.font fontWithSize:30];
            lblpurchased1.font=[lblpurchased1.font fontWithSize:30];
            lblpassword1.font=[lblpassword1.font fontWithSize:30];
            btnChangePassword.titleLabel.font = [btnChangePassword.titleLabel.font fontWithSize:30];
            
            btnedit.titleLabel.font = [btnedit.titleLabel.font fontWithSize:30];
            btnSave.titleLabel.font = [btnSave.titleLabel.font fontWithSize:30];
            btnback.titleLabel.font = [btnback.titleLabel.font fontWithSize:30];
            btnEditImage.titleLabel.font = [btnback.titleLabel.font fontWithSize:24];
            lblUserID.font=[lblUserID.font fontWithSize:30];
        }
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    NSString *imagestr = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"l_image"]];
    NSData * im = [[NSUserDefaults standardUserDefaults]valueForKey:@"profile_picture"];
    imageProfile.image = [UIImage imageWithData:im];
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
//        
//
//        //imageProfile.contentMode=UIViewContentModeScaleAspectFit;
//
//        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imagestr]];
//                 [imageProfile sd_setImageWithURL:[NSURL URLWithString:imagestr]
//    placeholderImage:[UIImage imageNamed:@"user-i.png"]];
//        
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            // Update the UI
//            imageProfile.image = [UIImage imageWithData:imageData];
////
//           
//        });
//    });
//
//    [imageProfile sd_setImageWithURL:[NSURL URLWithString:imagestr]
//                    placeholderImage:[UIImage imageNamed:@"user-i.png"]];
    
    //---make profile image round
   
    
    lblRole.hidden = NO;
    
    [self.view bringSubviewToFront:lblRole];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    //--assigning image and label values
    lblEmail.text = [NSString stringWithFormat:@"%@",[user valueForKey:@"l_email"]];
    //NSData *image_data= [[NSUserDefaults standardUserDefaults]valueForKey:@"user_image"];
    lblUserID.text = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"l_userName"]];
    // imageProfile.image = [UIImage imageWithData:image_data];
    NSString *first = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"l_firstName"]];
    lblName.text = first;
    NSString *last = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"l_lastName"]];
    lblLastname.text = last;
//    NSString* namestr =[NSString stringWithFormat:@"%@ %@",first,last];
//    lblName.text = namestr;
    
    
    lblPhoneno.text = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"l_phoneNo"]];
    NSString *phone =[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"l_phoneNo"]];
   // lblPhoneno.text=@"5454564564564564564";
    NSMutableString *mutstr = [[NSMutableString alloc]init];
    for (int i = 0; i<phone.length; i++)
    {
        NSString *character = [NSString stringWithFormat:@"%C",[phone characterAtIndex:i]];
        if(i==0){
            mutstr =[NSMutableString stringWithFormat:@"%@",character];
        }else{
        mutstr = [NSMutableString stringWithFormat:@"%@%@",mutstr,character];
        }
        [self showmaskonnumber:mutstr];
    }
    laststr =[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"l_phoneNo"]];
    lblRole.text = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"l_roleName"]];
    lblMEAname.text = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"l_meaName"]];
    NSString *role = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"l_purchasedBefore"]];
    if([role isEqualToString:@"1"]){
        lblPurchased.text = @"YES";
        [btnCheckBox setImage:[UIImage imageNamed:@"checkbox2_checked.png"] forState:UIControlStateNormal];
    }else{
        lblPurchased.text = @"NO";
        [btnCheckBox setImage:[UIImage imageNamed:@"checkbox2_unchecked.png"] forState:UIControlStateNormal];
    }
    
    txtEmail.hidden = YES;
    txtMEA.hidden = YES;
    txtPhoneNo.hidden = YES;
    txtRole.hidden = YES;
    txtName.hidden = YES;
    
    [txtName resignFirstResponder];
    [txtPhoneNo resignFirstResponder];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma  mark - Buttons
- (IBAction)btnCheckBox:(id)sender {
    if(checkbox_Value == true)
    {
        checkbox_Value = false;
        btnImage = [UIImage imageNamed:@"checkbox2_unchecked.png"];
        [btnCheckBox setImage:btnImage forState:UIControlStateNormal];
        return;
    }
    
    checkbox_Value = true;
    btnImage = [UIImage imageNamed:@"checkbox2_checked.png"];
    [btnCheckBox setImage:btnImage forState:UIControlStateNormal];
}

- (IBAction)btnback:(id)sender {    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnEdit:(id)sender {
    btnEditImage.hidden = YES;
    lblpassword1.hidden=YES;
    namelbl.textColor = [UIColor blackColor];
    phonelbl.textColor = [UIColor blackColor];
    purchasedlbl.textColor = [UIColor blackColor];
    lastnamelbl.textColor = [UIColor blackColor];
    
    
    // txtEmail.text = lblEmail.text;
    txtLastname.hidden = NO;
    txtPhoneNo.text = lblPhoneno.text;
    txtName.text = lblName.text;
    txtLastname.text = lblLastname.text;
   // txtRole.text = lblRole.text;
    
    txtName.textColor = [UIColor blackColor];
    txtPhoneNo.textColor = [UIColor blackColor];
    txtLastname.textColor = [UIColor blackColor];
    
    lblLastname.hidden = YES;
    btnEdit.hidden = YES;
    btnCheckBox.hidden = NO;
    btnSave.hidden = NO;
    lblEmail.hidden = NO;

    lblPhoneno.hidden = YES;
    lblRole.hidden = NO;
    lblPurchased.hidden = YES;
    lblName.hidden = YES;
    
    txtRole.hidden = YES;
    txtPhoneNo.hidden = NO;
    txtMEA.hidden = YES;
    txtEmail.hidden = YES;
    btnCheckBox.hidden = NO;
    txtName.hidden=NO;
    
    btnChangePassword.hidden = YES;
}

- (IBAction)btnChangePassword:(id)sender {
    changePasswordViewController *obj = [[changePasswordViewController alloc]initWithNibName:@"changePasswordViewController" bundle:nil];
    [self.navigationController pushViewController:obj animated:YES];
}
- (IBAction)btnEditImage:(id)sender {
    showProfileImageViewController *obj = [[showProfileImageViewController alloc]initWithNibName:@"showProfileImageViewController" bundle:nil];
    [self.navigationController pushViewController:obj animated:YES];
}



- (IBAction)btnSave:(id)sender {
     NSString* namestr = [txtName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
     NSString* phoneno = [txtPhoneNo.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSCharacterSet *unwantedStr = [NSCharacterSet characterSetWithCharactersInString:@"+() -"];
    phoneno = [[phoneno componentsSeparatedByCharactersInSet: unwantedStr] componentsJoinedByString: @""];
    NSString* lastname = [txtLastname.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    UIAlertView *alert;
    NSString *msg;
//    
//    NSMutableString *fir_name,*Secon_nam;
//    Secon_nam = [[NSMutableString alloc]init];
//    NSArray *name = [namestr componentsSeparatedByString:@" "];
//    
//    if (name.count<2) {
//        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"ARA" message:@"Please enter your last name." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//        [alert show];
//        
//        return;
//    }else {
//        fir_name = [NSMutableString stringWithFormat:@"%@",[name objectAtIndex:0]];
//        for(int n = 1; n<name.count; n++){
//            Secon_nam = [NSMutableString stringWithFormat:@"%@%@ ",Secon_nam,[name objectAtIndex:n]];
//            NSLog(@"%@",Secon_nam);
//    
//        }
//    }
//    
    
    if([txtName isEmpty])
    {
        msg = @"please enter name";
        lblerrorName.hidden = NO;

        lblerrorName.text = msg;
       [txtName becomeFirstResponder];
        return;
    }else if(namestr.length > 25)
    {
          msg = @"Entered name is too long.";
        lblerrorName.hidden = NO;
        
        lblerrorName.text = msg;
        [txtName becomeFirstResponder];
        return;
    }else if([txtLastname isEmpty])
    {
        msg = @"please enter last name";
        lblerrorName.hidden = NO;
        
        lblerrorName.text = msg;
        [txtLastname becomeFirstResponder];
        return;
    }else if(lastname.length > 25)
    {
        msg = @"Entered last name is too long";
        lblerrorName.hidden = NO;
        
        lblerrorName.text = msg;
        [txtLastname becomeFirstResponder];
        return;
    }else if([txtPhoneNo isEmpty])
    {
        
        msg = @"please enter phone no";
        lblerrorPhoneno.hidden = NO;

        lblerrorPhoneno.text =msg;
        [txtPhoneNo becomeFirstResponder];
        
        return;
    }else if(phoneno.length < 5)
    {
        msg = @"Kindly enter a valid phone number.";
        lblerrorPhoneno.hidden = NO;
        
        lblerrorPhoneno.text = msg;
        [txtPhoneNo becomeFirstResponder];
        return;
    }
    if(phoneno.length >10)
    {
        if([[NSString stringWithFormat:@"%C",[phoneno characterAtIndex:0]] isEqual:@"1"])
        {
            
        }else{
        msg = @"Phone no should be atmost of 10 digits";
        lblerrorPhoneno.hidden = NO;
        lblerrorPhoneno.text =msg;
        [txtPhoneNo becomeFirstResponder];
        return;
        }
    }
    namelbl.textColor = [UIColor darkGrayColor];
    phonelbl.textColor = [UIColor darkGrayColor];
    purchasedlbl.textColor = [UIColor darkGrayColor];
    lastnamelbl.textColor= [UIColor darkGrayColor];
    
    [txtPhoneNo resignFirstResponder];
    [txtName resignFirstResponder];
    [txtLastname resignFirstResponder];
    [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];

    lblName.hidden=NO;
    btnSave.hidden = YES;
    btnEdit.hidden = NO;
    btnEditImage.hidden = NO;
    
    lblpassword1.hidden = NO;
    txtRole.hidden = YES;
    txtPhoneNo.hidden = YES;
    txtMEA.hidden = YES;
    txtEmail.hidden = YES;
    btnCheckBox.hidden = YES;
    
    lblEmail.hidden = NO;

    lblPhoneno.hidden = NO;
    lblPurchased.hidden = NO;
    lblRole.hidden = NO;
    
    btnChangePassword.hidden = NO;
    
    if(checkbox_Value == true)
    {
        lblPurchased.text = @"Yes";
    }else
    {
        lblPurchased.text = @"No";
    }
    lblLastname.hidden = NO;
    lblPhoneno.text =txtPhoneNo.text;
    lblName.text = txtName.text;
    lblLastname.text = lastname;
    txtName.hidden=YES;
    txtLastname.hidden = YES;
   
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *roldID = [NSString stringWithFormat:@"%@",[user valueForKey:@"l_roleId"]];
    NSString *email = [NSString stringWithFormat:@"%@",[user valueForKey:@"l_email"]];
    NSString *password = [NSString stringWithFormat:@"%@",[user valueForKey:@"l_password"]];
    NSString *isfacebook = [NSString stringWithFormat:@"%@",[user valueForKey:@"l_facebookUser"]];
    NSString *meaid = [NSString stringWithFormat:@"%@",[user valueForKey:@"l_meaId"]];
    NSString *username= [NSString stringWithFormat:@"%@",[user valueForKey:@"l_userName"]];
    NSString *userid= [NSString stringWithFormat:@"%@",[user valueForKey:@"l_userid"]];

    NSString *purchasedBefore;
    if(checkbox_Value == YES){
         purchasedBefore = @"true";
    }else{
        purchasedBefore = @"false";

    }
    //NSString *purchasedBefore = [NSString stringWithFormat:@"%d",checkbox_Value];
    SignUpViewController *obj = [[SignUpViewController alloc]init];
    
    
    [obj userRegestration:namestr LastName:lastname RoleID:roldID PhoneNumber:phoneno Emailid:email Password:password PurchasedBefore:purchasedBefore IsFacebookUser:isfacebook MEAID:meaid UserName:username userid:userid];
 
}
#pragma mark - text delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField == txtName)
    {
        [txtLastname becomeFirstResponder];
        return YES;
    }else if(textField == txtLastname)
    {
        [txtPhoneNo becomeFirstResponder];
        return YES;
    }
    [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    
    [textField resignFirstResponder];
    scrollView.scrollEnabled = YES;
    
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    
    if(textField==txtPhoneNo)
    {
        lblerrorPhoneno.hidden = YES;
        
    }
    if(textField==txtName)
    {
        lblerrorName.hidden = YES;
        
    }

    
    svos = scrollView.contentOffset;
    scrollView.scrollEnabled = YES;
    
        
        
        if(  textField==txtPhoneNo) {
            
            CGPoint pt;
            CGRect rc = [textField bounds];
            rc = [textField convertRect:rc toView:scrollView];
            pt = rc.origin;
            pt.x = 0;
            pt.y -=100;
            [scrollView setContentOffset:pt animated:YES];
        }
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField==txtPhoneNo)
    {
//        if(string.length == 0)
//        {
//            return NO;
//        }
        NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if(newString.length==0)
        {   txtPhoneNo.text=@"";
            return YES;
        }
        NSArray *components = [newString componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]];
        NSString *decimalString = [components componentsJoinedByString:@""];
        
        NSUInteger length = decimalString.length;
        BOOL hasLeadingOne = length > 1 && [decimalString characterAtIndex:0] == '1';
        
    if (laststr.length<decimalString.length)
    {
            
        
        if (length == 0 || (length > 10 && !hasLeadingOne) || (length > 11))
        {
            [txtPhoneNo becomeFirstResponder];
            
            return NO;
        }
    }
        laststr = [NSString stringWithFormat:@"%@",decimalString];

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

#pragma  mark - Other Methods
-(void)responseimageWebservice:(NSString*)imageurl
{
    
    
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
-(void)cancelNumberPad{
    [txtPhoneNo resignFirstResponder];
    NSString *phone =[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"l_phoneNo"]];
    // lblPhoneno.text=@"5454564564564564564";
    NSMutableString *random = [[NSMutableString alloc]init];
    for (int i = 0; i<phone.length; i++)
    {
        NSString *character = [NSString stringWithFormat:@"%C",[phone characterAtIndex:i]];
        if(i==0){
            random =[NSMutableString stringWithFormat:@"%@",character];
        }else{
            random = [NSMutableString stringWithFormat:@"%@%@",random,character];
        }
        [self showmaskonnumber:random];
    }
    [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    scrollView.scrollEnabled = YES;
}

-(void)doneWithNumberPad{
    [txtPhoneNo resignFirstResponder];
    [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    scrollView.scrollEnabled = YES;
}

-(void)gestureHandlerMethod:(UITapGestureRecognizer*)sender {
    
    [txtName resignFirstResponder];
    [txtPhoneNo resignFirstResponder];
    
    [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    scrollView.scrollEnabled = YES;
}
-(void)setRoundedAvatar:(UIImageView *)avatarView toDiameter:(float)newSize atView:(UIView *)containedView;
{
    
    
    
    avatarView.layer.cornerRadius = newSize/2;
    avatarView.clipsToBounds = YES;
    
    
    
    CGRect frame = avatarView.frame;
    frame.size.width = newSize;
    frame.size.height = newSize;
    frame.origin.y = frame.origin.y -8;
    avatarView.frame = frame;
    
    
    
    
    //
    //    CGRect frame = avatarView.frame;
    //    frame.size.width = newSize;
    //    frame.size.height = newSize;
    //     frame.origin.x = frame.origin.x+45;
    //    avatarView.frame = frame;
    
}
-(void)targetMethod:(NSTimer *)timer
{
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        
        CGRect frame = imageProfile.frame;
        frame.size.width = 190;
        frame.size.height = 190;
        frame.origin.x = frame.origin.x +20;
        frame.origin.y = frame.origin.y -5;
        if(IS_IPAD_PRO_1366 )
        {
            frame.size.width = 230;
            frame.size.height = 230;
            frame.origin.x = frame.origin.x +15;
        }
        imageProfile.frame = frame;
        
        imageProfile.layer.cornerRadius = imageProfile.frame.size.width /2;
        imageProfile.layer.masksToBounds = YES;
        imageProfile.layer.borderWidth = 2;
        imageProfile.layer.borderColor=[[UIColor lightGrayColor] CGColor];
        imageProfile.hidden = NO;
    }else {
        if ([[ UIScreen mainScreen ] bounds ].size.width == 320 )
        {
            CGRect frame = imageProfile.frame;
            frame.size.width = 100;
            frame.size.height = 100;
            imageProfile.frame = frame;
        }
        imageProfile.layer.cornerRadius = imageProfile.frame.size.width /2;
        imageProfile.layer.masksToBounds = YES;
        imageProfile.layer.borderWidth = 2;
        imageProfile.layer.borderColor=[[UIColor lightGrayColor] CGColor];
        imageProfile.hidden = NO;
    }
    
}
-(void)showmaskonnumber:(NSString*)number
{
    
    NSString *newString = number;
    if(newString.length==0)
    {   txtPhoneNo.text=@"";
        return ;
    }
    NSArray *components = [newString componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]];
    NSString *decimalString = [components componentsJoinedByString:@""];
    
    NSUInteger length = decimalString.length;
    BOOL hasLeadingOne = length > 1 && [decimalString characterAtIndex:0] == '1';
    
    if (length == 0 || (length > 10 && !hasLeadingOne) || (length > 11)) {
        [txtPhoneNo becomeFirstResponder];
        
        return;
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
    
    NSString *frmtStr = formattedString;
    lblPhoneno.text = frmtStr;
    txtPhoneNo.text = frmtStr;
}

@end
