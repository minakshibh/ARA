//
//  PaypalAccountsTableViewCell.h
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 18/08/15.
//  Copyright (c) 2015 Krishna_Mac_2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaypalAccountsTableViewCell : UITableViewCell
{
    IBOutlet UIImageView *imageViewPaypalIcon;
    
    IBOutlet UILabel *lblEmail;
    IBOutlet UIImageView *iamgeViewTick;
}
-(void)setLabelText:(NSString*)image1 :(NSString*)email : (NSString*)image2;

@end
