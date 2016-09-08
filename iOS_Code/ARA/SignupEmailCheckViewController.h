//
//  SignupEmailCheckViewController.h
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 29/12/15.
//  Copyright © 2015 Krishna_Mac_2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignupEmailCheckViewController : UIViewController<UITextFieldDelegate,UIGestureRecognizerDelegate>
{
    IBOutlet UILabel *lblComposeyourprofile;
    IBOutlet UILabel *lblEnteremailaddress;
    CGPoint svos;
    IBOutlet UIImageView *imageViewDisablestep2;
    IBOutlet UIImageView * icon;
}
@end
