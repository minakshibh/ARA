    //
//  notificationViewController.m
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 14/01/16.
//  Copyright © 2016 Krishna_Mac_2. All rights reserved.
//

#import "notificationViewController.h"
#import "AboutAppViewController.h"
#import "LoginViewController.h"
#import "UIView+Toast.h"
#import "dashboardViewController.h"

@interface notificationViewController ()

@end

@implementation notificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    countFinalVal =0;
    
    noOfLinesArr = [[NSMutableArray alloc]init];

    
    
    
    
  //
    
    refreshControl = [[UIRefreshControl alloc]init];
    [tableView addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(refreshTableView) forControlEvents:UIControlEventValueChanged];
    status1 =false;
 
    tableView.allowsMultipleSelectionDuringEditing = NO;
    // Do any additional setup after loading the view from its nib.
    
    newView = [[UIView alloc]initWithFrame:CGRectMake(-45, 70, self.view.frame.size.width, 30)];
    if (IS_IPHONE_5 || IS_IPHONE_4_OR_LESS) {
        newView = [[UIView alloc]initWithFrame:CGRectMake(-45, 70, self.view.frame.size.width, 30)];
    }
    if (IS_IPHONE_6) {
        newView = [[UIView alloc]initWithFrame:CGRectMake(-10, 70, self.view.frame.size.width, 30)];
    }
    if (IS_IPHONE_6P) {
        newView = [[UIView alloc]initWithFrame:CGRectMake(-10, 70, self.view.frame.size.width+25, 30)];
    }
    if (IS_IPAD) {
         newView = [[UIView alloc]initWithFrame:CGRectMake(-10, 70, self.view.frame.size.width+400, 30)];
    }
    UIButton* submit = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [submit setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //[submit setTitleColor:[UIColor colorWithWhite:0.0 alpha:0.56] forState:UIControlStateDisabled];
    [submit.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [submit setFrame:CGRectMake(0.0, 0.0, newView.frame.size.width, newView.frame.size.height)];
    [submit addTarget:self action:@selector(LoadMore:) forControlEvents:UIControlEventTouchUpInside];
    [submit setTitle:@"Load more" forState:UIControlStateNormal];
    submit.backgroundColor = [UIColor lightGrayColor];
    [newView addSubview:submit];
    
    [tableView setTableFooterView:newView];
    
    
    notificationDataArr = [[NSMutableArray alloc]init];
    database = [[DBManager alloc]init];
    notificationDataArr = [database showData];
    int count = [database GetDataCount];
    if (count>notificationDataArr.count) {
        newView.hidden = NO;
    }else{
        newView.hidden = YES;
    }
    
    [self getNotifications];
}

-(void)viewWillAppear:(BOOL)animated{
    

  //  countInitialVal = (int)[notificationDataArr count];
    
    if (IS_IPAD) {
        lblHeading.font = [lblHeading.font fontWithSize:24];
        btnBack.titleLabel.font = [btnBack.titleLabel.font fontWithSize:24];
    
    if (IS_IPAD_PRO_1366) {
        btnBack.titleLabel.font = [btnBack.titleLabel.font fontWithSize:24];
         btnAboutApp.titleLabel.font = [btnAboutApp.titleLabel.font fontWithSize:20];
        btnLogOut.titleLabel.font = [btnLogOut  .titleLabel.font fontWithSize:20];
         btnAutoAvesURL.titleLabel.font = [btnLogOut  .titleLabel.font fontWithSize:20];
    }
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"lastnotificationId"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableview Delegates
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath isEqual:self.expandedIndexPath])
    {
        UILabel * Description = [[UILabel alloc]  initWithFrame: CGRectMake(15, 0, 250+450*IS_IPAD+50*IS_IPHONE_6+85*IS_IPHONE_6P+250*IS_IPAD_PRO_1366, 18)];
        database = [[DBManager alloc]init];
        database = [notificationDataArr objectAtIndex:indexPath.row];
        Description.text = database.NotificationText;
//        Description.text= [notificationDataArr objectAtIndex:indexPath.row];
        [Description autosizeForWidth];
        
        return Description.frame.size.height+70;
    }
    
    UILabel * Description = [[UILabel alloc]  initWithFrame: CGRectMake(15, 0, 250+450*IS_IPAD+50*IS_IPHONE_6+85*IS_IPHONE_6P+250*IS_IPAD_PRO_1366, 18)] ;
    
    database = [[DBManager alloc]init];
    database = [notificationDataArr objectAtIndex:indexPath.row];
    Description.text = database.NotificationText;
    int lines = [Description getNoOflines];
    if (lines == 1 || lines == 2 || lines == 3) {
        [Description autosizeForWidth];
        return Description.frame.size.height+70;
    }else{
         return 133-15*IS_IPHONE_4_OR_LESS-15*IS_IPHONE_5-15*IS_IPHONE_6-15*IS_IPHONE_6P-8*IS_IPAD+30*IS_IPAD_PRO_1366;
    }
 //   return 133-15*IS_IPHONE_4_OR_LESS-15*IS_IPHONE_5-15*IS_IPHONE_6-15*IS_IPHONE_6P-8*IS_IPAD+30*IS_IPAD_PRO_1366;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return notificationDataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)atableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
        for(UIView *view in cell.contentView.subviews){
            if ([view isKindOfClass:[UIView class]]) {
                [view removeFromSuperview];
            }
        }
    
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        }
    
    if ([indexPath isEqual:self.expandedIndexPath])
    {
        database = [[DBManager alloc]init];
        database = [notificationDataArr objectAtIndex:indexPath.row];
        NSString *fontNameStr,*imageNotification;
        if ([database.isRead isEqualToString:@"true"])
        {
            fontNameStr = @"Roboto-Regular";
            imageNotification = @"1bell_read.png";
        }else{
           fontNameStr = @"Roboto-Bold";
            imageNotification = @"1bell_unread.png";
        }
       
        
        UIImageView * notificationImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 15, 18)];
        if (IS_IPHONE_6P) {
            notificationImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 12, 15, 16)];
        }
        notificationImage.image = [UIImage imageNamed:imageNotification];
        [cell.contentView addSubview:notificationImage];

        UILabel * TitleLabel = [[UILabel alloc]  initWithFrame: CGRectMake(notificationImage.frame.origin.x+notificationImage.frame.size.width+15, 5, 200, 30)];
         TitleLabel.font = (IS_IPAD) ? [UIFont fontWithName:fontNameStr size:17] : [UIFont fontWithName:fontNameStr size:15];
        TitleLabel.font = (IS_IPAD_PRO_1366) ? [UIFont fontWithName:fontNameStr size:22] : TitleLabel.font;
        TitleLabel.text= database.serviceName;
        
        [cell.contentView addSubview:TitleLabel];
        
        UILabel * Description = [[UILabel alloc]  initWithFrame: CGRectMake(TitleLabel.frame.origin.x, TitleLabel.frame.origin.y+TitleLabel.frame.size.height+1*IS_IPAD, 250+450*IS_IPAD+50*IS_IPHONE_6+85*IS_IPHONE_6P+250*IS_IPAD_PRO_1366, 18)];
        Description.text= database.NotificationText;
        Description.font = (IS_IPAD) ? [UIFont fontWithName:fontNameStr size:15] : [UIFont fontWithName:fontNameStr size:13];
        Description.font = (IS_IPAD_PRO_1366) ? [UIFont fontWithName:fontNameStr size:19] : Description.font;
        [Description autosizeForWidth];
        int lines = [Description getNoOflines];
        [cell.contentView addSubview:Description];
        
        UILabel * DateDay = [[UILabel alloc]  initWithFrame: CGRectMake(Description.frame.origin.x, Description.frame.origin.y+Description.frame.size.height-5, 200, 40)];
        DateDay.text= database.ScheduledAt;
        DateDay.font = (IS_IPAD) ? [UIFont fontWithName:fontNameStr size:14] : [UIFont fontWithName:fontNameStr size:12];
        DateDay.font = (IS_IPAD_PRO_1366) ? [UIFont fontWithName:fontNameStr size:18] : DateDay.font;
        DateDay.textColor = [UIColor lightGrayColor];
        [cell.contentView addSubview:DateDay];
        if (lines==1) {
            DateDay.frame = CGRectMake(DateDay.frame.origin.x, DateDay.frame.origin.y-2, DateDay.frame.size.width, DateDay.frame.size.height);

        }
        
            if (lines < 4) {
            
            }else{
                UIImageView * dropDownImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-23, DateDay.frame.origin.y+16, 8, 6)];
                dropDownImage.image = [UIImage imageNamed:@"1collapse_icon.png"];
                [cell.contentView addSubview:dropDownImage];
            }
        
        UILabel * partitionlabel = [[UILabel alloc]  initWithFrame: CGRectMake(notificationImage.frame.origin.x, DateDay.frame.origin.y+DateDay.frame.size.height-5, tableView.frame.size.width-2*notificationImage.frame.origin.x, 1)];
        partitionlabel.backgroundColor= [UIColor lightGrayColor];
        [cell.contentView addSubview:partitionlabel];
        if (lines==1) {
            partitionlabel.frame = CGRectMake(partitionlabel.frame.origin.x, partitionlabel.frame.origin.y-2, partitionlabel.frame.size.width, partitionlabel.frame.size.height);
            
        }
