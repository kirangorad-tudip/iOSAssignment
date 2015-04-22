//
//  ViewController.m
//  IOSAssignments
//
//  Created by tudip on 23/04/15.
//  Copyright (c) 2015 MM-10. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)openActionSheet:(id)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Select 1",@"Select 2", nil];
    
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex==0) {
        
    }
    else if (buttonIndex==1) {
        
    }
    else if (buttonIndex==2) {
        
    }
    
}

#pragma mark UIActivityViewController implementation
- (IBAction)openShareSheet:(id)sender {
    
    NSString *shareUrl = @"http://tudip.com";
    
    NSURL *myWebsite = [NSURL URLWithString:shareUrl];
    
    NSArray *objectsToShare = @[self, myWebsite];
    
    UIActivityViewController *shareView = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    
    [shareView setValue:@"Lassy Project" forKey:@"subject"];
    
    [self presentViewController:shareView animated:YES completion:nil];

}

- (id)activityViewController:(UIActivityViewController *)activityViewController itemForActivityType:(NSString *)activityType {
   
    NSString *shareString = @"";
    
    if ([activityType isEqualToString:UIActivityTypePostToFacebook]) {
        shareString = @"Tudip Technologies";
    } else if ([activityType isEqualToString:UIActivityTypePostToTwitter]) {
        shareString = @"Tudip Technologies";
    }else if ([activityType isEqualToString:UIActivityTypeMessage]) {
        shareString = @"Tudip Technologies";
    }else if ([activityType isEqualToString:UIActivityTypeMail]) {
        shareString = @"Tudip Technologies";
    }
    
    return shareString;
    
}

@end
