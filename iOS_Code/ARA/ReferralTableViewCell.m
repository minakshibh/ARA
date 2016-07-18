//
//  ReferralTableViewCell.m
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 12/08/15.
//  Copyright (c) 2015 Krishna_Mac_2. All rights reserved.
//

#import "ReferralTableViewCell.h"

@implementation ReferralTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Referral View
-(void)setLabelText:(NSString*)Name :(NSString*)date : (NSString*)tag :(NSString*)ReferralType
{
    //imageView.hidden = NO;
    
   
    
    if([ReferralType isEqualToString:@"Direct"])
    {
        imageViewimage.image =[UIImage imageNamed:@"direct_ref.png"];
    }else //if ([ReferralType isEqualToString:@"Direct"])
    {
        imageViewimage.image = [UIImage imageNamed:@"direct_ref.png"];
   //     imageViewimage.image = [UIImage imageNamed:@"chained_ref.png"];
    }
  imageViewimage.contentMode = UIViewContentModeScaleAspectFit;

    lblAmontEarnedScoreboard.hidden =YES;
    lblPricetxtScoreboard.hidden = YES;
    lblPriceScoreboard.hidden = YES;
    lblName.text = Name;
    
    lblDate.text = date;

    lblDateReward.hidden = YES;
    if([[tag lowercaseString] isEqualToString:@"open"])
    {
        lbltag.textColor = [UIColor colorWithRed:95.0f/255.0f green:204.0f/255.0f blue:87.0f/255.0f alpha:1.0f];
     //   lbltag.textColor = [UIColor whiteColor];
        lbltag.text = @"OPEN";
        CGRect frame = lbltag.frame;
        frame.origin.x = frame.origin.x-10;
        lbltag.frame = frame;
        lbltag.font = [UIFont fontWithName:@"Roboto-Bold" size:14];

    }else if([[tag lowercaseString] isEqualToString:@"sold"]){
        lbltag.textColor = [UIColor colorWithRed:105.0f/255.0f green:160.0f/255.0f blue:208.0f/255.0f alpha:1.0f];
      //  lbltag.textColor = [UIColor whiteColor];
        lbltag.text = @"SOLD";
        
        CGRect frame = lbltag.frame;
        frame.origin.x = frame.origin.x-10;
        lbltag.frame = frame;
        lbltag.font = [UIFont fontWithName:@"Roboto-Bold" size:14];

    }else{
        lbltag.textColor = [UIColor colorWithRed:224.0f/255.0f green:120.0f/255.0f blue:85.0f/255.0f alpha:1.0f];
       // lbltag.textColor = [UIColor whiteColor];
        lbltag.text = [tag uppercaseString];
        
        CGRect frame = lbltag.frame;
        frame.size.width = frame.size.width +20;
        frame.origin.x = frame.origin.x-24;
        lbltag.frame = frame;
        
        if([lbltag.text isEqualToString:@"CALL INTIATED"])
        {
             lbltag.text = @"CALL INITIATED";
             lbltag.frame = CGRectMake(lbltag.frame.origin.x-25, lbltag.frame.origin.y, lbltag.frame.size.width+20, lbltag.frame.size.height);
        }
        
        lbltag.font = [UIFont fontWithName:@"Roboto-Bold" size:12];
        }
    
    
    lbltag.layer.cornerRadius = 3.0;
    [lbltag setClipsToBounds:YES];
    
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        imageViewimage.frame = CGRectMake(imageViewimage.frame.origin.x+2, imageViewimage.frame.origin.y-3, imageViewimage.frame.size.width-4, imageViewimage.frame.size.height+10);
        
        lblName.font = [lblName.font fontWithSize:24];
        lblDate.font = [lblDate.font fontWithSize:18];
        lbltag.font = [lbltag.font fontWithSize:24];
        
        lblDate.frame = CGRectMake(lblDate.frame.origin.x, lblDate.frame.origin.y, lblDate.frame.size.width, lblDate.frame.size.height);
        if(IS_IPAD_PRO_1366)
        {
            lblName.font = [lblName.font fontWithSize:30];
            lblDate.font = [lblDate.font fontWithSize:24];
            lbltag.font = [lbltag.font fontWithSize:30];
            
            lblDate.frame = CGRectMake(lblDate.frame.origin.x, lblDate.frame.origin.y+3, lblDate.frame.size.width, lblDate.frame.size.height);
        }
    }
}

