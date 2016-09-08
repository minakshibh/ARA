//
//  showProfileImageViewController.h
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 04/09/15.
//  Copyright (c) 2015 Krishna_Mac_2. All rights reserved.
//

#import "ViewController.h"
#import "AFHTTPRequestOperation.h"
@interface showProfileImageViewController : ViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>
{
    
    IBOutlet UIImageView *imageViewProfile;
    IBOutlet UIButton *btnProfile;
    IBOutlet UILabel *lblheading;
    NSData *imagedata;UIImage *img ;
    IBOutlet UIButton *btnCancel;
}
- (IBAction)btnCancel:(id)sender;
- (IBAction)btnEdit:(id)sender;
- (IBAction)btnProfile:(id)sender;
@property (nonatomic, strong) UIPopoverController *popoverImageViewController;
@property (strong, nonatomic) AFHTTPRequestOperation *op;

@end
