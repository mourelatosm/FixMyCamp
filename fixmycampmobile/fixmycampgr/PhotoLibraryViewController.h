//
//  PhotoLibraryViewController.h
//  NavApp
//
//  Created by Marios Mourelatos on 22/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoLibraryViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    IBOutlet UIImageView *imageView;
    UIImagePickerController *imagePicker;
}

@property (nonatomic, retain) UIImageView *imageView;

-(IBAction) btnClicked:(id)sender;
-(IBAction) btn1Clicked:(id)sender;



@end