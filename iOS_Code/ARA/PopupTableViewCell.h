//
//  PopupTableViewCell.h
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 14/12/15.
//  Copyright © 2015 Krishna_Mac_2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopupTableViewCell : UITableViewCell
{
    
    IBOutlet UIImageView *imageViewSelection;
    IBOutlet UILabel *lblContactType;
    IBOutlet UILabel *lblContactDetail;
    
}
-(void)setLabelText:(NSString*)image :(NSString*)contactType : (NSString*)contactDetails :(BOOL*)isPhoneno;

@end
