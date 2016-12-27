//
//  SMContactsSelector.m
//  
//
//  Created by Sergio on 03/03/11.
//  Copyright 2011 Sergio. All rights reserved.
//

#import "SMContactsSelector.h"
#import "CustomIOS7AlertView.h"

#define kIOS7TableView 9999

@interface NSString (character)

- (BOOL)isLetterInAlphabet:(NSArray*)alphabet;

- (BOOL)isRecordInArray:(NSArray *)array;

@end

@implementation NSString (character)

- (BOOL)isLetterInAlphabet:(NSArray *)alphabet
{
	BOOL isLetter = NO;
    NSString* firstCharacter = [[self substringToIndex:1] uppercaseString];
	
	for (NSString* letter in alphabet)
	{
		if ([firstCharacter isEqualToString:letter])
		{
			isLetter = YES;
			break;
		}
	}
	
	return isLetter;
}

- (BOOL)isRecordInArray:(NSArray *)array
{
    for (NSString *str in array)
    {
        if ([self isEqualToString:str]) 
        {
            return YES;
        }
    }
    
    return NO;
}

@end

@interface SMContactsSelector ()
{
   // NSMutableArray *mutArr;
}
- (UIView *)createTableView;





- (void)postActionSelectRowAtIndex:(NSInteger)row
                           section:(NSInteger)section
                       withContext:(id)context
                              text:(NSString *)text
                           andItem:(NSMutableDictionary *)item
                               row:(int)rowSelected;

@property (nonatomic, strong) NSArray *objectsArray;
@property (nonatomic, strong) NSArray *labelsArray;
@property (nonatomic, strong)CustomIOS7AlertView *alertIOS7;
@property (nonatomic, strong)UITableView *telsTable;

@end

@implementation SMContactsSelector
{
    int contactRow;
}

@synthesize telsTable;
@synthesize alertIOS7;
@synthesize objectsArray;
@synthesize labelsArray;
@synthesize table;
@synthesize cancelItem;
@synthesize doneItem;
@synthesize delegate;
@synthesize filteredListContent;
@synthesize savedSearchTerm;
@synthesize savedScopeButtonIndex;
@synthesize searchWasActive;
@synthesize barSearch;
@synthesize alertTable;
@synthesize selectedItem;
@synthesize currentTable;
@synthesize arrayLetters;
@synthesize requestData;
@synthesize alertTitle;
@synthesize recordIDs;
@synthesize showModal;
@synthesize toolBar;
@synthesize showCheckButton;
@synthesize upperBar;

- (id)init
{
    return [self initWithNibName:@"SMContactsSelector" bundle:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Default bar style is black, but you can override it to customise the appearance
        self.barStyle = UIBarStyleBlackOpaque;
    }
    return self;
}
-(void)sample {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:@"parvbhaskar@krishnais.com" forKey:@"email"];
    [dict setObject:@"parv" forKey:@"firstName"];
    [dict setObject:@"bhaskar" forKey:@"lastName"];
    NSMutableArray *collectedData = [[NSMutableArray alloc]init];
    [collectedData addObject:dict];
    
    NSMutableDictionary *checkedContactList=[[NSMutableDictionary alloc]init];
    [checkedContactList setObject:collectedData forKey:@"Invitations"];
    NSLog(@"checkedContactList is %@",checkedContactList);
    
    
    //convert dictionary into json
    NSError *error;
    
    NSData *jsonData=[NSJSONSerialization dataWithJSONObject:checkedContactList options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonstring;
    if (jsonData) {
        
        jsonstring = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    else {
        NSLog(@"Got an error: %@", error);
        jsonstring = @"";
    }
    NSLog(@"Your JSON String is %@", jsonstring);
    
    
    //hit api
    
    
    [kappDelegate ShowIndicator];
    
    NSMutableURLRequest *request ;
    NSString*_postData ;
    NSURLConnection *connection;
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSLog(@"%@",[user valueForKey:@"l_userid"]);
    NSString *userid = [NSString stringWithFormat: @"%@",[user valueForKey:@"l_userid"]];
    
    _postData = [NSString stringWithFormat:@"Data=%@",jsonstring];
    
    
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/invitation/app",Kwebservices]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
    
    NSLog(@"data post >>> %@",request);
    
    [request setHTTPMethod:@"POST"];
    [request addValue:userid forHTTPHeaderField:@"userid"];
    [request setHTTPBody: [_postData dataUsingEncoding:NSUTF8StringEncoding]];
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if(connection)
    {
        if(webData==nil)
        {
            webData = [NSMutableData data] ;
            NSLog(@"data");
        }
        else
        {
            webData=nil;
            webData = [NSMutableData data] ;
        }
        NSLog(@"server connection made");
    }
    else
    {
        NSLog(@"connection is NULL");
    }
    
 
}

-(void)viewWillAppear:(BOOL)animated{
    barSearch.barStyle = UIBarStyleBlack;
    // set bar transparancy
//    bar.translucent = NO;
    // set bar color
    barSearch.barTintColor = [UIColor blackColor];
//    // set bar button color
 //   bar.tintColor = [UIColor blackColor];
//    // set bar background color
//    bar.backgroundColor = [UIColor blackColor];
}
- (void)viewDidLoad
{
    
    
    //[self sample];
    
	[super viewDidLoad];
    
    
    _status = false;
    [self iPadDesignInitialization];
         clickedRow=[[NSMutableArray alloc]init];
    getDictionaryData=[[NSMutableArray alloc]init];
    
    //self.navigationController.navigationBar.hidden = YES;
    if ((requestData != DATA_CONTACT_TELEPHONE) && 
        (requestData != DATA_CONTACT_EMAIL) &&
        (requestData != DATA_CONTACT_ID))
    {
        
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        
        @throw ([NSException exceptionWithName:@"Undefined data request"reason:@"Define requestData variable (EMAIL or TELEPHONE)" userInfo:nil]);
    }

    self.arrayLetters = [NSLocalizedStringFromTable(@"alphabet", @"SMContactsSelector", nil) componentsSeparatedByString:@" "];
    
 
    cancelItem.title = NSLocalizedStringFromTable(@"cancel", @"SMContactsSelector", nil);
    cancelItem.tintColor=[UIColor whiteColor];
    doneItem.title = NSLocalizedStringFromTable(@"done", @"SMContactsSelector", nil);
    doneItem.tintColor=[UIColor whiteColor];
    alertTitle = NSLocalizedStringFromTable(@"alert_title", @"SMContactsSelector", nil);
    
	cancelItem.action = @selector(dismiss);
	doneItem.action = @selector(acceptAction);
	
    if (!showModal) 
    {
        toolBar.hidden = YES;
        CGRect rect = table.frame;
        rect.size.height += toolBar.frame.size.height;
        table.frame = rect;
        table.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 60000
    
    __block SMContactsSelector *controller = self;
    
    // Request authorization to Address Book
    ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, NULL);
    
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined)
    {
        ABAddressBookRequestAccessWithCompletion(addressBookRef,
        ^(bool granted, CFErrorRef error) {
            if (granted)
            [controller loadContacts];
                                                     
        });
    }
    else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized)
    {
        // The user has previously given access, add the contact
        [self loadContacts];
        CFRelease(addressBookRef);
    }
    else
    {
        NSString *msg = NSLocalizedStringFromTable(@"permission_denied", @"SMContactsSelector", nil);
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
        message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        alert.tag = 457;
        [alert show];
        [alert release];
        CFRelease(addressBookRef);
        return;
    }
    
