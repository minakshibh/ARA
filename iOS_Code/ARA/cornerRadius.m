//
//  cornerRadious.m
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 11/12/15.
//  Copyright © 2015 Krishna_Mac_2. All rights reserved.
//

#import "cornerRadius.h"

@implementation cornerRadius

+ (void)setRadiusofButton:(UIButton*)name :(float)val
{
    name.layer.cornerRadius = val;
    [name setClipsToBounds:YES];
}

+ (void)setRadiusofLabel:(UILabel*)name :(float)val
{
    name.layer.cornerRadius = val;
    [name setClipsToBounds:YES];
}




@end
