//
//  referralListViewController.h
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 12/08/15.
//  Copyright (c) 2015 Krishna_Mac_2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReferralObj.h"
@interface referralListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UIImageView *headerImage;

    IBOutlet UITableView *tableView;
    ReferralObj *obj;
    NSMutableArray* referralListArray,*referralListForSold,*referralListForOpen,*referralListSortName,*sorted_array;
    NSArray *referralListSortDate;
    NSString *filter_status,*sold_open,*filter_height,*detail_view,*response_status,*pop_out,*restore_radiobtn,*optional;
    IBOutlet UIView *soryByView;
    IBOutlet UIView *filterView;
    BOOL sort_value,filter_value;
    UIView *sort_back_view;
    IBOutlet UILabel *lblheader;
    IBOutlet UILabel *lblSelectFilter;
    BOOL radio_soldOnly;
    UIImage *btnImage1,*btnImage2,*btnImage3,*btnImage4;
    IBOutlet UIButton *btnSoldOnly;
    IBOutlet UIButton *btnOpenOnly;
    IBOutlet UIButton *btnSortByname;
    IBOutlet UIButton *btnSortBydate;
    IBOutlet UILabel *lblheadingView;
    NSMutableArray *sold_arr,*open_arr,*name_arr,*date_arr,*sample_arr;
    IBOutlet UIView *sortFilterView;
    int create_tag_btn;
    IBOutlet UILabel *lbltagbackground;
     IBOutlet UILabel *lblSelectSort;
    IBOutlet UIButton *btnSort;
    IBOutlet UIButton *btnFilter;
    IBOutlet UILabel *lblpartition;
    NSMutableData *webData;
    IBOutlet UIButton *btnFilternone;
    IBOutlet UIButton *btnSortnone;
    int count;
    IBOutlet UIButton *btnBack;
    IBOutlet UILabel *lblDIrectreferral;
    IBOutlet UILabel *lblIndirectreferral;
    IBOutlet UIView *bottomView;
    IBOutlet UIImageView *imageindirectreferral;
    IBOutlet UIImageView *imagedirectregerral;
}
- (IBAction)btnFilternone:(id)sender;
- (IBAction)btnSortnone:(id)sender;
- (IBAction)btncancelSort:(id)sender;
- (IBAction)btncancelFilter:(id)sender;
- (IBAction)btnRefresh:(id)sender;
- (IBAction)btnBack:(id)sender;
- (IBAction)btnSortByname:(id)sender;
- (IBAction)btnSort:(id)sender;
- (IBAction)btnFilter:(id)sender;
- (IBAction)btnSortBydate:(id)sender;
- (IBAction)btnSoldOnly:(id)sender;
- (IBAction)btnOpenOnly:(id)sender;
-(void)delTag:(id)sender;
-(void)getList:(NSString*)status;
@property (strong, nonatomic) NSString *trigger,*webservice_trigger,*headerstr;

@end