#pragma  mark - Reward View
-(void)setLabelTextforReward:(NSString*)Name :(NSString*)referralId : (NSString*)price :(NSString*)date
{
    lblAmontEarnedScoreboard.hidden = YES;
    lblPricetxtScoreboard.hidden = YES;
    lblPriceScoreboard.hidden = YES;
    lblName.text = Name;
    lblDate.text = referralId;
    lbltag.hidden = YES;
    lblpriceReferral.text = [NSString stringWithFormat:@"$%@",price];
    lblDateReward.text = [NSString stringWithFormat:@"Sold Date: %@",date];
    
    if ( IS_IPAD )
    {
        lblAmontEarnedScoreboard.font=[lblAmontEarnedScoreboard.font fontWithSize:20];
        lblPricetxtScoreboard.font=[lblPricetxtScoreboard.font fontWithSize:20];
        lblPriceScoreboard.font=[lblPriceScoreboard.font fontWithSize:20];
        lblName.font=[lblName.font fontWithSize:20];
        lblDate.font=[lblDate.font fontWithSize:20];
        lblpriceReferral.font=[lblpriceReferral.font fontWithSize:20];
        lblDateReward.font=[lblDateReward.font fontWithSize:20];
        if(IS_IPAD_PRO_1366)
        {
            lblAmontEarnedScoreboard.font=[lblAmontEarnedScoreboard.font fontWithSize:24];
            lblPricetxtScoreboard.font=[lblPricetxtScoreboard.font fontWithSize:24];
            lblPriceScoreboard.font=[lblPriceScoreboard.font fontWithSize:24];
            lblName.font=[lblName.font fontWithSize:24];
            lblDate.font=[lblDate.font fontWithSize:24];
            lblpriceReferral.font=[lblpriceReferral.font fontWithSize:24];
            lblDateReward.font=[lblDateReward.font fontWithSize:24];
        }
    }
    
}
#pragma  mark - Scoreboard View
-(void)setLabelTextforScoreboard:(NSString*)Name : (NSString*)price :(NSString*)trigger
{
    lblNameScoreboard.text = Name;
    lblDateReward.hidden = YES;
    lblDate.hidden = YES;
    lblName.hidden = YES;
    lbltag.hidden = YES;
    
    
    if([trigger isEqualToString:@"HighestReferral"])
    {
        lblAmontEarnedScoreboard.text = @"Referrals :";
        lblAmontEarnedScoreboard.hidden=YES;
       // lblPriceScoreboard.textAlignment = NSTextAlignmentCenter;
        
        
        
        
        NSString *yourString = [NSString stringWithFormat:@"Referrals : %@",price];
        NSMutableAttributedString *yourAttributedString = [[NSMutableAttributedString alloc] initWithString:yourString];
        NSString *boldString = [NSString stringWithFormat:@"%@",price];
        NSRange boldRange = [yourString rangeOfString:boldString];
        [yourAttributedString addAttribute: NSFontAttributeName value:[UIFont boldSystemFontOfSize:14] range:boldRange];
        
        [yourAttributedString addAttribute:NSFontAttributeName
                      value:[UIFont systemFontOfSize:12]
                      range:NSMakeRange(0, 10)];
        
        [yourAttributedString addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, 10)];
        
        [lblPriceScoreboard setAttributedText: yourAttributedString];
        
        
      // lblPriceScoreboard.text = [NSString stringWithFormat:@"Referrals : %@",price];
        
    }else if([trigger isEqualToString:@"HighestSoldReferral"])
    {
        lblAmontEarnedScoreboard.text = @"Sold Referrals :";
         lblAmontEarnedScoreboard.hidden=YES;

        
        
        NSString *yourString = [NSString stringWithFormat:@"Sold Referrals : %@",price];
        NSMutableAttributedString *yourAttributedString = [[NSMutableAttributedString alloc] initWithString:yourString];
        NSString *boldString = [NSString stringWithFormat:@"%@",price];
        NSRange boldRange = [yourString rangeOfString:boldString];
        [yourAttributedString addAttribute: NSFontAttributeName value:[UIFont boldSystemFontOfSize:14] range:boldRange];
        
        [yourAttributedString addAttribute:NSFontAttributeName
                                     value:[UIFont systemFontOfSize:12]
                                     range:NSMakeRange(0, 15)];
        
        [yourAttributedString addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, 15)];
        
        [lblPriceScoreboard setAttributedText: yourAttributedString];
 
        
//     lblPriceScoreboard.text = [NSString stringWithFormat:@"Sold Referrals : %@",price];

    }else if([trigger isEqualToString:@"HighestEarner"])
    {
        
        NSString *yourString = [NSString stringWithFormat:@"Amount Earned : %@",price];
        NSMutableAttributedString *yourAttributedString = [[NSMutableAttributedString alloc] initWithString:yourString];
        NSString *boldString = [NSString stringWithFormat:@"%@",price];
        NSRange boldRange = [yourString rangeOfString:boldString];
        [yourAttributedString addAttribute: NSFontAttributeName value:[UIFont boldSystemFontOfSize:14] range:boldRange];
        
        [yourAttributedString addAttribute:NSFontAttributeName
                                     value:[UIFont systemFontOfSize:12]
                                     range:NSMakeRange(0, 15)];
        
        [yourAttributedString addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, 15)];
        
        [lblPriceScoreboard setAttributedText: yourAttributedString];
        
      //  lblPriceScoreboard.text = [NSString stringWithFormat:@"Amount Earned : %@",price];
        lblAmontEarnedScoreboard.hidden=YES;
    }
    
    
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        
        
        lblNameScoreboard.font = [lblNameScoreboard.font fontWithSize:19];
        lblPriceScoreboard.font = [lblPriceScoreboard.font fontWithSize:17];
        lblAmontEarnedScoreboard.font = [lblAmontEarnedScoreboard.font fontWithSize:17];
         lblPriceScoreboard.frame = CGRectMake(lblPriceScoreboard.frame.origin.x,lblPriceScoreboard.frame.origin.y, lblPriceScoreboard.frame.size.width,
        lblPriceScoreboard.frame.size.height);
        
        if(IS_IPAD_PRO_1366)
        {
            lblNameScoreboard.font = [lblNameScoreboard.font fontWithSize:30];
            lblPriceScoreboard.font = [lblPriceScoreboard.font fontWithSize:25];
            lblAmontEarnedScoreboard.font = [lblAmontEarnedScoreboard.font fontWithSize:25];
        }
    }
    
    
}
@end