#else
        [self loadContacts];
#endif
    
    selectedRow = [NSMutableArray new];
	table.editing = NO;
    table.backgroundColor = [UIColor clearColor];

    self.upperBar.topItem.title = self.title;
    
    // Set bar style
    NSLog(@"THe bar style is %ld",(long)self.barStyle);
    self.barSearch.barStyle = self.barStyle;
    self.upperBar.barStyle = self.barStyle;
}
-(void)sortContacts
{
//    NSLog(@"%@",dataArray);
//    NSDictionary *dict = dataArray[0];
//    NSLog(@"%@",dict);
  //  NSMutableArray *mutArr = [[NSMutableArray alloc]init];
//    
//    for (NSString* key in dict)
//    {
//        NSArray* value = [dict objectForKey:key];
//        if (value.count != 0){
//            [mutArr addObject:key];
//        }
//        
//        
//    }
 
    
    
    
}
- (void)loadContacts
{
    NSString *objsAux = @"";
    ABAddressBookRef addressBook = ABAddressBookCreate( );
    CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople( addressBook );
    
    CFIndex nPeople = ABAddressBookGetPersonCount(addressBook);
    
    NSMutableSet* allContacts = [[NSMutableSet alloc] initWithCapacity:nPeople];
    
    for (int i = 0; i < nPeople; i++)
    {
        
        ABRecordRef person = CFArrayGetValueAtIndex(allPeople, i);
        ABMultiValueRef property = ABRecordCopyValue(person, (requestData == DATA_CONTACT_TELEPHONE) ? kABPersonPhoneProperty : kABPersonEmailProperty);
        
        NSArray *propertyArray = (NSArray *)ABMultiValueCopyArrayOfAllValues(property);
        CFRelease(property);
        
        NSString *objs = @"";
        
        BOOL lotsItems = NO;
        
        
        if (propertyArray.count == 0){
            continue;
        }
        
        
        for (int i = 0; i < [propertyArray count]; i++)
        {
            if ([objs isEqual: @""])
            {
                objs = [propertyArray objectAtIndex:i];
                objsAux = [objsAux stringByAppendingFormat:@",%@", objs];
            }
            else
            {
                lotsItems = YES;
                objs = [objs stringByAppendingString:[NSString stringWithFormat:@",%@", [propertyArray objectAtIndex:i]]];
                objsAux = [objsAux stringByAppendingFormat:@",%@", objs];
            }
        }
        
        [propertyArray release];
        
        CFStringRef name;
        name = ABRecordCopyValue(person, kABPersonFirstNameProperty);
        CFStringRef lastNameString;
        lastNameString = ABRecordCopyValue(person, kABPersonLastNameProperty);
        
        NSString *user_Firstname=[NSString stringWithFormat:@"%@",name];
          NSString *user_Lastname=[NSString stringWithFormat:@"%@",lastNameString];
        NSString *empty=@"";
        
        if ([user_Firstname isEqualToString:empty]|| [user_Firstname isEqualToString:@"(null)"] ){
            
            continue;
            }
        if ([user_Lastname isEqualToString:empty] || [user_Lastname isEqualToString:@"(null)"]){
            
            
            continue;
        }
        
        
//        if (user_Lastname !=nil){
//            continue;
//            
//        }

        NSString *nameString = (NSString *)name;
        
        NSString *lastName = (NSString *)lastNameString;
        int currentID = (int)ABRecordGetRecordID(person);
        
        if ((id)lastNameString != nil)
        {
            nameString = [NSString stringWithFormat:@"%@ %@", nameString, lastName];
        }
        
        
    
        NSMutableDictionary *info = [NSMutableDictionary new];
        [info setValue:[NSString stringWithFormat:@"%@", [[nameString stringByReplacingOccurrencesOfString:@" " withString:@""] substringToIndex:1]] forKey:@"letter"];
        [info setValue:[NSString stringWithFormat:@"%@", nameString] forKey:@"name"];
        [info setValue:@"-1" forKey:@"rowSelected"];
        
        if ((![objs isEqual: @""]) || ([[objs lowercaseString] rangeOfString:@"null"].location == NSNotFound))
        {
            if (requestData == DATA_CONTACT_EMAIL)
            {
                [info setValue:[NSString stringWithFormat:@"%@", objs] forKey:@"email"];
                
                if (!lotsItems)
                {
                    [info setValue:[NSString stringWithFormat:@"%@", objs] forKey:@"emailSelected"];
                }
                else
                {
                    [info setValue:@"" forKey:@"emailSelected"];
                }
            }
        
            if (requestData == DATA_CONTACT_TELEPHONE)
            {
                [info setValue:[NSString stringWithFormat:@"%@", objs] forKey:@"telephone"];
                
                if (!lotsItems)
                {
                    [info setValue:[NSString stringWithFormat:@"%@", objs] forKey:@"telephoneSelected"];
                }
                else
                {
                    [info setValue:@"" forKey:@"telephoneSelected"];
                }
            }
            
            if (requestData == DATA_CONTACT_ID)
            {
                [info setValue:[NSString stringWithFormat:@"%d", currentID] forKey:@"recordID"];
                
                [info setValue:@"" forKey:@"recordIDSelected"];
            }
        }
    
        if ([recordIDs count] > 0)
        {
            BOOL insert = ([[NSString stringWithFormat:@"%d", currentID] isRecordInArray:recordIDs]);
            NSLog(@"Record ids are %@",recordIDs);
            
            if (insert)
            {
                [allContacts addObject:info];
            }
        }
   
        else
            
            NSLog(@"value for info is %@",info);
            [allContacts addObject:info];
        
        [info release];
        if (name) CFRelease(name);
        if (lastNameString) CFRelease(lastNameString);
    }
//===>
    
    CFRelease(allPeople);
    CFRelease(addressBook);
    
    if (self.requestData == DATA_CONTACT_TELEPHONE) {
        // Remove people without telephone numbers in the case where
        // that's all we care about
        NSArray* contactsArray = [allContacts allObjects];
        for (NSDictionary *item in contactsArray) {
            
            NSString *str = (NSString *)[item valueForKey:@"telephone"];
            if (!str || [str isEqualToString:@""]) {
                [allContacts removeObject:item];
            }
        }
    }
    
    NSArray* contactsArray = [allContacts allObjects];
    for (NSDictionary *item in contactsArray) //removing duplicates
    {
        NSString *str = (NSString *)[item valueForKey:@"telephone"];
        
        if ([str containsString:@","])
        {
            NSArray *tels = [str componentsSeparatedByString:@","];
            
            for (NSString *i in tels)
            {
                int count = 0;
                
                for (NSDictionary *item in allContacts)
                {
                    NSString *str = (NSString *)[item valueForKey:@"telephone"];
                    
                    if ([str containsString:i])
                        count++;
                }
                
                if (count > 1)
                    [allContacts removeObject:item];
            }
        }
    
    }

    NSSortDescriptor *sorter = [[[NSSortDescriptor alloc] initWithKey:@"name"
                                                            ascending:YES
                                                             selector:@selector(localizedStandardCompare:)] autorelease];
    
    NSArray *sortDescriptors = [NSArray arrayWithObject:sorter];
    
    NSArray* data = [[allContacts allObjects] sortedArrayUsingDescriptors:sortDescriptors];
    [allContacts release];
   
    if (self.savedSearchTerm)
    {
        [self.searchDisplayController setActive:self.searchWasActive];
        [self.searchDisplayController.searchBar setSelectedScopeButtonIndex:self.savedScopeButtonIndex];
        [self.searchDisplayController.searchBar setText:savedSearchTerm];
        
        self.savedSearchTerm = nil;
    }
    
    self.searchDisplayController.searchResultsTableView.scrollEnabled = YES;
    self.searchDisplayController.searchBar.showsCancelButton = NO;
    
    NSMutableDictionary	*info = [NSMutableDictionary new];
    
    for (int i = 0; i < [arrayLetters count]; i++)
    {
        NSMutableArray *array = [NSMutableArray new];
        NSLog(@"the all data is %@",data);
       
        for (NSDictionary *dict in data)
        {
            
            NSString *name = [dict valueForKey:@"name"];
            name = [name stringByReplacingOccurrencesOfString:@" " withString:@""];
            
            if ([[[name substringToIndex:1] uppercaseString] isEqualToString:[arrayLetters objectAtIndex:i]])
            {
                
                NSLog(@"array lettes are %@",arrayLetters);
                [array addObject:dict];
            }
        }
        
        [info setValue:array forKey:[arrayLetters objectAtIndex:i]]
        ;
      
        [array release];
    }
    
    for (int i = 0; i < [arrayLetters count]; i++)
    {
        NSMutableArray *array = [NSMutableArray new];
        
        for (NSDictionary *dict in data)
        {
            NSString *name = [dict valueForKey:@"name"];
            name = [name stringByReplacingOccurrencesOfString:@" " withString:@""];
            
            if ((![name isLetterInAlphabet:arrayLetters]) && (![name containsNullString]))
            {
                [array addObject:dict];
                NSLog(@"simple array is %@",array);

            }
        }
        
        [info setValue:array forKey:@"#"];
        NSLog(@"Additioal simple array is %@",array);

        [array release];
    }
    
    dataArray = [[NSArray alloc] initWithObjects:info, nil];
  
    self.filteredListContent = [NSMutableArray arrayWithCapacity:[data count]];
    [self.searchDisplayController.searchBar setShowsCancelButton:NO];
    [info release];
  
    [self.table reloadData];
}

