//
//  ViewController.m
//  CropFunctionalityDemo
//
//  Created by tudip on 30/04/15.
//  Copyright (c) 2015 MM-10. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIImagePickerControllerDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) UIImagePickerController *imgPickerCtr;
@end
@implementation ViewController
@synthesize scrollView,imgPickerCtr,imageView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (UIImage *)captureScreen {
    UIGraphicsBeginImageContextWithOptions(self.view.frame.size, YES, 0.0f);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (IBAction)cropPhoto:(id)sender {
    
    UIImage *croppedImg = nil;
    CGRect cropRect = CGRectMake(200,200,400,400);
    
    croppedImg = [self croppIngimageByImageName:[self captureScreen] toRect:cropRect];
    imageView.image = croppedImg;
}

- (UIImage *)croppIngimageByImageName:(UIImage *)imageToCrop toRect:(CGRect)rect
{
    CGImageRef imageRef = CGImageCreateWithImageInRect([imageToCrop CGImage], rect);
    UIImage *cropped = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    NSLog(@"crop called");
    return cropped;
}


- (IBAction)takeImage:(id)sender {
    
    self.imgPickerCtr = [[UIImagePickerController alloc] init];
    self.imgPickerCtr.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.imgPickerCtr.delegate = self;
    //self.imgPickerCtrl.allowsEditing = YES;
    //self.imgPickerCtrl.showsCameraControls = NO;
    [self presentViewController:self.imgPickerCtr animated:YES completion:nil];
    
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //You can retrieve the actual UIImage
    UIImage *image;
    image = [info valueForKey:UIImagePickerControllerOriginalImage];
    //image = [info valueForKey:UIImagePickerControllerEditedImage];
    //Or you can get the image url from AssetsLibrary
    //self.path = [info valueForKey:UIImagePickerControllerOriginalImage];
    //NSData *imgData = UIImageJPEGRepresentation(image, 1); //1 it represents the quality of the image.
    [imgPickerCtr dismissViewControllerAnimated:YES completion:^{
        
        
        if(image){
            imageView.image = image;
            //self.isAChildPhotoPresent = YES;
           // child_photourl = nil;
            
            //CGSize size = CGSizeMake(100, 100);
            //UIImage *resizeImage = [self reSizeImage:image toSize:size];
            //NSData *imgData = UIImageJPEGRepresentation(resizeImage, 1);
           // picOfChild.image = resizeImage;
            //new image make this saveable. enable button
           // if(txt_childname.text.length>0){
            //    self.navigationItem.rightBarButtonItem.enabled = YES;
            //}
        }
        
    }];
}

@end
