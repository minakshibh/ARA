//
//  showProfileImageViewController.m
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 04/09/15.
//  Copyright (c) 2015 Krishna_Mac_2. All rights reserved.
//

#import "showProfileImageViewController.h"
#import "JSON.h"
#import "SBJson.h"
#import "AFHTTPRequestOperationManager.h"
#import "ASIHTTPRequest.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImageView+WebCache.h"
#import "SDImageCache.h"

#import "JTSImageViewController.h"
#import "JTSImageInfo.h"

#define TRY_AN_ANIMATED_GIF 0
//#import "UIView+Toast.h"
@interface showProfileImageViewController ()

@end

@implementation showProfileImageViewController

- (void)viewDidLoad {
    
//    [NSTimer scheduledTimerWithTimeInterval:10
//                                     target:self
//                                   selector:@selector(targetMethod1:)
//                                   userInfo:nil
//                                    repeats:NO];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    //imageViewProfile.image = [UIImage imageNamed:@"dummy-user-img.png"];
    
    [super viewDidLoad];
    
    imagestr = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"l_image"]];//profile_picture           //l_image
    
    
    NSLog(@"image url %@",imagestr);
    [imageViewProfile sd_setImageWithURL:[NSURL URLWithString:imagestr]];
    
    
    imageViewProfile.contentMode=UIViewContentModeScaleAspectFit;
    
        [self.view endEditing:YES];
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:nil
                                      delegate:self
    cancelButtonTitle:@"Cancel"
    destructiveButtonTitle:@"Photo Library"
    otherButtonTitles:@"Camera",nil];
    
        actionSheet.actionSheetStyle = UIBarStyleBlackTranslucent;
        [actionSheet showInView:self.view];
    
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
//        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imagestr]];
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            // Update the UI
//            imageViewProfile.image = [UIImage imageWithData:imageData];
//        });
//    });
    
//    [imageViewProfile sd_setImageWithURL:[NSURL URLWithString:imagestr]
//                    placeholderImage:nil];
   
    // Do any additional setup after loading the view from its nib.
    if (IS_IPAD )
    {
        lblheading.font=[lblheading.font fontWithSize:24];
        
        btnProfile.titleLabel.font = [btnProfile.titleLabel.font fontWithSize:24];

        if(IS_IPAD_PRO_1366)
        {
            lblheading.font=[lblheading.font fontWithSize:30];
            
            btnProfile.titleLabel.font = [btnProfile.titleLabel.font fontWithSize:30];
        }
    }
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] init];
    [tapRecognizer addTarget:self action:@selector(bigButtonTapped:)];
    [imageViewProfile addGestureRecognizer:tapRecognizer];
   
}
- (void)bigButtonTapped:(id)sender {
    
    // Create image info
    
    NSString *empty = @"<null>";
    
    if (imagestr != nil ) {
        
        if (![imagestr isEqual:empty]){

    JTSImageInfo *imageInfo = [[JTSImageInfo alloc] init];
#if TRY_AN_ANIMATED_GIF == 1
    imageInfo.imageURL = [NSURL URLWithString:@"http://media.giphy.com/media/O3QpFiN97YjJu/giphy.gif"];
#else
    imageInfo.image = imageViewProfile.image;
#endif
    imageInfo.referenceRect = imageViewProfile.frame;
    imageInfo.referenceView = imageViewProfile.superview;
    imageInfo.referenceContentMode = imageViewProfile.contentMode;
    imageInfo.referenceCornerRadius = imageViewProfile.layer.cornerRadius;
    
    // Setup view controller
    JTSImageViewController *imageViewer = [[JTSImageViewController alloc]
                                           initWithImageInfo:imageInfo
                                           mode:JTSImageViewControllerMode_Image
                                           backgroundStyle:JTSImageViewControllerBackgroundOption_Scaled];
    
    // Present the view controller.
    [imageViewer showFromViewController:self transition:JTSImageViewControllerTransition_FromOriginalPosition];
        }
    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return imageViewProfile;
}
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
}

