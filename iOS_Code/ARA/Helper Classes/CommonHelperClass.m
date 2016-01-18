//
//  CommonHelperClass.m
//  ManageGo
//
//  Created by Navpreet Singh on 4/28/15.
//  Copyright (c) 2015 navpreet. All rights reserved.
//

#import "CommonHelperClass.h"

@implementation CommonHelperClass
+(CGFloat) CalculateStringHeight:(NSString *)String fontSize:(float)kFont{
    NSString *str = String;
    CGSize size = [str sizeWithFont:[UIFont fontWithName:@"Roboto-Light" size:kFont] constrainedToSize:CGSizeMake(200, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    NSLog(@"%f",size.height);
    return size.height;
   
}

+(NSString *)jsonWrapper:(id)input
{
    NSError *error;
    NSData *jsonData2 = [NSJSONSerialization dataWithJSONObject:input options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData2 encoding:NSUTF8StringEncoding];
    return jsonString;
}

@end