- (void)acceptAction
{
    
    
   
    
	NSMutableArray *objects = [NSMutableArray new];
  
    NSMutableArray *collectedData=[[NSMutableArray alloc]init];

    //
    NSDictionary *dict = dataArray[0];
    NSLog(@"dict%@",dict);
    NSMutableArray *mutArr = [[NSMutableArray alloc]init];
    
    for (NSString* key in dict)
    {
        NSArray* value = [dict objectForKey:key];
        if (value.count != 0){
            [mutArr addObject:key];
            
        }
    }
    
    //
    
	for (int i = 0; i < [arrayLetters count]; i++)
	{
		NSMutableArray *obj = [[dataArray objectAtIndex:0] valueForKey:[arrayLetters objectAtIndex:i]];
		for (int x = 0; x < [obj count]; x++)
		{
			NSMutableDictionary *item = (NSMutableDictionary *)[obj objectAtIndex:x];
			BOOL checked = [[item objectForKey:@"checked"] boolValue];
            
			if (checked)
			{
                NSString *str = @"";
                NSString *name= @"";
                
                
				if (requestData == DATA_CONTACT_TELEPHONE) 
                {
                    str = [item valueForKey:@"telephoneSelected"];
                    name=[item valueForKey:@"name"];
                    if (![str isEqualToString:@""]) 
                    {
                        [objects addObject:str];
                        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
                        [dict setObject:str forKey:@"email"];
                        [dict setObject:name forKey:@"name"];
                        [collectedData addObject:dict];
                        // NSLog(@"Value for telephone checked %@",objects);
                    }
                }
                else if (requestData == DATA_CONTACT_EMAIL)
                {
                    str = [item valueForKey:@"emailSelected"];
                     name=[item valueForKey:@"name"];
                    NSArray *nameSeparator=[name componentsSeparatedByString:@" "];
                    NSString* firstName = [nameSeparator objectAtIndex:0];
                    NSString* lastName = [nameSeparator objectAtIndex:1];
                    
                    
                    
                    if (![str isEqualToString:@""]) 
                    {
                        [objects addObject:str];
                        [clickedRow addObject:str];
                        [clickedRow addObject:name];
               
                        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
                        [dict setObject:str forKey:@"email"];
                        [dict setObject:firstName forKey:@"firstName"];
                         [dict setObject:lastName forKey:@"lastName"];
                        [collectedData addObject:dict];
                        NSLog(@"Value for email checked %@",dict);

                        
                    }
                    
            }
               
                
                else
                {
                    str = [item valueForKey:@"recordID"];
                    
                    if (![str isEqualToString:@""]) 
                    {
                        [objects addObject:str];
                        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
                        [dict setObject:str forKey:@"email"];
                        [dict setObject:name forKey:@"name"];
                        
                        [collectedData addObject:dict];
                      //   NSLog(@"Value for Record id checked %@",objects);
                    }
                }
               

			}
		}
    }
    
    
    if (collectedData.count == 0){
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:AlertTitle message:@"Select a contact to send invitation" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    
    
    NSLog(@"Value for checked %@",collectedData);
    if ([self.delegate respondsToSelector:@selector(numberOfRowsSelected:withData:andDataType:)])
        [self.delegate numberOfRowsSelected:[objects count] withData:objects andDataType:requestData];
    
    [objects release];
   // [self dismiss];
    
    
    NSMutableDictionary *checkedContactList=[[NSMutableDictionary alloc]init];
    [checkedContactList setObject:collectedData forKey:@"Invitations"];
 NSLog(@"checkedContactList is %@",checkedContactList);
    
    
    //convert dictionary into json
    NSError *error;
  
    NSData *jsonData=[NSJSONSerialization dataWithJSONObject:checkedContactList options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonstring;
    if (jsonData) {
        
        jsonstring = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    else {
    NSLog(@"Got an error: %@", error);
                jsonstring = @"";
    }
    NSLog(@"Your JSON String is %@", jsonstring);
    
 
    //hit api
    
    
    [kappDelegate ShowIndicator];
    
    NSMutableURLRequest *request ;
    NSString*_postData ;
    NSURLConnection *connection;
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSLog(@"%@",[user valueForKey:@"l_userid"]);
    NSString *userid = [NSString stringWithFormat: @"%@",[user valueForKey:@"l_userid"]];
    
    _postData = [NSString stringWithFormat:@"Data=%@",jsonstring];
    
    
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/invitation/app",Kwebservices]] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
    
    NSLog(@"data post >>> %@",request);
    
    [request setHTTPMethod:@"POST"];
    [request addValue:userid forHTTPHeaderField:@"userid"];
    [request setHTTPBody: [_postData dataUsingEncoding:NSUTF8StringEncoding]];
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if(connection)
    {
        if(webData==nil)
        {
            webData = [NSMutableData data] ;
            NSLog(@"data");
        }
        else
        {
            webData=nil;
            webData = [NSMutableData data] ;
        }
        NSLog(@"server connection made");
    }
    else
    {
        NSLog(@"connection is NULL");
    }
    
}

- (void)dismiss
{
    
    [self.navigationController popViewControllerAnimated:YES];
	
   // [self dismissViewControllerAnimated:YES completion:nil];
  
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (!_status){
        selectedSectionNo = [NSString stringWithFormat: @"%ld",(long)indexPath.section];
    }
	if (tableView == self.searchDisplayController.searchResultsTableView)
	{
		[self tableView:self.searchDisplayController.searchResultsTableView accessoryButtonTappedForRowWithIndexPath:indexPath];
		[self.searchDisplayController.searchResultsTableView deselectRowAtIndexPath:indexPath animated:YES];
	}
	else
	{
        if (tableView.tag == kIOS7TableView)
        {
            [selectedItem setObject:[NSNumber numberWithInteger:indexPath.row] forKey:@"rowSelected"];
            _status = false;
            [alertIOS7 close];
            [telsTable deselectRowAtIndexPath:indexPath animated:YES];

            if (showModal)
            {
                BOOL checked = [[selectedItem objectForKey:@"checked"] boolValue];
                
                [selectedItem setObject:[NSNumber numberWithBool:!checked] forKey:@"checked"];
                
                UITableViewCell *cell = [selectedItem objectForKey:@"cell"];
              //   NSLog(@"Value for checked %@",selectedItem);
                
               
                
                UIButton *button = (UIButton *)cell.accessoryView;
                
                UIImage *newImage = (checked) ? [UIImage imageNamed:@"unchecked.png"] : [UIImage imageNamed:@"checked.png"];
                [button setBackgroundImage:newImage forState:UIControlStateNormal];
                
                if (tableView == self.searchDisplayController.searchResultsTableView)
                {
                    [self.searchDisplayController.searchResultsTableView reloadData];
                    [selectedRow addObject:selectedItem];
                }
            }
            
            [self postActionSelectRowAtIndex:indexPath.row
                                     section:indexPath.section
                                 withContext:nil
                                        text:[objectsArray objectAtIndex:indexPath.row]
                                     andItem:selectedItem
                                         row:contactRow];
        }
        else
        {
            [self tableView:self.table accessoryButtonTappedForRowWithIndexPath:indexPath];
            [self.table deselectRowAtIndexPath:indexPath animated:YES];
        }
	}	
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
  //  [table scrollToRowAtIndexPath:indexPath
//                         atScrollPosition:UITableViewScrollPositionTop
//                                 animated:YES];
  //  [table scrollsToTop];
	UITableViewCell *cell = nil;
    static NSString *kCustomCellID;
    
    
    
  self.table.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    if (tableView.tag == kIOS7TableView)
    {
        kCustomCellID = @"iOS7TableView";
        
        cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:kCustomCellID];
        
        if (cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCustomCellID] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleBlue;
            cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
        }

        cell.textLabel.text = [objectsArray objectAtIndex:indexPath.row];
        
        
        NSInteger rowSelected = [[selectedItem valueForKey:@"rowSelected"] integerValue];
        
        if ((rowSelected != -1) && (indexPath.row == rowSelected))
        {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        
        return cell;
    }
    else
    {
        kCustomCellID = @"MyCellID";
        
        cell = [tableView dequeueReusableCellWithIdentifier:kCustomCellID];
        
        if (cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCustomCellID] autorelease];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        }
    }
	
	NSMutableDictionary *item = nil;
	if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        item = (NSMutableDictionary *)[self.filteredListContent objectAtIndex:indexPath.row];
    }
	else
	{
        //-
        NSLog(@"dataArray%@",dataArray);
        NSDictionary *dict = dataArray[0];
        NSLog(@"dict%@",dict);
        NSMutableArray *mutArr = [[NSMutableArray alloc]init];
        
        for (NSString* key in dict)
        {
            NSArray* value = [dict objectForKey:key];
            if (value.count != 0){
                [mutArr addObject:key];
              
            }
    }
  // [mutArr sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
     [mutArr sortUsingSelector:@selector(caseInsensitiveCompare:)];

//---
        
        NSLog(@"mutArr%@",[mutArr objectAtIndex:indexPath.section]);
        NSLog(@"new dataArray%@",[dataArray objectAtIndex:0]);
        NSLog(@"value dataArray%@",[[dataArray objectAtIndex:0] valueForKey:[mutArr objectAtIndex:indexPath.section]]);
		NSMutableArray *obj = [[dataArray objectAtIndex:0] valueForKey:[mutArr objectAtIndex:indexPath.section]];
        
        
//        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
//        [dataArray sortUsingDescriptors:[NSArray arrayWithObject:sort]];
        
		item = (NSMutableDictionary *)[obj objectAtIndex:indexPath.row];
	}
  [[item allKeys] sortedArrayUsingSelector:@selector(compare:)];
	cell.textLabel.text = [item objectForKey:@"name"];
	cell.textLabel.adjustsFontSizeToFitWidth = YES;
     cell.detailTextLabel.text=[item objectForKey:@"email"];
    cell.detailTextLabel.font= [UIFont systemFontOfSize:14];
	[item setObject:cell forKey:@"cell"];
	
	BOOL checked = [[item objectForKey:@"checked"] boolValue];
	UIImage *image = (checked) ? [UIImage imageNamed:@"checked.png"] : [UIImage imageNamed:@"unchecked.png"];
	
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if (!showCheckButton)
        button.hidden = YES;
    else
        button.hidden = NO;
    
	CGRect frame = CGRectMake(0.0, 0.0, image.size.width, image.size.height);
	button.frame = frame;
	
	if (tableView == self.searchDisplayController.searchResultsTableView) 
	{
		button.userInteractionEnabled = NO;
	}
	
	[button setBackgroundImage:image forState:UIControlStateNormal];
    
	[button addTarget:self action:@selector(checkButtonTapped:event:) forControlEvents:UIControlEventTouchUpInside];
	cell.backgroundColor = [UIColor clearColor];
	cell.accessoryView = button;
	
	return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     return self.table.rowHeight = 70.f;
}
- (void)checkButtonTapped:(id)sender event:(id)event
{
	NSSet *touches = [event allTouches];
	UITouch *touch = [touches anyObject];
	CGPoint currentTouchPosition = [touch locationInView:self.table];
	NSIndexPath *indexPath = [self.table indexPathForRowAtPoint: currentTouchPosition];
	
	if (indexPath != nil)
	{
		[self tableView:self.table accessoryButtonTappedForRowWithIndexPath:indexPath];
	}
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    
    if (!_status){
        selectedSectionNo = [NSString stringWithFormat: @"%ld",(long)indexPath.section];
    }
    
    
	NSMutableDictionary *item = nil;
    //-
    NSLog(@"dataArray%@",dataArray);
    NSDictionary *dict = dataArray[0];
    NSLog(@"dict%@",dict);
    NSMutableArray *mutArr = [[NSMutableArray alloc]init];
    
    for (NSString* key in dict)
    {
        NSArray* value = [dict objectForKey:key];
        if (value.count != 0){
            [mutArr addObject:key];
          
        }
     
    }
     [mutArr sortUsingSelector:@selector(caseInsensitiveCompare:)];
  // [mutArr sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];

   
    NSLog(@"mutArr%@",mutArr);
   
    //--
	if (tableView == self.searchDisplayController.searchResultsTableView)
	{
		item = (NSMutableDictionary *)[filteredListContent objectAtIndex:indexPath.row];
	}
	else
	{
		NSMutableArray *obj = [[dataArray objectAtIndex:0] valueForKey:[mutArr objectAtIndex:indexPath.section]];
		item = (NSMutableDictionary *)[obj objectAtIndex:indexPath.row];
	}
    
    objectsArray = nil;
    
    if (requestData == DATA_CONTACT_TELEPHONE)
        objectsArray = [(NSArray *)[[item valueForKey:@"telephone"] componentsSeparatedByString:@","] retain];
    else if (requestData == DATA_CONTACT_EMAIL)
        objectsArray = [(NSArray *)[[item valueForKey:@"email"] componentsSeparatedByString:@","] retain];
    else
        objectsArray = [(NSArray *)[[item valueForKey:@"recordID"] componentsSeparatedByString:@","] retain];

    float sysVer = [[[UIDevice currentDevice] systemVersion] floatValue];
    
    int objectsCount = [objectsArray count];

    if (objectsCount > 1)
    {
        selectedItem = item;
        self.currentTable = tableView;

        if (sysVer >= 7.0)
        {
            contactRow = indexPath.row;
            
            alertIOS7 = [[CustomIOS7AlertView alloc] initWithParentView:self.view];
            
            NSString *language = [[NSLocale preferredLanguages] objectAtIndex:0];
            
            NSString *cancelString = @"";
            
            if ([language containsString:@"es"])
            {
                cancelString = @"Cancelar";
            }
            else
            {
                cancelString = @"Cancel";
            }
            
            [alertIOS7 setContainerView:[self createTableView]];
            [alertIOS7 setButtonTitles:[NSArray arrayWithObjects:cancelString, nil]];
            [alertIOS7 setDelegate:self];
            [alertIOS7 setUseMotionEffects:true];
            [alertIOS7 setUserInteractionEnabled:YES];
            [alertIOS7 setAutoresizesSubviews:YES];
            [alertIOS7 setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
            [alertIOS7 show];
            [alertIOS7 setClipsToBounds:YES];
            
            _status = true;
        }
        else
        {
            alertTable = [[AlertTableView alloc] initWithCaller:self
                                                           data:objectsArray
                                                          title:alertTitle
                                                        context:self
                                                     dictionary:item
                                                        section:indexPath.section
                                                            row:indexPath.row];
            alertTable.isModal = showModal;
            [alertTable show];
            [alertTable release];
        }
    }
    else
    {
        if (showModal)
        {
            BOOL checked = [[item objectForKey:@"checked"] boolValue];
            
            [item setObject:[NSNumber numberWithBool:!checked] forKey:@"checked"];
            
            UITableViewCell *cell = [item objectForKey:@"cell"];
            UIButton *button = (UIButton *)cell.accessoryView;
            
            UIImage *newImage = (checked) ? [UIImage imageNamed:@"unchecked.png"] : [UIImage imageNamed:@"checked.png"];
            [button setBackgroundImage:newImage forState:UIControlStateNormal];
            
            if (tableView == self.searchDisplayController.searchResultsTableView)
            {
                [self.searchDisplayController.searchResultsTableView reloadData];
                [selectedRow addObject:item];
            }
        }
        else
        {
            if ([self.delegate respondsToSelector:@selector(numberOfRowsSelected:withData:andDataType:)])
            {
                [self.delegate numberOfRowsSelected:1
                                           withData:[NSArray arrayWithObject:[item valueForKey:@"telephoneSelected"]]
                                        andDataType:requestData];
            }
        }
    }
}


-(void) iPadDesignInitialization{
    if (IS_IPAD)
    {
        
       [backBtn.titleLabel setFont:[UIFont systemFontOfSize:24.0f]];
    }
        if(IS_IPAD_PRO_1366)
        {
            
            
         [backBtn.titleLabel setFont:[UIFont systemFontOfSize:30.0f]];
        }
}
#pragma mark - connection delegate

-(NSInteger)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
    NSLog(@"response status code: %ld %@", (long)[httpResponse statusCode],httpResponse.debugDescription);
    
    NSLog(@"Received Response");
    webData =[[NSMutableData alloc]init];
    [webData setLength:0];
    
    if((long)[httpResponse statusCode] == ResultOk)
    {
        NSLog(@"Received Response");
        [webData setLength: 0];
        recieved_status = @"passed";
        
    }
    else if ((long)[httpResponse statusCode] == ResultFailed)
    {
        recieved_status = @"failed";
        return [httpResponse statusCode];
        
    }
    return  YES;
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [kappDelegate HideIndicator];
    
    
    if ([[NSString stringWithFormat:@"%@",error] rangeOfString:@"The Internet connection appears to be offline." options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        [HelperAlert  alertWithOneBtn:@"ERROR" description:@"The Internet connection appears to be offline." okBtn:OkButtonTitle];
        return;
    }
    if ([[NSString stringWithFormat:@"%@",error] rangeOfString:@"The network connection was lost" options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        [HelperAlert  alertWithOneBtn:@"ERROR" description:@"The network connection was lost" okBtn:OkButtonTitle];
        return;
    }
    if ([[NSString stringWithFormat:@"%@",error] rangeOfString:@"Could not connect to the server" options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        [HelperAlert  alertWithOneBtn:@"ERROR" description:@"Internet connection lost. Could not connect to the server" okBtn:OkButtonTitle];
        return;
    }
    
    if ([[NSString stringWithFormat:@"%@",error] rangeOfString:@"The request timed out" options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        [HelperAlert  alertWithOneBtn:@"ERROR" description:@"The request timed out. Not able to connect to server" okBtn:OkButtonTitle];
        return;
    }
    [HelperAlert  alertWithOneBtn:@"ERROR" description:@"Intenet connection failed.. Try again later." okBtn:OkButtonTitle];
    NSLog(@"ERROR with the Connection ");
    webData =nil;
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data1
{
    [webData appendData:data1];
    NSLog(@"data Received %@",webData);
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [kappDelegate HideIndicator];
    
    NSLog(@"DONE. Received Bytes: %lu", (unsigned long)[webData length]);
    
    if ([webData length]==0)
        return;
    
    NSString *responseString = [[NSString alloc] initWithData:webData encoding:NSUTF8StringEncoding];
    NSLog(@"responseString:%@",responseString);
    NSError *error;
      SBJsonParser *json = [[SBJsonParser alloc] init];
    NSMutableDictionary *userDetailDict=[json objectWithString:responseString error:&error];
    NSLog(@"user detail%@",userDetailDict);
    if ([responseString isEqualToString:@"true"])
    {
       
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:AlertTitle message:@"Invitation Send Successfully." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
  else if ([responseString isEqualToString:@"false"])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:AlertTitle message:@"Invitation Sending failed Please Try After Some Time." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
  /*********/
        NSArray *getEmails=[userDetailDict valueForKey:@"existingInvitationEmails"];
        
        NSLog(@"getEmails%@",getEmails);
        
        
        NSString *email=[[NSString alloc]init];
       
        if ([getEmails count] > 0) {
            
            for ( int i=0; i< [getEmails count]; i++) {
                

                if (i == 0) {
                    
                  email=[[getEmails objectAtIndex:i]valueForKey:@"Email"];
                }
                else
                {
                    email=[NSString stringWithFormat:@"%@,\n %@",email,[[getEmails objectAtIndex:i]valueForKey:@"Email"]];
                   
                    
                }
                
       
            }
            
            NSLog(@" my email %@",email);
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Invitation has been already sent to the highlighted email address(es)." message:email delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];

        }
        
       else
       {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:AlertTitle message:@"Invitation Sent successfully" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
       }
    }

    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex ==0 ) {
        
       [self.navigationController popViewControllerAnimated:YES];
        
    }}
#pragma mark -
#pragma mark Custom view iOS7

- (UIView *)createTableView
{
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 290, 200)];
    contentView.backgroundColor = [UIColor clearColor];
    
    NSString *currentLanguage = [[[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] objectAtIndex:0] lowercaseString];
    
    NSString *titleAlert = @"";
    
    if ([currentLanguage isEqualToString:@"es"])
	{
        titleAlert = @"Selecciona";
	}
	else
	{
        titleAlert = @"Select";
	}
    
    UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, contentView.frame.size.width, 30)];
    labelTitle.text = titleAlert;
    labelTitle.backgroundColor = [UIColor clearColor];
    labelTitle.textAlignment = NSTextAlignmentCenter;
    labelTitle.textColor = [UIColor blackColor];
    labelTitle.font = [UIFont boldSystemFontOfSize:15];
    
    [contentView addSubview:labelTitle];
    [labelTitle release];
    
    telsTable = [[UITableView alloc] initWithFrame:CGRectMake(11, labelTitle.frame.size.height + 5, contentView.frame.size.width - 22, 165) style:UITableViewStylePlain];
    
    telsTable.backgroundColor = [UIColor whiteColor];
    
    telsTable.scrollEnabled=YES;
    
    telsTable.delegate = self;
    telsTable.dataSource = self;
    
    telsTable.tag = kIOS7TableView;
    [contentView addSubview:telsTable];
    [telsTable reloadData];
    
    return [contentView autorelease];
}
-(IBAction)back:(id)sender
{
    
    [self dismiss];
    
}

