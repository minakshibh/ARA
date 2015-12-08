//
//  myBadgesTableViewCell.h
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 14/08/15.
//  Copyright (c) 2015 Krishna_Mac_2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myBadgesTableViewCell : UITableViewCell
{
    
    IBOutlet UILabel *badagesName;
    IBOutlet UILabel *badagesNo;
    IBOutlet UILabel *badagesDate;
    IBOutlet UIImageView *badagesImage;
    IBOutlet UIButton *btnClick;
}
- (IBAction)btnClick:(id)sender;
-(void)setLabelText:(NSString*)name :(NSString*)no : (NSString*)date :(NSString*)image :(NSString*)earned;

@end
