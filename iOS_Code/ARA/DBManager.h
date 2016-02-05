//
//  DBManager.h
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 19/01/16.
//  Copyright © 2016 Krishna_Mac_2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@interface DBManager : NSObject
{
    NSString *databasePath,*lastnotificationId;
}

+(DBManager*)getSharedInstance;
-(BOOL)createDB;
- (BOOL) saveData:(NSString*)userId isRead:(NSString*)isRead
notificationtitle:(NSString*)notificationtitle notificationDetail:(NSString*)notificationDetail notificationDate:(NSString*)notificationDate NotificationId:(NSString*)NotificationId CreatedDate:(NSString*)CreatedDate;
@property (strong,nonatomic) NSString *ScheduledAt,*NotificationText,*serviceName,*isRead,*NotificationId,*CreatedDate;
- (NSMutableArray*)showData;
- (BOOL)updateTableNotification:(NSString*)NotificationId;
- (BOOL)deleteTableNotification:(NSString*)NotificationId;
- (NSMutableArray*)loadMoreData;
- (int) GetDataCount;
- (NSMutableArray*)getAllData;
- (BOOL)deleteAllData;
@end
