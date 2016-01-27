//
//  ScheduleServiceViewController.m
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 21/01/16.
//  Copyright © 2016 Krishna_Mac_2. All rights reserved.
//

#import "ScheduleServiceViewController.h"
#import "UIView+Toast.h"

@interface ScheduleServiceViewController ()

@end

@implementation ScheduleServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    statusService = false;
    statusTime = false;
    
    pickerDateStatus = false;
    
    selectTimeSlotArr = [[NSMutableArray alloc]initWithObjects:@"Morning",@"Afternoon",@"No Preference", nil];
    selectTimeSlotIdArr = [[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",nil];
    
    pickerDate.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    pickerDate.datePickerMode = UIDatePickerModeDate;
    [pickerDate addTarget:self action:@selector(dueDateChanged:) forControlEvents:UIControlEventValueChanged];
    [pickerDate setMinimumDate: [NSDate date]];
    if (IS_IPAD) {
        
    }
    
    
    //--scrolview initialization
    scrollView.scrollEnabled = YES;
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(200, 450);
    scrollView.backgroundColor=[UIColor clearColor];
    
    txtComments.delegate = self;
    
    if (IS_IPAD)
    {
        lblCommentsCount.font = [txtFirstname.font fontWithSize:14];
        txtFirstname.font = [txtFirstname.font fontWithSize:20];
        txtLastName.font = [txtLastName.font fontWithSize:20];
        txtPhoneNo.font = [txtPhoneNo.font fontWithSize:20];
        txtemailAddress.font = [txtemailAddress.font fontWithSize:20];
        txtTypeOfService.font = [txtTypeOfService.font fontWithSize:20];
        txtPrefferedDate.font = [txtPrefferedDate.font fontWithSize:20];
        txtSelectTimeSlot.font = [txtSelectTimeSlot.font fontWithSize:20];
        txtComments.font = [txtComments.font fontWithSize:20];
        btnTypeOfService.titleLabel.font = [btnTypeOfService.titleLabel.font fontWithSize:20];
        btnSelectTimeSlot.titleLabel.font = [btnSelectTimeSlot.titleLabel.font fontWithSize:20];
        btnBack.titleLabel.font = [btnBack.titleLabel.font fontWithSize:20];
        btnSubmit.titleLabel.font = [btnSubmit.titleLabel.font fontWithSize:24];
        lblheading.font = [lblheading.font fontWithSize:24];
        lblCommentPlaceholder.font = [lblCommentPlaceholder.font fontWithSize:20];
        
        
//        btnback.titleLabel.font = [btnback.titleLabel.font fontWithSize:24];
//        btnImportContacts.titleLabel.font = [btnImportContacts.titleLabel.font fontWithSize:24];
//        btnSubmitReferral.titleLabel.font = [btnSubmitReferral.titleLabel.font fontWithSize:24];
//        txtFirstname.font = [txtFirstname.font fontWithSize:20];
//        txtLastname.font = [txtLastname.font fontWithSize:20];
//        txtPhoneno.font = [txtPhoneno.font fontWithSize:20];
        viewPickerbackground.frame = CGRectMake(viewPickerbackground.frame.origin.x, viewPickerbackground.frame.origin.y+55, viewPickerbackground.frame.size.width, viewPickerbackground.frame.size.height);
    }
     [self getDataTypeOfService];
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [backgroundTouch addGestureRecognizer:singleFingerTap];
}
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    
    [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    [txtFirstname resignFirstResponder];
    [txtLastName resignFirstResponder];
    [txtemailAddress resignFirstResponder];
    [txtPrefferedDate resignFirstResponder];
    [txtComments resignFirstResponder];
    [txtPhoneNo resignFirstResponder];

    tableViewSelectTimeSlot.hidden = YES;
    tableViewTypeOfService.hidden = YES;
    statusService = false; statusTime = false;
}
-(void)viewWillAppear:(BOOL)animated{
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    lblfirstnameBackground.layer.cornerRadius = 5.0;
    lblfirstnameBackground.layer.borderWidth = 1.0;
    lblfirstnameBackground.layer.borderColor = [UIColor colorWithRed:144.0f/255.0f green:184.0f/255.0f blue:218.0f/255.0f alpha:1.0f].CGColor;
    [lblfirstnameBackground setClipsToBounds:YES];
    
    
    
    lbllastNameBackground.layer.cornerRadius = 5.0;
    lbllastNameBackground.layer.borderWidth = 1.0;
    lbllastNameBackground.layer.borderColor = [UIColor colorWithRed:144.0f/255.0f green:184.0f/255.0f blue:218.0f/255.0f alpha:1.0f].CGColor;
    [lbllastNameBackground setClipsToBounds:YES];
    
    
    lblphoneNoBackground.layer.cornerRadius = 5.0;
    lblphoneNoBackground.layer.borderWidth = 1.0;
    lblphoneNoBackground.layer.borderColor = [UIColor colorWithRed:187.0f/255.0f green:216.0f/255.0f blue:244.0f/255.0f alpha:1.0f].CGColor;
    [lblphoneNoBackground setClipsToBounds:YES];
    
    
    lblemailAddressBackground.layer.cornerRadius = 5.0;
    lblemailAddressBackground.layer.borderWidth = 1.0;
    lblemailAddressBackground.layer.borderColor = [UIColor colorWithRed:144.0f/255.0f green:184.0f/255.0f blue:218.0f/255.0f alpha:1.0f].CGColor;
    [lblemailAddressBackground setClipsToBounds:YES];
    
    lbltypeOfServiceBackground.layer.cornerRadius = 5.0;
    lbltypeOfServiceBackground.layer.borderWidth = 1.0;
    lbltypeOfServiceBackground.layer.borderColor = [UIColor colorWithRed:144.0f/255.0f green:184.0f/255.0f blue:218.0f/255.0f alpha:1.0f].CGColor;
    [lbltypeOfServiceBackground setClipsToBounds:YES];
    
    lblprefferedDateBackground.layer.cornerRadius = 5.0;
    lblprefferedDateBackground.layer.borderWidth = 1.0;
    lblprefferedDateBackground.layer.borderColor = [UIColor colorWithRed:144.0f/255.0f green:184.0f/255.0f blue:218.0f/255.0f alpha:1.0f].CGColor;
    [lblprefferedDateBackground setClipsToBounds:YES];
    
    lblselectTimeSlotBackground.layer.cornerRadius = 5.0;
    lblselectTimeSlotBackground.layer.borderWidth = 1.0;
    lblselectTimeSlotBackground.layer.borderColor = [UIColor colorWithRed:144.0f/255.0f green:184.0f/255.0f blue:218.0f/255.0f alpha:1.0f].CGColor;
    [lblselectTimeSlotBackground setClipsToBounds:YES];
    
    lblcommentsBackground.layer.cornerRadius = 5.0;
    lblcommentsBackground.layer.borderWidth = 1.0;
    lblcommentsBackground.layer.borderColor = [UIColor colorWithRed:144.0f/255.0f green:184.0f/255.0f blue:218.0f/255.0f alpha:1.0f].CGColor;
    [lblcommentsBackground setClipsToBounds:YES];
    
    tableViewSelectTimeSlot.layer.cornerRadius = 5.0;
    tableViewSelectTimeSlot.layer.borderWidth = 1.0;
    tableViewSelectTimeSlot.layer.borderColor = [UIColor colorWithRed:144.0f/255.0f green:184.0f/255.0f blue:218.0f/255.0f alpha:1.0f].CGColor;
    [tableViewSelectTimeSlot setClipsToBounds:YES];
    
    tableViewTypeOfService.layer.cornerRadius = 5.0;
    tableViewTypeOfService.layer.borderWidth = 1.0;
    tableViewTypeOfService.layer.borderColor = [UIColor colorWithRed:144.0f/255.0f green:184.0f/255.0f blue:218.0f/255.0f alpha:1.0f].CGColor;
    [tableViewTypeOfService setClipsToBounds:YES];
    
    btnSubmit.layer.cornerRadius = 7.0;
    btnSubmit.layer.borderWidth = 1.0;
    btnSubmit.layer.borderColor = [UIColor colorWithRed:144.0f/255.0f green:184.0f/255.0f blue:218.0f/255.0f alpha:1.0f].CGColor;
    [btnSubmit setClipsToBounds:YES];
    
    btnDonePicker.layer.cornerRadius = 5.0;
    btnDonePicker.layer.borderWidth = 1.0;
    btnDonePicker.layer.borderColor = [UIColor colorWithRed:144.0f/255.0f green:184.0f/255.0f blue:218.0f/255.0f alpha:1.0f].CGColor;
    [btnDonePicker setClipsToBounds:YES];
    
    btnCancelPicker.layer.cornerRadius = 5.0;
    btnCancelPicker.layer.borderWidth = 1.0;
    btnCancelPicker.layer.borderColor = [UIColor colorWithRed:144.0f/255.0f green:184.0f/255.0f blue:218.0f/255.0f alpha:1.0f].CGColor;
    [btnCancelPicker setClipsToBounds:YES];
    
    [txtFirstname setValue:[UIColor colorWithRed:144.0f/255.0f green:184.0f/255.0f blue:218.0f/255.0f alpha:1.0f] forKeyPath:@"_placeholderLabel.textColor"];
    [txtLastName setValue:[UIColor colorWithRed:144.0f/255.0f green:184.0f/255.0f blue:218.0f/255.0f alpha:1.0f] forKeyPath:@"_placeholderLabel.textColor"];
    [txtPhoneNo setValue:[UIColor colorWithRed:144.0f/255.0f green:184.0f/255.0f blue:218.0f/255.0f alpha:1.0f] forKeyPath:@"_placeholderLabel.textColor"];
    [txtemailAddress setValue:[UIColor colorWithRed:144.0f/255.0f green:184.0f/255.0f blue:218.0f/255.0f alpha:1.0f] forKeyPath:@"_placeholderLabel.textColor"];
    [txtPrefferedDate setValue:[UIColor colorWithRed:144.0f/255.0f green:184.0f/255.0f blue:218.0f/255.0f alpha:1.0f] forKeyPath:@"_placeholderLabel.textColor"];
    
    
    //set Label

    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    txtFirstname.text = [userDefault valueForKey:@"l_firstName"];
    txtLastName.text = [userDefault valueForKey:@"l_lastName"];
    txtPhoneNo.text = [userDefault valueForKey:@"l_phoneNo"];
    txtemailAddress.text = [userDefault valueForKey:@"l_email"];
    
    
    NSString* str = [userDefault valueForKey:@"l_phoneNo"];
//    NSArray *ar = [email componentsSeparatedByString:@"\n"];
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
        txtPhoneNo.text = returnedStr;
    }
    
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbar sizeToFit];
    txtPhoneNo.inputAccessoryView = numberToolbar;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark- Buttons


