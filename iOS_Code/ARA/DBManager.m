//
//  DBManager.m
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 19/01/16.
//  Copyright © 2016 Krishna_Mac_2. All rights reserved.
//

#import "DBManager.h"

static DBManager *sharedInstance = nil;
static sqlite3 *database = nil;
static sqlite3_stmt *statement = nil;
@implementation DBManager


+(DBManager*)getSharedInstance{
    if (!sharedInstance) {
        sharedInstance = [[super allocWithZone:NULL]init];
        [sharedInstance createDB];
    }
    return sharedInstance;
}
-(BOOL)createDB{
    NSString *docsDir;
    NSArray *dirPaths;
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString:
                    [docsDir stringByAppendingPathComponent: @"notification.db"]];
    BOOL isSuccess = YES;
    NSFileManager *filemgr = [NSFileManager defaultManager];
    if ([filemgr fileExistsAtPath: databasePath ] == NO)
    {
        const char *dbpath = [databasePath UTF8String];
        if (sqlite3_open(dbpath, &database) == SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt = "create table if not exists notificationDetails (userId text, isRead BOOLEAN, notificationtitle text, notificationDetail text, notificationDate text, NotificationId text, Id INTEGER PRIMARY KEY AUTOINCREMENT, CreatedDate text)";
            if (sqlite3_exec(database, sql_stmt, NULL, NULL, &errMsg)
                != SQLITE_OK)
            {
                isSuccess = NO;
                NSLog(@"Failed to create table");
            }
            sqlite3_close(database);
            return  isSuccess;
           }
        else {
            isSuccess = NO;
            NSLog(@"Failed to open/create database");
        }
    }
    return isSuccess;
}
- (BOOL) saveData:(NSString*)userId isRead:(NSString*)isRead
notificationtitle:(NSString*)notificationtitle notificationDetail:(NSString*)notificationDetail notificationDate:(NSString*)notificationDate NotificationId:(NSString*)NotificationId CreatedDate:(NSString*)CreatedDate
{
    NSString *docsDir;
    NSArray *dirPaths;
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString:
                    [docsDir stringByAppendingPathComponent: @"notification.db"]];
    
    const char *dbpath = [databasePath UTF8String];
    
    
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat:@"insert into notificationDetails (userId, isRead, notificationtitle, notificationDetail, notificationDate, NotificationId, CreatedDate) values(\"%@\",\"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\")",userId,isRead,notificationtitle,notificationDetail,notificationDate,NotificationId,CreatedDate];
        
