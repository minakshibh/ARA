//
//  CommonHelperClass.h
//  ManageGo
//
//  Created by Navpreet Singh on 4/28/15.
//  Copyright (c) 2015 navpreet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "KGModal.h"
@interface CommonHelperClass : NSObject

+(NSString *)jsonWrapper:(id)input;
+(CGFloat) CalculateStringHeight:(NSString *)String fontSize:(float)kFont;

@end
