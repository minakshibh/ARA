//
//  showProfileImageViewController.h
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 04/09/15.
//  Copyright (c) 2015 Krishna_Mac_2. All rights reserved.
//

#import "ViewController.h"

@interface showProfileImageViewController : ViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>
{
    
    IBOutlet UIImageView *imageViewProfile;
    NSData *imagedata;
}
- (IBAction)btnEdit:(id)sender;
- (IBAction)btnProfile:(id)sender;

@end
