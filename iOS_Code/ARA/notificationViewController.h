//
//  notificationViewController.h
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 14/01/16.
//  Copyright © 2016 Krishna_Mac_2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "CommonHelperClass.h"

@interface notificationViewController : UIViewController
{
    
    IBOutlet UIButton *btnBack;
    IBOutlet UITableView *tableView;
    IBOutlet UIButton *btnAutoAvesURL;
    IBOutlet UIButton *btnAboutApp;
    IBOutlet UIButton *btnLogOut;
    NSMutableData *webData;
    int webservice;
    NSString *recieved_status;
    NSArray *modified;
}
- (IBAction)btnAboutApp:(id)sender;
- (IBAction)btnAutoAvesURL:(id)sender;
- (IBAction)btnLogOut:(id)sender;
- (IBAction)btnBack:(id)sender;
@property (nonatomic) NSIndexPath *expandedIndexPath;
@end
