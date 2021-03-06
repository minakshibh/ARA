
//
//  AppDelegate.m
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 10/08/15.
//  Copyright (c) 2015 Krishna_Mac_2. All rights reserved.
//

#import "AppDelegate.h"
#import "splashViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "LoginViewController.h"
#import "dashboardViewController.h"
#import "referralListViewController.h"
#import "RecoveryViewController.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Fabric with:@[[Crashlytics class]]];

    ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(nil, nil);
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined) {
        ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error) {
            if (granted) {
                //                picker.peoplePickerDelegate = self;
                //
                //                [self presentModalViewController:picker animated:YES];
                //                [picker setPeoplePickerDelegate:self];
                //                [picker setDisplayedProperties:[NSArray arrayWithObject:[NSNumber numberWithInt:kABPersonPhoneProperty]]];
            } else {
                // Show an alert here if user denies access telling that the contact cannot be added because you didn't allow it to access the contacts
            }
        });
    }else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized) {
        // If the user user has earlier provided the access, then add the contact
        //        picker.peoplePickerDelegate = self;
        //
        //        [self presentModalViewController:picker animated:YES];
        //        [picker setPeoplePickerDelegate:self];
        //        [picker setDisplayedProperties:[NSArray arrayWithObject:[NSNumber numberWithInt:kABPersonPhoneProperty]]];
    }
    else {
        // If the user user has NOT earlier provided the access, create an alert to tell the user to go to Settings app and allow access
//        NSString *msgStr = @"You've disabled access to contacts. To re-enable, please go to Settings and enable Contacts for AutoAves.";
        //        [HelperAlert alertWithOneBtn:AlertTitle description:msgStr okBtn:OkButtonTitle];
    }
//    for(NSString *fontfamilyname in [UIFont familyNames])
//    {
//        NSLog(@"Family:'%@'",fontfamilyname);
//    }
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"TITLE"];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"NETWORK_TITLE"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"APP_TITLE"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"REFERRAL_TITLE"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"myInvitationBtn"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"networkInvitationBtn"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"appInstallationBtn"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"networkReferralBtn"];
    @try {
//   [Crittercism enableWithAppID:@"56723ec36c33dc0f00f11469"];
    
    if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
        
        // If there's one, just open the session silently, without showing the user the login UI
        [FBSession openActiveSessionWithReadPermissions:@[@"public_profile"]
                                           allowLoginUI:NO
                                      completionHandler:^(FBSession *session, FBSessionState state, NSError *error) {
                                          // Handler for session state changes
                                          // Call this method EACH time the session state changes,
                                          //  NOT just when the session open
                                          [self sessionStateChanged:session state:state error:error];
                                      }];
    }

    //---setting root view controller
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    splashViewController *rootVC = [[splashViewController alloc]initWithNibName:@"splashViewController" bundle:nil];
    self.navigator = [[UINavigationController alloc] initWithRootViewController:rootVC];
    self.window.rootViewController = self.navigator;
    [self.window makeKeyAndVisible];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
    
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeAlert|UIUserNotificationTypeSound
                                                                                 categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    } else {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         UIRemoteNotificationTypeBadge |
         UIRemoteNotificationTypeAlert |
         UIRemoteNotificationTypeSound];
        
    }
#else
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     UIRemoteNotificationTypeBadge |
     UIRemoteNotificationTypeAlert |
     UIRemoteNotificationTypeSound];
    
#endif
  
