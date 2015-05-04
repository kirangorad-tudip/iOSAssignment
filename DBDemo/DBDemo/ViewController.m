//
//  ViewController.m
//  DBDemo
//  Author: Kiran Gorad
//  Created by tudip on 02/05/15.
//  Copyright (c) 2015 MM-10. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    NSString *docsDir;
    NSArray *dirPaths;
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"contacts.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if ([filemgr fileExistsAtPath: databasePath ] == NO)
    {
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS CONTACTS (ID INTEGER PRIMARY KEY, NAME TEXT, DEPT TEXT, YEAR TEXT)";
            
            if (sqlite3_exec(contactDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                [self showAlert:@"Failed to create table"];
            }
            
            sqlite3_close(contactDB);
            
            } else {
                
                [self showAlert:@"Failed to open/create database"];
        }
    }
    
    [super viewDidLoad];}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveData:(id)sender {
    sqlite3_stmt    *statement;
    
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO CONTACTS (id, name, dept, year) VALUES (\"%@\", \"%@\", \"%@\", \"%@\")", regNoTextField.text, nameTextField.text, departmentTextField.text, yearTextField.text];
        
        const char *insert_stmt = [insertSQL UTF8String];
        
        sqlite3_prepare_v2(contactDB, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            [self showAlert:@"Contact added"];
            regNoTextField.text = @"";
            nameTextField.text = @"";
            departmentTextField.text = @"";
            yearTextField.text = @"";

        } else {
            [self showAlert:@"Failed to add contact"];
        }
        sqlite3_finalize(statement);
        sqlite3_close(contactDB);
    }
}

- (IBAction)findData:(id)sender {
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt    *statement;
    
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT id, name, dept, year FROM contacts WHERE id=\"%@\"", findByRegisterNumberTextField.text];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *idField = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                NSString *nameField = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                NSString *deptField = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                NSString *yearField = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                
                [self showAlert:@"Match found"];
                
                regNoTextField.text = idField;
                nameTextField.text = nameField;
                departmentTextField.text = deptField;
                yearTextField.text = yearField;
  

            } else {
                
                [self showAlert:@"Match not found"];
                regNoTextField.text = @"";
                nameTextField.text = @"";
                departmentTextField.text = @"";
                yearTextField.text = @"";

            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)showAlert :(NSString*)alertMsg {
    alert = [[UIAlertView alloc] initWithTitle:nil
                                       message:alertMsg
                                      delegate:self
                             cancelButtonTitle:@"OK"
                             otherButtonTitles:nil];
    [alert show];
}

-(void) hideAlert
{
    if( alert )
    {
        [alert dismissWithClickedButtonIndex:0 animated:YES];
        alert = nil;
    }
    
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

@end
