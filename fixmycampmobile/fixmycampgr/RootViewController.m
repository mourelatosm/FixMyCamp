//
//  RootViewController.m
//  NavApp
//
//  Created by Marios Mourelatos on 4/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "ViewTwoController.h"
#import "MapsViewController.h"

#define kOFFSET_FOR_KEYBOARD 160.0


@implementation RootViewController

@synthesize viewTwoController;
@synthesize mapsViewController;

@synthesize password;
@synthesize username;
@synthesize email;
@synthesize activityIndicator;


-(IBAction)switchPage:(id)sender
{
    if (viewTwoController == nil) 
    {
        ViewTwoController *viewTwo = [[ViewTwoController alloc] initWithNibName:@"ViewTwoController" bundle:[NSBundle mainBundle]];
        self.viewTwoController = viewTwo;
        [viewTwo release];
    }
    
    [self.navigationController pushViewController:self.viewTwoController animated:YES];
}

-(IBAction)switchMaps:(id)sender;
{
    if (mapsViewController == nil) 
    {
        MapsViewController *viewTwo = [[MapsViewController alloc] initWithNibName:@"MapsViewController" bundle:[NSBundle mainBundle]];
        self.mapsViewController = viewTwo;
        [viewTwo release];
    }
    
    [self.navigationController pushViewController:self.mapsViewController animated:YES];
}

//############################################################################################################################################################



//xeirismos kai estiash pliktrologeiou

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard 
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}

//---when a TextField view begins editing---
// apo to textFieldView pairnw kai swzw sto currentTextField ton tipw tou textfield pou molis patithike
-(void) textFieldDidBeginEditing:(UITextField *)textFieldView 
{  
	currentTextField = textFieldView;
} 

// when the user taps the return key on the keybord
-(BOOL) textFieldShouldReturn:(UITextField *) textFieldView 
{  
	[textFieldView resignFirstResponder];
    return NO;
}

-(void) textFieldDidEndEditing:(UITextField *) textFieldView 
{  
	currentTextField = nil;
}


-(void) keyboardDidShow:(NSNotification *) notification 
{
	if (keyboardIsShown) return;
	
    NSDictionary* info = [notification userInfo];
	
	//---obtain the size of the keyboard---
	NSValue *aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];	
	CGRect keyboardRect = [self.view convertRect:[aValue CGRectValue] fromView:nil];
    
	NSLog(@"%f", [aValue CGRectValue].size.height);
    
	NSLog(@"%f", keyboardRect.size.height);
	
    //---resize the scroll view (with keyboard)---
    CGRect viewFrame = [self.view frame];
    viewFrame.size.height -= keyboardRect.size.height;
    self.view.frame = viewFrame;
	
    //---scroll to the current text field---
    CGRect textFieldRect = [currentTextField frame];
    [self.view scrollRectToVisible:textFieldRect animated:YES];
    
    keyboardIsShown = YES;
}

//---when the keyboard disappears---
-(void) keyboardDidHide:(NSNotification *) notification {
	NSDictionary* info = [notification userInfo];
	
	//---obtain the size of the keyboard---
    NSValue* aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
	CGRect keyboardRect = [self.view convertRect:[aValue CGRectValue] fromView:nil];
    
    //---resize the scroll view back to the original size (without keyboard)---
    CGRect viewFrame = [self.view frame];
    viewFrame.size.height += keyboardRect.size.height;
    self.view.frame = viewFrame;
	
    keyboardIsShown = NO;
}

/*
- (void)keyboardWillShow:(NSNotification *)notif
{
    //keyboard will be shown now. depending for which textfield is active, move up or move down the view appropriately
    
    if ([username isFirstResponder] && self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    if (![username isFirstResponder] && self.view.frame.origin.y < 0)
    {
        //[self setViewMovedUp:NO];
    }
    if ([password isFirstResponder] && self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    if (![password isFirstResponder] && self.view.frame.origin.y < 0)
    {
        //[self setViewMovedUp:NO];
    }
    if ([email isFirstResponder] && self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    if (![email isFirstResponder] && self.view.frame.origin.y < 0)
    {
        //[self setViewMovedUp:NO];
    }
}
*/