- (IBAction)btnBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnTypeOfService:(id)sender {
    
    if (statusService==true) {
        tableViewTypeOfService.hidden=YES;
        statusService = false;
        return;
    }else{
    tableViewSelectTimeSlot.hidden=YES;
    statusTime = false;
    tableViewTypeOfService.hidden=NO;
    statusService = true;
    [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        [tableViewTypeOfService reloadData];
        return;
    }
    
}
- (IBAction)btnCancelPicker:(id)sender {
    viewPickerbackground.hidden = YES;
}
-(void) dueDateChanged:(UIDatePicker *)sender {
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init] ;
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    //self.myLabel.text = [dateFormatter stringFromDate:[dueDatePickerView date]];
    
    NSLog(@"Picked the date %@", [dateFormatter stringFromDate:[sender date]]);
    pickerSelectedDate = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:[sender date]]];
    
    NSString *today1 =[dateFormatter stringFromDate:[NSDate date]];
    NSDate *today = (NSDate*)today1;
    
    //NSDate *today = [NSDate date]; // it will give you current date
    NSDate *dateChoosed = (NSDate*)pickerSelectedDate; // your date
    
    NSComparisonResult result;
    //has three possible values: NSOrderedSame,NSOrderedDescending, NSOrderedAscending
    
    result = [today compare:dateChoosed]; // comparing two dates
    
    if(result==NSOrderedAscending){
        NSLog(@"today is less");
        pickerDateStatus = true;
        
    }else if(result==NSOrderedDescending){
        NSLog(@"newDate is less");
        pickerDateStatus = false;
    }else{
        NSLog(@"Both dates are same");
        pickerDateStatus = true;
    }
    
}
- (IBAction)btnDonePicker:(id)sender {
    if (pickerDateStatus) {
        txtPrefferedDate.text = pickerSelectedDate;
        viewPickerbackground.hidden = YES;
        [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        tableViewSelectTimeSlot.hidden = NO;
        statusTime = true;
        return;
    }else{
        if (pickerSelectedDate==nil) {
            NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init] ;
            [dateFormatter setDateStyle:NSDateFormatterLongStyle];
            [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
            pickerSelectedDate = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:[NSDate date]]];
            
            txtPrefferedDate.text = pickerSelectedDate;
            viewPickerbackground.hidden = YES;
            
            [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
            tableViewSelectTimeSlot.hidden = NO;
            statusTime = true;
            return;
        }
        [self.view makeToast:@"Please select a valid date..."];
    }
    
   }
