//
//  SignUpViewController.m
//  Charting
//
//  Created by Suman Roy on 30/11/15.
//  Copyright (c) 2015 sourcebits. All rights reserved.
//

#import "SignUpViewController.h"
#import "UserDataController.h"
#import "User.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController{
    
    NSOperationQueue *signUpQueue;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [ self.signUpActivityIndicator setHidden:YES ];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)userSignUp:(id)sender {
    
    [ self.signUpActivityIndicator startAnimating ];
    [ self.signUpWaitingView setHidden:NO ];
    
    [ [ NSOperationQueue mainQueue ] addOperationWithBlock:^{  BOOL userSignUpStatus = [ UserDataController createNewUser:self.userNameTextField.text
                                                                                                                 password:self.passwordTextField.text
                                                                                                                  emailId:self.emailTextField.text ];
        [ self.signUpWaitingView setHidden:YES ];
        
        [ self.signUpActivityIndicator stopAnimating ];
        
        if (userSignUpStatus) {
            
            UITabBarController *mainTabBar = [ self.storyboard instantiateViewControllerWithIdentifier:@"TabBarController"];
            
            [ self presentViewController:mainTabBar animated:YES completion:nil ];
            
        } else {
            
            [ self.userNameTextField setText:@"" ];
            [ self.passwordTextField setText:@"" ];
            [ self.emailTextField setText:@"" ];
            [ self.confirmPasswordTextField setText:@"" ];
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                                message:@"Email already exists"
                                                               delegate:self
                                                      cancelButtonTitle:nil
                                                      otherButtonTitles:@"OK",nil];
            [alertView show];
            
        }
    }];
    
    
    
}

@end