-(void) viewWillAppear:(BOOL)animated {    
    //---registers the notifications for keyboard---
    [[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(keyboardDidShow:) 
												 name:UIKeyboardDidShowNotification 
											   object:self.view.window]; 
    
    [[NSNotificationCenter defaultCenter]	 addObserver:self
											  selector:@selector(keyboardDidHide:)
												  name:UIKeyboardDidHideNotification
												object:nil];
}

-(void) viewWillDisappear:(BOOL)animated {
	//---removes the notifications for keyboard---
    [[NSNotificationCenter defaultCenter] removeObserver:self 
													name:UIKeyboardWillShowNotification 
												  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self 
													name:UIKeyboardWillHideNotification 
												  object:nil];
}

//############################################################################################################################################################


//webService
-(IBAction)btnSaveUser:(id)sender
{
    NSString *soapMsg = 
    [NSString stringWithFormat:
     @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
     "<S:Envelope xmlns:S=\"http://schemas.xmlsoap.org/soap/envelope/\">"
     "<S:Header/>"
     "<S:Body>"
     "<ns2:sighnUpUser xmlns:ns2=\"http://lastgo/\">"
     "<username>%@</username>"
     "<password>%@</password>"
     "<email>%@</email>"
     "</ns2:sighnUpUser>"
     "</S:Body>"
     "</S:Envelope>", username.text, password.text, email.text];
    
    NSLog(@"%@", soapMsg);
    NSURL *url = [NSURL URLWithString:@"http://localhost:8080/LastGo/LoginWSService?wsdl"];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    
    
    NSString *msgLength = [NSString stringWithFormat:@"%d",[soapMsg length]];
    [req addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue:@"http://localhost:8080/LastGo/LoginWSService?wsdl" forHTTPHeaderField:@"SOAPAction"];
    
    [req addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    [activityIndicator startAnimating];
    
    
    //gia ekgathidrish ths sindeshs xrisismopoiw thn NSURLConnection me to req object pou molis dimiourgisa parapanw
    conn = [[NSURLConnection alloc] initWithRequest:req delegate:self];
    
    if (conn)
    {
        webData = [[NSMutableData data] retain];
    }
}

//When data starts streaming in from the Web service, the connection:didReceiveResponse: method is called
-(void) connection:(NSURLConnection *)connection 
didReceiveResponse:(NSURLResponse *)response
{
    [webData setLength: 0];
}

//As the data progressively comes in from the Web service, the connection:didReceiveData: method is called.
-(void) connection:(NSURLConnection *) connection
    didReceiveData:(NSData *) data
{
    [webData appendData:data];
}

//If there is an error during the transmission, the connection:didFailWithError: method is called:
-(void) connection:(NSURLConnection *) connection
  didFailWithError:(NSError *) error
{
    [webData release];
    [connection release];
}

//When the connection has finished and successfully downloaded the response, the connectionDidFinishLoading: method is called
-(void) connectionDidFinishLoading:(NSURLConnection *) connection 
{
    NSLog(@"DONE. Received Bytes: %d", [webData length]);
    NSString *theXML = [[NSString alloc]
                        initWithBytes:[webData mutableBytes]
                        length:[webData length]
                        encoding:NSUTF8StringEncoding];
    
    
    //shows the xml
    NSLog(@"%@",theXML);
    [theXML release];
    //stop animating         
    [activityIndicator stopAnimating];
    
    if (xmlParser) 
    {
        [xmlParser release];
    }
    
    
    //Initializing of the parser
    xmlParser = [[NSXMLParser alloc] initWithData: webData];
    [xmlParser setDelegate:self];
    [xmlParser setShouldResolveExternalEntities:YES];
    [xmlParser parse];
    
    
    
    [connection release];
    
    [webData release];
    
}

//Fired when the start tag of an element is found
-(void) parser:(NSXMLParser *) parser
didStartElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qName 
    attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"return"]) 
    {
        if (!soapResults)
        {
            NSLog(@"den vrethike to element name");
            soapResults = [[NSMutableString alloc] init];
        }
        elementFound = YES;
    }
    NSLog(@"den vrethike to element name");
}


//Fired when the text in an element is found---
-(void)parser:(NSXMLParser *) parser
foundCharacters:(NSString *)string
{
    if(elementFound)
    {
        [soapResults appendString:string];
    }
}

//Fired when the end of an element found
-(void)parser:(NSXMLParser *)parser
didEndElement:(NSString *)elementName
 namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"return"]) 
    {
        NSLog(@"%@", soapResults);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"User saved" message:soapResults delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
        [alert release];
        [soapResults setString:@""];
        elementFound = FALSE;
    }
}



-(void)dealloc
{
    [soapResults release];
    
    [password release];
    [username release];
    [activityIndicator release];
    [super  dealloc];
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
