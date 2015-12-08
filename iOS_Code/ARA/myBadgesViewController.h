//
//  myBadgesViewController.h
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 14/08/15.
//  Copyright (c) 2015 Krishna_Mac_2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myBadgesViewController : UIViewController
{
    IBOutlet UIImageView *headerImage;
    IBOutlet UIButton *btnBack;

    IBOutlet UITableView *tableView;
    NSArray *arrImagesUrl;
    NSMutableData *webData;
    NSString* response_status;
    int webservices;
    IBOutlet UIButton *btnallBadges;
    IBOutlet UIButton *btnback;
    NSMutableArray *badgesArray;
    NSString *status,*mybadges;
    IBOutlet UILabel *lblheading;
    NSMutableArray *earnedBadgesNames;
    int count;
}
- (IBAction)btnallBadges:(id)sender;
- (IBAction)btnback:(id)sender;

@end
