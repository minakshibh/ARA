//
//  referralDetailViewController.m
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 12/08/15.
//  Copyright (c) 2015 Krishna_Mac_2. All rights reserved.
//

#import "referralDetailViewController.h"

@interface referralDetailViewController ()

@end

@implementation referralDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    lblsoldDatePrtitionLine.hidden=YES;
    lblSoldDatetxt.hidden = YES;
    lblSoldDateValue.hidden=YES;
    
    lblPricePrtitionLine.hidden = YES;
    lblPricetxt.hidden = YES;
    lblPriceValue.hidden = YES;
    
//    if(self.obj.AFLeadNote.length == 6)
//    {
//        txtNotesDetail.text = @"";
//    }
//    else
//    {
//        txtNotesDetail.text = self.obj.AFLeadNote;
//    }
    
    if (![_obj.IsAutoFlowLeadExists boolValue]){
        btnAddNotes.hidden = true;
        tableView.hidden = true;
        
        txtNotesDetail.hidden = true;
        lblNotes.hidden = true;
        lblNotesBottomLine.hidden = true;
    }
    
    if([_obj.ReferralType isEqualToString:@"Chained"])
    {
        
    }else{
        CGRect frame = commentView.frame;
        frame.origin.y = lblSoldDate.frame.origin.y + lblSoldDate.frame.size.height;
        commentView.frame = frame;
    }
    if([_from_RewardList isEqualToString:@"yes"])
    {
        lblsoldDatePrtitionLine.hidden=NO;
        lblSoldDatetxt.hidden = NO;
        lblSoldDateValue.hidden=NO;
        
        lblPricePrtitionLine.hidden = NO;
        lblPricetxt.hidden = NO;
        lblPriceValue.hidden = NO;
        
        
        
//        if([_obj.ReferralType isEqualToString:@"Chained"])
//        {
//            
//        }else{
//            lblreferraltxt.hidden = YES;
//            float height5 = lblReferrerName.frame.size.height;
//            
//            CGRect frame4 =lblPricetxt.frame;
//            frame4.origin.y = lblPricetxt.frame.origin.y-height5;
//            lblPricetxt.frame = frame4;
//            
//            CGRect frame5 =lblPriceValue.frame;
//            frame5.origin.y = lblPriceValue.frame.origin.y-height5;
//            lblPriceValue.frame = frame5;
//            
//            CGRect frame6 =lblPricePrtitionLine.frame;
//            frame6.origin.y = lblPricePrtitionLine.frame.origin.y-height5;
//            lblPricePrtitionLine.frame = frame6;
//        }
//        CGRect frame = lblPriceValue.frame;
//        float height = frame.size.height;
//        
//        CGRect frame_commentView = commentView.frame;
//        frame_commentView.origin.y = frame_commentView.origin.y + height;
//        commentView.frame = frame_commentView;
//        
//        CGRect frame_CommentValue = lblCommentValue.frame;
//        frame_CommentValue.origin.y = frame_CommentValue.origin.y + height;
//        lblCommentValue.frame = frame_CommentValue;
//        
//        CGRect frame_CommentPrtitionLine = lblCommentPrtitionLine.frame;
//        frame_CommentPrtitionLine.origin.y = frame_CommentPrtitionLine.origin.y + height;
//        lblCommentPrtitionLine.frame = frame_CommentPrtitionLine;
        
        
    }
    
    
    if([_obj.ReferralType isEqualToString:@"Direct"])
    {
//        imagechainunchained.image = [UIImage imageNamed:@"direct_ref.png"];
//        lblsoldOpen.text = @"DIRECT";
    }else //if ([ReferralType isEqualToString:@"Direct"])
    {
//        imagechainunchained.image = [UIImage imageNamed:@"chained_ref.png"];
//        lblsoldOpen.text = @"CHAINED";
    }
    
    lblName.text = [NSString stringWithFormat:@"%@ %@",_obj.first_name,_obj.last_name];
    lblEmail.text = _obj.email;
    NSLog(@"%lu",(unsigned long)_obj.phone_no.length);
    if(_obj.phone_no.length < 10)
    {
        lblPhoneno.text = @"";
    }else{
    //lblPhoneno.text = _obj.phone_no;
        
        NSString *phone =[NSString stringWithFormat:@"%@",_obj.phone_no];
        // lblPhoneno.text=@"5454564564564564564";
        NSMutableString *mutStr = [[NSMutableString alloc]init];
        for (int i = 0; i<phone.length; i++)
        {
            NSString *character = [NSString stringWithFormat:@"%C",[phone characterAtIndex:i]];
            if(i==0){
                mutStr =[NSMutableString stringWithFormat:@"%@",character];
            }else{
                mutStr = [NSMutableString stringWithFormat:@"%@%@",mutStr,character];
            }
            [self showmaskonnumber:mutStr];
        }
    }
    
   // lblreferralId.text = _obj.
    lblreferralId.text = _obj.UniqueReferralNumber;
    NSString *commentStr = [NSString stringWithFormat:@"%@",_obj.comments];
     if(commentStr.length>6 || commentStr.length<=4){
    lblCommentValue.text = _obj.comments;
     }else{
         lblCommentValue.text = @"";
     }
    
    NSString *emailStr = [NSString stringWithFormat:@"%@",_obj.email];
    if(emailStr.length>6){
        lblEmail.text = _obj.email;
    }else{
        lblEmail.text = @"";
    }
    
