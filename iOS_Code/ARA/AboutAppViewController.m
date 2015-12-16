//
//  AboutAppViewController.m
//  AUTOAVES_REFERRAL
//
//  Created by Krishna Mac Mini 2 on 27/11/15.
//  Copyright © 2015 Krishna_Mac_2. All rights reserved.
//

#import "AboutAppViewController.h"

@interface AboutAppViewController ()

@end

@implementation AboutAppViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    
    
    
    
    
    int d = 0; // standard display
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2.0) {
        d = 1; // is retina display
    }
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        d += 2;
    }
    
    if (d==0) {
        headerImage.image = [UIImage imageNamed:@"320X480.png"];
    }
    if (d==1) {
        headerImage.image = [UIImage imageNamed:@"320X568.png"];
    }
    if (d==2) {
        headerImage.image = [UIImage imageNamed:@"480X800.png"];
    }
    if (d==3) {
        headerImage.image = [UIImage imageNamed:@"640X1136.png"];
    }

    
    NSDictionary *infoDictionary = [[NSBundle mainBundle]infoDictionary];
    
    NSString *version = infoDictionary[@"CFBundleShortVersionString"];
    NSString *build1 = infoDictionary[(NSString*)kCFBundleVersionKey];
    NSString *bundleName = infoDictionary[(NSString *)kCFBundleNameKey];
    
    buildName.text = bundleName;
    buildVersion.text = version;
    build.text = build1;
    
    
    NSString *folderPath = [[NSBundle mainBundle] bundlePath];
    NSArray *filesArray = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:folderPath error:nil];
    NSEnumerator *filesEnumerator = [filesArray objectEnumerator];
    NSString *fileName;
    unsigned long long int fileSize = 0;
    
    while (fileName = [filesEnumerator nextObject]) {
        NSDictionary *fileDictionary = [[NSFileManager defaultManager] fileAttributesAtPath:[folderPath stringByAppendingPathComponent:fileName] traverseLink:YES];
        fileSize += [fileDictionary fileSize];
    }
    
    NSLog(@"App size : %lld",fileSize);
    
    double convertedValue = fileSize;
    int multiplyFactor = 0;
    
    NSArray *tokens = [NSArray arrayWithObjects:@"bytes",@"KB",@"MB",@"GB",@"TB",nil];
    
    while (convertedValue > 1024) {
        convertedValue /= 1024;
        multiplyFactor++;
    }
    
    NSLog(@"%@",[NSString stringWithFormat:@"%4.2f %@",convertedValue, [tokens objectAtIndex:multiplyFactor]]);
    
    buildSize.text = [NSString stringWithFormat:@"%4.2f %@",convertedValue, [tokens objectAtIndex:multiplyFactor]];
    
    if ( IS_IPAD )
    {
        BUILDVERSION.font = [BUILDVERSION.font fontWithSize:24];
        buildVersion.font = [buildVersion.font fontWithSize:24];
        buildSize.font = [buildSize.font fontWithSize:24];
       btnback.titleLabel.font = [btnback.titleLabel.font fontWithSize:24];
         BUILDSIZE.font = [BUILDSIZE.font fontWithSize:24];
        btnheading.font = [btnheading.font fontWithSize:24];
        if(IS_IPAD_PRO_1366)
        {

            BUILDVERSION.font = [BUILDVERSION.font fontWithSize:30];
            buildVersion.font = [buildVersion.font fontWithSize:30];
            buildSize.font = [buildSize.font fontWithSize:30];
            btnback.titleLabel.font = [btnback.titleLabel.font fontWithSize:30];
            BUILDSIZE.font = [BUILDSIZE.font fontWithSize:30];
            btnheading.font = [btnheading.font fontWithSize:30];
            
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
     }
@end
