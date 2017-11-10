//
//  ReferralTableViewCell.h
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 12/08/15.
//  Copyright (c) 2015 Krishna_Mac_2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReferralTableViewCell : UITableViewCell
{
    IBOutlet UILabel *lblName;
    IBOutlet UILabel *lblDate;
    IBOutlet UILabel *lbltag;
    IBOutlet UILabel *lblDateReward;
    IBOutlet UILabel *lblpriceReferral;
    
    IBOutlet UILabel *lblPriceScoreboard;
    IBOutlet UILabel *lblPricetxtScoreboard;
    IBOutlet UILabel *lblNameScoreboard;
    IBOutlet UIImageView *imageView;
    IBOutlet UIImageView *imageViewimage;
    IBOutlet UILabel *lblAmontEarnedScoreboard;
    IBOutlet UITextView *txtTag;
}
-(void)setLabelText:(NSString*)Name :(NSString*)date : (NSString*)tag :(NSString*)ReferralType;
-(void)setLabelTextforReward:(NSString*)Name :(NSString*)referralId : (NSString*)price :(NSString*)date;
-(void)setLabelTextforScoreboard:(NSString*)Name : (NSString*)price :(NSString*)trigger;

@end
