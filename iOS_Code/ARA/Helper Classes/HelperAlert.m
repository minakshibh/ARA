//
//  HelperAlert.m
//  HelperApp
//
//  Created by Poonam Parmar on 2/9/15.
//  Copyright (c) 2015 MSS. All rights reserved.
//

#import "HelperAlert.h"

@implementation HelperAlert

//
+ (UIAlertView *) alertWithOneBtn:(NSString*)title description:(NSString*)description okBtn:(NSString *)okBtn{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:description delegate:nil cancelButtonTitle:okBtn otherButtonTitles:nil, nil];
    [alert show];
    return alert;
}

+ (UIAlertView *) alertWithOneBtn:(NSString*)title description:(NSString*)description okBtn:(NSString *)okBtn withTag:(int)tag forController:(UIViewController*)controller{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:description delegate:controller cancelButtonTitle:okBtn otherButtonTitles:nil, nil];
    alert.tag = tag;
    [alert show];
    return alert;
}

+(UIAlertView*) alertWithTwoBtns:(NSString *)title description:(NSString *)description okBtn:(NSString *)okBtn cancelBtn:(NSString *)cancelBtn{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:description delegate:self cancelButtonTitle:okBtn otherButtonTitles:cancelBtn, nil];
    [alert show];
    return alert;
    
}

+(UIAlertView*) alertWithTwoBtns:(NSString *)title description:(NSString *)description okBtn:(NSString *)okBtn cancelBtn:(NSString *)cancelBtn withTag:(int)tag forController:(UIViewController*)controller{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:description delegate:controller cancelButtonTitle:okBtn otherButtonTitles:cancelBtn, nil];
     alert.tag = tag;
    [alert show];
    return alert;
}

@end
