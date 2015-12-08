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
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"ARA" message:msg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
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
        
        //badagesImage.frame = CGRectMake(badagesImage.frame.origin.x, badagesImage.frame.origin.y, badagesImage.frame.size.width, badagesImage.frame.size.height+5);
    }
}
@end
