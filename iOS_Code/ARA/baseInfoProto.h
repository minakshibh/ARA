//
//  baseInfoProto.h
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 11/01/17.
//  Copyright © 2017 Krishna_Mac_2. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol baseInfoProto <NSObject>

@property (nonatomic, strong, readonly) NSString *CreatedDate;
@property (nonatomic, strong, readonly) NSString *Email;
@property (nonatomic, strong, readonly) NSString *FirstName;
@property (nonatomic, strong, readonly) NSString *FullName;
@property (nonatomic, strong, readonly) NSString *InvitationId;
@property (nonatomic, strong, readonly) NSString *IsFacebookUser;
@property (nonatomic, strong, readonly) NSString *MEAID;
@property (nonatomic, strong, readonly) NSString *MEAName;
@property (nonatomic, strong, readonly) NSString *PhoneNumber;
@property (nonatomic, strong, readonly) NSString *UserName;
@property (nonatomic, strong, readonly) NSString *UserId;
@property (nonatomic, strong, readonly) NSString *Password;
@property (nonatomic, strong, readonly) NSString *RoleName;
@property (nonatomic, strong, readonly) NSString *RoleID;
@property (nonatomic, strong, readonly) NSString *PurchasedBefore;
@property (nonatomic, strong, readonly) NSString *ProfilePicName;
@property (nonatomic, strong, readonly) NSString *IsAppDistributor;
@property (nonatomic, strong, readonly) NSString *LastName;
@property (nonatomic, strong, readonly) NSString *UserDetailId;
@property (nonatomic, strong, readonly) NSString *UserToken;
@property (nonatomic, strong, readonly) NSString *UserType;

@end