//        sqlite3_bind_text(statement,1,[userId UTF8String],-1,SQLITE_TRANSIENT);
//        sqlite3_bind_text(statement,2,[isRead UTF8String],-1,SQLITE_TRANSIENT);
//        sqlite3_bind_text(statement,3,[notificationtitle UTF8String],-1,SQLITE_TRANSIENT);
//        sqlite3_bind_text(statement,4,[notificationDetail UTF8String],-1,SQLITE_TRANSIENT);
//        sqlite3_bind_text(statement,5,[notificationDate UTF8String],-1,SQLITE_TRANSIENT);
         const char *insert_stmt = [insertSQL UTF8String];
       
        if(sqlite3_prepare_v2(database,insert_stmt, -1, &statement, NULL)==SQLITE_OK)
        {
            sqlite3_step(statement);
                                    return YES;
                                } 
                                else {
                                    return NO;
                                }
                  //              sqlite3_reset(statement);
    }
    return NO;
}
- (NSMutableArray*)loadMoreData
{
    NSString *docsDir;
    NSArray *dirPaths;
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString:
                    [docsDir stringByAppendingPathComponent: @"notification.db"]];
    
    NSString *userid = [NSString stringWithFormat: @"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"l_userid"]];
    NSMutableArray *data = [[NSMutableArray alloc]init];
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        
        NSString *querySQL = [NSString stringWithFormat: @"select * from notificationDetails where userId = \"%@\" and NotificationId < \"%@\" ORDER BY NotificationId DESC LIMIT 10",userid,[[NSUserDefaults standardUserDefaults]valueForKey:@"lastnotificationId"]];

       
//         NSString *querySQL = [NSString stringWithFormat: @"select * from notificationDetails where userId = \"%@\" ORDER BY notificationDate DESC and NotificationId > \"%@\" LIMIT 10",userid,[[NSUserDefaults standardUserDefaults]valueForKey:@"lastnotificationId"]];
        
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            int i=0,k=0;
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                i++;
                DBManager *database = [[DBManager alloc]init];
                NSString *ScheduledAt = [[NSString alloc] initWithUTF8String:
                                         (const char*) sqlite3_column_text(statement, 4)];
                database.ScheduledAt = ScheduledAt;
                
                NSString *NotificationText = [[NSString alloc] initWithUTF8String:
                                              (const char *) sqlite3_column_text(statement, 3)];
                database.NotificationText = NotificationText;
                
                NSString *serviceName = [[NSString alloc]initWithUTF8String:
                                         (const char *) sqlite3_column_text(statement, 2)];
                database.serviceName = serviceName;
                
                NSString *isRead = [[NSString alloc]initWithUTF8String:
                                    (const char *) sqlite3_column_text(statement, 1)];
                database.isRead = isRead;
                
                NSString *NotificationId = [[NSString alloc]initWithUTF8String:
                                            (const char *) sqlite3_column_text(statement, 5)];
                database.NotificationId = NotificationId;
                
                

                lastnotificationId = [[NSString alloc]initWithUTF8String:
                                      (const char *) sqlite3_column_text(statement,5)];
                NSLog(@"lastnotificationId ---- %@",lastnotificationId);
                 [[NSUserDefaults standardUserDefaults]setObject:lastnotificationId forKey:@"lastnotificationId"];
                
               
                
                NSString *createdDate = [[NSString alloc]initWithUTF8String:
                                         (const char *) sqlite3_column_text(statement, 7)];
                database.CreatedDate = createdDate;
                
                [data addObject:database];
            }
            [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",i] forKey:@"loadMoreCount"];
          
            return data;
        }
        else{
            NSLog(@"Not found");
            return data;
        }
        //   sqlite3_reset(statement);
    }
    return data;
}
- (int) GetDataCount
{
    NSString *docsDir;
    NSArray *dirPaths;
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString:
                    [docsDir stringByAppendingPathComponent: @"notification.db"]];
    
    NSString *userid = [NSString stringWithFormat: @"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"l_userid"]];
    NSMutableArray *data = [[NSMutableArray alloc]init];
    const char *dbpath = [databasePath UTF8String];
    
    int count = 0;
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        
        NSString *querySQL = [NSString stringWithFormat: @"SELECT COUNT(*) FROM notificationDetails where userId = \"%@\"",userid];
        
        
        
        const char *query_stmt = [querySQL UTF8String];
        
        
        sqlite3_stmt *statement;
        
        if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                count = sqlite3_column_int(statement, 0);
            }
        }
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s" );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        
    }
    
    return count;
}
- (NSMutableArray*)showData
{
    NSString *docsDir;
    NSArray *dirPaths;
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString:
                    [docsDir stringByAppendingPathComponent: @"notification.db"]];
    
    NSString *userid = [NSString stringWithFormat: @"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"l_userid"]];
    NSMutableArray *data = [[NSMutableArray alloc]init];
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        
        NSString *querySQL = [NSString stringWithFormat: @"select * from notificationDetails where userId = \"%@\" ORDER BY notificationDate DESC LIMIT 10",userid];
       
        
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            
            int i=0;
            while (sqlite3_step(statement) == SQLITE_ROW)
            { 
                DBManager *database = [[DBManager alloc]init];
                NSString *ScheduledAt = [[NSString alloc] initWithUTF8String:
                                  (const char*) sqlite3_column_text(statement, 4)];
                database.ScheduledAt = ScheduledAt;

                NSString *NotificationText = [[NSString alloc] initWithUTF8String:
                                  (const char *) sqlite3_column_text(statement, 3)];
                database.NotificationText = NotificationText;
                
                NSString *serviceName = [[NSString alloc]initWithUTF8String:
                                   (const char *) sqlite3_column_text(statement, 2)];
                database.serviceName = serviceName;
                
                NSString *isRead = [[NSString alloc]initWithUTF8String:
                                         (const char *) sqlite3_column_text(statement, 1)];
                database.isRead = isRead;
                
                NSString *NotificationId = [[NSString alloc]initWithUTF8String:
                                    (const char *) sqlite3_column_text(statement, 5)];
                database.NotificationId = NotificationId;
                
                
                
                    
                
                lastnotificationId = [[NSString alloc]initWithUTF8String:
                                            (const char *) sqlite3_column_text(statement, 5)];
                NSLog(@"%@",lastnotificationId);
                
                
                NSString *createdDate = [[NSString alloc]initWithUTF8String:
                                            (const char *) sqlite3_column_text(statement, 7)];
                database.CreatedDate = createdDate;
                
                [data addObject:database];
            }
            [[NSUserDefaults standardUserDefaults]setObject:lastnotificationId forKey:@"lastnotificationId"];
            return data;
        }
        else{
            NSLog(@"Not found");
            return data;
        }
     //   sqlite3_reset(statement);
    }
    return data;
}
- (BOOL)updateTableNotification:(NSString*)NotificationId
{
    NSString *docsDir;
    NSArray *dirPaths;

    dirPaths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];

    databasePath = [[NSString alloc] initWithString:
                    [docsDir stringByAppendingPathComponent: @"notification.db"]];
    
    NSString *updatingValue = @"true";
    
    
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"update notificationDetails set isRead = \"%@\" Where NotificationId=\"%@\"",updatingValue,NotificationId];
        
        const char *query_stmt = [querySQL UTF8String];
        
        
        if(sqlite3_prepare_v2(database,query_stmt, -1, &statement, NULL)==SQLITE_OK)
        {
            sqlite3_step(statement);
            return YES;
        }
        else {
            return NO;
        }
        //              sqlite3_reset(statement);        //   sqlite3_reset(statement);
    }
    return NO;
}
- (BOOL)deleteTableNotification:(NSString*)NotificationId
{
    NSString *docsDir;
    NSArray *dirPaths;
    
    dirPaths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    
    databasePath = [[NSString alloc] initWithString:
                    [docsDir stringByAppendingPathComponent: @"notification.db"]];
    
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"DELETE FROM notificationDetails where NotificationId=\"%@\"",NotificationId];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if(sqlite3_prepare_v2(database,query_stmt, -1, &statement, NULL)==SQLITE_OK)
        {
            sqlite3_step(statement);
            return YES;
        }
        else {
            return NO;
        }
        //              sqlite3_reset(statement);        //   sqlite3_reset(statement);
    }
    return NO;
}
- (NSMutableArray*)getAllData
{
    NSString *docsDir;
    NSArray *dirPaths;
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString:
                    [docsDir stringByAppendingPathComponent: @"notification.db"]];
    
    NSString *userid = [NSString stringWithFormat: @"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"l_userid"]];
    NSMutableArray *data = [[NSMutableArray alloc]init];
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        
        NSString *querySQL = [NSString stringWithFormat: @"select * from notificationDetails"];
        
        
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                DBManager *database = [[DBManager alloc]init];
                NSString *ScheduledAt = [[NSString alloc] initWithUTF8String:
                                         (const char*) sqlite3_column_text(statement, 4)];
                database.ScheduledAt = ScheduledAt;
                
                NSString *NotificationText = [[NSString alloc] initWithUTF8String:
                                              (const char *) sqlite3_column_text(statement, 3)];
                database.NotificationText = NotificationText;
                
                NSString *serviceName = [[NSString alloc]initWithUTF8String:
                                         (const char *) sqlite3_column_text(statement, 2)];
                database.serviceName = serviceName;
                
                NSString *isRead = [[NSString alloc]initWithUTF8String:
                                    (const char *) sqlite3_column_text(statement, 1)];
                database.isRead = isRead;
                
                NSString *NotificationId = [[NSString alloc]initWithUTF8String:
                                            (const char *) sqlite3_column_text(statement, 5)];
                database.NotificationId = NotificationId;
                
                lastnotificationId = [[NSString alloc]initWithUTF8String:
                                      (const char *) sqlite3_column_text(statement, 6)];
                NSLog(@"%@",lastnotificationId);
                [data addObject:database];
            }
            [[NSUserDefaults standardUserDefaults]setObject:lastnotificationId forKey:@"lastnotificationId"];
            return data;
        }
        else{
            NSLog(@"Not found");
            return data;
        }
        //   sqlite3_reset(statement);
    }
    return data;
}
- (BOOL)deleteAllData
{
    NSString *docsDir;
    NSArray *dirPaths;
    
    dirPaths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    
    databasePath = [[NSString alloc] initWithString:
                    [docsDir stringByAppendingPathComponent: @"notification.db"]];
    
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"DELETE * FROM notificationDetails"];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if(sqlite3_prepare_v2(database,query_stmt, -1, &statement, NULL)==SQLITE_OK)
        {
            sqlite3_step(statement);
            return YES;
        }
        else {
            return NO;
        }
        //              sqlite3_reset(statement);        //   sqlite3_reset(statement);
    }
    return NO;
}
- (NSMutableArray*)getLastRecord
{
    NSString *docsDir;
    NSArray *dirPaths;
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString:
                    [docsDir stringByAppendingPathComponent: @"notification.db"]];
    
    NSString *userid = [NSString stringWithFormat: @"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"l_userid"]];
    NSMutableArray *data = [[NSMutableArray alloc]init];
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        
        NSString *querySQL = [NSString stringWithFormat: @"select * from notificationDetails where userId = \"%@\" ORDER BY notificationDate DESC LIMIT 10",userid];
        
        
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                DBManager *database = [[DBManager alloc]init];
                NSString *ScheduledAt = [[NSString alloc] initWithUTF8String:
                                         (const char*) sqlite3_column_text(statement, 4)];
                database.ScheduledAt = ScheduledAt;
                
                NSString *NotificationText = [[NSString alloc] initWithUTF8String:
                                              (const char *) sqlite3_column_text(statement, 3)];
                database.NotificationText = NotificationText;
                
                NSString *serviceName = [[NSString alloc]initWithUTF8String:
                                         (const char *) sqlite3_column_text(statement, 2)];
                database.serviceName = serviceName;
                
                NSString *isRead = [[NSString alloc]initWithUTF8String:
                                    (const char *) sqlite3_column_text(statement, 1)];
                database.isRead = isRead;
                
                NSString *NotificationId = [[NSString alloc]initWithUTF8String:
                                            (const char *) sqlite3_column_text(statement, 5)];
                database.NotificationId = NotificationId;
                
                lastnotificationId = [[NSString alloc]initWithUTF8String:
                                      (const char *) sqlite3_column_text(statement, 6)];
                NSLog(@"%@",lastnotificationId);
                
                NSString *createdDate = [[NSString alloc]initWithUTF8String:
                                         (const char *) sqlite3_column_text(statement, 7)];
                database.CreatedDate = createdDate;
                
                [data addObject:database];
            }
            [[NSUserDefaults standardUserDefaults]setObject:lastnotificationId forKey:@"lastnotificationId"];
            return data;
        }
        else{
            NSLog(@"Not found");
            return data;
        }
        //   sqlite3_reset(statement);
    }
    return data;
}

@end
