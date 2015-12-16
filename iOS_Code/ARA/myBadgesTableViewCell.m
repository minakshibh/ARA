//
//  myBadgesTableViewCell.m
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 14/08/15.
//  Copyright (c) 2015 Krishna_Mac_2. All rights reserved.
//

#import "myBadgesTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation myBadgesTableViewCell

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (IBAction)btnClick:(id)sender {
    
//   [self.delegate cellWithButtonDidPressed:self];    
  
    NSString* msg = [NSString stringWithFormat:@"You haven't earned this badge yet."];
    [HelperAlert alertWithOneBtn:AlertTitle description:msg okBtn:OkButtonTitle];
}

-(void)setLabelText:(NSString*)name :(NSString*)no : (NSString*)date :(NSString*)image :(NSString*)earned
{
    btnClick.alpha = 0.80;
    
    if ([earned isEqualToString:@"1"]) {
        btnClick.hidden=YES;
    }else{
         btnClick.hidden=NO;
        badagesDate.hidden = YES;
    }
    
    
    badagesName.text = name;
    badagesNo.text = no;
    if([date isEqualToString:@""])
    {
         badagesDate.text = @"";
    }else{
    badagesDate.text = [NSString stringWithFormat:@"Earned on : %@",date];
    }
//   badagesImage.image = [UIImage imageWithData:@""];
   
//    [badagesImage sd_setImageWithURL:[NSURL URLWithString:image] placeholderImage:                                [UIImage imageNamed:@"user-i.png"]];
    [badagesImage sd_setImageWithURL:[NSURL URLWithString:image]
                      placeholderImage:[UIImage imageNamed:@"user-i.png"]];
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
//        
//        
//                //imageProfile.contentMode=UIViewContentModeScaleAspectFit;
//        
//                NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:image]];
//        
//        [badagesImage sd_setImageWithURL:[NSURL URLWithString:image]
//                         placeholderImage:nil];
//        
//        
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    // Update the UI
//                    badagesImage.image = [UIImage imageWithData:imageData];
//        //
//                   
//                });
//            });
    
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
//        lblheadingView.font=[lblheadingView.font fontWithSize:24];
//        btnSort.titleLabel.font = [btnSort.titleLabel.font fontWithSize:24];
//        imagedirectregerral.frame = CGRectMake(imagedirectregerral.frame.origin.x+20, imagedirectregerral.frame.origin.y, imagedirectregerral.frame.size.width, imagedirectregerral.frame.size.height);
        
         badagesName.font=[badagesName.font fontWithSize:24];
         badagesDate.font=[badagesDate.font fontWithSize:20];
         badagesNo.font=[badagesNo.font fontWithSize:20];
         badagesImage.contentMode = UIViewContentModeScaleAspectFit;

        badagesImage.frame = CGRectMake(badagesImage.frame.origin.x-10, badagesImage.frame.origin.y, badagesImage.frame.size.width, badagesImage.frame.size.height);
        
        badagesName.frame = CGRectMake(badagesName.frame.origin.x-20, badagesName.frame.origin.y, badagesName.frame.size.width, badagesName.frame.size.height);
        badagesDate.frame = CGRectMake(badagesDate.frame.origin.x-20, badagesDate.frame.origin.y, badagesDate.frame.size.width, badagesDate.frame.size.height);
        badagesNo.frame = CGRectMake(badagesNo.frame.origin.x-20, badagesNo.frame.origin.y, badagesNo.frame.size.width, badagesNo.frame.size.height);
        
        //badagesImage.frame = CGRectMake(badagesImage.frame.origin.x, badagesImage.frame.origin.y, badagesImage.frame.size.width, badagesImage.frame.size.height+5);
        
        
        if(IS_IPAD_PRO_1366)
        {
            badagesName.font=[badagesName.font fontWithSize:30];
            badagesDate.font=[badagesDate.font fontWithSize:24];
            badagesNo.font=[badagesNo.font fontWithSize:24];
            badagesImage.contentMode = UIViewContentModeScaleAspectFit;
            
            badagesNo.frame = CGRectMake(badagesNo.frame.origin.x, badagesNo.frame.origin.y+3, badagesNo.frame.size.width, badagesNo.frame.size.height);
             badagesDate.frame = CGRectMake(badagesDate.frame.origin.x, badagesDate.frame.origin.y+3, badagesDate.frame.size.width, badagesDate.frame.size.height);
        }
    }
}
@end
