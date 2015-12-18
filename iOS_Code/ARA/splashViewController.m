 //
//  splashViewController.m
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 08/09/15.
//  Copyright (c) 2015 Krishna_Mac_2. All rights reserved.
//

#import "splashViewController.h"
#import "LoginViewController.h"
#import "dashboardViewController.h"
#import <Crittercism/Crittercism.h>

@interface splashViewController ()

@end
@class AppDelegate;

@implementation splashViewController
@synthesize title,titlelbl,mainImageView,gratArchievArray;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//
//    NSDate *date1 = [NSDate date];
//    NSDateFormatter* formatter1 = [[NSDateFormatter alloc] init] ;
//    [formatter1 setDateFormat:@"yyyy-MM-dd"];
//    NSString*todaysDate = [formatter1 stringFromDate:date1];
//    NSUserDefaults * value = [NSUserDefaults standardUserDefaults];
//    
//    autoArchieve=[value valueForKey:@"autoArchieve"];
//    keepHistry=[value valueForKey:@"keepArchieveHisty"];
//    autoArchieveDate =[value valueForKey: @"autoArchivDate" ];
//    emailid=[value valueForKey:@"Emailid"];
//
//
//
    @try {
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        appDelegate.navigator.navigationBarHidden = YES;
    }
    @catch (NSException *exception) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Splash-1" message:[NSString stringWithFormat:@"%@",exception.reason] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];

    }
    @finally {
        
    }
   
    

//
//    NSArray *animationArray = [NSArray arrayWithObjects:[UIImage imageNamed:@"1.jpg"],[UIImage imageNamed:@"1.jpg"],[UIImage imageNamed:@"1.jpg"],[UIImage imageNamed:@"1.jpg"],[UIImage imageNamed:@"2.jpg"],[UIImage imageNamed:@"3.jpg"],[UIImage imageNamed:@"4.jpg"],[UIImage imageNamed:@"5.jpg"],[UIImage imageNamed:@"6.jpg"],[UIImage imageNamed:@"7.jpg"],[UIImage imageNamed:@"8.jpg"],[UIImage imageNamed:@"9.jpg"],[UIImage imageNamed:@"10.jpg"], [UIImage imageNamed:@"11.jpg"],[UIImage imageNamed:@"12.jpg"], [UIImage imageNamed:@"13.jpg"],[UIImage imageNamed:@"14.jpg"],[UIImage imageNamed:@"14.jpg"],[UIImage imageNamed:@"14.jpg"],[UIImage imageNamed:@"14.jpg"],[UIImage imageNamed:@"14.jpg"],[UIImage imageNamed:@"14.jpg"],[UIImage imageNamed:@"14.jpg"],[UIImage imageNamed:@"14.jpg"],[UIImage imageNamed:@"14.jpg"],[UIImage imageNamed:@"14.jpg"],[UIImage imageNamed:@"14.jpg"],[UIImage imageNamed:@"14.jpg"],[UIImage imageNamed:@"14.jpg"],[UIImage imageNamed:@"14.jpg"],[UIImage imageNamed:@"14.jpg"],[UIImage imageNamed:@"14.jpg"],nil];
//    NSLog(@"%f",[[UIScreen mainScreen] bounds].size.height);
//    if ([[UIScreen mainScreen] bounds].size.height == 568) {
//        
//        [titlelbl setFont: [UIFont fontWithName:@"Helvetica Neue" size:30]];
//        
//        mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(36, 225, 244, 117)];
//        //this is iphone 5 xib
//    }
//    else if([[UIScreen mainScreen] bounds].size.height == 480) {
//        [titlelbl setFont: [UIFont fontWithName:@"Helvetica Neue" size:30]];
//        
//        mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(36, 190, 244, 99)];
//        // this is iphone 4 xib
//    }
//    else if([[UIScreen mainScreen] bounds].size.height == 667)
//    {
//        [titlelbl setFont: [UIFont fontWithName:@"Helvetica Neue" size:30]];
//        
//        mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(42, 264, 286, 138)];
//     // this is iphone 6 xib
//    }
//    else if([[UIScreen mainScreen] bounds].size.height == 736){
//        [titlelbl setFont: [UIFont fontWithName:@"Helvetica Neue" size:85]];
//        mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(46, 291,316, 152)];
//        // this is iphone 6+ xib
//    }
//     mainImageView.contentMode=UIViewContentModeScaleAspectFit;
//    //[NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(crossfade) userInfo:nil repeats:YES];
//    mainImageView.animationImages = animationArray;
//    mainImageView.animationDuration = 2.5f; //mainImageView is instance of UIImageView
//    mainImageView.animationRepeatCount = 0;
//    [mainImageView startAnimating];
//    [self.view addSubview:mainImageView];
//    
//    //    CABasicAnimation *crossFade = [CABasicAnimation animationWithKeyPath:@"contents"];
//    //    crossFade.autoreverses = YES;
//    //    crossFade.repeatCount = 0;
//    //    crossFade.duration = 0.1;
//    
//   
//    
//
    @try {
    
    int d = 0; // standard display
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2.0) {
        d = 1; // is retina display
    }

    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        d += 2;
    }
    
    if (d==0) {
        imageView.image = [UIImage imageNamed:@"AutoAves Splash_320.jpg"];
    }
    if (d==1) {
        imageView.image = [UIImage imageNamed:@"AutoAves Splash_320@2x.jpg"];
    }
    if (d==2) {
        imageView.image = [UIImage imageNamed:@"AutoAves Splash_320~ipad.jpg"];
    }
    if (d==3) {
        imageView.image = [UIImage imageNamed:@"AutoAves Splash_320@2x~ipad.jpg"];
    }

    }@catch (NSException *exception) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Splash-2" message:[NSString stringWithFormat:@"%@",exception.reason] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    @finally {
        
    }
    
    
    @try {
        
    [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(presentnextView) userInfo:nil repeats:NO];
    [super viewDidLoad];
   
  
    }@catch (NSException *exception) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Splash-3" message:[NSString stringWithFormat:@"%@",exception.reason] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    @finally {
        
    }

}
-(void)presentnextView
{
    
    @try {
       //--check for user already loggedin
    NSUserDefaults *user123 = [NSUserDefaults standardUserDefaults];
    NSString *already_logged_in = [NSString stringWithFormat:@"%@",[user123 valueForKey:@"l_loggedin"]];
    
    if([already_logged_in isEqualToString:@"yes"])
    {

        dashboardViewController *obj = [[dashboardViewController alloc]initWithNibName:@"dashboardViewController" bundle:nil];
        [self.navigationController pushViewController:obj animated:NO];
        return;
    }
    
    }@catch (NSException *exception) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Splash-4" message:[NSString stringWithFormat:@"%@",exception.reason] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    @finally {
        
    }
    

    @try {
   
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSUserDefaults * value = [NSUserDefaults standardUserDefaults];
    NSString *myString = [value objectForKey:@"preferedDate"];
    
    if(myString==nil)
        myString=@"";
    

    LoginViewController *home;
    home = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    //this is iphone 5 xib
        
    [self.navigationController pushViewController:home animated:YES];
    }@catch (NSException *exception) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Splash-5" message:[NSString stringWithFormat:@"%@",exception.reason] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    @finally {
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

@end