#pragma mark
#pragma mark AlertTableViewDelegate delegate method

- (void)didSelectRowAtIndex:(NSInteger)row 
                    section:(NSInteger)section
                withContext:(id)context
                       text:(NSString *)text 
                    andItem:(NSMutableDictionary *)item
                        row:(int)rowSelected
{
    
    
    [self postActionSelectRowAtIndex:row section:section withContext:context text:text andItem:item row:rowSelected];
}

- (void)postActionSelectRowAtIndex:(NSInteger)row
                           section:(NSInteger)section
                       withContext:(id)context
                              text:(NSString *)text
                           andItem:(NSMutableDictionary *)item
                               row:(int)rowSelected
{
    if ([text isEqualToString:@"-1"])
    {
        selectedItem = nil;
        return;
    }
    else if ([text isEqualToString:@"-2"])
    {
        (requestData == DATA_CONTACT_TELEPHONE) ? [selectedItem setValue:@"" forKey:@"telephoneSelected"] : [selectedItem setValue:@"" forKey:@"emailSelected"];
        [selectedItem setObject:[NSNumber numberWithBool:NO] forKey:@"checked"];
        [selectedItem setValue:@"-1" forKey:@"rowSelected"];
        UITableViewCell *cell = [selectedItem objectForKey:@"cell"];
        UIButton *button = (UIButton *)cell.accessoryView;
        
        UIImage *newImage = [UIImage imageNamed:@"unchecked.png"];
        [button setBackgroundImage:newImage forState:UIControlStateNormal];
    }
    else
    {
        (requestData == DATA_CONTACT_TELEPHONE) ? [selectedItem setValue:text forKey:@"telephoneSelected"] : [selectedItem setValue:text forKey:@"emailSelected"];
        [selectedItem setObject:[NSNumber numberWithBool:YES] forKey:@"checked"];
        
        UITableViewCell *cell = [selectedItem objectForKey:@"cell"];
        UIButton *button = (UIButton *)cell.accessoryView;
        
        UIImage *newImage = [UIImage imageNamed:@"checked.png"];
        [button setBackgroundImage:newImage forState:UIControlStateNormal]; 
        [button reloadInputViews];
        
        if (self.currentTable == self.searchDisplayController.searchResultsTableView)
        {
            [self.searchDisplayController.searchResultsTableView reloadData];
            [selectedRow addObject:selectedItem];
        }
    }
    
    if (self.currentTable == self.searchDisplayController.searchResultsTableView)
	{
        [filteredListContent replaceObjectAtIndex:rowSelected withObject:item];
	}
	else
	{
        //////----->>
        NSLog(@"The all data is%@",dataArray);
        
        
        //////----->>
        NSLog(@"%@",dataArray);
        NSDictionary *dict = dataArray[0];
        NSLog(@"%@",dict);
        NSMutableArray *mutArr = [[NSMutableArray alloc]init];
        
        for (NSString* key in dict)
        {
            NSArray* value = [dict objectForKey:key];
            
            NSLog(@"value is %@",value);
            if (value.count != 0){
                
                [mutArr addObject:key];
           
            }
        }
         [mutArr sortUsingSelector:@selector(caseInsensitiveCompare:)];
		NSMutableArray *obj = [[dataArray objectAtIndex:0] valueForKey:[mutArr objectAtIndex:[selectedSectionNo integerValue]]];
		[obj replaceObjectAtIndex:rowSelected withObject:item];
        [mutArr sortUsingSelector:@selector(caseInsensitiveCompare:)];
	}
    
    selectedItem = nil;
    
    if (!showModal) 
    {
        if ([self.delegate respondsToSelector:@selector(numberOfRowsSelected:withData:andDataType:)])
        {
            [self.delegate numberOfRowsSelected:1 
                                       withData:[NSArray arrayWithObject:[item valueForKey:@"telephoneSelected"]]
                                    andDataType:requestData];
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    if (tableView.tag == kIOS7TableView)
        return [objectsArray count];
    
	if (tableView == self.searchDisplayController.searchResultsTableView)
        return [self.filteredListContent count];
	//-
    NSLog(@"%@",dataArray);
    NSDictionary *dict = dataArray[0];
    NSLog(@"%@",dict);
    NSMutableArray *mutArr = [[NSMutableArray alloc]init];
    
    for (NSString* key in dict)
    {
        NSArray* value = [dict objectForKey:key];
        if (value.count != 0){
            [mutArr addObject:key];
            
   
    }
}
     [mutArr sortUsingSelector:@selector(caseInsensitiveCompare:)];
    

    //-
	int i = 0;
	NSString *sectionString = [mutArr objectAtIndex:section];
	
	NSArray *array = (NSArray *)[[dataArray objectAtIndex:0] valueForKey:sectionString];
    
	for (NSDictionary *dict in array)
	{
		NSString *name = [dict valueForKey:@"name"];
		name = [name stringByReplacingOccurrencesOfString:@" " withString:@""];
		
		if (![name isLetterInAlphabet:mutArr])
		{
			i++;
		}
		else
		{
			if ([[[name substringToIndex:1] uppercaseString] isEqualToString:[mutArr objectAtIndex:section]]) 
			{
				i++;
			}
		}
	}
	
	return i;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView 
{
	if ((tableView == self.searchDisplayController.searchResultsTableView) ||
        (tableView.tag == kIOS7TableView))
	{
        return nil;
    }
	
    return arrayLetters;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
	if ((tableView == self.searchDisplayController.searchResultsTableView) ||
        (tableView.tag == kIOS7TableView))
	{
        return 0;
    }
	
    return [arrayLetters indexOfObject:title];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	if ((tableView == self.searchDisplayController.searchResultsTableView) ||
        (tableView.tag == kIOS7TableView))
	{
        return 1;
    }
    
	//--
    
    
    NSLog(@"%@",dataArray);
    NSDictionary *dict = dataArray[0];
    NSLog(@"%@",dict);
    NSMutableArray *mutArr = [[NSMutableArray alloc]init];
  
    for (NSString* key in dict)
    {
        NSArray* value = [dict objectForKey:key];
        
        NSLog(@"value is %@",value);
        if (value.count != 0){
            
            [mutArr addObject:key];

        }
    }
     [mutArr sortUsingSelector:@selector(caseInsensitiveCompare:)];
 
  
	return [mutArr count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section 
{	
	if ((tableView == self.searchDisplayController.searchResultsTableView) ||
        (tableView.tag == kIOS7TableView))
	{
        return @"";
    }
    //--->
   
        NSLog(@"%@",dataArray);
        NSDictionary *dict = dataArray[0];
        NSLog(@"%@",dict);
      NSMutableArray *mutArr = [[NSMutableArray alloc]init];
    
        for (NSString* key in dict)
        {
            NSArray* value = [dict objectForKey:key];
            if (value.count != 0){
                [mutArr addObject:key];
            }
            
            
        }
    
     [mutArr sortUsingSelector:@selector(caseInsensitiveCompare:)];
  
    
	return [mutArr objectAtIndex:section];
}

#pragma mark -
#pragma mark Content Filtering

- (void)displayChanges:(BOOL)yesOrNO
{
	int elements = [filteredListContent count];
	NSMutableArray *selected = [NSMutableArray new];
	for (int i = 0; i < elements; i++)
	{
		NSMutableDictionary *item = (NSMutableDictionary *)[filteredListContent objectAtIndex:i];
		
		BOOL checked = [[item objectForKey:@"checked"] boolValue];
		
		if (checked)
		{
			[selected addObject:item];
		}
	}
	
	for (int i = 0; i < [arrayLetters count]; i++)
	{
		NSMutableArray *obj = [[dataArray objectAtIndex:0] valueForKey:[arrayLetters objectAtIndex:i]];
		
		for (int x = 0; x < [obj count]; x++)
		{
			NSMutableDictionary *item = (NSMutableDictionary *)[obj objectAtIndex:x];
            
			if (yesOrNO)
			{
				for (NSDictionary *d in selected)
				{
					if (d == item)
					{
						[item setObject:[NSNumber numberWithBool:yesOrNO] forKey:@"checked"];
					}
				}
			}
			else 
			{
				for (NSDictionary *d in selectedRow)
				{
					if (d == item)
					{
						[item setObject:[NSNumber numberWithBool:yesOrNO] forKey:@"checked"];
					}
				}
			}
		}
	}
	
	[selected release];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)_searchBar
{
	selectedRow = [NSMutableArray new];
	[self.searchDisplayController.searchBar setShowsCancelButton:NO];
   [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,[NSValue valueWithUIOffset:UIOffsetMake(0, 1)],UITextAttributeTextShadowOffset,nil] forState:UIControlStateNormal];
    [self.searchDisplayController.searchBar setTintColor:[UIColor whiteColor]];
        
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)_searchBar
{
	selectedRow = nil;
	[self displayChanges:NO];
	[self.searchDisplayController setActive:NO];
	[self.table reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)_searchBar
{
	[self displayChanges:YES];
	[self.searchDisplayController setActive:NO];
	[self.table reloadData];
}

- (void)filterContentForSearchText:(NSString *)searchText scope:(NSString*)scope
{
	[self.filteredListContent removeAllObjects];
    
	for (int i = 0; i < [arrayLetters count]; i++)
	{
		NSMutableArray *obj = [[dataArray objectAtIndex:0] valueForKey:[arrayLetters objectAtIndex:i]];
		
		for (int x = 0; x < [obj count]; x++)
		{
			NSMutableDictionary *item = (NSMutableDictionary *)[obj objectAtIndex:x];
			
			NSString *name = [[item valueForKey:@"name"] lowercaseString];
			name = [name stringByReplacingOccurrencesOfString:@" " withString:@""];
			
			NSComparisonResult result = [name compare:[searchText lowercaseString] options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
			if (result == NSOrderedSame)
			{
				[self.filteredListContent addObject:item];
			}
		}
	}
}

#pragma mark -
#pragma mark UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:
	 [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
	 [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
    return YES;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation))
    {
        if (alertIOS7 != nil)
        {
            NSLog(@"landscape");
            [alertIOS7 layoutSubviews];
            [alertIOS7 layoutIfNeeded];
        }
    }
    else
    {
        if (alertIOS7 != nil)
        {
            [alertIOS7 layoutSubviews];
            [alertIOS7 layoutIfNeeded];
            NSLog(@"portrait again!");
        }
    }
}

#pragma mark -
#pragma mark CustomIOS7AlertViewDelegate methods

- (void)customIOS7dialogButtonTouchUpInside:(CustomIOS7AlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    _status = false;
    [alertView close];
}

- (void)dealloc
{
    [dataArray release];
    [objectsArray release];
    [telsTable release];
	self.filteredListContent = nil;
    self.arrayLetters = nil;
	[super dealloc];
}

@end