-(void)targetMethod1:(NSTimer *)timer
{
//    NSData * im = [[NSUserDefaults standardUserDefaults]valueForKey:@"profile_picture"];//l_image    //profile_picture
//    
//    imageViewProfile.image = [UIImage imageWithData:im];
//    imageViewProfile.contentMode=UIViewContentModeScaleAspectFit;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    SDImageCache *imageCache = [SDImageCache sharedImageCache];
    [imageCache clearMemory];
    [imageCache clearDisk];
}

#pragma  mark - buttons
- (IBAction)btnCancel:(id)sender {
    AFHTTPRequestOperationManager *manager ;
    [manager.operationQueue cancelAllOperations];
    NSLog(@"Cancelled------------");
   
}

- (IBAction)btnEdit:(id)sender {
    [self.view endEditing:YES];
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  destructiveButtonTitle:@"Photo Library"
                                  otherButtonTitles:@"Camera",nil];
    actionSheet.actionSheetStyle = UIBarStyleBlackTranslucent;
    [actionSheet showInView:self.view];

}

- (IBAction)btnProfile:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma  mark - ActionSheet Delegates
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex;  // after animation
{
    if (buttonIndex == 1)
    {
        UIImagePickerController * picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker
                           animated:YES completion:nil];
    }
    if (buttonIndex==0)
    {
        UIImagePickerController * picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        //        [self presentViewController:picker animated:YES completion:nil];
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:picker];
            [popover presentPopoverFromRect:btnProfile.bounds inView:imageViewProfile permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
           // self.popoverImageViewController = popover;
        } else {
            
            [self presentViewController:picker animated:YES completion:nil];
        }
    }

}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        UIImagePickerController * picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker
                           animated:YES completion:nil];
    }
    if (buttonIndex==0)
    {
        UIImagePickerController * picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//        [self presentViewController:picker animated:YES completion:nil];
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:picker];
            [popover presentPopoverFromRect:imageViewProfile.bounds inView:imageViewProfile permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
            self.popoverImageViewController = popover;
        } else {
            [self presentModalViewController:picker animated:YES];
        }
    }
    
}
#pragma mark - Image Picker Delegates

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info

