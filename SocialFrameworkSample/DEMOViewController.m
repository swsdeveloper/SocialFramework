//
//  DEMOViewController.m
//  SocialFrameworkSample
//
//  Created by Steven Shatz on 2/13/15.
//  Copyright (c) 2015 Steven Shatz. All rights reserved.ved.
//

#import "DEMOViewController.h"
#import <Social/Social.h>
#import "Constants.h"

@interface DEMOViewController ()

@end

@implementation DEMOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action Methods

// The SLComposeViewController class presents a view to the user to compose a post for supported social networking services.
//
// isAvailableForServiceType: - returns whether you can send a request for a particular service type.
//  For the account to be available, the user must be logged into the social service in the device settings.
//
// setInitialText: - sets the initial text to be posted.
//  This method returns NO if text does not fit in the currently available character space or if the view controller has already been presented to the user (and therefore cannot be changed).
//  Character limits are dependent on the target service and are documented by the service provider.
//
// addURL:URLWithString: - adds a url to be posted (same restrictions as for initial text)
//
// After presenting the view controller, only the user can edit the post.

- (IBAction)btnFacebookSharing_Clicked:(id)sender{
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *fbSheetOBJ = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        if (fbSheetOBJ) {
            [fbSheetOBJ setInitialText:@"TurnToTech - NYC"];
            [fbSheetOBJ addURL:[NSURL URLWithString:@"http://turntotech.io"]];
            [fbSheetOBJ addImage:[UIImage imageNamed:@"angkor2.jpg"]];
            
            fbSheetOBJ.completionHandler = ^(SLComposeViewControllerResult result){
                if (result) {
                    NSLog(@"User submitted Facebook post");
                } else {
                    NSLog(@"User cancelled Facebook post");
                }
            };
            
            [self presentViewController:fbSheetOBJ animated:YES completion:Nil];
        } else {
            [self displayErrorAlert];
        }
        
    } else {
        [self displayLogInAlertForSocialNetwork:@"Facebook"];
    }
}
- (IBAction)btnTwitterSharing_Clicked:(id)sender{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheetOBJ = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        if (tweetSheetOBJ) {
            [tweetSheetOBJ setInitialText:@"TurnToTech - NYC"];
            [tweetSheetOBJ addURL:[NSURL URLWithString:@"http://turntotech.io"]];
            
            tweetSheetOBJ.completionHandler = ^(SLComposeViewControllerResult result){
                if (result) {
                    NSLog(@"User submitted Twitter post");
                } else {
                    NSLog(@"User cancelled Twitter post");
                }
            };
            
            [self presentViewController:tweetSheetOBJ animated:YES completion:Nil];
        } else {
            [self displayErrorAlert];
        }

    } else {
        [self displayLogInAlertForSocialNetwork:@"Twitter"];
    }
}

#pragma mark - Alert Methods

- (void)displayLogInAlertForSocialNetwork:(NSString *)socialNetwork {
    NSString *alertTitle = @"WARNING";
    NSString *alertMessage = [NSString stringWithFormat:@"Please log into %@.", socialNetwork];
    [self displayAlertWithTitle:alertTitle andMessage:alertMessage];
}

- (void)displayErrorAlert {
    NSString *alertTitle = @"ERROR";
    NSString *alertMessage = @"Attempt to create action sheet failed.";
    [self displayAlertWithTitle:alertTitle andMessage:alertMessage];
}

- (void)displayAlertWithTitle:(NSString *)title andMessage:(NSString *)message {
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:title
                                          message:message
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   NSLog(@"OK action");
                               }];
    
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
