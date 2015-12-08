//
//  splashViewController.h
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 08/09/15.
//  Copyright (c) 2015 Krishna_Mac_2. All rights reserved.
//

#import "ViewController.h"
#import <MessageUI/MessageUI.h>
#import <QuickLook/QuickLook.h>

@interface splashViewController : ViewController<QLPreviewControllerDelegate,QLPreviewControllerDataSource>
{
    NSArray *docPaths;
    NSString *documentsDir, *dbPath, *fileName;
    NSString *autoArchieve,*keepHistry,*autoArchieveDate,*emailid;
    NSDate *tenDaysAgo;
    NSDate *twentyDaysAgo;
    NSDate *thirtyDaysAgo;
    IBOutlet UIImageView *imageView;
}
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *titlelbl;
@property (strong, nonatomic) UIImageView * mainImageView;
@property (strong, nonatomic) NSMutableArray *gratArchievArray;


@end
