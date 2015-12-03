//
//  SignInViewController.m
//  Charting
//
//  Created by Suman Roy on 25/11/15.
//  Copyright (c) 2015 sourcebits. All rights reserved.
//
#import "SignInViewController.h"
#import "ChannelViewController.h"
#import "SignUpViewController.h"
#import "UserDataController.h"
#import "User.h"

@interface SignInViewController ()

@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.loginIndicator setHidden:YES ];
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


- (IBAction)userSignIn:(id)sender {
    
    [ self.loginIndicator startAnimating ];
    [ self.loginWaitingView setHidden:NO ];
    
    NSString *userName = @"suman.roy@sourcebits.com";//self.userNameTextField.text;
    NSString *userPass = @"admin1234";//self.passwordTextField.text;
    
    [ [ NSOperationQueue mainQueue ] addOperationWithBlock:^{
        
        BOOL signIn = [ UserDataController loginUser:userName password:userPass ];
        
        [ self.loginIndicator stopAnimating ];
        [ self.loginWaitingView setHidden:YES ];
        
        if (signIn) {
            
            
            UITabBarController *main = [self.storyboard instantiateViewControllerWithIdentifier:@"TabBarController"];
            
            [ self presentViewController:main animated:YES completion:nil];
            
        } else {
            
            
            
            self.userNameTextField.text = @"";
            self.passwordTextField.text = @"";
            
            UIAlertView *login = [[ UIAlertView alloc] initWithTitle:@"Login Failed"
                                                             message:@"Incorrect Credentials"
                                                            delegate:self
                                                   cancelButtonTitle:@"Try Again"
                                                   otherButtonTitles: nil ];
            
            [ login show ];
        }
    }];
    
}

- (IBAction)userSignUp:(id)sender {
    
    SignUpViewController *signUp = [self.storyboard instantiateViewControllerWithIdentifier:@"SignUpViewController"];
    
    [ self.navigationController pushViewController:signUp animated:YES ];
    
    
}
@end
