//
//  referralListViewController.m
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 12/08/15.
//  Copyright (c) 2015 Krishna_Mac_2. All rights reserved.
//

#import "referralListViewController.h"
#import "ReferralTableViewCell.h"
#import "referralDetailViewController.h"
#import "TLTagsControl.h"
#import "JSON.h"
#import "SBJson.h"
#import "AFHTTPRequestOperationManager.h"
#import "ASIHTTPRequest.h"
#import "dashboardViewController.h"

@interface referralListViewController ()
@property (nonatomic, strong) IBOutlet TLTagsControl *defaultEditingTagControl;
@property (nonatomic, strong) UIColor *tagsBackgroungColor;
@property (nonatomic, strong) IBOutlet TLTagsControl *tagControl;

@end

@implementation referralListViewController
UIButton *tag_btn,*tag_cancel_btn;

- (void)viewDidLoad {
    
    count=0;
    create_tag_btn=1;
    
    [btnSortnone setImage:[UIImage imageNamed:@"radio-checked.png"] forState:UIControlStateNormal];
    [btnFilternone setImage:[UIImage imageNamed:@"radio-checked.png"] forState:UIControlStateNormal];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
    open_arr = [[NSMutableArray alloc]init];
    sold_arr = [[NSMutableArray alloc]init];
    name_arr = [[NSMutableArray alloc]init];
    date_arr = [[NSMutableArray alloc]init];

    filter_height =@"no";
    
    radio_soldOnly = false;

    filter_status= @" ";
    
   
    [super viewDidLoad];
    
    //tag_btn = [[UIButton alloc]init];
    
//    filterView.layer.borderColor = [UIColor grayColor].CGColor;
//    filterView.layer.borderWidth = 1.0;
//    filterView.layer.cornerRadius = 4.0;
//    [filterView setClipsToBounds:YES];
//    
//    soryByView.layer.borderColor = [UIColor grayColor].CGColor;
//    soryByView.layer.borderWidth = 1.0;
//    soryByView.layer.cornerRadius = 4.0;
//    [soryByView setClipsToBounds:YES];
    
    int d = 0; // standard display
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2.0) {
        d = 1; // is retina display
    }
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        d += 2;
    }
    
    if (d==0) {
        headerImage.image = [UIImage imageNamed:@"320X480.png"];
    }
    if (d==1) {
        headerImage.image = [UIImage imageNamed:@"320X568.png"];
    }
    if (d==2) {
        headerImage.image = [UIImage imageNamed:@"480X800.png"];
    }
    if (d==3) {
        headerImage.image = [UIImage imageNamed:@"640X1136.png"];
    }
    
    if ( IS_IPAD )
    {
     //   btnSubmitReferral.titleLabel.font = [UIFont systemFontOfSize:24];
        lblheadingView.font=[lblheadingView.font fontWithSize:24];
        btnSort.titleLabel.font = [btnSort.titleLabel.font fontWithSize:24];
        btnBack.titleLabel.font = [btnBack.titleLabel.font fontWithSize:24];
        btnFilter.titleLabel.font = [btnFilter.titleLabel.font fontWithSize:24];
        
        imagedirectregerral.frame = CGRectMake(imagedirectregerral.frame.origin.x+20, imagedirectregerral.frame.origin.y, imagedirectregerral.frame.size.width, imagedirectregerral.frame.size.height);
        imageindirectreferral.frame = CGRectMake(imageindirectreferral.frame.origin.x+20, imageindirectreferral.frame.origin.y, imageindirectreferral.frame.size.width, imageindirectreferral.frame.size.height);
        lblDIrectreferral.frame = CGRectMake(lblDIrectreferral.frame.origin.x+20, lblDIrectreferral.frame.origin.y, lblDIrectreferral.frame.size.width, lblDIrectreferral.frame.size.height);
        lblIndirectreferral.frame = CGRectMake(lblIndirectreferral.frame.origin.x+20, lblIndirectreferral.frame.origin.y, lblIndirectreferral.frame.size.width, lblIndirectreferral.frame.size.height);
        
        lblDIrectreferral.font=[lblDIrectreferral.font fontWithSize:18];
        lblIndirectreferral.font=[lblIndirectreferral.font fontWithSize:18];
        
    }
    
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    AppDelegate*appdelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];

    sort_back_view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, appdelegate.window.frame.size.width, appdelegate.window.frame.size.height)];
    sort_back_view.backgroundColor =[[UIColor blackColor] colorWithAlphaComponent:.6];
    sort_back_view.alpha=1.0;
    [self.view addSubview:sort_back_view];
    sort_back_view.hidden = YES;

      lblheadingView.text = [NSString stringWithFormat:@"%@ (0)",_headerstr];
    
    UITapGestureRecognizer *messagesTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(delTag:)];
    [_defaultEditingTagControl addGestureRecognizer:messagesTap];
    
      lblheadingView.text = [NSString stringWithFormat:@"%@ (0)",_headerstr];
    [self getList:_webservice_trigger];
    [[NSUserDefaults standardUserDefaults]setObject:_webservice_trigger forKey:@"webservice_trigger"];
    
    if([_headerstr isEqualToString:@"SOLD REFERRALS"] || [_headerstr isEqualToString:@"INACTIVE REFERRALS"] || [_headerstr isEqualToString:@"ACTIVE REFERRALS"])
    {
        btnFilter.hidden = YES;
        lblpartition.hidden = YES;
        
        CGRect frame = btnSort.frame;
        frame.size.width = self.view.frame.size.width;
        btnSort.frame = frame;
        
         [btnSort.titleLabel setTextAlignment:NSTextAlignmentCenter];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    if([detail_view isEqualToString: @"yes"])
    {
        detail_view =@"no";
    }else{
    
    if (referralListArray.count>0)
    {
    //--for sort option
    //(1)
        [self sortByName:referralListArray];
    //(2)
    // create the string array
        [self sortByDate:referralListArray];
    //--
    
    
    //---for filter options
        [self filterForSold:referralListArray];
    
        [self filterForOpen:referralListArray];

     pop_out = @"yes";
        [tableView reloadData];
    
    }
    
    btnFilter.hidden = NO;
    lblpartition.hidden = NO;
    
    CGRect frame = btnSort.frame;
    frame.size.width = self.view.frame.size.width/2;
    btnSort.frame = frame;
    
    if([detail_view isEqualToString:@"yes"])
    {
    
        
    }else{
        
        filter_status = @"";
    }
//    if ([_trigger isEqualToString:@"sold"])
//    {
//        
//        
//        [self performSelector:@selector(InsertView)  withObject:nil afterDelay:0.3];
//        
//    }
    
    if([restore_radiobtn isEqualToString:@"yes"])
    {
        if([filter_height isEqualToString:@"yes"])
        {
            CGRect frame = tableView.frame;
            frame.origin.y = frame.origin.y - lbltagbackground.frame.size.height;
            frame.size.height = frame.size.height+lbltagbackground.frame.size.height;
            tableView.frame = frame;
            filter_height =@"no";
            _defaultEditingTagControl.hidden = YES;
        }
        _defaultEditingTagControl.hidden = YES;
        filter_status = @" ";
        //_trigger = @" ";
        tag_btn.hidden = YES;
        sold_open =@" ";
        btnImage1 = [UIImage imageNamed:@"radio-unchecked.png"];
        [btnSoldOnly setImage:btnImage1 forState:UIControlStateNormal];
        [btnOpenOnly setImage:btnImage1 forState:UIControlStateNormal];
        [btnSortBydate setImage:btnImage1 forState:UIControlStateNormal];
        [btnSortByname setImage:btnImage1 forState:UIControlStateNormal];
        [tableView reloadData];
        
    }else{
        
    }
        
    }
}
-(void)InsertView
{
    CGRect frame1 = _defaultEditingTagControl.frame;
    frame1.size.width = frame1.size.width+frame1.size.height-4;
    _defaultEditingTagControl.frame = frame1;
    
    btnFilter.hidden = NO;
    
    CGRect frame = btnSort.frame ;
    frame.size.width = btnFilter.frame.size.width;
    btnSort.frame =frame;

    lblpartition.hidden = NO;
    
    if([filter_height isEqualToString:@"yes"])
    {
        CGRect frame = tableView.frame;
        frame.origin.y = frame.origin.y - lbltagbackground.frame.size.height;
        frame.size.height = frame.size.height+lbltagbackground.frame.size.height;
        tableView.frame = frame;
        filter_height =@"no";
        _defaultEditingTagControl.hidden = YES;
    }else{
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}
#pragma mark - tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        return 80;
    }
    
    
    return 60;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if([pop_out isEqualToString:@"yes"])
    {
        pop_out = @"no";
        
        return 0;
    }
    
    
    if([filter_status isEqualToString:@"sortByDate"])
    {
        return [referralListSortDate count];
    }else if([filter_status isEqualToString:@"sortByName"])
    {
        return [sorted_array count];
        
    }else if([filter_status isEqualToString:@"sold_filter"])
    {
        return [referralListForSold count];
        
    }else if ([filter_status isEqualToString:@"open_filter"])
    {
        return [referralListForOpen count];
        
    }else{
        return [referralListArray count];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"ArticleCellID";
    
    ReferralTableViewCell *cell = (ReferralTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
   
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ReferralTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
    if([filter_status isEqualToString:@"sortByDate"])
    {
        obj = [referralListSortDate objectAtIndex:indexPath.row];
    }else if([filter_status isEqualToString:@"sortByName"])
    {
        obj = [sorted_array objectAtIndex:indexPath.row];
    }else if([filter_status isEqualToString:@"sold_filter"])
    {
        obj = [referralListForSold objectAtIndex:indexPath.row];
    }else if ([filter_status isEqualToString:@"open_filter"])
    {
        obj = [referralListForOpen objectAtIndex:indexPath.row];
    }else
    {
        obj = [referralListArray objectAtIndex:indexPath.row];
    }
    NSString *name = [NSString stringWithFormat:@"%@ %@",obj.first_name,obj.last_name];
    
    
    if([obj.ReferralStatus isEqualToString:@"sold"]){
        [cell setLabelText:name :[NSString stringWithFormat:@"Sold Date: %@",obj.SoldDate] :obj.ReferralStatus :obj.ReferralType];
    }else{
        NSString *datee = [NSString stringWithFormat:@"%@",obj.createDate];
        NSArray *dateArr = [datee componentsSeparatedByString:@" "];
        NSString *date = [NSString stringWithFormat:@"%@",[dateArr objectAtIndex:0]];
        NSString *timeAMPM =[NSString stringWithFormat:@"%@ %@",[dateArr objectAtIndex:1],[dateArr objectAtIndex:2]];
        
        NSArray *semidate = [date componentsSeparatedByString:@"-"];
        NSString *finalDate = [NSString stringWithFormat:@"%@-%@-%@",[semidate objectAtIndex:2],[semidate objectAtIndex:1],[semidate objectAtIndex:0]];
        
        
        
        
        
        [cell setLabelText:name :[NSString stringWithFormat:@"Submit Date: %@ %@",finalDate,timeAMPM] :obj.ReferralStatus :obj.ReferralType];
    }
    
//    if([obj.ReferralType isEqualToString:@"Direct"])
//    {
//        cell.imageView.image = [UIImage imageNamed:@"direct_ref.png"];
//        
//        
//    }else //if ([ReferralType isEqualToString:@"Direct"])
//    {
//        cell.imageView.image = [UIImage imageNamed:@"chained_ref.png"];
//    }
    //cell.imageView.contentMode=UIViewContentModeScaleAspectFit;

    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    //cell.imageView.image = [UIImage imageNamed:@"chained_ref.png"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if([filter_status isEqualToString:@"sortByDate"])
    {
        obj = [referralListSortDate objectAtIndex:indexPath.row];
    }else if([filter_status isEqualToString:@"sortByName"])
    {
        obj = [sorted_array objectAtIndex:indexPath.row];
    }else if([filter_status isEqualToString:@"sold_filter"])
    {
        obj = [referralListForSold objectAtIndex:indexPath.row];
    }else if ([filter_status isEqualToString:@"open_filter"])
    {
        obj = [referralListForOpen objectAtIndex:indexPath.row];
    }else
    {
        obj = [referralListArray objectAtIndex:indexPath.row];
    }
    
    
    referralDetailViewController *RDvc = [[referralDetailViewController alloc]initWithNibName:@"referralDetailViewController" bundle:nil];
    RDvc.obj = obj;
    detail_view = @"yes";
    [self.navigationController pushViewController:RDvc animated:YES];
}
#pragma  mark - Buttons
- (IBAction)btnFilternone:(id)sender {
    
    if([filter_status isEqualToString:@"sold_filter"])
    {
        if([sold_open isEqualToString:@"sortByDate"])
        {
            [self sortByDate:referralListArray];
            filter_status = @"sortByDate";
            [tableView reloadData];
        }else if ([sold_open isEqualToString:@"sortByName"]) {
            [self sortByName:referralListArray];
            filter_status = @"sortByName";
            [tableView reloadData];
        }else if([sold_open isEqualToString:@"open_filter"])
        {
            filter_status = @" ";
            [tableView reloadData];
        }else{
            filter_status = @" ";
            [tableView reloadData];
        }
        btnImage1 = [UIImage imageNamed:@"radio-unchecked.png"];
        [btnSoldOnly setImage:btnImage1 forState:UIControlStateNormal];
        [btnFilternone setImage:[UIImage imageNamed:@"radio-checked.png"] forState:UIControlStateNormal];
        
        
        //--to shift the tableview
        if([filter_height isEqualToString:@"yes"])
        {
            CGRect frame = tableView.frame;
            frame.origin.y = frame.origin.y - lbltagbackground.frame.size.height;
            frame.size.height = frame.size.height+lbltagbackground.frame.size.height;
            tableView.frame = frame;
            filter_height =@"no";
            _defaultEditingTagControl.hidden = YES;
        }
    }else if([filter_status isEqualToString:@"open_filter"])
    {
        if([sold_open isEqualToString:@"sortByDate"])
        {
            [self sortByDate:referralListArray];
            filter_status = @"sortByDate";
            [tableView reloadData];
        }else if ([sold_open isEqualToString:@"sortByName"]) {
            [self sortByName:referralListArray];
            filter_status = @"sortByName";
            [tableView reloadData];
        }else if([sold_open isEqualToString:@"sold_filter"])
        {
            filter_status = @" ";
            [tableView reloadData];
        }else
        {
            filter_status = @" ";
            [tableView reloadData];
        }
        btnImage1 = [UIImage imageNamed:@"radio-unchecked.png"];
        [btnOpenOnly setImage:btnImage1 forState:UIControlStateNormal];
        [btnFilternone setImage:[UIImage imageNamed:@"radio-checked.png"] forState:UIControlStateNormal];


        //--to shift the tableview
        if([filter_height isEqualToString:@"yes"])
        {
            CGRect frame = tableView.frame;
            frame.origin.y = frame.origin.y - lbltagbackground.frame.size.height;
            frame.size.height = frame.size.height+lbltagbackground.frame.size.height;
            tableView.frame = frame;
            filter_height =@"no";
            _defaultEditingTagControl.hidden = YES;
        }

    }else if([filter_status isEqualToString:@"sortByName"])
    {
        [self sortByName:referralListArray];
        filter_status = @"sortByName";
        [tableView reloadData];
        
        if([filter_height isEqualToString:@"yes"])
        {
            CGRect frame = tableView.frame;
            frame.origin.y = frame.origin.y - lbltagbackground.frame.size.height;
            frame.size.height = frame.size.height+lbltagbackground.frame.size.height;
            tableView.frame = frame;
            filter_height =@"no";
            _defaultEditingTagControl.hidden = YES;
        }
    }else if([filter_status isEqualToString:@"sortByDate"])
    {
        [self sortByDate:referralListArray];
        filter_status = @"sortByDate";
        [tableView reloadData];
        
        if([filter_height isEqualToString:@"yes"])
        {
            CGRect frame = tableView.frame;
            frame.origin.y = frame.origin.y - lbltagbackground.frame.size.height;
            frame.size.height = frame.size.height+lbltagbackground.frame.size.height;
            tableView.frame = frame;
            filter_height =@"no";
            _defaultEditingTagControl.hidden = YES;
        }
    }
    

    
    
    sort_back_view.hidden = YES;
    soryByView.hidden = YES;
    filterView.hidden = YES;
    
}

- (IBAction)btnSortnone:(id)sender {
    
    
    if([filter_status isEqualToString:@"sortByName"])
    {
        
        if([sold_open isEqualToString:@"sold_filter"])
        {
            [self filterForSold:referralListArray];
            filter_status = @"sold_filter";
            [tableView reloadData];
        }else if([sold_open isEqualToString:@"open_filter"])
        {
            [self filterForOpen:referralListArray];
            filter_status = @"open_filter";
            [tableView reloadData];
        }else if([sold_open isEqualToString:@"sortByDate"])
        {
            filter_status = @" ";
            [tableView reloadData];
        }else
            {
                filter_status = @" ";
                [tableView reloadData];
            }
        btnImage1 = [UIImage imageNamed:@"radio-unchecked.png"];
        [btnSortByname setImage:btnImage1 forState:UIControlStateNormal];
        [btnSortnone setImage:[UIImage imageNamed:@"radio-checked.png"] forState:UIControlStateNormal];

    }
    if([filter_status isEqualToString:@"sortByDate"])
    {
        if([sold_open isEqualToString:@"sold_filter"])
        {
            [self filterForSold:referralListArray];
            filter_status = @"sold_filter";
            [tableView reloadData];
        }else if([sold_open isEqualToString:@"open_filter"])
        {
            [self filterForOpen:referralListArray];
            filter_status = @"open_filter";
            [tableView reloadData];
        }else if([sold_open isEqualToString:@"sortByName"])
        {
            filter_status = @" ";
            [tableView reloadData];
        }else {
            filter_status = @" ";
            [tableView reloadData];
        }
        
        btnImage1 = [UIImage imageNamed:@"radio-unchecked.png"];
        [btnSortBydate setImage:btnImage1 forState:UIControlStateNormal];
        [btnSortnone setImage:[UIImage imageNamed:@"radio-checked.png"] forState:UIControlStateNormal];
    }
    if([filter_status isEqualToString:@"sold_filter"])
    {
        [self filterForSold:referralListArray];
        filter_status = @"sold_filter";
        [tableView reloadData];
    }
    if([filter_status isEqualToString:@"open_filter"])
    {
        [self filterForOpen:referralListArray];
        filter_status = @"open_filter";
        [tableView reloadData];
    }
    
    sort_back_view.hidden = YES;
    soryByView.hidden = YES;
    filterView.hidden = YES;
    optional= @"yes";
}

- (IBAction)btncancelSort:(id)sender {
    sort_back_view.hidden = YES;
    soryByView.hidden = YES;
    filterView.hidden = YES;
}

- (IBAction)btncancelFilter:(id)sender {
    sort_back_view.hidden = YES;
    soryByView.hidden = YES;
    filterView.hidden = YES;
}

- (IBAction)btnRefresh:(id)sender {
     [self delTag:@""];
    filter_status = @" ";
    sold_open = @" ";
    [tableView reloadData];
    
    
    btnImage1 = [UIImage imageNamed:@"radio-unchecked.png"];
    [btnSoldOnly setImage:btnImage1 forState:UIControlStateNormal];
    [btnOpenOnly setImage:btnImage1 forState:UIControlStateNormal];
    [btnSortBydate setImage:btnImage1 forState:UIControlStateNormal];
    [btnSortByname setImage:btnImage1 forState:UIControlStateNormal];
    [tableView reloadData];
   
    [self filterForOpen:referralListArray];
    [self filterForSold:referralListArray];
    [self sortByName:referralListArray];
    [self sortByDate:referralListArray];
}

- (IBAction)btnBack:(id)sender {
    pop_out= @"yes";
    [tableView reloadData];
    restore_radiobtn = @"yes";
    [self.navigationController popViewControllerAnimated:YES];
}



- (IBAction)btnSort:(id)sender {
    
    
    //----add view
    sort_back_view.hidden = NO;
    [self.view bringSubviewToFront:soryByView];
    soryByView.hidden = NO;
}

- (IBAction)btnFilter:(id)sender {
    
    //----add view
    sort_back_view.hidden = NO;
    [self.view bringSubviewToFront:filterView];
    filterView.hidden = NO;
    }

- (IBAction)btnSortBydate:(id)sender {
    optional = @"no";
   if([filter_status isEqualToString:@"sold_filter"])
   {
       date_arr = referralListForSold;
       [self sortByDate:date_arr];
       sold_open =@"sold_filter";

   }else if([filter_status isEqualToString:@"open_filter"])
   {
       date_arr = referralListForOpen;
       [self sortByDate:date_arr];
       sold_open=@"open_filter";
   }else if([filter_status isEqualToString:@"sortByName"])
   {
       if([sold_open isEqualToString:@"sold_filter"])
       {
           date_arr = referralListForSold;
           [self sortByDate:date_arr];
           sold_open =@"sold_filter";
       }else if([sold_open isEqualToString:@"open_filter"]){
           date_arr = referralListForOpen;
           [self sortByDate:date_arr];
           sold_open =@"open_filter";
       }else{
           date_arr =sorted_array;
           [self sortByDate:date_arr];
           sold_open =@"sortByName";
       }
       
   }else{
       if([sold_open isEqualToString:@"sold_filter"])
       {
           sold_open = sold_open;
       }else if([sold_open isEqualToString:@"open_filter"]){
       sold_open = sold_open;
       }else{
       sold_open =@" ";
       date_arr = referralListArray;
           [self sortByDate:date_arr];
       }
   }
    
    filter_status = @"sortByDate";
    UIImage *btnImage = [UIImage imageNamed:@"radio-checked.png"];
    [btnSortBydate setImage:btnImage forState:UIControlStateNormal];
    [tableView reloadData];
    //--change icon of sort by name
    btnImage4 = [UIImage imageNamed:@"radio-unchecked.png"];
    [btnSortByname setImage:btnImage4 forState:UIControlStateNormal];
    [btnSortnone setImage:[UIImage imageNamed:@"radio-unchecked.png"] forState:UIControlStateNormal];

    
    //--remove view
    sort_back_view.hidden = YES;
    soryByView.hidden = YES;
    }

- (IBAction)btnSortByname:(id)sender {
    optional=@"no";
    if([filter_status isEqualToString:@"sold_filter"])
    {
        name_arr = referralListForSold;
        [self sortByName:name_arr];
        sold_open=@"sold_filter";
    }else if([filter_status isEqualToString:@"open_filter"])
    {
        name_arr = referralListForOpen;
        [self sortByName:name_arr];
        sold_open=@"open_filter";
    }else if([filter_status isEqualToString:@"sortByDate"])
    {
        if([sold_open isEqualToString:@"sold_filter"])
        {
            name_arr = referralListForSold;
            [self sortByName:name_arr];
            sold_open =@"sold_filter";
        }else if([sold_open isEqualToString:@"open_filter"]){
            name_arr = referralListForOpen;
            [self sortByName:name_arr];
            sold_open =@"open_filter";

        }else{
            name_arr = referralListSortDate;
            [self sortByName:name_arr];
            sold_open=@"sortByDate";
        }
        
    }else{
        name_arr = referralListArray;
        [self sortByName:referralListArray];
    }
    filter_status = @"sortByName";
    UIImage *btnImage = [UIImage imageNamed:@"radio-checked.png"];
    [btnSortByname setImage:btnImage forState:UIControlStateNormal];
    [tableView reloadData];
    //--change icon of sort by date
    btnImage1 = [UIImage imageNamed:@"radio-unchecked.png"];
    [btnSortBydate setImage:btnImage1 forState:UIControlStateNormal];
    [btnSortnone setImage:[UIImage imageNamed:@"radio-unchecked.png"] forState:UIControlStateNormal];
    
    //--remove view
    sort_back_view.hidden = YES;
    soryByView.hidden = YES;
    }

- (IBAction)btnSoldOnly:(id)sender {
   optional=@"no";
     if([filter_status isEqualToString:@"sortByDate"])
        {
            if([sold_open isEqualToString:@"sortByName"])
            {
                [self sortByDate:referralListArray];
                sold_arr = referralListSortDate;
                sold_open = @"sortByDate";
                [self filterForSold:sold_arr];
                
            }else if([sold_open isEqualToString:@"open_filter"])
            {
                [self sortByDate:referralListArray];
                sold_arr = referralListSortDate;
                sold_open = @"sortByDate";
                [self filterForSold:sold_arr];
            }
            else{
            sold_arr = referralListSortDate ;
            sold_open = @"sortByDate";
            [self filterForSold:sold_arr];
            }
        }else if([filter_status isEqualToString:@"sortByName"])
        {
            if([sold_open isEqualToString:@"sortByDate"])
            {
                [self sortByName:referralListArray];
                sold_arr = sorted_array;
                sold_open = @"sortByDate";
                [self filterForSold:sold_arr];

                
            }else if([sold_open isEqualToString:@"sortByName"]){
            sold_arr = sorted_array ;
            sold_open = @"sortByName";
            [self filterForSold:sold_arr];
            }else if([sold_open isEqualToString:@"open_filter"])
            {
            [self sortByName:referralListArray];
            sold_arr = sorted_array;
            sold_open = @"sortByDate";
            [self filterForSold:sold_arr];
        }else
        {
            sold_arr = name_arr;
            [self filterForSold:sold_arr];
            sold_open = @"sortByName";
        }
            
        }else if ([filter_status isEqualToString:@"open_filter"])
        {
            if([sold_open isEqualToString:@"sortByName"])
            {
                [self sortByName:referralListArray];
                sold_arr = sorted_array;
                [self filterForSold:sold_arr];
            }else if([sold_open isEqualToString:@"sortByDate"]){
                [self sortByDate:referralListArray];
                sold_arr = referralListSortDate;
                [self filterForSold:sold_arr];
                
            }else if([sold_open isEqualToString:@"sold_filter"]){
                sold_arr = referralListArray;
                [self filterForSold:sold_arr];
            }
            sold_open = @"open_filter";
            
        }

    filter_status = @"sold_filter";
    UIImage *btnImage = [UIImage imageNamed:@"radio-checked.png"];
    [btnSoldOnly setImage:btnImage forState:UIControlStateNormal];
    [tableView reloadData];
    
    NSArray *array = [NSArray arrayWithObjects:@"Sold Only   X", nil];
    _defaultEditingTagControl.tags = [array mutableCopy];
        _defaultEditingTagControl.hidden = NO;
   _tagControl.sold_open = @"sold";
    [_defaultEditingTagControl reloadTagSubviews];

    //[tag_btn setTitle:@"     Sold Only" forState:UIControlStateNormal];
    //tag_btn.hidden = NO;
    if([filter_height isEqualToString:@"no"])
    {
    CGRect frame = tableView.frame;
    frame.origin.y = frame.origin.y+lbltagbackground.frame.size.height;
        frame.size.height = frame.size.height-lbltagbackground.frame.size.height;
    tableView.frame = frame;
    filter_height = @"yes";
    }
    
    //--change icon of sort by date
    btnImage1 = [UIImage imageNamed:@"radio-unchecked.png"];
    [btnFilternone setImage:[UIImage imageNamed:@"radio-unchecked.png"] forState:UIControlStateNormal];
    [btnOpenOnly setImage:btnImage1 forState:UIControlStateNormal];

    //--remove view
    sort_back_view.hidden = YES;
    filterView.hidden = YES;
    }

- (IBAction)btnOpenOnly:(id)sender {
   optional=@"no";
    
    if([filter_status isEqualToString:@"sortByDate"])
    {
        if([sold_open isEqualToString:@"sortByName"])
        {
            [self sortByDate:referralListArray];
            open_arr = referralListSortDate;
            sold_open = @"sortByDate";
            [self filterForOpen:open_arr];
        }else if([sold_open isEqualToString:@"sold_filter"])
        {
            [self sortByDate:referralListArray];
            open_arr = referralListSortDate;
            sold_open = @"sortByDate";
            [self filterForOpen:open_arr];
        }else{
        open_arr = referralListSortDate ;
        sold_open = @"sortByDate";
        [self filterForOpen:open_arr];
        }
    }else if([filter_status isEqualToString:@"sortByName"])
    {
        if([sold_open isEqualToString:@"sold_filter"])
        {
            [self sortByName:referralListArray];
            open_arr = sorted_array;
            sold_open = @"sortByName";

            [self filterForOpen:open_arr];
        }if([sold_open isEqualToString:@"sortByDate"])
        {
            [self sortByName:referralListArray];
            open_arr = sorted_array;
            sold_open = @"sortByName";
            [self filterForOpen:open_arr];
        }else if([sold_open isEqualToString:@"sold_filter"])
        {
            [self sortByName:referralListArray];
            open_arr = sorted_array;
            sold_open = @"sortByName";
            [self filterForOpen:open_arr];
        } else{
        open_arr = sorted_array ;
        sold_open = @"sortByName";
        [self filterForOpen:open_arr];
        }
        
    }else if ([filter_status isEqualToString:@"sold_filter"])
    {
        if([sold_open isEqualToString:@"sortByName"])
        {   [self sortByName:referralListArray];
            open_arr = sorted_array;
            [self filterForOpen:open_arr];
        }else  if([sold_open isEqualToString:@"sortByDate"]){
            [self sortByDate:referralListArray];
            open_arr = referralListSortDate;
            [self filterForOpen:open_arr];
            
        }else if([sold_open isEqualToString:@"open_filter"]){
            open_arr = referralListArray;
            [self filterForOpen:open_arr];
        }
        sold_open = @"sold_filter";
        
    }
    
    filter_status = @"open_filter";
    UIImage *btnImage = [UIImage imageNamed:@"radio-checked.png"];
    [btnOpenOnly setImage:btnImage forState:UIControlStateNormal];
    [tableView reloadData];
    
    NSArray *array = [NSArray arrayWithObjects:@"Open Only  X", nil];
    _defaultEditingTagControl.tags = [array mutableCopy];
    [_defaultEditingTagControl reloadTagSubviews];
    _defaultEditingTagControl.hidden = NO;
    //[tag_btn setTitle:@"     Open Only" forState:UIControlStateNormal];
    //tag_btn.hidden = NO;
    if([filter_height isEqualToString:@"no"])
    {
    CGRect frame = tableView.frame;
    frame.origin.y = frame.origin.y+lbltagbackground.frame.size.height;
        frame.size.height = frame.size.height-lbltagbackground.frame.size.height;
    tableView.frame = frame;
    filter_height = @"yes";
    }

    //--change icon of sort by date
    btnImage1 = [UIImage imageNamed:@"radio-unchecked.png"];
    [btnFilternone setImage:[UIImage imageNamed:@"radio-unchecked.png"] forState:UIControlStateNormal];
    [btnSoldOnly setImage:btnImage1 forState:UIControlStateNormal];

    //--remove view
    sort_back_view.hidden = YES;
    filterView.hidden = YES;
}
#pragma  mark - Other Methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(alertView.tag==2){
        if(buttonIndex == 0)//OK button pressed
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}
-(void)sortByName:(NSMutableArray*)arr
{
    referralListSortName = [[NSMutableArray alloc]init];
    for (int k=0; k<arr.count; k++) {
        obj = [arr objectAtIndex:k];
        
        [referralListSortName addObject:[NSString stringWithFormat:@"%@ %@",obj.first_name,obj.last_name]];
    }
    NSSortDescriptor *firstNameSort = [NSSortDescriptor sortDescriptorWithKey:nil
                                                                    ascending:NO
                                                                     selector:@selector(localizedStandardCompare:)];
    referralListSortName = [[referralListSortName sortedArrayUsingDescriptors:@[firstNameSort]]mutableCopy];
    
    sorted_array = [[NSMutableArray alloc]init];
    for (int j=0; j<referralListSortName.count; j++) {
        
        for (int h=0; h<referralListArray.count; h++) {
            
            obj = [referralListArray objectAtIndex:h];
            if ([[referralListSortName objectAtIndex:j] isEqualToString:[NSString stringWithFormat:@"%@ %@",obj.first_name,obj.last_name]]) {
                [sorted_array addObject:obj];
                break;
            }
        }
    }
    
     sorted_array=[[[sorted_array reverseObjectEnumerator] allObjects] mutableCopy];
}
-(void)sortByDate:(NSMutableArray*)arr
{
    // create the string array
    NSMutableArray *dateArray = [[NSMutableArray alloc]init];
    for (int l=0; l<arr.count; l++) {
        obj = [arr objectAtIndex:l];
        NSArray *str = [obj.createDate componentsSeparatedByString:@" "];
        NSString *dateStr = [NSString stringWithFormat:@"%@ %@",[str objectAtIndex:0],[str objectAtIndex:1]];
        [dateArray addObject:dateStr];
    }
    
    
    // create the date formatter with the correct format
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH-mm-ss"];
    
    NSMutableArray *tempArray = [[NSMutableArray alloc]init];
    
    // fast enumeration of the array
    for (int g=0;g<dateArray.count;g++) {
     //   NSString* dateString = [NSString stringWithFormat:@"%@",[dateArray objectAtIndex:g]];
        NSDate *date = [NSDate date];
       date = [formatter dateFromString:[NSString stringWithFormat:@"%@",[dateArray objectAtIndex:g]]];
        NSDateFormatter *fm = [[NSDateFormatter alloc]init];
        [fm setDateFormat:@"MM-dd-yyyy hh-mm-ss"];
        [tempArray addObject:[NSString stringWithFormat:@"%@",[fm stringFromDate:date]]];
    }
    
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"self"
                                                               ascending:NO];
    NSArray *descriptors = [NSArray arrayWithObject:descriptor];
    NSArray *reverseOrder = [dateArray sortedArrayUsingDescriptors:descriptors];
    
    // sort the array of dates
    // [tempArray sortUsingComparator:^NSComparisonResult(NSDate *date2, NSDate *date1) {
    // return date2 compare date1 for descending. Or reverse the call for ascending.
    //      return [date2 compare:date1];
    //  }];
    
    NSLog(@"%@", reverseOrder);
    referralListSortDate = [[NSMutableArray alloc]init];
    for (int f=0; f<reverseOrder.count; f++) {
        NSString *date_value = [NSString stringWithFormat:@"%@",[reverseOrder objectAtIndex:f]];
        for (int h=0; h<referralListArray.count; h++) {
            
            obj = [referralListArray objectAtIndex:h];
            
            NSArray *array2 = [obj.createDate componentsSeparatedByString:@" "];
            NSString *date_Value2 = [NSString stringWithFormat:@"%@ %@",[array2 objectAtIndex:0],[array2 objectAtIndex:1]];
            
            if ([date_value isEqualToString:date_Value2]) {
                [referralListSortDate addObject:obj];
                break;
            }
        }
    }
}
-(void)filterForSold:(NSMutableArray*)arr
{
    referralListForSold = [[NSMutableArray alloc]init];
    for (int i=0; i<arr.count; i++) {
        obj = [arr objectAtIndex:i];
        
        if([obj.ReferralStatus isEqualToString:@"sold"])
        {
            [referralListForSold addObject:obj];
        }
    }
}
-(void)filterForOpen:(NSMutableArray*)arr
{
    referralListForOpen = [[NSMutableArray alloc]init];
    for (int i=0; i<arr.count; i++) {
        obj = [arr objectAtIndex:i];
        
        if([obj.ReferralStatus isEqualToString:@"open"])
        {
            [referralListForOpen addObject:obj];
        }
    }

}
-(void)delTag:(id)sender
{
//    tag_btn.hidden = YES;
//    [tableView bringSubviewToFront:tag_btn];
    if([optional isEqualToString:@"yes"])
    {
        if([filter_height isEqualToString:@"yes"])
        {
            CGRect frame = tableView.frame;
            frame.origin.y = frame.origin.y - lbltagbackground.frame.size.height;
            frame.size.height = frame.size.height+lbltagbackground.frame.size.height;
            tableView.frame = frame;
            filter_height =@"no";
            _defaultEditingTagControl.hidden = YES;
        }
        filter_status = @" ";
        sold_open = @" ";
        [tableView reloadData];
        return;
    }
    if ([sold_open isEqualToString:@"sortByName"])
    {
        
        if([filter_status isEqualToString:@"open_filter"])
        {
            btnImage2 = [UIImage imageNamed:@"radio-unchecked.png"];
            [btnOpenOnly setImage:btnImage2 forState:UIControlStateNormal];
            filter_status = sold_open;
            [self sortByName:referralListArray];
            [tableView reloadData];
        }else if([filter_status isEqualToString:@"sold_filter"]){
            
            
            btnImage1 = [UIImage imageNamed:@"radio-unchecked.png"];
            [btnSoldOnly setImage:btnImage1 forState:UIControlStateNormal];
            filter_status = sold_open;
            [self sortByName:referralListArray];
            [tableView reloadData];
        }else if([filter_status isEqualToString:@"sortByDate"]){
            [self sortByDate:referralListArray];
            filter_status=@"sortByDate";
            sold_open = @" ";
            [tableView reloadData];
        }
        
        
    }else if ([sold_open isEqualToString:@"sortByDate"])
    {
       
        if([filter_status isEqualToString:@"open_filter"])
        {
            btnImage2 = [UIImage imageNamed:@"radio-unchecked.png"];
            [btnOpenOnly setImage:btnImage2 forState:UIControlStateNormal];
            filter_status = sold_open;
            [self sortByDate:referralListArray];
            [tableView reloadData];
        }else if([filter_status isEqualToString:@"sold_filter"])
        {

            btnImage1 = [UIImage imageNamed:@"radio-unchecked.png"];
            [btnSoldOnly setImage:btnImage1 forState:UIControlStateNormal];
            filter_status = sold_open;
            [self sortByDate:referralListArray];
            [tableView reloadData];
        }else if([filter_status isEqualToString:@"sortByName"]){
            [self sortByName:referralListArray];
            filter_status=@"sortByName";
            sold_open = @" ";
            [tableView reloadData];
        }
       

    }else if ([sold_open isEqualToString:@"sold_filter"])
        {
        
        if([filter_status isEqualToString:@"open_filter"])
        {
            btnImage2 = [UIImage imageNamed:@"radio-unchecked.png"];
            [btnOpenOnly setImage:btnImage2 forState:UIControlStateNormal];
             [btnSortBydate setImage:btnImage2 forState:UIControlStateNormal];
              [btnSortByname setImage:btnImage2 forState:UIControlStateNormal];
            
            filter_status =  @" ";
            
            [tableView reloadData];
            
        }else if([filter_status isEqualToString:@"sold_filter"])
        {
            btnImage1 = [UIImage imageNamed:@"radio-unchecked.png"];
            [btnSoldOnly setImage:btnImage1 forState:UIControlStateNormal];
            filter_status = sold_open;
            
            [tableView reloadData];
        }else if([filter_status isEqualToString:@"sortByName"])
        {
            [self sortByName:referralListArray];
            
            filter_status =@"sortByName";
            [tableView reloadData];

        }else if([filter_status isEqualToString:@"sortByDate"])
        {
            [self sortByDate:referralListArray];

            filter_status =@"sortByDate";
            [tableView reloadData];
        }
           
        }else if ([sold_open isEqualToString:@"open_filter"])
        {
            
            
            
            if([filter_status isEqualToString:@"open_filter"])
            {
                btnImage2 = [UIImage imageNamed:@"radio-unchecked.png"];
                [btnOpenOnly setImage:btnImage2 forState:UIControlStateNormal];
                filter_status = sold_open;
                [tableView reloadData];
            }else if([filter_status isEqualToString:@"sold_filter"]){
                
                
                btnImage1 = [UIImage imageNamed:@"radio-unchecked.png"];
                [btnSoldOnly setImage:btnImage1 forState:UIControlStateNormal];
                [btnSortBydate setImage:btnImage1 forState:UIControlStateNormal];
                [btnSortByname setImage:btnImage1 forState:UIControlStateNormal];

                filter_status = @" ";
                [tableView reloadData];
            }else if([filter_status isEqualToString:@"sortByName"]){
                [self sortByName:referralListArray];
                
                filter_status =@"sortByName";
                [tableView reloadData];
            }else if([filter_status isEqualToString:@"sortByDate"]){
                [self sortByDate:referralListArray];
                
                filter_status =@"sortByDate";
                [tableView reloadData];
            }
            
        }else{
            
            if([filter_status isEqualToString:@"open_filter"])
            {
                btnImage2 = [UIImage imageNamed:@"radio-unchecked.png"];
                [btnOpenOnly setImage:btnImage2 forState:UIControlStateNormal];
                
            }else if([filter_status isEqualToString:@"sold_filter"])
            {
                btnImage1 = [UIImage imageNamed:@"radio-unchecked.png"];
                [btnSoldOnly setImage:btnImage1 forState:UIControlStateNormal];
                
            }
            else
            {
                
                
                btnImage1 = [UIImage imageNamed:@"radio-unchecked.png"];
                [btnSoldOnly setImage:btnImage1 forState:UIControlStateNormal];
            }
            filter_status = sold_open;
            [tableView reloadData];
        }
    
    if([filter_height isEqualToString:@"yes"])
    {
        CGRect frame = tableView.frame;
        frame.origin.y = frame.origin.y - lbltagbackground.frame.size.height;
        frame.size.height = frame.size.height+lbltagbackground.frame.size.height;
        tableView.frame = frame;
        filter_height =@"no";
        _defaultEditingTagControl.hidden = YES;
    }else{
           }
    btnImage1 = [UIImage imageNamed:@"radio-unchecked.png"];
    [btnSoldOnly setImage:btnImage1 forState:UIControlStateNormal];
    [btnOpenOnly setImage:btnImage1 forState:UIControlStateNormal];
}
-(void)getList:(NSString*)status
{
    if(count==0)
    {
        [kappDelegate ShowIndicator];
        count++;
    }
    
    
    
    NSMutableURLRequest *request ;
    NSString*_postData ;
    
    _postData = [NSString stringWithFormat:@""];
    
    NSString *user_id = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"l_userid"]];
    NSLog(@"%@",user_id);
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/referrals/%@/statusType/%@",Kwebservices,user_id,status]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
    
    NSLog(@"%@",request);
    
    NSLog(@"data post >>> %@",_postData);
    
    [request setHTTPMethod:@"GET"];
    [request addValue:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"UserToken"]] forHTTPHeaderField:@"token"];
    [request setHTTPBody: [_postData dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
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
#pragma mark - Connection Delegates

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"Received Response");
    [webData setLength: 0];
    
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
    NSLog(@"response status code: %ld", (long)[httpResponse statusCode]);
    
    if((long)[httpResponse statusCode] == ResultOk)
    {
        NSLog(@"Received Response");
        [webData setLength: 0];
        response_status = @"passed";
        btnFilter.userInteractionEnabled=YES;
        btnSort.userInteractionEnabled = YES;
        
    }else if ((long)[httpResponse statusCode] == ResultFailed)
    {
        response_status = @"failed";
        
    }else if ((long)[httpResponse statusCode] == 404)
    {
        btnFilter.userInteractionEnabled=NO;
        btnSort.userInteractionEnabled = NO;
        
    }
        
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [kappDelegate HideIndicator];
    
    
    if ([[NSString stringWithFormat:@"%@",error] rangeOfString:@"The Internet connection appears to be offline." options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        [HelperAlert  alertWithOneBtn:@"ERROR" description:@"The Internet connection appears to be offline." okBtn:OkButtonTitle];
        return;
    }
    if ([[NSString stringWithFormat:@"%@",error] rangeOfString:@"The network connection was lost" options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        [HelperAlert  alertWithOneBtn:@"ERROR" description:@"The network connection was lost" okBtn:OkButtonTitle];
        return;
    }
    if ([[NSString stringWithFormat:@"%@",error] rangeOfString:@"Could not connect to the server" options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        [HelperAlert  alertWithOneBtn:@"ERROR" description:@"Internet connection lost. Could not connect to the server" okBtn:OkButtonTitle];
        return;
    }
    
    if ([[NSString stringWithFormat:@"%@",error] rangeOfString:@"The request timed out" options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        [HelperAlert  alertWithOneBtn:@"ERROR" description:@"The request timed out. Not able to connect to server" okBtn:OkButtonTitle];
        return;
    }
    [HelperAlert  alertWithOneBtn:@"ERROR" description:@"Intenet connection failed.. Try again later." okBtn:OkButtonTitle];
    NSLog(@"ERROR with the Connection ");
    webData =nil;
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data1
{
    [webData appendData:data1];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
        NSLog(@"DONE. Received Bytes: %lu", (unsigned long)[webData length]);
    
    if ([webData length]==0)
        return;
    
    NSString *responseString = [[NSString alloc] initWithData:webData encoding:NSUTF8StringEncoding];
    NSLog(@"responseString:%@",responseString);
       NSError *error;
if([response_status isEqualToString:@"passed"])
{
    
    if ([responseString rangeOfString:@"An error has occurred" options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        [HelperAlert alertWithOneBtn:AlertTitle description:@"Not able to get data" okBtn:OkButtonTitle];
       

    }
    if ([responseString rangeOfString:@"Not Found" options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        [HelperAlert alertWithOneBtn:AlertTitle description:@"There is no data to display"okBtn:OkButtonTitle];

        
       pop_out = @"yes";
        [tableView reloadData];
        return;
    }
    SBJsonParser *json = [[SBJsonParser alloc] init];
    NSMutableDictionary *userDetailDict=[json objectWithString:responseString error:&error];
    
    if([response_status isEqualToString:@"passed"])
    {
        
        if (userDetailDict.count<1) {
             [HelperAlert alertWithOneBtn:AlertTitle description:@"No referrals to display yet. Start submitting some referrals."  okBtn:OkButtonTitle withTag:2 forController:self];

//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:AlertTitle  message:@"No referrals to display yet. Start submitting some referrals." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//            
//            alert.tag=2;
//            [alert show];
            
            
             [kappDelegate HideIndicator];
            return;
        }
        
        
        lblheadingView.text = [NSString stringWithFormat:@"%@ (%lu)",_headerstr,(unsigned long)userDetailDict.count];
        if(userDetailDict.count==0)
        {
            btnFilter.userInteractionEnabled=NO;
            btnSort.userInteractionEnabled = NO;
        }else{
            btnFilter.userInteractionEnabled=YES;
            btnSort.userInteractionEnabled = YES;
        }
        referralListArray = [[NSMutableArray alloc] init];
        for (int i=0; i<userDetailDict.count; i++)
        {
            obj = [[ReferralObj alloc] init];
            obj.first_name = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"FirstName"]objectAtIndex:i]];
            obj.last_name = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"LastName"]objectAtIndex:i]];
            obj.email = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"Email"]objectAtIndex:i]];
            if([NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"PhoneNumber"]objectAtIndex:i]].length==6)
            {
                obj.phone_no = @" ";
            }else{
                obj.phone_no = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"PhoneNumber"]objectAtIndex:i]];
            }
            obj.phone_no = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"PhoneNumber"]objectAtIndex:i]];
            obj.MEAid = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"MeaId"]objectAtIndex:i]];
            obj.comments=[NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"Comments"]objectAtIndex:i]];
            obj.createDate = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"CreatedDate"]objectAtIndex:i]];
            obj.referralID = [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"ReferralId"]objectAtIndex:i]]];
            obj.ReferralStatus = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"ReferralStatus"]objectAtIndex:i]];
            obj.ReferrerEmail = [NSString stringWithFormat:@"%@",[[userDetailDict   valueForKey:@"ReferrerEmail"]objectAtIndex:i]];
            obj.ReferrerID = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"ReferrerID"]objectAtIndex:i]];
            obj.ReferrerName = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"ReferrerName"]objectAtIndex:i]];
            obj.ReferrerUserName = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"ReferrerUserName"]objectAtIndex:i]];
            obj.SoldDate = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"SoldDate"]objectAtIndex:i]];
            obj.UniqueReferralNumber = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"UniqueReferralNumber"]objectAtIndex:i]];
            obj.UserDetailId = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"UserDetailId"]objectAtIndex:i]];
            obj.MeaName = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"MeaName"]objectAtIndex:i]];
        obj.ReferralType = [NSString stringWithFormat:@"%@",[[userDetailDict valueForKey:@"ReferralType"]objectAtIndex:i]];
            obj.tag = [[userDetailDict valueForKey:@"FirstName"]objectAtIndex:i];
        
            [referralListArray addObject:obj];
        }
        
    
        if(referralListArray.count>0)
        {
    //--for sort option
    //(1)
            [self sortByName:referralListArray];
    //(2)
    // create the string array
            [self sortByDate:referralListArray];
    //--
    
    
    //---for filter options
            [self filterForSold:referralListArray];
    
            [self filterForOpen:referralListArray];
    //--
        }
        [tableView reloadData];
         [kappDelegate HideIndicator];
    }
}else{
    NSString *msg = @"No referrals to display yet. Start submitting some referrals.";
    
[HelperAlert alertWithOneBtn:AlertTitle description:msg  okBtn:OkButtonTitle withTag:2 forController:self];
//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:AlertTitle  message:msg delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//    
//    alert.tag=2;
//    [alert show];
 [kappDelegate HideIndicator];
}
   

}

@end