//        if (countFinalVal==0) {
//            UILabel * cover = [[UILabel alloc]  initWithFrame: CGRectMake(0,0,partitionlabel.frame.origin.x+partitionlabel.frame.size.width ,tableView.frame.size.height )];
//            cover.backgroundColor = [UIColor whiteColor];
//            cover.alpha = 0.8;
//            [cell.contentView addSubview:cover];
//        }else {
//            if (indexPath.row > (countFinalVal-1))
//            {
//                UILabel * cover = [[UILabel alloc]  initWithFrame: CGRectMake(0,0,partitionlabel.frame.origin.x+partitionlabel.frame.size.width ,tableView.frame.size.height )];
//                cover.backgroundColor = [UIColor whiteColor];
//                cover.alpha = 0.8;
//                [cell.contentView addSubview:cover];
//                
//            }
//        }
//        
        
       
    }
    else{
        database = [[DBManager alloc]init];
        database = [notificationDataArr objectAtIndex:indexPath.row];
        
        NSString *fontNameStr,*imageNotification;
        if ([database.isRead isEqualToString:@"true"])
        {
            fontNameStr = @"Roboto-Regular";
            imageNotification = @"1bell_read.png";
        }else{
            fontNameStr = @"Roboto-Bold";
            imageNotification = @"1bell_unread.png";
        }
        
        
        
        
        
        UIImageView * notificationImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 15, 18)];
        if (IS_IPHONE_6P) {
            notificationImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 12, 15, 16)];
            }
        notificationImage.image = [UIImage imageNamed:imageNotification];
        [cell.contentView addSubview:notificationImage];
        
        UILabel * TitleLabel = [[UILabel alloc]  initWithFrame: CGRectMake(notificationImage.frame.origin.x+notificationImage.frame.size.width+15, 5, 200, 30)];
        TitleLabel.font = (IS_IPAD) ? [UIFont fontWithName:fontNameStr size:17] : [UIFont fontWithName:fontNameStr size:15];
        TitleLabel.font = (IS_IPAD_PRO_1366) ? [UIFont fontWithName:fontNameStr size:22] : TitleLabel.font;
        TitleLabel.text= database.serviceName;
        [cell.contentView addSubview:TitleLabel];
        
        
        UILabel * Description = [[UILabel alloc]  initWithFrame: CGRectMake(TitleLabel.frame.origin.x, TitleLabel.frame.origin.y+TitleLabel.frame.size.height+1*IS_IPAD, 250+450*IS_IPAD+50*IS_IPHONE_6+85*IS_IPHONE_6P+250*IS_IPAD_PRO_1366, 65+20*IS_IPAD_PRO_1366)];
        Description.text= database.NotificationText;
        Description.font = (IS_IPAD) ? [UIFont fontWithName:fontNameStr size:15] : [UIFont fontWithName:fontNameStr size:13];
        Description.font = (IS_IPAD_PRO_1366) ? [UIFont fontWithName:fontNameStr size:19] : Description.font;
        int lines = [Description getNoOflines];
        [noOfLinesArr addObject:[NSString stringWithFormat:@"%d",lines]];
        if (lines == 1 || lines == 2 || lines == 3) {
            Description.frame = CGRectMake(Description.frame.origin.x, Description.frame.origin.y, Description.frame.size.width, 18);
            [Description autosizeForWidth];
        }else{
            Description.numberOfLines = 3;
        }
        if (IS_IPHONE_4_OR_LESS){
            if (lines == 1 || lines == 2 || lines == 3) {
                 Description.frame = CGRectMake(Description.frame.origin.x, Description.frame.origin.y, Description.frame.size.width, Description.frame.size.height);
            }else{
                Description.frame = CGRectMake(Description.frame.origin.x, Description.frame.origin.y-7, Description.frame.size.width, Description.frame.size.height);
            }
        }else if(IS_IPHONE_5){
             if (lines == 1 || lines == 2 || lines == 3) {
                  Description.frame = CGRectMake(Description.frame.origin.x, Description.frame.origin.y, Description.frame.size.width, Description.frame.size.height);
             }else{
                  Description.frame = CGRectMake(Description.frame.origin.x, Description.frame.origin.y-7, Description.frame.size.width, Description.frame.size.height);
             }
        }else if(IS_IPHONE_6){
            if (lines == 1 || lines == 2 || lines == 3) {
                Description.frame = CGRectMake(Description.frame.origin.x, Description.frame.origin.y, Description.frame.size.width, Description.frame.size.height);
            }else{
           Description.frame = CGRectMake(Description.frame.origin.x, Description.frame.origin.y-7, Description.frame.size.width, Description.frame.size.height);
            }
        }else if(IS_IPHONE_6P){
            if (lines == 1 || lines == 2 || lines == 3) {
                Description.frame = CGRectMake(Description.frame.origin.x, Description.frame.origin.y, Description.frame.size.width, Description.frame.size.height);
            }else{
            Description.frame = CGRectMake(Description.frame.origin.x, Description.frame.origin.y-7, Description.frame.size.width, Description.frame.size.height);
            }
        }else if(IS_IPAD){
            if (lines == 1 || lines == 2 || lines == 3) {
                Description.frame = CGRectMake(Description.frame.origin.x, Description.frame.origin.y, Description.frame.size.width, Description.frame.size.height);
            }else{
          Description.frame = CGRectMake(Description.frame.origin.x, Description.frame.origin.y-2, Description.frame.size.width, Description.frame.size.height);
            }
        }
        [cell.contentView addSubview:Description];
        
        
        UILabel * DateDay = [[UILabel alloc]  initWithFrame: CGRectMake(Description.frame.origin.x, Description.frame.origin.y+Description.frame.size.height-5, 200, 40)];
        DateDay.text= database.ScheduledAt;
        DateDay.textColor = [UIColor lightGrayColor];
        DateDay.font = (IS_IPAD) ? [UIFont fontWithName:fontNameStr size:14] : [UIFont fontWithName:fontNameStr size:12];
        DateDay.font = (IS_IPAD_PRO_1366) ? [UIFont fontWithName:fontNameStr size:18] : DateDay.font;
         if (IS_IPHONE_4_OR_LESS){
             if (lines == 1 || lines == 2 || lines == 3) {
                 DateDay.frame = CGRectMake(DateDay.frame.origin.x, DateDay.frame.origin.y, DateDay.frame.size.width, DateDay.frame.size.height);
             }else{
             DateDay.frame = CGRectMake(DateDay.frame.origin.x, DateDay.frame.origin.y-7, DateDay.frame.size.width, DateDay.frame.size.height);
             }
         }else if(IS_IPHONE_5){
             if (lines == 1 || lines == 2 || lines == 3) {
                 DateDay.frame = CGRectMake(DateDay.frame.origin.x, DateDay.frame.origin.y, DateDay.frame.size.width, DateDay.frame.size.height);
             }else{
           DateDay.frame = CGRectMake(DateDay.frame.origin.x, DateDay.frame.origin.y-7, DateDay.frame.size.width, DateDay.frame.size.height);
             }
         }else if(IS_IPHONE_6){
             if (lines == 1 || lines == 2 || lines == 3) {
                 DateDay.frame = CGRectMake(DateDay.frame.origin.x, DateDay.frame.origin.y, DateDay.frame.size.width, DateDay.frame.size.height);
             }else{
           DateDay.frame = CGRectMake(DateDay.frame.origin.x, DateDay.frame.origin.y-7, DateDay.frame.size.width, DateDay.frame.size.height);
             }
         }else if(IS_IPHONE_6P){
             if (lines == 1 || lines == 2 || lines == 3) {
                 DateDay.frame = CGRectMake(DateDay.frame.origin.x, DateDay.frame.origin.y, DateDay.frame.size.width, DateDay.frame.size.height);
             }else{
           DateDay.frame = CGRectMake(DateDay.frame.origin.x, DateDay.frame.origin.y-7, DateDay.frame.size.width, DateDay.frame.size.height);
             }
         }else if(IS_IPAD){
             DateDay.frame = CGRectMake(DateDay.frame.origin.x, DateDay.frame.origin.y-2, DateDay.frame.size.width, DateDay.frame.size.height);
         }
        [cell.contentView addSubview:DateDay];
        
        
            if (lines < 4) {
            
            }else{
                UIImageView * dropDownImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-23, DateDay.frame.origin.y+16, 8, 6)];
                dropDownImage.image = [UIImage imageNamed:@"1expand_icon.png"];
                [cell.contentView addSubview:dropDownImage];
            }
        
        UILabel * partitionlabel = [[UILabel alloc]  initWithFrame: CGRectMake(notificationImage.frame.origin.x, DateDay.frame.origin.y+DateDay.frame.size.height-5, tableView.frame.size.width-2*notificationImage.frame.origin.x, 1)];
        if (IS_IPAD) {
            partitionlabel.frame = CGRectMake(partitionlabel.frame.origin.x, partitionlabel.frame.origin.y-2, partitionlabel.frame.size.width, partitionlabel.frame.size.height);
            if (IS_IPAD_PRO_1366) {
                 partitionlabel.frame = CGRectMake(partitionlabel.frame.origin.x, partitionlabel.frame.origin.y+3, partitionlabel.frame.size.width, partitionlabel.frame.size.height);
            }
        }
        partitionlabel.backgroundColor= [UIColor lightGrayColor];
        [cell.contentView addSubview:partitionlabel];
        