{
    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    imageViewProfile.image = chosenImage;
    
    float actualHeight = chosenImage.size.height;
    float actualWidth = chosenImage.size.width;
    float maxHeight = 600.0;
    float maxWidth = 800.0;
    float imgRatio = actualWidth/actualHeight;
    float maxRatio = maxWidth/maxHeight;
    float compressionQuality = 1.0;//50 percent compression
    
    if (actualHeight > maxHeight || actualWidth > maxWidth){
        if(imgRatio < maxRatio){
            //adjust width according to maxHeight
            imgRatio = maxHeight / actualHeight;
            actualWidth = imgRatio * actualWidth;
            actualHeight = maxHeight;
        }
        else if(imgRatio > maxRatio){
            //adjust height according to maxWidth
            imgRatio = maxWidth / actualWidth;
            actualHeight = imgRatio * actualHeight;
            actualWidth = maxWidth;
        }
        else{
            actualHeight = maxHeight;
            actualWidth = maxWidth;
        }
    }
    
    CGRect rect = CGRectMake(0.0, 0.0, actualWidth, actualHeight);
    UIGraphicsBeginImageContext(rect.size);
    [chosenImage drawInRect:rect];
    img = UIGraphicsGetImageFromCurrentImageContext();
    
    imagedata = UIImageJPEGRepresentation(img, compressionQuality);
    UIGraphicsEndImageContext();
    [picker dismissViewControllerAnimated:YES completion:NULL];
    [self imageUpload];
    
}
+ (UIImage*)resizeImageWithImage: (UIImage*) sourceImage scaledToWidth: (float) i_width
{
    
    float oldWidth = sourceImage.size.width;
    float scaleFactor = i_width / oldWidth;
    
    float newHeight = sourceImage.size.height * scaleFactor;
    float newWidth = oldWidth * scaleFactor;
    
    CGSize newSize = CGSizeMake(newWidth, newHeight);
    UIGraphicsBeginImageContext(newSize);
    [sourceImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
 //   [self.view makeToast:@"Operation canceled"];
    [picker dismissViewControllerAnimated:YES completion:NULL];
}
-(void)imageUpload
{
    [kappDelegate ShowIndicator];
    [self.view bringSubviewToFront:btnCancel];
    
    NSString *imagePostUrl = [NSString stringWithFormat:@"%@/users/%@/profilepic",Kwebservices,[[NSUserDefaults standardUserDefaults] valueForKey:@"l_userid"]];
    //http://69.164.149.164:801/api/users/151/profilepic

    NSString *fileName = [NSString stringWithFormat:@"profilePic%ld%c%c.png", (long)[[NSDate date] timeIntervalSince1970], arc4random_uniform(26) + 'a', arc4random_uniform(26) + 'a'];
    
    
   // AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://server.url"]];
    
    NSDictionary *parameters = @{@"":@""};
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    [manager setResponseSerializer:responseSerializer];
    manager.securityPolicy.allowInvalidCertificates = YES;
    
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    AFHTTPRequestOperation *op = [manager POST:imagePostUrl parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //do not put image inside parameters dictionary as I did, but append it!//imagedata
        
        //[imageViewProfile setImage:img];
//        
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
//        formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss";
//        NSLog(@"%@", [formatter stringFromDate:[NSDate date]]);
        
        
        NSString *date=[NSString stringWithFormat:@"%@",[self randomStringWithLength:6]];
    
        NSLog(@"append image data %@",imagedata);
        [formData appendPartWithFileData:imagedata name:fileName fileName:[NSString stringWithFormat:@"%@.jpg",date] mimeType:@"image/jpeg"];
    //     [self.view makeToast:@"The image is being uploading...."];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@ ***** %@", operation.responseString, responseObject);
        
     //   [self.view makeToast:@"Image upload complete."];
        
        NSString *imagestr = [ operation.responseString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        NSString *imagestr1 = [[NSString alloc]init];
        for (int i=0; i < [imagestr length]; i++) {
            //   [myString characterAtIndex:i]
            
            if(i==0)
            {
                continue;
            }
            if(i == [imagestr length]-1){
                continue;
            }
            NSString *ch = [imagestr substringWithRange:NSMakeRange(i, 1)];
            imagestr1 = [NSString stringWithFormat:@"%@%@",imagestr1,ch];
        }
//        NSURL *imageURL = [NSURL URLWithString:imagestr1];
//        imageViewProfile.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageURL]];
//        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
       
     //  [[NSUserDefaults standardUserDefaults]setObject:imagestr1 forKey:@"profile_picture"];
    
    //  [imageViewProfile sd_setImageWithURL:[NSURL URLWithString:imagestr1]];
        
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"profile_picture"];

        [imageViewProfile sd_setImageWithURL:[NSURL URLWithString:imagestr1]];
        
        [[NSUserDefaults standardUserDefaults]setObject:imagedata forKey:@"profile_picture"];
 NSLog(@"new image url %@",imagestr1);
        [[NSUserDefaults standardUserDefaults]setObject:imagestr1 forKey:@"l_image"];
 
        [kappDelegate HideIndicator];
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@ ***** %@", operation.responseString, error);
        
        [HelperAlert alertWithOneBtn:AlertTitle description:@"Failed to upload selected profile picture" okBtn:OkButtonTitle];
       
        [kappDelegate HideIndicator];

        return ;
    }];
    [op start];
}



-(NSString *) randomStringWithLength: (int) len {
    
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length])]];
    }
    
    return randomString;
}

@end