- (IBAction)btnSelectTimeSlot:(id)sender {
    if (statusTime==true) {
        tableViewSelectTimeSlot.hidden=YES;
        statusTime = false;
        return;
    }else{
        tableViewTypeOfService.hidden=YES;
        statusService = false;
        tableViewSelectTimeSlot.hidden=NO;
        statusTime = true;
        [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        [tableViewSelectTimeSlot reloadData];
        return;
    }
}
- (IBAction)btnSubmit:(id)sender {
    
    [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    [txtFirstname resignFirstResponder];
    [txtLastName resignFirstResponder];
    [txtemailAddress resignFirstResponder];
    [txtPrefferedDate resignFirstResponder];
    [txtComments resignFirstResponder];
    [txtPhoneNo resignFirstResponder];
    
    NSString* firstNameStr = [txtFirstname.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString* lastNameStr = [txtLastName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString* phoneStr = [txtPhoneNo.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSCharacterSet *unwantedStr = [NSCharacterSet characterSetWithCharactersInString:@"+() -"];
    phoneStr = [[phoneStr componentsSeparatedByCharactersInSet: unwantedStr] componentsJoinedByString: @""];
    NSString* emailStr = [txtemailAddress.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString* commentsStr = [txtComments.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString* PrefferedDateStr = [txtPrefferedDate.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSString *msgstr;
    if([txtFirstname isEmpty])
    {
        msgstr = @"Please enter a First Name.";
        [HelperAlert  alertWithOneBtn:AlertTitle description:msgstr okBtn:OkButtonTitle];
        return;
    }else if([txtLastName isEmpty])
    {
        msgstr = @"Please enter a Last Name.";
        [HelperAlert  alertWithOneBtn:AlertTitle description:msgstr okBtn:OkButtonTitle];
        return;
    }else if([txtPhoneNo isEmpty]){
        
        if ([txtemailAddress isEmpty]) {
            msgstr = @"Please enter a Phone Number/Email Address.";
             [HelperAlert  alertWithOneBtn:AlertTitle description:msgstr okBtn:OkButtonTitle];
            return;
        }
        
        if (![txtemailAddress emailValidation]==YES) {
            [HelperAlert  alertWithOneBtn:AlertTitle description:@"Entered email is not valid" okBtn:OkButtonTitle];
            [txtemailAddress becomeFirstResponder];
            return;
        }
    }else if([txtemailAddress isEmpty]){
        
        if ([txtPhoneNo isEmpty]) {
            msgstr = @"Please enter a Phone Number/Email Address.";
            [HelperAlert  alertWithOneBtn:AlertTitle description:msgstr okBtn:OkButtonTitle];
            return;
        }
        if (![txtPhoneNo isEmpty]) {
            if (phoneStr.length<10 ) {
                [HelperAlert  alertWithOneBtn:AlertTitle description:@"Please enter a valid phone number." okBtn:OkButtonTitle];
                return;
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
    }
    
//    if (![txtPhoneNo isEmpty]) {
//        
//        
//        if (phoneStr.length<10 ) {
//            [HelperAlert  alertWithOneBtn:AlertTitle description:@"Please enter a valid phone number." okBtn:OkButtonTitle];
//            
//            
//            return;
//        }
//    }
//    if (phoneStr.length>10 ) {
//        if([[NSString stringWithFormat:@"%C",[phoneStr characterAtIndex:0]] isEqual:@"1"])
//        {
//            
//        }else{
//            
//            msgstr = @"Please enter phone no. of atmost 10 digits";
//            [HelperAlert  alertWithOneBtn:AlertTitle description:msgstr okBtn:OkButtonTitle];
//            
//            return;
//        }
//    }
//    if (![txtemailAddress emailValidation]==YES) {
//        [HelperAlert  alertWithOneBtn:AlertTitle description:@"Please check your email address" okBtn:OkButtonTitle];
//        
//        
//        [txtemailAddress becomeFirstResponder];
//        return;
//    }

//    if([txtTypeOfService isEmpty])
//    {
//        msgstr = @"Please select a Service Type.";
//        [HelperAlert  alertWithOneBtn:AlertTitle description:msgstr okBtn:OkButtonTitle];
//        return;
//    }else if([txtPrefferedDate isEmpty])
//    {
//        msgstr = @"Please select a Preferred Date.";
//        [HelperAlert  alertWithOneBtn:AlertTitle description:msgstr okBtn:OkButtonTitle];
//        return;
//    }else if([txtSelectTimeSlot isEmpty])
//    {
//        msgstr = @"Please select a Time Slot.";
//        [HelperAlert  alertWithOneBtn:AlertTitle description:msgstr okBtn:OkButtonTitle];
//        return;
//    }else if(commentsStr.length<=0)
//    {
//        msgstr = @"Please select a Time Slot.";
//        [HelperAlert  alertWithOneBtn:AlertTitle description:msgstr okBtn:OkButtonTitle];
//        return;
//    }
//    -(void)submitFormData:(NSString*)firstName :(NSString*)lastName :(NSString*)phoneNumber :(NSString*)email :(NSString*)scheduleServiceTyperId :(NSString*)preferredDate :(NSString*)timeSlot :(NSString*)comments{
    
    if([txtTypeOfService isEmpty]){
        ServiceTypeSelectedId=nil;
    }
    if([txtPrefferedDate isEmpty])
    {
        PrefferedDateStr = nil;
    }
    if([txtSelectTimeSlot isEmpty]){
        selectTimeSlotSeletedId = @"3";
    }
    if(commentsStr.length<=0)
    {
        commentsStr = @"";
    }
    [self submitFormData:firstNameStr :lastNameStr :phoneStr :emailStr :ServiceTypeSelectedId :PrefferedDateStr :selectTimeSlotSeletedId :commentsStr];
    
}



#pragma mark-TextField Delegae
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    scrollView.scrollEnabled = YES;
    viewPickerbackground.hidden = YES;
    if (textField==txtPrefferedDate) {
        [txtFirstname resignFirstResponder];
        [txtLastName resignFirstResponder];
        [txtPhoneNo resignFirstResponder];
        [txtemailAddress resignFirstResponder];
        [txtComments resignFirstResponder];
        
        
         viewPickerbackground.hidden = NO;
    }
    return YES;
}

- (void) textFieldDidBeginEditing:(UITextField *)textField{
    tableViewSelectTimeSlot.hidden = YES;
    tableViewTypeOfService.hidden = YES;
    statusService  = false;
    statusTime = false;
    
    if (textField==txtPrefferedDate) {
         [txtFirstname resignFirstResponder];
         [txtLastName resignFirstResponder];
         [txtPhoneNo resignFirstResponder];
         [txtemailAddress resignFirstResponder];
         [txtComments resignFirstResponder];
        
        
        
         [txtPrefferedDate resignFirstResponder];
        return;
    }
    
    svos = scrollView.contentOffset;
    
    if (IS_IPHONE_4_OR_LESS || IS_IPHONE_5) {
    
    if(textField == txtemailAddress) {
        
        CGPoint pt;
        CGRect rc = [textField bounds];
        rc = [textField convertRect:rc toView:scrollView];
        pt = rc.origin;
        pt.x = 0;
        pt.y -=160;
        [scrollView setContentOffset:pt animated:YES];
    }
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if(textField == txtFirstname)
    {
        [txtLastName becomeFirstResponder];
        return YES;
    }else if(textField == txtLastName)
    {
        [txtPhoneNo becomeFirstResponder];
        return YES;
    }else if(textField == txtPhoneNo)
    {
        [txtemailAddress becomeFirstResponder];
        return YES;
    }else if(textField == txtemailAddress)
    {
        [txtemailAddress resignFirstResponder];
        [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        tableViewTypeOfService.hidden = NO;
        statusService = true;
        return YES;
    }else if(textField == txtPrefferedDate)
    {
        [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        tableViewSelectTimeSlot.hidden = NO;
        statusTime = true;
        return YES;
    }
    [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    return YES;
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
        
        if (length == 0  || (length > 10 && !hasLeadingOne) || (length ==12)) {
            
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

#pragma  mark- textView Delegates
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
    
    lblCommentsCount.text = [NSString stringWithFormat:@"%ld",(long)remainingCount];
    
    if([[textView text] length] > restrictedLength){
        textView.text=[temp substringToIndex:[temp length]-1];
    }
}
-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{
        [txtComments resignFirstResponder];
    [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    return  YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ( [text isEqualToString:@"\n"] ) {
        [textView resignFirstResponder];
    }
    
    return YES;
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
     viewPickerbackground.hidden = YES;
    
    scrollView.scrollEnabled = YES;
    svos = scrollView.contentOffset;
    if (IS_IPHONE_4_OR_LESS || IS_IPHONE_5 || IS_IPHONE_6 ||IS_IPHONE_6P) {
        if(textView == txtComments) {
            [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
            CGPoint pt;
            CGRect rc = [textView bounds];
            rc = [textView convertRect:rc toView:scrollView];
            pt = rc.origin;
            pt.x = 0;
            pt.y -=200;
            [scrollView setContentOffset:pt animated:YES];
            lblCommentPlaceholder.hidden = YES;
        }
    }
    if (IS_IPAD) {
        if(textView == txtComments) {
            [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
            CGPoint pt;
            CGRect rc = [textView bounds];
            rc = [textView convertRect:rc toView:scrollView];
            pt = rc.origin;
            pt.x = 0;
            pt.y -=320;
            [scrollView setContentOffset:pt animated:YES];
            lblCommentPlaceholder.hidden = YES;
        }
    }
    
}
#pragma mark- Other Methods
-(NSString*)showmaskonnumber:(NSString*)number
{
    
    NSString *newString = number;
    
    NSArray *components = [newString componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]];
    NSString *decimalString = [components componentsJoinedByString:@""];
    
    NSUInteger length = decimalString.length;
    BOOL hasLeadingOne = length > 1 && [decimalString characterAtIndex:0] == '1';
    
//    if (length == 0 || (length > 10 && !hasLeadingOne) || (length > 10)) {
//        [txtPhoneno becomeFirstResponder];
//        
//        return number;
//    }
    
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
    
    // NSString *abc = formattedString;
    return  formattedString;
    
}

-(void)submitFormData:(NSString*)firstName :(NSString*)lastName :(NSString*)phoneNumber :(NSString*)email :(NSString*)scheduleServiceTyperId :(NSString*)preferredDate :(NSString*)timeSlot :(NSString*)comments{
    [kappDelegate ShowIndicator];
    webservice=2;
    NSMutableURLRequest *request ;
    NSString*_postData ;
    NSURLConnection *connection;
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSLog(@"%@",[user valueForKey:@"l_userid"]);
    NSString *userid = [NSString stringWithFormat: @"%@",[user valueForKey:@"l_userid"]];
    
    _postData = [NSString stringWithFormat:@"FirstName=%@&LastName=%@&PhoneNumber=%@&Email=%@&ScheduledServiceTypeId=%@&PreferredDate=%@&TimeSlot=%@&Comments=%@",firstName,lastName,phoneNumber,email,scheduleServiceTyperId,preferredDate,timeSlot,comments];
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/scheduledService",Kwebservices]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
    NSLog(@"data post >>> %@",_postData);
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody: [_postData dataUsingEncoding:NSUTF8StringEncoding]];
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
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
    [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    
}

-(void)doneWithNumberPad{
    [txtemailAddress becomeFirstResponder];
    
}
-(void)getDataTypeOfService
{
   // [kappDelegate ShowIndicator];
    webservice=1;
    NSMutableURLRequest *request ;
    NSString*_postData ;
    NSURLConnection *connection;
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSLog(@"%@",[user valueForKey:@"l_userid"]);
    
   
    
    NSString *userid = [NSString stringWithFormat: @"%@",[user valueForKey:@"l_userid"]];
    
    _postData = [NSString stringWithFormat:@""];
    
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/scheduledService/types",Kwebservices]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
    
    NSLog(@"data post >>> %@",_postData);
    
    [request setHTTPMethod:@"GET"];
    [request setHTTPBody: [_postData dataUsingEncoding:NSUTF8StringEncoding]];
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
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

#pragma mark- nsurl Delegate Methods

-(NSInteger)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
    NSLog(@"response status code: %ld %@", (long)[httpResponse statusCode],httpResponse.debugDescription);
    
    NSLog(@"Received Response");
    [webData setLength: 0];
    
    if((long)[httpResponse statusCode] == ResultOk)
    {
        NSLog(@"Received Response");
        [webData setLength: 0];
        recieved_status = @"passed";
        
    }else if ((long)[httpResponse statusCode] == ResultFailed)
    {
        recieved_status = @"failed";
        return [httpResponse statusCode];
        
    } else if ((long)[httpResponse statusCode] == 404)
    {
        recieved_status = @"no data";
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
    
    SBJsonParser *json = [[SBJsonParser alloc] init];
    NSMutableDictionary *userDetailDict=[json objectWithString:responseString error:&error];
    
    if([recieved_status isEqualToString:@"passed"])
    {
        if (webservice==1) {
            
            serviceTypeNameArray = [[NSMutableArray alloc]init];
            serviceTypeIdArray = [[NSMutableArray alloc]init];
            for (int i=0; i<userDetailDict.count; i++) {
                NSString * serviceType = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"Name"]objectAtIndex:i]];
                NSString *serviceTypeId = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"ID"]objectAtIndex:i]];
                [serviceTypeNameArray addObject:serviceType];
                [serviceTypeIdArray addObject:serviceTypeId];
            }
            [tableViewTypeOfService reloadData];
            
        }else if(webservice==2){
            if ([responseString rangeOfString:@"Service Data Updated Successfully" options:NSCaseInsensitiveSearch].location != NSNotFound){
                
                UIAlertController * alert=   [UIAlertController
                                              alertControllerWithTitle:@"ARA"
                                              message:@"Your Service Request has been sent. You will be contacted to confirm an appointment. Thank you!"
                                              preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* yesButton = [UIAlertAction
                                            actionWithTitle:@"Okay"
                                            style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * action)
                                            {
                                                [self.navigationController popViewControllerAnimated:YES];
                                            }];
                [alert addAction:yesButton];
                [self presentViewController:alert animated:YES completion:nil];
                [kappDelegate HideIndicator];
                return;
            }else{
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"ARA" message:responseString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [alert show];

            }
            
        }
    }else{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"ARA" message:responseString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];

    }
    [kappDelegate HideIndicator];
}
#pragma mark- TableView Delegates
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    [txtFirstname resignFirstResponder];
    [txtLastName resignFirstResponder];
    [txtemailAddress resignFirstResponder];
    [txtPrefferedDate resignFirstResponder];
    [txtComments resignFirstResponder];
    [txtPhoneNo resignFirstResponder];
     viewPickerbackground.hidden = YES;
    
    if (tableViewTypeOfService) {
       
        if (IS_IPAD) {
            return 50;
        }
        return 30;
        
    }else{
        if (IS_IPAD) {
            return 50;
        }
        return 30;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView == tableViewTypeOfService) {
        if (serviceTypeNameArray.count <4) {
            
            if (IS_IPAD) {
                tableViewTypeOfService.frame = CGRectMake(tableViewTypeOfService.frame.origin.x, tableViewTypeOfService.frame.origin.y, tableViewTypeOfService.frame.size.width, 50*serviceTypeNameArray.count);
            }else{
                tableViewTypeOfService.frame = CGRectMake(tableViewTypeOfService.frame.origin.x, tableViewTypeOfService.frame.origin.y, tableViewTypeOfService.frame.size.width, 30*serviceTypeNameArray.count);

                }
        }
        return serviceTypeNameArray.count;
    }else{
        if (selectTimeSlotArr.count <4) {
            
            if (IS_IPAD) {
                 tableViewSelectTimeSlot.frame = CGRectMake(tableViewSelectTimeSlot.frame.origin.x, tableViewSelectTimeSlot.frame.origin.y, tableViewSelectTimeSlot.frame.size.width, 50*selectTimeSlotArr.count);
            }else {
                tableViewSelectTimeSlot.frame = CGRectMake(tableViewSelectTimeSlot.frame.origin.x, tableViewSelectTimeSlot.frame.origin.y, tableViewSelectTimeSlot.frame.size.width, 30*selectTimeSlotArr.count);
            }
        }
        return selectTimeSlotArr.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    for(UIView *view in cell.contentView.subviews){
        if ([view isKindOfClass:[UIView class]]) {
            [view removeFromSuperview];
        }
    }
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    if (tableView == tableViewTypeOfService) {
        cell.textLabel.text = [serviceTypeNameArray objectAtIndex:indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.textLabel.textColor=[UIColor colorWithRed:25.0f/255.0f green:93.0f/255.0f blue:172.0f/255.0f alpha:1.0f];
        if(IS_IPAD){
           cell.textLabel.font = [UIFont systemFontOfSize:18];
        }

    }else{
        cell.textLabel.text = [selectTimeSlotArr objectAtIndex:indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.textLabel.textColor=[UIColor colorWithRed:25.0f/255.0f green:93.0f/255.0f blue:172.0f/255.0f alpha:1.0f];
        if(IS_IPAD){
            cell.textLabel.font = [UIFont systemFontOfSize:18];
        }
    }
    tableView.separatorStyle= UITableViewCellSeparatorStyleSingleLine;
    [tableView setSeparatorColor:[UIColor colorWithRed:144.0f/255.0f green:184.0f/255.0f blue:218.0f/255.0f alpha:1.0f]];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == tableViewTypeOfService) {
        
        NSString *selectedService = [serviceTypeNameArray objectAtIndex:indexPath.row];
        
        NSInteger selectedIndex = [serviceTypeNameArray indexOfObject:selectedService] ;
        ServiceTypeSelectedId = [serviceTypeIdArray objectAtIndex:selectedIndex];
        
        tableViewTypeOfService.hidden = YES;
        txtTypeOfService.text = selectedService;
        [btnTypeOfService setTitle:@"" forState:UIControlStateNormal];
        [txtPrefferedDate becomeFirstResponder];
    }else{
        NSString *timeSlotStr = [selectTimeSlotArr objectAtIndex:indexPath.row];
        
        NSInteger selectedIndex = [selectTimeSlotArr indexOfObject:timeSlotStr] ;
        selectTimeSlotSeletedId = [selectTimeSlotIdArr objectAtIndex:selectedIndex];
        
        tableViewSelectTimeSlot.hidden = YES;
        txtSelectTimeSlot.text = timeSlotStr;
        [btnSelectTimeSlot setTitle:@"" forState:UIControlStateNormal];
        [txtComments becomeFirstResponder];
    }
}
@end
