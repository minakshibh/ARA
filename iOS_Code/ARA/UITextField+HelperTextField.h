//
//  UITextField+HelperTextField.h
//  HelperApp
//
//  Created by Poonam Parmar on 3/9/15.
//  Copyright (c) 2015 MSS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (HelperTextField) <UITextFieldDelegate>




/*with this method you can check email validation
 Bool will return yes or no
 */
-(BOOL)emailValidation;





/*with this method you can check phone number validation
 Bool will return yes or no
 */
-(BOOL)numberValidation;





/*with this method you can ristrict user to enter letters
 User can enter only numbers
 */
-(void)enterOnlyNumber;




/*with this method you can ristrict user to enter numbers
 User can enter only letters
 */

-(void)enterOnlyLetters;




/*with this method you can ristrict user to enter special characters
 User can enter only letters and numbers
 */
-(void)ristrictSpecialChar;


- (void)textfieldwithLabel;
- (void)textfieldwithLabelBlack;

-(BOOL)isEmpty;

@end
