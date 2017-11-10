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
#import "UIImageView+Webcache.h"
#import "DBManager.h"
#import "dashboardViewController.h"


//#import "UIImageView+WebCache.h"


@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    
    imageProfile.hidden = YES;
    [super viewDidLoad];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    email = [NSString stringWithFormat:@"%@",[user valueForKey:@"l_email"]];
    password = [NSString stringWithFormat:@"%@",[user valueForKey:@"l_password"]];
    
    lblUserID.textColor = [UIColor colorWithRed:0.0f/255.0f green:122.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
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
    
    
    [self getloginDetails];
}

-(void)viewWillAppear:(BOOL)animated
{
    UIImage *img = [[SDImageCache sharedImageCache]imageFromMemoryCacheForKey:@"l_image"];
    if (img != nil){
        imageProfile.image = img;
    }else{
        
        NSString *imagestr = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"l_image"]];
        //    [imageProfile sd_setImageWithURL:[NSURL URLWithString:imagestr]placeholderImage:[UIImage imageNamed:@"user-i.png"]options:SDWebImageRefreshCached];
        [imageProfile sd_setImageWithURL:[NSURL URLWithString:imagestr]placeholderImage:[UIImage imageNamed:@"user-i.png"]options:SDWebImageRefreshCached];
    }
    
    
    
    lblRole.hidden = NO;
    
    [self.view bringSubviewToFront:lblRole];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    //--assigning image and label values
    lblEmail.text = [NSString stringWithFormat:@"%@",[user valueForKey:@"l_email"]];
    
    
    lblUserID.text = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"l_userName"]];
    
    NSString *first = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"l_firstName"]];
    lblName.text = first;
    NSString *last = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"l_lastName"]];
    lblLastname.text = last;
    
    
    lblPhoneno.text = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"l_phoneNo"]];
    NSString *phone =[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"l_phoneNo"]];
    
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
    
    if([[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"l_meaName"]] isEqualToString:@"<null>"]){
        lblMEAname.text = @"";
    }else{
        lblMEAname.text = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"l_meaName"]];
    }
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
    
    
    
    txtLastname.hidden = NO;
    txtPhoneNo.text = lblPhoneno.text;
    txtName.text = lblName.text;
    txtLastname.text = lblLastname.text;
    
    
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
    
    NSString *msg;
    
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
    }else if(phoneno.length == 10)
    {
        if([[NSString stringWithFormat:@"%C",[phoneno characterAtIndex:0]] isEqual:@"1"])
        {
           msg = @"Kindly enter a valid phone number.";
            lblerrorPhoneno.hidden = NO;
            
            lblerrorPhoneno.text = msg;
            [txtPhoneNo becomeFirstResponder];
            return;
        }
        
    }else if(phoneno.length < 10)
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
    lblerrorPhoneno.hidden =YES;
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
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    scrollView.scrollEnabled = YES;
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(350, 800);
    
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    scrollView.scrollEnabled = NO;
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
-(void)getloginDetails
{
    // [kappDelegate ShowIndicator];
    NSMutableURLRequest *request ;
    NSString*_postData ;
    
    _postData = [NSString stringWithFormat:@""];
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/accounts/login",Kwebservices]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
    
    NSLog(@"data Get >>> %@",_postData);
    
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
    //  [kappDelegate HideIndicator];
    
    
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
    NSLog(@"The append data is %@",data1);
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //  [kappDelegate HideIndicator];
    
    NSLog(@"DONE. Received Bytes: %lu", (unsigned long)[webData length]);
    
    if ([webData length]==0)
        return;
    
    NSString *responseString = [[NSString alloc] initWithData:webData encoding:NSUTF8StringEncoding];
    
    
    NSLog(@"responseString:%@",responseString);
    NSError *error;
    if([status isEqualToString:@"failed"])
    {
        //        [HelperAlert alertWithOneBtn:AlertTitle description:responseString okBtn:OkButtonTitle];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:AlertTitle message:responseString delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
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
        NSString *AppDistributor = [NSString stringWithFormat:@"%@",[userDetailDict valueForKey:@"IsAppDistributor"]];
        
        // NSString *parameter=@"1";
        NSUserDefaults *storeData=[NSUserDefaults standardUserDefaults];
        [storeData setObject:AppDistributor forKey:@"Value"];
        [storeData synchronize];
        
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
            
            NSLog(@"THe Data in Dictionary is %@",dict);
            
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
            
            
            
            if ([txtEmail.text isEqualToString:user_name]) {
                
                [[NSUserDefaults standardUserDefaults] setObject:user_name forKey:@"remember_me_status_email"];
                
            }
            else
            {
                [[NSUserDefaults standardUserDefaults] setObject:email forKey:@"remember_me_status_email"];
                
            }
            
            
            [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"remember_me_status_pass"];
        }else{
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"remember_me_status"];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"remember_me_status_email"];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"remember_me_status_pass"];
        }
        
        DBManager *db = [[DBManager alloc]init];
        [db createDB];
        
        
        //  [kappDelegate HideIndicator];
        //  dashboardViewController *obj = [[dashboardViewController alloc]initWithNibName:@"dashboardViewController" bundle:nil];
        //  obj.from_login = @"yes";
        
        //   [self.navigationController pushViewController:obj animated:YES];
        
        
        
    }else{
        //        [HelperAlert alertWithOneBtn:AlertTitle description:responseString okBtn:OkButtonTitle];
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:AlertTitle message:responseString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    //   [kappDelegate HideIndicator];
    
}
@end