//        UILabel * cover = [[UILabel alloc]  initWithFrame: CGRectMake(0,0,partitionlabel.frame.origin.x+partitionlabel.frame.size.width ,partitionlabel.frame.origin.y+partitionlabel.frame.size.height )];
//        cover.backgroundColor = [UIColor whiteColor];
//        cover.alpha = 0.9;
//        [cell.contentView addSubview:cover];
       
        
    }
    
//    UIButton * DeleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    DeleteButton.frame = CGRectMake(self.view.frame.size.width-35, 10, 25, 25);
//    [DeleteButton setImage:[UIImage imageNamed:@"1del_icon.png"] forState:UIControlStateNormal];
//    DeleteButton.tag = indexPath.row;
//    [DeleteButton addTarget:self action:@selector(cellDeleteButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//    [cell.contentView addSubview:DeleteButton];
    
    
    
   
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    int count = (int)[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"loadMoreCount"]];
    
    
    
        return  cell;
}
- (void)tableView:(UITableView *)atableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSMutableArray *modifiedRows = [NSMutableArray array];
    if ([indexPath isEqual:self.expandedIndexPath]) {
        [modifiedRows addObject:self.expandedIndexPath];
        self.expandedIndexPath = nil;
    } else {
        
        database = [[DBManager alloc]init];
        database = [notificationDataArr objectAtIndex:indexPath.row];
        
        
        UILabel * Description = [[UILabel alloc]  initWithFrame: CGRectMake(0, 0, 250+450*IS_IPAD+50*IS_IPHONE_6+85*IS_IPHONE_6P+250*IS_IPAD_PRO_1366, 65+20*IS_IPAD_PRO_1366)];
        Description.text= database.NotificationText;
        Description.font = (IS_IPAD) ? [UIFont fontWithName:@"Roboto-Regular" size:15] : [UIFont fontWithName:@"Roboto-Regular" size:13];
        Description.font = (IS_IPAD_PRO_1366) ? [UIFont fontWithName:@"Roboto-Regular" size:19] : Description.font;
        int lines = [Description getNoOflines];
        
        
        int nooflines =  lines;
        if (nooflines <4) {
            NSLog(@"%d",nooflines);
            if ([database.isRead isEqualToString:@"false"]) {
                bool success =  [database updateTableNotification:database.NotificationId];
                if (success) {
                    database.isRead = @"true";
                    [notificationDataArr replaceObjectAtIndex:indexPath.row withObject:database];
                    
                    // notificationDataArr = [database showData];
                }
            }
            [modifiedRows addObject:indexPath];
            clickedIndex = indexPath;
            // This will animate updating the row sizes
            [tableView reloadRowsAtIndexPaths:modifiedRows withRowAnimation:UITableViewRowAnimationAutomatic];
            
            // Preserve the deselection animation (if desired)
            [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            return;
        }
        
        if (self.expandedIndexPath)
            [modifiedRows addObject:self.expandedIndexPath];
        
        self.expandedIndexPath = indexPath;
        [modifiedRows addObject:indexPath];
        
        
        
        if ([database.isRead isEqualToString:@"false"]) {
          bool success =  [database updateTableNotification:database.NotificationId];
            if (success) {
                database.isRead = @"true";
                [notificationDataArr replaceObjectAtIndex:indexPath.row withObject:database];
                
               // notificationDataArr = [database showData];
            }
           
        }
    }
    
    clickedIndex = indexPath;
    // This will animate updating the row sizes
    [tableView reloadRowsAtIndexPaths:modifiedRows withRowAnimation:UITableViewRowAnimationAutomatic];
    
    // Preserve the deselection animation (if desired)
    [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}
- (void)tableView:(UITableView *)atableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        database = [[DBManager alloc]init];
        database = [notificationDataArr objectAtIndex:indexPath.row];
        
        bool success = [database deleteTableNotification:database.NotificationId];
        if (success) {
            notificationDataArr = [database showData];
            int count = [database GetDataCount];
            if (count>notificationDataArr.count) {
                newView.hidden = NO;
            }else{
                newView.hidden = YES;
            }
            
            
            [tableView reloadData];
            [self.view makeToast:@"Notification Deleted"];
        }
        [tableView reloadData];

    }
}

