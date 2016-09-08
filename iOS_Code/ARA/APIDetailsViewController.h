//
//  APIDetailsViewController.h
//  AUTOAVES_REFERRAL
//
//  Created by Mac on 19/08/16.
//  Copyright © 2016 Krishna_Mac_2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface APIDetailsViewController : UIViewController
<UITableViewDelegate,UITableViewDataSource>
{
    int Pagetag;
    int myInvitation,networkInstalls,appInstalls,networkReferral;
    NSMutableDictionary *UserData;
    NSMutableData *webData;
    NSMutableArray *GetData;
    NSString *recieved_status;
    int count;
    int pageCountIPAD;
    IBOutlet UIButton *backBtn;
    NSMutableArray *allData;
    IBOutlet UILabel * lblFirstName;
    IBOutlet UILabel *lblLastName;
    IBOutlet UILabel *lblEmail;
    IBOutlet UILabel *lblInvitationStatus;
    IBOutlet UILabel *lblInvitationId;
    IBOutlet UILabel *lblVIewHeading;
    IBOutlet UILabel *lblCount;
    UIView *footerView;
    UIButton *addcharity;
    BOOL value;
    int newValue;
}
@property(strong,nonatomic)IBOutlet UITableView *table;
@end
