//
//  AppDelegate.h
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 10/08/15.
//  Copyright (c) 2015 Krishna_Mac_2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UIActivityIndicatorView *activityIndicatorObject;
    UIView  *DisableView;
    NSString *errorMessage;
    
}
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navigator;

-(void)ShowIndicator;
-(void)HideIndicator;
+(void)fixHeightOfThisLabel:(UILabel *)aLabel;
@end

