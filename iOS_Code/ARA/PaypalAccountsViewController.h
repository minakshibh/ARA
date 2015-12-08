//
//  PaypalAccountsViewController.h
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 18/08/15.
//  Copyright (c) 2015 Krishna_Mac_2. All rights reserved.
//

#import "ViewController.h"

@interface PaypalAccountsViewController : ViewController
{
    IBOutlet UIImageView *headerImage;
    IBOutlet UIButton *btnback;

    IBOutlet UITableView *tableView;
    IBOutlet UILabel *btnheading;
    NSMutableData *webData;
    NSString *result_status;
    int webservice,count;
    NSArray *email_array;
    IBOutlet UIButton *btnAdd;
}
- (IBAction)btnAdd:(id)sender;
- (IBAction)btnBack:(id)sender;
- (IBAction)btnEdit:(id)sender;


@end
