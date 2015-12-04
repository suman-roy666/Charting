//
//  LogoutViewController.m
//  Charting
//
//  Created by Suman Roy on 26/11/15.
//  Copyright (c) 2015 sourcebits. All rights reserved.
//

#import "LogoutViewController.h"
#import "ChannelDataController.h"
#import "User.h"
#import "SignInViewController.h"
#import "UserDataController.h"
#import "ServerConnectionManager.h"

@interface LogoutViewController ()

@end

@implementation LogoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)logoutUser:(id)sender {
    
    BOOL status = [ UserDataController logOutUser ];
    
    if ( status ) {
        SignInViewController *logOutResultViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"UserSignInNavigationController"];
        
        [ self presentViewController:logOutResultViewController animated:YES completion:nil ];
        
    } else {
        
        UIAlertView *login = [[ UIAlertView alloc] initWithTitle:@"Logout Failed"
                                                         message:@"User Blocked or Already Logged Out"
                                                        delegate:self
                                               cancelButtonTitle:@"Try Again"
                                               otherButtonTitles: nil ];
        
        [ login show ];
    }
}
@end
