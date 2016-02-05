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
#import "DBManager.h"

@interface notificationViewController : UIViewController
{
    
    IBOutlet UIButton *lblBack;
    IBOutlet UILabel *lblHeading;
    IBOutlet UIButton *btnBack;
    IBOutlet UITableView *tableView;
    IBOutlet UIButton *btnAutoAvesURL;
    IBOutlet UIButton *btnAboutApp;
    IBOutlet UIButton *btnLogOut;
    NSMutableData *webData;
    int webservice;
    NSString *recieved_status,*notificationTimeStamp,*executeFirtTime;
    int dataCount;
    NSMutableArray *notificationDataArr,*saveData,*noOfLinesArr;
    NSIndexPath *clickedIndex;
    int countInitialVal,countFinalVal;
    DBManager *database;
    UIRefreshControl *refreshControl;
    bool status1;
    IBOutlet UIView *bottomView;
    UIView *newView;
    
}
- (IBAction)btnLoadMore:(id)sender;
- (IBAction)btnAutoAvesURL:(id)sender;
- (IBAction)btnLogOut:(id)sender;
- (IBAction)btnBack:(id)sender;

@property (nonatomic) NSIndexPath *expandedIndexPath;
@property (nonatomic) CGFloat changeX;
@end