//#ifdef __IPHONE_8_0
//    //Right, that is the point
//    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound) categories:nil];
//    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
//#else
//    //register to receive notifications
//    UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
//    
//    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
//#endif
       
    return YES;
    } @catch (NSException *exception) {
        NSLog(@"%@", exception.reason);
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"App Delegate 1" message:[NSString stringWithFormat:@"%@",exception.reason] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];

    }@finally {
        
    }
    

}
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {

    @try {
   
//    if (notificationSettings.types != UIUserNotificationTypeNone) {
//        NSLog(@"didRegisterUser");
        [application registerForRemoteNotifications];
//    }
        
    }@catch (NSException *exception) {
        NSLog(@"%@", exception.reason);
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:AlertTitle message:[NSString stringWithFormat:@"%@",exception.reason] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        
    }@finally {
        
    }
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken: (NSData *)_deviceToken
{
    @try {
     
    // Get a hex string from the device token with no spaces or < >
    NSString*deviceToken = [[[[_deviceToken description] stringByReplacingOccurrencesOfString:@"<"withString:@""]
                             stringByReplacingOccurrencesOfString:@">" withString:@""]
                            stringByReplacingOccurrencesOfString: @" " withString: @""];
    NSLog(@"Device Token: %@", deviceToken);
    

    [[NSUserDefaults standardUserDefaults ]removeObjectForKey:@"deviceToken"];
    [[NSUserDefaults standardUserDefaults]setValue:deviceToken forKey:@"deviceToken"];
    }@catch (NSException *exception) {
        NSLog(@"%@", exception.reason);
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:AlertTitle message:[NSString stringWithFormat:@"%@",exception.reason] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        
    }@finally {
        
    }
    
    
}

-(void) application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void
                                                                                                                               (^)(UIBackgroundFetchResult))completionHandler
{
    NSArray *array = [userInfo valueForKey:@"aps"];
    NSString *noti_msg = [array valueForKey:@"alert"];

    [HelperAlert alertWithOneBtn:AlertTitle description:noti_msg okBtn:OkButtonTitle];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {

    NSLog(@"Error in registration. Error: %@", error);
}

#pragma mark- OPENURL
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
//    NSArray *appName = [[NSString stringWithFormat:@"%@",url] componentsSeparatedByString:@":"];
//    NSString *appNameStr = [NSString stringWithFormat:@"%@",[appName objectAtIndex:0]];
    
    if ([[url scheme] isEqualToString:@"autoaves"])
    {
    // NSString *customURL = @"iOSDevTips://?token=123abct&registered=1";
    NSLog(@"Calling Application Bundle ID: %@", sourceApplication);
    NSLog(@"URL scheme:%@", [url scheme]);
    NSLog(@"URL query: %@", [url query]);
        
//    NSArray *token = [[NSString stringWithFormat:@"%@",[url query]] componentsSeparatedByString:@"="];
//        NSString *tokenStr = [NSString stringWithFormat:@"%@",[token objectAtIndex:1]];
//        if (!(token.count>0) || (tokenStr.length < 4)) {
//            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"AutoAves" message:@"Link is not correct." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//            [alert show];
//            
////            LoginViewController *loginVC = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
////            [self.navigator pushViewController:loginVC animated:YES];
//            
//            self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//            LoginViewController *loginVC = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
//            self.navigator = [[UINavigationController alloc] initWithRootViewController:loginVC];
//            self.window.rootViewController = self.navigator;
//            [self.window makeKeyAndVisible];
//            
//            
//            return YES;
//        }
//    
//        RecoveryViewController *obj = [[RecoveryViewController alloc]initWithNibName:@"RecoveryViewController" bundle:nil];
//        obj.guid = tokenStr;
//        [self.navigator pushViewController:obj animated:YES];
        
        
        
//        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//         RecoveryViewController *recoveryVC = [[RecoveryViewController alloc]initWithNibName:@"RecoveryViewController" bundle:nil];
//        recoveryVC.guid = tokenStr;
//        self.navigator = [[UINavigationController alloc] initWithRootViewController:recoveryVC];
//        self.navigator.navigationBarHidden = YES;
//        self.window.rootViewController = self.navigator;
//        [self.window makeKeyAndVisible];
        
//    RecoveryViewController *recoveryVC = [[RecoveryViewController alloc]initWithNibName:@"RecoveryViewController" bundle:nil];
//        recoveryVC.guid = tokenStr;
//    [self.navigator pushViewController:recoveryVC animated:YES];
        
    return YES;
    }
    
    return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
}
- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error
{
    @try {
      
    // If the session was opened successfully
    if (!error && state == FBSessionStateOpen){
        
        
        
        NSLog(@"Session opened Dont show the login screen");
        // Show the user the logged-in UI
        // [self userLoggedIn];
        return;
    }
    if (state == FBSessionStateClosed || state == FBSessionStateClosedLoginFailed){
        // If the session is closed
        NSLog(@"Session closed and user is logged out");
        
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
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"profile_picture"];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"savedImageURL"];
        LoginViewController *LIvc = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
         NSLog(@"-----facebook------");
        [self.navigator pushViewController:LIvc animated:YES];
        // Show the user the logged-out UI
        // [self userLoggedOut];
    }
    
    // Handle errors
    if (error){
        NSLog(@"Error");
        NSString *alertText;
        NSString *alertTitle;
        // If the error requires people using an app to make an action outside of the app in order to recover
        if ([FBErrorUtility shouldNotifyUserForError:error] == YES){
            alertTitle = @"Something went wrong";
            alertText = [FBErrorUtility userMessageForError:error];
            //[self showMessage:alertText withTitle:alertTitle];
        } else {
            
            // If the user cancelled login, do nothing
            if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
                NSLog(@"User cancelled login");
                
                // Handle session closures that happen outside of the app
            } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession){
                alertTitle = @"Session Error";
                alertText = @"Your current session is no longer valid. Please log in again.";
                // [self showMessage:alertText withTitle:alertTitle];
                
                // Here we will handle all other errors with a generic error message.
                // We recommend you check our Handling Errors guide for more information
                // https://developers.facebook.com/docs/ios/errors/
            } else {
                //Get more error information from the error
                NSDictionary *errorInformation = [[[error.userInfo objectForKey:@"com.facebook.sdk:ParsedJSONResponseKey"] objectForKey:@"body"] objectForKey:@"error"];
                
                // Show the user an error message
                alertTitle = @"Something went wrong";
                alertText = [NSString stringWithFormat:@"Please retry. \n\n If the problem persists contact us and mention this error code: %@", [errorInformation objectForKey:@"message"]];
                //[self showMessage:alertText withTitle:alertTitle];
            }
        }
        // Clear this token
        [FBSession.activeSession closeAndClearTokenInformation];
        // Show the user the logged-out UI
        //[self userLoggedOut];
    }
    }@catch (NSException *exception) {
        NSLog(@"%@", exception.reason);
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"App Delegate 1" message:[NSString stringWithFormat:@"%@",exception.reason] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        
    }@finally {
        
    }
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[NSUserDefaults standardUserDefaults] synchronize];
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    application.applicationIconBadgeNumber = 0;
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#pragma mark - Show Indicator

