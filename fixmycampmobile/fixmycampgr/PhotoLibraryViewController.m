//
//  PhotoLibraryViewController.m
//  PhotoLibrary
//
//  Created by Marios Mourelatos on 9/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PhotoLibraryViewController.h"


@implementation PhotoLibraryViewController


@synthesize imageView;


- (void)viewDidLoad
{
    imagePicker = [[UIImagePickerController alloc] init];
    [super viewDidLoad];
}

- (NSString *) filePath: (NSString *) fileName 
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    return [documentsDir stringByAppendingPathComponent:fileName];
}

- (void) saveImage
{
    //---get the data from the ImageView---
    NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation(imageView.image)];
	
    //---write the data to file---
    [imageData writeToFile:[self filePath:@"MyPicture.png"] atomically:YES];
}

- (IBAction) btnClicked: (id) sender
{
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.allowsEditing =YES;
    
    //   NSArray *mediaTypes = [NSArray arrayWithObjects: kUTTypeImage, kUTTypeMovie, nil];
    
    //   imagePicker.mediaTypes = mediaTypes;
    
    //---show the Image Picker---
    NSLog(@"show image picker");
    [self presentModalViewController:imagePicker animated:YES];
}

- (IBAction)btn1Clicked:(id)sender
{
    
    imagePicker.delegate = self;
    //---show the camera---
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;

    //imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
    imagePicker.allowsEditing = YES;
    
    
    //---show the Image Picker---
    NSLog(@"show image picker");
    [self presentModalViewController:imagePicker animated:YES];    
}




- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info 
{
    UIImage *image;
    NSURL *mediaUrl;
    mediaUrl = (NSURL *)[info valueForKey:UIImagePickerControllerMediaURL];
	
    if (mediaUrl == nil)
    {
        NSLog(@"mediaUrl is nil");
        image = (UIImage *) [info valueForKey:UIImagePickerControllerEditedImage];
        if (image == nil) 
        {
            NSLog(@"image is nil");
            //---original image selected---
            image = (UIImage *) [info valueForKey:UIImagePickerControllerOriginalImage];
			
            //---display the image---
            imageView.image = image;
			
			//---save the image captured---
            [self saveImage];
        }
        else //---edited image picked---
        {
            //---get the cropping rectangle applied to the image---
            CGRect rect = [[info valueForKey:UIImagePickerControllerCropRect] CGRectValue];

			
            //---display the image---
            NSLog(@"display the image");
            imageView.image = image;
            
            [self saveImage];
			
        }
    }

    //---hide the Image Picker---
    NSLog(@"hide the image picker");
    [picker dismissModalViewControllerAnimated:YES];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    //---user did not select image/video; hide the Image Picker---
    [picker dismissModalViewControllerAnimated:YES];
}

- (void)dealloc {
	[imageView release];
    [imagePicker release];
    [super dealloc];
}



- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
 - (void)viewDidLoad
 {
 [super viewDidLoad];
 }
 */

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


@end
