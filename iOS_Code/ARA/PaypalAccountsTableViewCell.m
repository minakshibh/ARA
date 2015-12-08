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

-(void)setLabelText:(NSString*)image1 :(NSString*)email : (NSString*)image2
{
    if([image1 isEqualToString:@"Paypal"])
    {
    imageViewPaypalIcon.image = [UIImage imageNamed:@"paypal-icon.png"];
    }
    lblEmail.text = email;
    
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

    }
}
@end