//    NSString *phoneStr = [NSString stringWithFormat:@"%@",_obj.phone_no];
//    if(phoneStr.length>6){
//        lblPhoneno.text = _obj.phone_no;
//    }else{
//        lblPhoneno.text = @"";
//    }
    
    lblMEAname.text = _obj.MeaName;
//  lblheading.text = [NSString stringWithFormat:@"REFERRAL ID : %@",_obj.UniqueReferralNumber];
    NSString *create_str=[NSString stringWithFormat:@"%@",_obj.createDate];
    NSString *sold_str = [NSString stringWithFormat:@"%@",_obj.SoldDate];
    NSLog(@"%@%lu",create_str,(unsigned long)sold_str.length);
    if(create_str.length>6){
        
        NSString *datee = [NSString stringWithFormat:@"%@",create_str];
//        NSArray *dateArr = [datee componentsSeparatedByString:@" "];
//        NSString *date = [NSString stringWithFormat:@"%@",[dateArr objectAtIndex:0]];
//        NSString *timeAMPM =[NSString stringWithFormat:@"%@ %@",[dateArr objectAtIndex:1],[dateArr objectAtIndex:2]];
//        
//        NSArray *semidate = [date componentsSeparatedByString:@"-"];
//        NSString *finalDate = [NSString stringWithFormat:@"%@-%@-%@",[semidate objectAtIndex:2],[semidate objectAtIndex:1],[semidate objectAtIndex:0]];
        

        lblCreateDate.text = [NSString stringWithFormat:@"%@",datee];
    }else{
            lblCreateDate.text = @"";
        }
    
    
    /**/if([_obj.ReferralType isEqualToString:@"Direct"])
    {
    }else{
    if(_obj.ReferrerName.length==6){
        lblReferrerName.text = @"";
    }else{
    lblReferrerName.text = _obj.ReferrerName;
    }
    }
    if(sold_str.length>6){
        NSString *datee = [NSString stringWithFormat:@"%@",sold_str];
//        NSArray *dateArr = [datee componentsSeparatedByString:@" "];
//        NSString *date = [NSString stringWithFormat:@"%@",[dateArr objectAtIndex:0]];
//        NSString *timeAMPM =[NSString stringWithFormat:@"%@ %@",[dateArr objectAtIndex:1],[dateArr objectAtIndex:2]];
//        
//        NSArray *semidate = [date componentsSeparatedByString:@"-"];
//        NSString *finalDate = [NSString stringWithFormat:@"%@-%@-%@",[semidate objectAtIndex:2],[semidate objectAtIndex:1],[semidate objectAtIndex:0]];
        
     
        
        lblSoldDate.text = [NSString stringWithFormat:@"%@",datee];
    }
    else{
        lblSoldDate.text = @" ";
    }
   
        if([[_obj.ReferralStatus lowercaseString] isEqualToString:@"lost sale"] || [[_obj.ReferralStatus lowercaseString] isEqualToString:@"delete from crm"] || [[_obj.ReferralStatus lowercaseString] isEqualToString:@"reversed"])
        {
            lblTagColor.backgroundColor = [UIColor colorWithRed:224.0f/255.0f green:120.0f/255.0f blue:85.0f/255.0f alpha:1.0f];
            //open
//            lblTagColor.backgroundColor = [UIColor colorWithRed:95.0f/255.0f green:204.0f/255.0f blue:87.0f/255.0f alpha:1.0f];
        
        }else if([[_obj.ReferralStatus lowercaseString] isEqualToString:@"sold"])
        {
            lblTagColor.backgroundColor = [UIColor colorWithRed:118.0f/255.0f green:178.0f/255.0f blue:230.0f/255.0f alpha:1.0f];
        }else{
            lblTagColor.backgroundColor = [UIColor colorWithRed:95.0f/255.0f green:204.0f/255.0f blue:87.0f/255.0f alpha:1.0f];
            
//            lblTagColor.backgroundColor = [UIColor colorWithRed:224.0f/255.0f green:120.0f/255.0f blue:85.0f/255.0f alpha:1.0f];
        }
    
    if (IS_IPAD)
    {
        lblheading.font = [lblheading.font fontWithSize:24];
        
        
        lblName.font = [lblName.font fontWithSize:24];
        lblPhoneno.font = [lblReferrerName.font fontWithSize:24];
        lblEmail.font = [lblEmail.font fontWithSize:24];
        lblMEAname.font = [lblMEAname.font fontWithSize:24];
        lblCreateDate.font = [lblCreateDate.font fontWithSize:24];
        lblSoldDate.font = [lblSoldDate.font fontWithSize:24];
        lblReferrerName.font = [lblReferrerName.font fontWithSize:24];
        lblCommentValue.font = [lblCommentValue.font fontWithSize:24];
        lblCommenttxt.font = [lblCommenttxt.font fontWithSize:24];
          lblreferraltxt.font = [lblreferraltxt.font fontWithSize:24];
        lblNotes.font = [lblNotes.font fontWithSize:24];
        txtNotesDetail.font = [txtNotesDetail.font fontWithSize:24];
        
        lblname1.font = [lblname1.font fontWithSize:24];
        lblphoneno1.font = [lblphoneno1.font fontWithSize:24];
        lblemail1.font = [lblemail1.font fontWithSize:24];
        lblmea1.font = [lblmea1.font fontWithSize:24];
        lblcreateddate1.font = [lblcreateddate1.font fontWithSize:24];
        lblsolddate1.font = [lblsolddate1.font fontWithSize:24];
        btndirectindirect.font = [btndirectindirect.font fontWithSize:24];
        btnback.titleLabel.font = [btnback.titleLabel.font fontWithSize:24];
        btnAddNotes.titleLabel.font = [btnAddNotes.titleLabel.font fontWithSize:24];
        
        if(IS_IPAD_PRO_1366)
        {
            lblheading.font = [lblheading.font fontWithSize:30];
            
            
            lblName.font = [lblName.font fontWithSize:30];
            lblPhoneno.font = [lblReferrerName.font fontWithSize:30];
            lblEmail.font = [lblEmail.font fontWithSize:30];
            lblMEAname.font = [lblMEAname.font fontWithSize:30];
            lblCreateDate.font = [lblCreateDate.font fontWithSize:30];
            lblSoldDate.font = [lblSoldDate.font fontWithSize:30];
            lblReferrerName.font = [lblReferrerName.font fontWithSize:30];
            lblCommentValue.font = [lblCommentValue.font fontWithSize:30];
            lblCommenttxt.font = [lblCommenttxt.font fontWithSize:30];
            lblreferraltxt.font = [lblreferraltxt.font fontWithSize:30];
            
            lblname1.font = [lblname1.font fontWithSize:30];
            lblphoneno1.font = [lblphoneno1.font fontWithSize:30];
            lblemail1.font = [lblemail1.font fontWithSize:30];
            lblmea1.font = [lblmea1.font fontWithSize:30];
            lblcreateddate1.font = [lblcreateddate1.font fontWithSize:30];
            lblsolddate1.font = [lblsolddate1.font fontWithSize:30];
            btndirectindirect.font = [btndirectindirect.font fontWithSize:30];
            btnback.titleLabel.font = [btnback.titleLabel.font fontWithSize:30];
            btnAddNotes.titleLabel.font = [btnAddNotes.titleLabel.font fontWithSize:30];
            
            lblNotes.font = [lblNotes.font fontWithSize:30];
            txtNotesDetail.font = [txtNotesDetail.font fontWithSize:30];

        }
        
    }
    if (IS_IPHONE_5 )
    {
        txtNotesDetail.frame = CGRectMake(txtNotesDetail.frame.origin.x, txtNotesDetail.frame.origin.y + 10, txtNotesDetail.frame.size.width-10, txtNotesDetail.frame.size.height);
        lblNotesBottomLine.frame = CGRectMake(lblNotesBottomLine.frame.origin.x, lblNotesBottomLine.frame.origin.y+10, lblNotesBottomLine.frame.size.width, lblNotesBottomLine.frame.size.height);
        lblCommentValue.frame = CGRectMake(lblCommentValue.frame.origin.x, lblCommentValue.frame.origin.y, lblCommentValue.frame.size.width-10, lblCommentValue.frame.size.height );
    }
    
    if (IS_IPHONE_6 )
    {
        txtNotesDetail.frame = CGRectMake(txtNotesDetail.frame.origin.x, txtNotesDetail.frame.origin.y+10, txtNotesDetail.frame.size.width+40, txtNotesDetail.frame.size.height);
        lblNotesBottomLine.frame = CGRectMake(lblNotesBottomLine.frame.origin.x, lblNotesBottomLine.frame.origin.y+10, lblNotesBottomLine.frame.size.width, lblNotesBottomLine.frame.size.height);
    }
    if (IS_IPHONE_6P)
    {
        txtNotesDetail.frame = CGRectMake(txtNotesDetail.frame.origin.x, txtNotesDetail.frame.origin.y+10, txtNotesDetail.frame.size.width+55, txtNotesDetail.frame.size.height);
        lblNotesBottomLine.frame = CGRectMake(lblNotesBottomLine.frame.origin.x, lblNotesBottomLine.frame.origin.y+10, lblNotesBottomLine.frame.size.width, lblNotesBottomLine.frame.size.height);
    }
    
    if (IS_IPAD)
    {
        lblCommentValue.frame = CGRectMake(lblCommentValue.frame.origin.x, lblCommentValue.frame.origin.y, lblCommentValue.frame.size.width+420, lblCommentValue.frame.size.height + 30);
        txtNotesDetail.frame = CGRectMake(txtNotesDetail.frame.origin.x, txtNotesDetail.frame.origin.y+10, txtNotesDetail.frame.size.width+420, txtNotesDetail.frame.size.height + 30);
        lblNotesBottomLine.frame = CGRectMake(lblNotesBottomLine.frame.origin.x, lblNotesBottomLine.frame.origin.y+15 + 30, lblNotesBottomLine.frame.size.width+420, lblNotesBottomLine.frame.size.height);
        
         btnAddNotes.frame = CGRectMake(btnAddNotes.frame.origin.x + 15, btnAddNotes.frame.origin.y , btnAddNotes.frame.size.width, btnAddNotes.frame.size.height);
    }
    
    [tableView performSelector:@selector(flashScrollIndicators) withObject:nil afterDelay:0];
}

