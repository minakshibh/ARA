//
//  APIDetailTableViewCell.m
//  AUTOAVES_REFERRAL
//
//  Created by Mac on 22/08/16.
//  Copyright © 2016 Krishna_Mac_2. All rights reserved.
//

#import "APIDetailTableViewCell.h"

@implementation APIDetailTableViewCell
@synthesize lblFullName,lblinvitationStatus,lblEmailId;
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



-(void)setvalue:(NSString *)name Email:(NSString *)emailID InvitationStatus:(NSString *)Status
{
    
    if (IS_IPAD) {
       
            
            lblFullName.font = [lblFullName.font fontWithSize:20];
         lblinvitationStatus.font = [lblinvitationStatus.font fontWithSize:20];
            lblEmailId.font = [lblEmailId.font fontWithSize:15];
        lblEmailId.frame = CGRectMake(lblEmailId.frame.origin.x, lblEmailId.frame.origin.y+1, lblEmailId.frame.size.width, lblEmailId.frame.size.height);

    }
    lblFullName.text =[NSString stringWithFormat:@"%@",name];
    lblEmailId.text=[NSString stringWithFormat:@"%@",emailID];
    lblinvitationStatus.text=[NSString stringWithFormat:@"%@",[Status uppercaseString]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
