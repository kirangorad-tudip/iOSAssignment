//
//  DetailViewController.h
//  DBDemo
//
//  Created by tudip on 02/05/15.
//  Copyright (c) 2015 MM-10. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

