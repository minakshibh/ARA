//
//  PopupTableViewCell.m
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 14/12/15.
//  Copyright © 2015 Krishna_Mac_2. All rights reserved.
//

#import "PopupTableViewCell.h"

@implementation PopupTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setLabelText:(NSString*)image :(NSString*)contactType : (NSString*)contactDetails :(BOOL*)isPhoneno
{
    
    
    
    NSString *imageName = [NSString stringWithFormat:@"%@",image];
    imageViewSelection.image = [UIImage imageNamed:imageName];
    
    lblContactType.text = [NSString stringWithFormat:@"%@",contactType];
    lblContactDetail.text = [NSString stringWithFormat:@"%@",contactDetails];
    
    if (isPhoneno==NO) {
        lblContactDetail.font=[lblContactDetail.font fontWithSize:15];
    }
    
    if (IS_IPHONE_4_OR_LESS || IS_IPHONE_5) {
        lblContactType.font=[lblContactType.font fontWithSize:14];
        lblContactDetail.font=[lblContactDetail.font fontWithSize:21];
    }
}
@end
