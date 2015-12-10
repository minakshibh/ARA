//
//  UITextfieldValidations.m
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 10/12/15.
//  Copyright © 2015 Krishna_Mac_2. All rights reserved.
//

#import "UITextfieldValidations.h"

@implementation UITextfieldValidations

+ (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


@end
