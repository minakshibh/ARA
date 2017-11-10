//
//  NonCopyPasteField.m
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 09/06/17.
//  Copyright © 2017 Krishna_Mac_2. All rights reserved.
//

#import "NonCopyPasteField.h"

@implementation NonCopyPasteField

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(copy:) || action == @selector(paste:)) {
        return NO;
    }
   return NO;
}

@end
