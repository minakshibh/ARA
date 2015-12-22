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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    lblsoldDatePrtitionLine.hidden=YES;
    lblSoldDatetxt.hidden = YES;
    lblSoldDateValue.hidden=YES;
    
    lblPricePrtitionLine.hidden = YES;
    lblPricetxt.hidden = YES;
    lblPriceValue.hidden = YES;
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
        lblsoldOpen.text = @"DIRECT";
    }else //if ([ReferralType isEqualToString:@"Direct"])
    {
//        imagechainunchained.image = [UIImage imageNamed:@"chained_ref.png"];
        lblsoldOpen.text = @"CHAINED";
    }
    
    lblName.text = [NSString stringWithFormat:@"%@ %@",_obj.first_name,_obj.last_name];
    lblEmail.text = _obj.email;
    NSLog(@"%lu",(unsigned long)_obj.phone_no.length);
    if(_obj.phone_no.length == 6)
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
     if(commentStr.length>6){
    lblCommentValue.text = _obj.comments;
     }else{
         lblCommentValue.text = @"";
     }
    
    lblMEAname.text = _obj.MeaName;
//  lblheading.text = [NSString stringWithFormat:@"REFERRAL ID : %@",_obj.UniqueReferralNumber];
    NSString *create_str=[NSString stringWithFormat:@"%@",_obj.createDate];
    NSString *sold_str = [NSString stringWithFormat:@"%@",_obj.SoldDate];
    NSLog(@"%@%lu",create_str,(unsigned long)sold_str.length);
    if(create_str.length>6){
        
        NSString *datee = [NSString stringWithFormat:@"%@",create_str];
        NSArray *dateArr = [datee componentsSeparatedByString:@" "];
        NSString *date = [NSString stringWithFormat:@"%@",[dateArr objectAtIndex:0]];
        NSString *timeAMPM =[NSString stringWithFormat:@"%@ %@",[dateArr objectAtIndex:1],[dateArr objectAtIndex:2]];
        
        NSArray *semidate = [date componentsSeparatedByString:@"-"];
        NSString *finalDate = [NSString stringWithFormat:@"%@-%@-%@",[semidate objectAtIndex:2],[semidate objectAtIndex:1],[semidate objectAtIndex:0]];
        

        
        
        lblCreateDate.text = [NSString stringWithFormat:@"%@ %@",finalDate,timeAMPM];
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
        NSArray *dateArr = [datee componentsSeparatedByString:@" "];
        NSString *date = [NSString stringWithFormat:@"%@",[dateArr objectAtIndex:0]];
        NSString *timeAMPM =[NSString stringWithFormat:@"%@ %@",[dateArr objectAtIndex:1],[dateArr objectAtIndex:2]];
        
        NSArray *semidate = [date componentsSeparatedByString:@"-"];
        NSString *finalDate = [NSString stringWithFormat:@"%@-%@-%@",[semidate objectAtIndex:2],[semidate objectAtIndex:1],[semidate objectAtIndex:0]];
        
        
        
        
        
        lblSoldDate.text = [NSString stringWithFormat:@"%@ %@",finalDate,timeAMPM];
    }
    else{
        lblSoldDate.text = @" ";
    }
   
    
   
    
        if([_obj.ReferralStatus isEqualToString:@"open"])
        {
            lblTagColor.backgroundColor = [UIColor colorWithRed:95.0f/255.0f green:204.0f/255.0f blue:87.0f/255.0f alpha:1.0f];
        
        }else if([_obj.ReferralStatus isEqualToString:@"sold"])
        {
            lblTagColor.backgroundColor = [UIColor colorWithRed:118.0f/255.0f green:178.0f/255.0f blue:230.0f/255.0f alpha:1.0f];
        }else{
            lblTagColor.backgroundColor = [UIColor colorWithRed:224.0f/255.0f green:120.0f/255.0f blue:85.0f/255.0f alpha:1.0f];
        }
    
    // Do any additional setup after loading the view from its nib.
 /*
    int d = 0; // standard display
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2.0) {
        d = 1; // is retina display
    }
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        d += 2;
    }
    
    if (d==0) {
        headerImage.image = [UIImage imageNamed:@"320X480.png"];
    }
    if (d==1) {
        headerImage.image = [UIImage imageNamed:@"320X568.png"];
    }
    if (d==2) {
        headerImage.image = [UIImage imageNamed:@"480X800.png"];
    }
    if (d==3) {
        headerImage.image = [UIImage imageNamed:@"640X1136.png"];
    }
    
    */
    
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
        
        lblname1.font = [lblname1.font fontWithSize:24];
        lblphoneno1.font = [lblphoneno1.font fontWithSize:24];
        lblemail1.font = [lblemail1.font fontWithSize:24];
        lblmea1.font = [lblmea1.font fontWithSize:24];
        lblcreateddate1.font = [lblcreateddate1.font fontWithSize:24];
        lblsolddate1.font = [lblsolddate1.font fontWithSize:24];
        btndirectindirect.font = [btndirectindirect.font fontWithSize:24];
        btnback.titleLabel.font = [btnback.titleLabel.font fontWithSize:24];
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
            
            
        }
        
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
@end
