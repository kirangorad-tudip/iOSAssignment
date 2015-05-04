//
//  ViewController.h
//  DBDemo
//  Author: Kiran Gorad
//  Created by tudip on 02/05/15.
//  Copyright (c) 2015 MM-10. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
@interface ViewController : UIViewController<UITextFieldDelegate>
{
    sqlite3 *contactDB;
    NSString *databasePath;
    UIAlertView *alert;
    IBOutlet UIScrollView *myScrollView;
    IBOutlet UITextField *regNoTextField;
    IBOutlet UITextField *yearTextField;
    IBOutlet UITextField *departmentTextField;
    IBOutlet UITextField *nameTextField;
    IBOutlet UITextField *findByRegisterNumberTextField;
    
}

- (IBAction)saveData:(id)sender;
- (IBAction)findData:(id)sender;


@end

