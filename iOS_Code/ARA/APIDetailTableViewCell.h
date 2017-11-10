//
//  APIDetailTableViewCell.h
//  AUTOAVES_REFERRAL
//
//  Created by Mac on 22/08/16.
//  Copyright © 2016 Krishna_Mac_2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface APIDetailTableViewCell : UITableViewCell
{


}
//@property(strong,nonatomic)IBOutlet UILabel*lblinvitationStatus;
@property(strong,nonatomic)IBOutlet UILabel*lblEmailId;
@property(strong,nonatomic)IBOutlet UILabel*lblFullName;
@property (strong, nonatomic) IBOutlet UITextView *lblinvitationStatus;
-(void)setvalue:(NSString *)name Email:(NSString *)emailID InvitationStatus:(NSString *)Status;
@end
