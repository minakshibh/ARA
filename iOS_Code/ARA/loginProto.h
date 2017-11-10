//
//  loginProto.h
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 11/01/17.
//  Copyright © 2017 Krishna_Mac_2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "baseInfoProto.h"

@protocol loginProto <NSObject>
@property (nonatomic, strong, readonly) NSMutableDictionary<baseInfoProto> *user;

@end
