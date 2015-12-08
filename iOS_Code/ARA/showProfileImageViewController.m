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
//#import "UIView+Toast.h"
@interface showProfileImageViewController ()

@end

@implementation showProfileImageViewController

- (void)viewDidLoad {
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    //imageViewProfile.image = [UIImage imageNamed:@"dummy-user-img.png"];
    
    [super viewDidLoad];
   // NSString *imagestr = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"l_image"]];

    NSData * im = [[NSUserDefaults standardUserDefaults]valueForKey:@"profile_picture"];
    
    imageViewProfile.image = [UIImage imageWithData:im];
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
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
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        [self presentViewController:picker animated:YES completion:nil];
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
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
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
    
    NSString *imagePostUrl = [NSString stringWithFormat:@"%@/users/%@/profilepic",Kwebservices,[[NSUserDefaults standardUserDefaults] valueForKey:@"l_userid"]];
    //
    NSString *fileName = [NSString stringWithFormat:@"profilePic%ld%c%c.png", (long)[[NSDate date] timeIntervalSince1970], arc4random_uniform(26) + 'a', arc4random_uniform(26) + 'a'];
    
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://server.url"]];
    //NSData *imageData = UIImageJPEGRepresentation(self.avatarView.image, 0.5);
    NSDictionary *parameters = @{@"":@""};
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    [manager setResponseSerializer:responseSerializer];
    manager.securityPolicy.allowInvalidCertificates = YES;
    
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    AFHTTPRequestOperation *op = [manager POST:imagePostUrl parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //do not put image inside parameters dictionary as I did, but append it!
        [formData appendPartWithFileData:imagedata name:fileName fileName:@"photo.jpg" mimeType:@"image/jpeg"];
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
        NSURL *imageURL = [NSURL URLWithString:imagestr1];
        imageViewProfile.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageURL]];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"profile_picture"];
       [[NSUserDefaults standardUserDefaults]setObject:imageData forKey:@"profile_picture"];

        [[NSUserDefaults standardUserDefaults]setObject:imagestr1 forKey:@"l_image"];
        [kappDelegate HideIndicator];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@ ***** %@", operation.responseString, error);
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"ARA" message:@"Failed to upload selected profile picture" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        [kappDelegate HideIndicator];

        return ;
    }];
    [op start];
}
@end
