//
//  AboutAppViewController.h
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 27/11/15.
//  Copyright © 2015 Krishna_Mac_2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutAppViewController : UIViewController
{
       IBOutlet UIImageView *headerImage;
    IBOutlet UILabel *btnheading;
    IBOutlet UIButton *btnback;
    IBOutlet UILabel *BUILDSIZE;
    IBOutlet UILabel *build;
    IBOutlet UILabel *BUILDVERSION;
    IBOutlet UILabel *buildName;
    IBOutlet UILabel *buildVersion;
    IBOutlet UILabel *buildSize;
}
- (IBAction)btnBack:(id)sender;
@end