#pragma mark- Buttons
- (IBAction)LoadMore:(id)sender{
    NSMutableArray *additionalDataArray = [[NSMutableArray alloc]init];
    
    additionalDataArray = [database loadMoreData];
    
    for (int i = 0; i<additionalDataArray.count; i++) {
        [notificationDataArr addObject:[additionalDataArray objectAtIndex:i]];
    }
    
    
//    notificationDataArr
    
    int count = [database GetDataCount];
    if (count>notificationDataArr.count) {
         newView.hidden = NO;
    }else{
        newView.hidden = YES;
    }
    
    [tableView reloadData];
}
- (IBAction)btnBack:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnAboutApp:(id)sender {
    AboutAppViewController *aboutAppVC = [[AboutAppViewController alloc]initWithNibName:@"AboutAppViewController" bundle:nil];
    [self.navigationController pushViewController:aboutAppVC animated:YES];
}

- (IBAction)btnAutoAvesURL:(id)sender {
    NSString *urlStr = [NSString stringWithFormat:@"http://%@",btnAutoAvesURL.titleLabel.text];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
}

- (IBAction)btnLogOut:(id)sender {
    dashboardViewController *dashboardVC = [[dashboardViewController alloc]init];
    
    [dashboardVC.timerDashboard invalidate];
    
    if([[[NSUserDefaults standardUserDefaults]valueForKey:@"from_fb"] isEqualToString:@"yes"])
    {
        if (FBSession.activeSession.state == FBSessionStateOpen
            || FBSession.activeSession.state == FBSessionStateOpenTokenExtended) {
            
            // Close the session and remove the access token from the cache
            // The session state handler (in the app delegate) will be called automatically
            [FBSession.activeSession closeAndClearTokenInformation];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"from_fb"];
            // If the session state is not any of the two "open" states when the button is clicked
            return;
        }
    }else{
        [self logout];
        
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"l_email"];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"l_firstName"];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"l_lastName"];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"l_facebookUser"];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"l_meaId"];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"l_meaName"];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"l_phoneNo"];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"l_userName"];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"l_userid"];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"l_roleName"];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"l_roleId"];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"l_purchasedBefore"];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"l_image"];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"l_loggedin"];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"from_fb"];

    }

}
-(void)logout
{
    [kappDelegate ShowIndicator];
    webservice=3;
    NSMutableURLRequest *request ;
    NSString*_postData ;
    NSURLConnection *connection;
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSLog(@"%@",[user valueForKey:@"l_userid"]);
    NSString *userid = [NSString stringWithFormat: @"%@",[user valueForKey:@"l_userid"]];
    //    NSString *udid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    //    NSString *currSys = @"ios";
    //    NSString *devToken = [[NSUserDefaults standardUserDefaults] valueForKey: @"deviceToken"];
    
    _postData = [NSString stringWithFormat:@""];
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/users/%@/logout",Kwebservices,userid]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
    
    NSLog(@"data post >>> %@",_postData);
    
    [request setHTTPMethod:@"POST"];
    //[request addValue:mea forHTTPHeaderField:@"MEAId"];
    //[request addValue:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"UserToken"]] forHTTPHeaderField:@"token"];
    
    [request setHTTPBody: [_postData dataUsingEncoding:NSUTF8StringEncoding]];
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if(connection)
    {
        if(webData==nil)
        {
            webData = [NSMutableData data] ;
            NSLog(@"data");
        }
        else
        {
            webData=nil;
            webData = [NSMutableData data] ;
        }
        NSLog(@"server connection made");
    }
    else
    {
        NSLog(@"connection is NULL");
    }
    
    
}
#pragma mark - connection delegate