-(void)ShowIndicator
{
    activityIndicatorObject = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    if (IS_IPHONE_5 )
    {
        activityIndicatorObject.center = CGPointMake(self.window.frame.size.width/2, self.window.frame.size.height/2);
        DisableView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.window.frame.size.width,self.window.frame.size.height)];
        
    }
    else if (IS_IPHONE_4_OR_LESS )
    {
        activityIndicatorObject.center = CGPointMake(self.window.frame.size.width/2, self.window.frame.size.height/2);
        DisableView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.window.frame.size.width, self.window.frame.size.height)];
        
    }
    else if (IS_IPHONE_6)
    {
        activityIndicatorObject.center = CGPointMake(self.window.frame.size.width/2, self.window.frame.size.height/2);
        DisableView=[[UIView alloc] initWithFrame:CGRectMake( 0, 0, self.window.frame.size.width, self.window.frame.size.height)];
        
    }
    else if(IS_IPHONE_6P)
    {
        activityIndicatorObject.center = CGPointMake(self.window.frame.size.width/2, self.window.frame.size.height/2);
        DisableView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.window.frame.size.width, self.window.frame.size.height)];
        
    }
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        activityIndicatorObject.center = CGPointMake(self.window.frame.size.width/2, self.window.frame.size.height/2);
        DisableView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.window.frame.size.width, self.window.frame.size.height)];
    }
    
    DisableView.backgroundColor=[UIColor blackColor];
    DisableView.alpha=0.5;
    [self.window addSubview:DisableView];
    activityIndicatorObject.color=[UIColor grayColor];
    [DisableView addSubview:activityIndicatorObject];
    [activityIndicatorObject startAnimating];
}

#pragma mark - Hide Indicator

-(void)HideIndicator
{
    [activityIndicatorObject stopAnimating];
    [DisableView removeFromSuperview];
    
}

@end
