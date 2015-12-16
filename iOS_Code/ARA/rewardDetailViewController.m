//
//  rewardDetailViewController.m
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 16/09/15.
//  Copyright (c) 2015 Krishna_Mac_2. All rights reserved.
//

#import "rewardDetailViewController.h"
#import "referralDetailViewController.h"

@interface rewardDetailViewController ()

@end

@implementation rewardDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    lblRewardAmount.text = [NSString stringWithFormat:@"$%@",_obj.RewardAmount];
    lblRewardDescription.text = _obj.RewardDescription;
    lblRewardlevel.text = _obj.Rewardlevel;
    lblRewardName.text = _obj.RewardName;
    lblRewardType.text = _obj.RewardType;
    
    if([_obj.IsReceived isEqualToString:@"1"])
    {
        lblTransactionID.text = _obj.TransactionID;
        lblHeading.text = @"PAYMENT EARNED";

    }else{
        lblTransactionID.hidden = YES;
        lblTransactionIDpartition.hidden = YES;
        lblTransactionIDtxt.hidden = YES;
        lblHeading.text = @"PAYMENT UPCOMING";

    }
    lblReferralID.text = _obj.UniqueReferralNumber;
    // Do any additional setup after loading the view from its nib.
    
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
    
    
    if (IS_IPAD)
    {
        lblHeading.font=[lblHeading.font fontWithSize:24];
        
        lblrewardAmount.font=[lblrewardAmount.font fontWithSize:24];

        lblrewarddesc.font=[lblrewarddesc.font fontWithSize:24];

        lblrewardname.font=[lblrewardname.font fontWithSize:24];
        lblrewardtype.font=[lblrewardtype.font fontWithSize:24];
        lblrewardlevel.font=[lblrewardlevel.font fontWithSize:24];
        lblReferralId.font=[lblReferralId.font fontWithSize:24];
        lblTransitionid.font=[lblTransitionid.font fontWithSize:24];
        
        
        lblRewardAmount.font=[lblRewardAmount.font fontWithSize:24];
        lblRewardDescription.font=[lblRewardDescription.font fontWithSize:24];
        lblRewardName.font=[lblRewardName.font fontWithSize:24];
        lblRewardType.font=[lblRewardType.font fontWithSize:24];
        lblRewardlevel.font=[lblRewardlevel.font fontWithSize:24];
        lblReferralID.font=[lblReferralID.font fontWithSize:24];
        lblTransactionID.font=[lblTransactionID.font fontWithSize:24];
        lblRewardAmount.font=[lblRewardAmount.font fontWithSize:24];
        btnreferraldetails.titleLabel.font=[btnBack.titleLabel.font fontWithSize:24];
        
        btnBack.titleLabel.font=[btnBack.titleLabel.font fontWithSize:24];
        if(IS_IPAD_PRO_1366)
        {
            lblHeading.font=[lblHeading.font fontWithSize:30];
            
            lblrewardAmount.font=[lblrewardAmount.font fontWithSize:30];
            
            lblrewarddesc.font=[lblrewarddesc.font fontWithSize:30];
            
            lblrewardname.font=[lblrewardname.font fontWithSize:30];
            lblrewardtype.font=[lblrewardtype.font fontWithSize:30];
            lblrewardlevel.font=[lblrewardlevel.font fontWithSize:30];
            lblReferralId.font=[lblReferralId.font fontWithSize:30];
            lblTransitionid.font=[lblTransitionid.font fontWithSize:30];
            
            
            lblRewardAmount.font=[lblRewardAmount.font fontWithSize:30];
            lblRewardDescription.font=[lblRewardDescription.font fontWithSize:30];
            lblRewardName.font=[lblRewardName.font fontWithSize:30];
            lblRewardType.font=[lblRewardType.font fontWithSize:30];
            lblRewardlevel.font=[lblRewardlevel.font fontWithSize:30];
            lblReferralID.font=[lblReferralID.font fontWithSize:30];
            lblTransactionID.font=[lblTransactionID.font fontWithSize:30];
            lblRewardAmount.font=[lblRewardAmount.font fontWithSize:30];
            btnreferraldetails.titleLabel.font=[btnBack.titleLabel.font fontWithSize:30];
            
            btnBack.titleLabel.font=[btnBack.titleLabel.font fontWithSize:30];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - Buttons
- (IBAction)btnBack:(id)sender {
    [self.navigationController popViewControllerAnimated: YES];
}

- (IBAction)btnReferrarDetail:(id)sender {
    referralDetailViewController *RDvc = [[referralDetailViewController alloc]initWithNibName:@"referralDetailViewController" bundle:nil];
    RDvc.from_RewardList = @"yes";
    RDvc.obj = _obj;
    [self.navigationController pushViewController:RDvc animated:YES];
}
@end
