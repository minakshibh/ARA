//
//  rewardListViewController.h
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 14/08/15.
//  Copyright (c) 2015 Krishna_Mac_2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReferralObj.h"
@interface rewardListViewController : UIViewController
{
    IBOutlet UIImageView *headerImage;
    IBOutlet UIButton *btnback;

    IBOutlet UILabel *lblheading;
    IBOutlet UITableView *tableView;
    IBOutlet UIButton *btnSold;
    IBOutlet UIButton *btnUpcoming;
    ReferralObj *obj;
    NSMutableData *webData;
    NSString *response_status;
    NSMutableArray *rewardListArray;
}
- (IBAction)btnBack:(id)sender;
- (IBAction)btnSold:(id)sender;
- (IBAction)btnUpcoming:(id)sender;

@end