-(void)viewWillAppear:(BOOL)animated
{
    CGFloat tableviewWidth = self.view.frame.size.width - tableView.frame.origin.x * 2;
    
    
    if(IS_IPHONE_5)
    {
        tableView.frame = CGRectMake(tableView.frame.origin.x, tableView.frame.origin.y, tableviewWidth - 60, tableView.frame.size.height + 10 );
    }
    else if(IS_IPHONE_6)
    {
        commentView.frame = CGRectMake(commentView.frame.origin.x, commentView.frame.origin.y, commentView.frame.size.width, commentView.frame.size.height + 40);
        CGFloat tableviewHeight = commentView.frame.size.height - (tableView.frame.origin.y + tableView.frame.size.height);

        tableView.frame = CGRectMake(tableView.frame.origin.x, tableView.frame.origin.y, tableviewWidth, tableView.frame.size.height + tableviewHeight);
    }
    else if(IS_IPHONE_6P)
    {
        commentView.frame = CGRectMake(commentView.frame.origin.x, commentView.frame.origin.y, commentView.frame.size.width, commentView.frame.size.height + 50);
        CGFloat tableviewHeight = commentView.frame.size.height - (tableView.frame.origin.y + tableView.frame.size.height);
        
        tableView.frame = CGRectMake(tableView.frame.origin.x, tableView.frame.origin.y, tableviewWidth + 25, tableView.frame.size.height + tableviewHeight);
    }
    else if(IS_IPAD)
    {
        commentView.frame = CGRectMake(commentView.frame.origin.x, commentView.frame.origin.y, commentView.frame.size.width, commentView.frame.size.height + 150);
        CGFloat tableviewHeight = commentView.frame.size.height - (tableView.frame.origin.y + tableView.frame.size.height);
        
        tableView.frame = CGRectMake(tableView.frame.origin.x, tableView.frame.origin.y, tableviewWidth + 375, tableView.frame.size.height + tableviewHeight);
    }

//    CGSize maximumLabelSize = CGSizeMake(296, FLT_MAX);
//    
//    // for notes label
//    CGSize expectedLabelSize = [self.obj.AFLeadNote sizeWithFont:lblNotesDetail.font constrainedToSize:maximumLabelSize lineBreakMode:txtNotesDetail.brea];
//    
//    //adjust the label the the new height.
//    CGRect newFrame = txtNotesDetail.frame;
//    newFrame.size.height = expectedLabelSize.height;
//    txtNotesDetail.frame = newFrame;
    
//     // for comments label
//    CGSize expectedLabelSizeComments = [self.obj.comments sizeWithFont:lblCommentValue.font constrainedToSize:maximumLabelSize lineBreakMode:lblCommentValue.lineBreakMode];
//    
//    //adjust the label the the new height.
//    CGRect newFrameComments = lblCommentValue.frame;
//    newFrameComments.size.height = expectedLabelSizeComments.height;
//    lblCommentValue.frame = newFrameComments;
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [tableView flashScrollIndicators];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(indicator:) userInfo:nil repeats:YES];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [timer invalidate];
}

