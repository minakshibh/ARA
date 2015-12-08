//
//  ScoreboardListViewController.h
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 17/08/15.
//  Copyright (c) 2015 Krishna_Mac_2. All rights reserved.
//

#import "ViewController.h"

@interface ScoreboardListViewController : ViewController
{
    IBOutlet UIButton *btnback;
    IBOutlet UIImageView *headerImage;

    IBOutlet UITableView *tableView;
    IBOutlet UIButton *btnYear;
    IBOutlet UIButton *btnAllTime;
    IBOutlet UIButton *btnQuater;
    IBOutlet UILabel *lblHeader;
    NSMutableData *webData;
    NSString *response_status;
    NSMutableArray *Earning,*ReferralCount,*UserName;
}
- (IBAction)btnBack:(id)sender;
- (IBAction)btnQuater:(id)sender;
- (IBAction)btnYear:(id)sender ;
- (IBAction)btnAllTime:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *lblHeader;
@property (strong,nonatomic) NSString *trigger,*timestamp;
@end
