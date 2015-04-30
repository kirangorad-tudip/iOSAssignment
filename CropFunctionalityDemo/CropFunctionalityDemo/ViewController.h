//
//  ViewController.h
//  CropFunctionalityDemo
//
//  Created by tudip on 30/04/15.
//  Copyright (c) 2015 MM-10. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet UIButton *takePhoto;
- (IBAction)cropPhoto:(id)sender;

- (IBAction)takeImage:(id)sender;
@end

