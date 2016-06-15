//
//  PaypalAccountsTableViewCell.m
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 18/08/15.
//  Copyright (c) 2015 Krishna_Mac_2. All rights reserved.
//

#import "PaypalAccountsTableViewCell.h"
int i=0;
@implementation PaypalAccountsTableViewCell

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)setLabelText:(NSString*)image1 :(NSString*)email : (NSString*)image2 : (NSString*)name
{
    if ([name  isEqual: @" "] ) {
         lblName.text  = email;
    }else{
        lblName.text  = name;
        lblEmail.text = email;
    }
    
    
    if([image1 isEqualToString:@"Paypal"])
    {
    imageViewPaypalIcon.image = [UIImage imageNamed:@"paypal-icon.png"];
    }
    
    
    if([image2 isEqualToString:@"1"])
    {
    iamgeViewTick.image = [UIImage imageNamed:@"tick.png"];
        i++;
    }
    imageViewPaypalIcon.contentMode=UIViewContentModeScaleAspectFit;
    
    iamgeViewTick.contentMode=UIViewContentModeScaleAspectFit;

    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        lblEmail.font=[lblEmail.font fontWithSize:24];
        iamgeViewTick.frame = CGRectMake(iamgeViewTick.frame.origin.x+10, iamgeViewTick.frame.origin.y, iamgeViewTick.frame.size.width, iamgeViewTick.frame.size.height);
        if(IS_IPAD_PRO_1366)
        {
             lblEmail.font=[lblEmail.font fontWithSize:30];
        }
    }
}
@end