-(void)indicator:(BOOL)animated{
    [tableView flashScrollIndicators];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnAddNotes:(id)sender {
    UIAlertView *testAlert = [[UIAlertView alloc] initWithTitle:@"Add Notes"
                                                        message:@""
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Save", nil];
    textViewNew = [UITextView new];
    textViewNew.font = [UIFont fontWithName:@"arial" size:16];
    testAlert.tag = 1;
//    if(self.obj.AFLeadNote.length == 6)
//    {
//        textViewNew.text = @"";
//    }
//    else
//    {
//        textViewNew.text = self.obj.AFLeadNote;
//    }
    [testAlert setValue:textViewNew forKey:@"accessoryView"];
    
    [testAlert show];
}

-(void)showmaskonnumber:(NSString*)number
{
    
    NSString *newString = number;
    
    NSArray *components = [newString componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]];
    NSString *decimalString = [components componentsJoinedByString:@""];
    
    NSUInteger length = decimalString.length;
    BOOL hasLeadingOne = length > 1 && [decimalString characterAtIndex:0] == '1';
    
    if (length == 0 || (length > 10 && !hasLeadingOne) || (length > 11)) {
        //[txtPhoneNo becomeFirstResponder];
        
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
    
   
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if(textView.textColor == [UIColor lightGrayColor]){
        textView.text = @"";
        textView.textColor = [UIColor darkGrayColor];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //Check for confirmation on exporting.
   
    if (alertView.tag == 1) {
        if (buttonIndex == 1)
        {
            NSLog(@"%@",textViewNew.text);
            
            if ([textViewNew.text isEqualToString:@""])
            {
                [HelperAlert  alertWithOneBtn:AlertTitle description:@"Please enter notes." okBtn:OkButtonTitle];
                return;
            }
            
            [self sendNotesToServer:textViewNew.text];
        
            textViewNew = [UITextView new];
            [alertView setValue:textViewNew forKey:@"accessoryView"];
        }
    }
}

-(void)sendNotesToServer:(NSString*)noteStr
{
    {
        [kappDelegate ShowIndicator];
        NSMutableURLRequest *request ;
        NSString*_postData ;
        
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSLog(@"%@",[user valueForKey:@"l_userid"]);
        
        _postData = [NSString stringWithFormat:@"ReferralId=%@&Notes=%@",self.obj.referralID, noteStr];
        
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/referrals/addNotes_autoFlow",Kwebservices]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
        
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
    
    [HelperAlert alertWithOneBtn:AlertTitle description:responseString okBtn:OkButtonTitle];
    
    if([response_status isEqualToString:@"passed"])
    {
        SBJsonParser *json = [[SBJsonParser alloc] init];
        NSMutableDictionary *userDetailDict=[json objectWithString:responseString error:&error];
        
        NSLog(@"%@",userDetailDict);
        
        
        [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"notesAdded"];
        
        [self.navigationController popViewControllerAnimated:YES];
 
    }
}

#pragma mark - tableview delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.obj.AFLeadNote != NULL)
    {
        return self.obj.AFLeadNote.count;
    }
    else
    {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)atableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    UILabel * Description = [[UILabel alloc]  initWithFrame: CGRectMake(15, 0, 250+450*IS_IPAD+50*IS_IPHONE_6+85*IS_IPHONE_6P+250*IS_IPAD_PRO_1366, 18)];
    
    NSDictionary *dataDict = self.obj.AFLeadNote[indexPath.row];
    Description.text = [dataDict valueForKey: @"note"];

    [Description autosizeForWidth];
    
    if(IS_IPHONE_6P)
    {
        return Description.frame.size.height + 30;
    }
    else if(IS_IPAD)
    {
        return Description.frame.size.height + 75;
    }
    else
    {
        return Description.frame.size.height + 25;
    }
}

- (UITableViewCell *)tableView:(UITableView *)atableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    NSDictionary *dataDict = self.obj.AFLeadNote[indexPath.row];
    
    cell.textLabel.text = [dataDict valueForKey: @"note"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Date: %@",[dataDict valueForKey: @"createdDate"]];
    
    cell.textLabel.numberOfLines = 0;
    
    if(IS_IPHONE_6P)
    {
        cell.textLabel.font = [lblName.font fontWithSize:14];
        cell.detailTextLabel.font  = [lblName.font fontWithSize:12];
    }
    else if(IS_IPAD)
    {
        cell.textLabel.font  = [lblName.font fontWithSize:24.0];
        cell.detailTextLabel.font  = [lblName.font fontWithSize:18.0];
    }
    else
    {
        cell.textLabel.font  = [lblName.font fontWithSize:14.0];
        cell.detailTextLabel.font  = [lblName.font fontWithSize:10.0];
    }

    cell.textLabel.textColor = [UIColor grayColor];
    cell.detailTextLabel.textColor = [UIColor grayColor];
    
    cell.backgroundColor = [UIColor clearColor];
    
    cell.separatorInset = UIEdgeInsetsMake(0.f, 10.f, 0.f, 10.f);
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

@end