-(NSInteger)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
    NSLog(@"response status code: %ld %@", (long)[httpResponse statusCode],httpResponse.debugDescription);
    
    NSLog(@"Received Response");
    [webData setLength: 0];
    
    if((long)[httpResponse statusCode] == ResultOk)
    {
        NSLog(@"Received Response");
        [webData setLength: 0];
        recieved_status = @"passed";
        
    }else if ((long)[httpResponse statusCode] == ResultFailed)
    {
        recieved_status = @"failed";
        return [httpResponse statusCode];
        
    } else if ((long)[httpResponse statusCode] == 404)
    {
        recieved_status = @"no data";
    }
    return  YES;
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [kappDelegate HideIndicator];
    
    
    if ([[NSString stringWithFormat:@"%@",error] rangeOfString:@"The Internet connection appears to be offline." options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        [HelperAlert  alertWithOneBtn:@"ERROR" description:@"The Internet connection appears to be offline." okBtn:OkButtonTitle];
        if (status1==true) {
            [refreshControl endRefreshing];
        }
        return;
    }
    if ([[NSString stringWithFormat:@"%@",error] rangeOfString:@"The network connection was lost" options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        [HelperAlert  alertWithOneBtn:@"ERROR" description:@"The network connection was lost" okBtn:OkButtonTitle];
        if (status1==true) {
            [refreshControl endRefreshing];
        }
        return;
    }
    if ([[NSString stringWithFormat:@"%@",error] rangeOfString:@"Could not connect to the server" options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        [HelperAlert  alertWithOneBtn:@"ERROR" description:@"Internet connection lost. Could not connect to the server" okBtn:OkButtonTitle];
        if (status1==true) {
            [refreshControl endRefreshing];
        }
        return;
    }
    
    if ([[NSString stringWithFormat:@"%@",error] rangeOfString:@"The request timed out" options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        [HelperAlert  alertWithOneBtn:@"ERROR" description:@"The request timed out. Not able to connect to server" okBtn:OkButtonTitle];
        if (status1==true) {
            [refreshControl endRefreshing];
        }
        return;
    }
    [HelperAlert  alertWithOneBtn:@"ERROR" description:@"Intenet connection failed.. Try again later." okBtn:OkButtonTitle];
    NSLog(@"ERROR with the Connection ");
    if (status1==true) {
        [refreshControl endRefreshing];
    }
    webData =nil;
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data1
{
    [webData appendData:data1];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [kappDelegate HideIndicator];
    
    NSLog(@"DONE. Received Bytes: %lu", (unsigned long)[webData length]);
    
    if ([webData length]==0)
        return;
    
    NSString *responseString = [[NSString alloc] initWithData:webData encoding:NSUTF8StringEncoding];
    NSLog(@"responseString:%@",responseString);
    NSError *error;
    
    SBJsonParser *json = [[SBJsonParser alloc] init];
    NSMutableDictionary *userDetailDict=[json objectWithString:responseString error:&error];
    
    if([recieved_status isEqualToString:@"passed"])
    {
        if (webservice==1) {
            
//            NSArray *data = [userDetailDict valueForKey:@"Notifications"];
             NSDictionary *data = userDetailDict;
            saveData = [[NSMutableArray alloc] init];
            
            
            for (int i=0; i<data.count; i++)
//                for (int i=0; i<55; i++)
            {
                NSString *saveStr = [[data valueForKey:@"CreatedDate"]objectAtIndex:0] ;
                [[NSUserDefaults standardUserDefaults]setObject:saveStr forKey:@"dashboardNotificationTimeStamp"];
                
                
                database = [[DBManager alloc] init];
                NSString* NotificationText = [NSString stringWithFormat:@"%@",[[data valueForKey:@"NotificationText"]objectAtIndex:i]];
                database.NotificationText = NotificationText;
                
                NSString* ScheduledAt = [NSString stringWithFormat:@"%@",[[data valueForKey:@"ScheduledAt"]objectAtIndex:i]];
                database.ScheduledAt = ScheduledAt;
//
                NSString *serviceName = [NSString stringWithFormat:@"%@",[[data valueForKey:@"NotificationTitle"]objectAtIndex:i]];
                NSArray *NotificationTypeArr =[[data valueForKey:@"NotificationType"]objectAtIndex:i];
                NSString *notificationTypeStr = [NSString stringWithFormat:@"%@",[NotificationTypeArr valueForKey:@"Name"]];
                serviceName = [NSString stringWithFormat:@"%@ - %@",notificationTypeStr,serviceName];
                database.serviceName = serviceName;
                
                NSString *NotificationId = [NSString stringWithFormat:@"%@",[[data valueForKey:@"NotificationId"]objectAtIndex:i]];
                database.NotificationId = NotificationId;
                
                NSString *CreatedDate = [NSString stringWithFormat:@"%@",[[data valueForKey:@"CreatedDate"]objectAtIndex:i]];
                database.CreatedDate = CreatedDate;
//                
//             NSString*   NotificationText = [NSString stringWithFormat:@"%d notification text this is for testing notification text this is for testing notification text this is for testing notification text this is for testing notification text this is for testing notification text this is for testing notification text this is for testing notification text this is for testing notification text this is for testing notification text this is for testing ",i];
//             NSString*   ScheduledAt = [NSString stringWithFormat:@"%@--%d",[NSDate date],i];
//             NSString*   serviceName = [NSString stringWithFormat:@"Service - Test Notification %d",i];
//             NSString*   NotificationId = [NSString stringWithFormat:@"%d",i];
//                
//                database.NotificationText = NotificationText;
//                database.ScheduledAt = ScheduledAt;
//                database.serviceName = serviceName;
//                database.NotificationId = NotificationId;
                
                
                [saveData addObject:database];
            }
            
//            if (executeFirtTime==nil) {
//                executeFirtTime = @"true";
//            }else{
//                NSMutableArray *allData = [[NSMutableArray alloc]init];
//                allData = [database getAllData];
//                saveData=[[[saveData reverseObjectEnumerator] allObjects] mutableCopy];
//                
//                
//                
//                for (int k=0; k<saveData.count; k++) {
//                    
//                    [allData insertObject:[saveData objectAtIndex:0] atIndex:0];
//                }
//                saveData = allData;
//                BOOL status = [database deleteAllData];
//                if (status) {
//                    [self savenotificationsToDB:saveData];
//                }
//            }
            
            
            
            
            [self savenotificationsToDB:saveData];
            
            int val = [notificationTimeStamp intValue];
            val++;
            [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",val] forKey:@"timeStamp"];
            
            database = [[DBManager alloc]init];
            notificationDataArr = [database showData];
            int count = [database GetDataCount];
            if (count>notificationDataArr.count) {
                newView.hidden = NO;
            }else{
                newView.hidden = YES;
            }
            
            if (status1==true) {
                [refreshControl endRefreshing];
            }
            
            
            [tableView reloadData];
            
        }else if (webservice==3)
        {
            //[self.view makeToast:[NSString stringWithFormat:@"%@",responseString]];
            //            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"ARA" message:responseString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            //            [alert show];
            [kappDelegate HideIndicator];
            
            LoginViewController *LIvc = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
            [self.navigationController pushViewController:LIvc animated:YES];
            
            return;
        }

    }else {
        
        if (webservice==1) {
            if ([recieved_status  isEqual: @"no data"]) {
//                [self.view makeToast:@"NO more notifications...."];
                if (status1==true) {
                    [refreshControl endRefreshing];
                }
                return;
            }
        }
    [HelperAlert  alertWithOneBtn:AlertTitle description:responseString okBtn:OkButtonTitle];
        
        if (status1==true) {
            [refreshControl endRefreshing];
        }
 
    }
}
#pragma mark - Save Data to DataBase
-(void)getNotifications
{
    
    webservice=1;
    NSMutableURLRequest *request ;
    NSString*_postData ;
    NSURLConnection *connection;
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSLog(@"%@",[user valueForKey:@"l_userid"]);
    
    notificationTimeStamp = [user valueForKey:@"timeStamp"];
    NSString *timeSS = [[NSUserDefaults standardUserDefaults]valueForKey:@"dashboardNotificationTimeStamp"];
    
    NSString *userid = [NSString stringWithFormat: @"%@",[user valueForKey:@"l_userid"]];
    
//    _postData = [NSString stringWithFormat:@"userId=%@&currentPage=%@&pageSize=%@",@"179",notificationTimeStamp,@"10"];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString* dateStr = [dateFormatter stringFromDate:[NSDate date]];
    
    _postData = [NSString stringWithFormat:@"UserId=%@&TimeStamp=%@",@"175",dateStr];
    if (timeSS !=nil) {
        _postData = [NSString stringWithFormat:@"UserId=%@&TimeStamp=%@",@"175",timeSS];
    }
    
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/notification/user",Kwebservices]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
    
    NSLog(@"data post >>> %@",_postData);
    
    [request setHTTPMethod:@"POST"];
    //[request addValue:mea forHTTPHeaderField:@"MEAId"];
  //  NSLog(@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"UserToken"]);
    //[request addValue:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"UserToken"]] forHTTPHeaderField:@"token"];
    
//    [request setHTTPBody: [_postData dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody: [_postData dataUsingEncoding:NSUTF8StringEncoding]];
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if(connection)
    {
        if(webData==nil)
        {
            webData = [NSMutableData data] ;
            NSLog(@"data");
        }
        else
        {
            webData=nil;
            webData = [NSMutableData data] ;
        }
        NSLog(@"server connection made");
    }
    else
    {
        NSLog(@"connection is NULL");
    }
}
-(void)savenotificationsToDB:(NSMutableArray*)data
{
    
    database = [[DBManager alloc]init];
    NSString *userid = [NSString stringWithFormat: @"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"l_userid"]];
   bool value = [database createDB];
    if (value==true) {
        for (int i =0; i<data.count; i++) {
            database = [data objectAtIndex:i];
            
            [database saveData:userid isRead:@"false" notificationtitle:database.serviceName notificationDetail:database.NotificationText notificationDate:database.ScheduledAt NotificationId:database.NotificationId CreatedDate:database.CreatedDate];
            
        }
    }
}
-(void)cellDeleteButtonAction:(UIButton*)sender
{
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
        
        database = [[DBManager alloc]init];
        database = [notificationDataArr objectAtIndex:indexPath.row];
        
        bool success = [database deleteTableNotification:database.NotificationId];
        if (success) {
             notificationDataArr = [database showData];
            int count = [database GetDataCount];
            if (count>notificationDataArr.count) {
                newView.hidden = NO;
            }else{
                newView.hidden = YES;
            }
            
            [tableView reloadData];
            [self.view makeToast:@"Notification Deleted"];
        }
}
- (void)refreshTableView
{
    status1=true;
    [self getNotifications];
}
@end
