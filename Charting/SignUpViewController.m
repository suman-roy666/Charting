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

-(void) showErrorAlertWithTitle:(NSString*)errorTitle message: (NSString*)errorMessage;

@end

@implementation SignUpViewController{
    
    NSOperationQueue *signUpQueue;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [ self.signUpActivityIndicator stopAnimating ];
    [ self.signUpWaitingView setHidden:YES ];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)userSignUp:(id)sender {
    
    [ self.signUpActivityIndicator startAnimating ];
    [ self.signUpWaitingView setHidden:NO ];
    
    
    
    
    [ [ NSOperationQueue mainQueue ] addOperationWithBlock:^{
        
        NSString *userName = self.userNameTextField.text;
        NSString *userEmail = self.emailTextField.text;
        NSString *userPassword = self.passwordTextField.text;
        NSString *passwordConfirmation = self.confirmPasswordTextField.text;
        
        BOOL isAnyTextFieldEmpty = (
                                    ( [ userName isEqualToString:@"" ]      || userName == nil )  ||
                                    ( [ userEmail isEqualToString:@"" ]     || userEmail == nil ) ||
                                    ( [ userPassword isEqualToString:@"" ]  || userPassword == nil)
                                    
                                    );
        
        if (!isAnyTextFieldEmpty) {
            
            if ([ passwordConfirmation isEqualToString:userPassword ]) {
                
                NSError *error = NULL;
                NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
                                                                                       options:NSRegularExpressionCaseInsensitive
                                                                                         error:&error];
                
                if (error) {
                    
                    [ self showErrorAlertWithTitle:@"Error" message:error.description ];
                    NSLog(@"error %@", error);
                }
                
                NSRange textRange = NSMakeRange(0, userEmail.length);
                
                NSRange matchRange = [regex rangeOfFirstMatchInString:userEmail options:NSMatchingReportProgress range:textRange];
                
                if (matchRange.location != NSNotFound){
                    
                    
                    
                    BOOL userSignUpStatus = [ UserDataController createNewUser:userName
                                                                      password:userPassword
                                                                       emailId:userEmail ];
                    
                    
                    
                    if (userSignUpStatus) {
                        
                        UITabBarController *mainTabBar = [ self.storyboard instantiateViewControllerWithIdentifier:@"TabBarController"];
                        
                        [ self presentViewController:mainTabBar animated:YES completion:nil ];
                        
                    } else {
                        
                        [ self.userNameTextField setText:@"" ];
                        [ self.emailTextField setText:@"" ];
                        [ self.passwordTextField setText:@"" ];
                        [ self.confirmPasswordTextField setText:@"" ];
                        
                        [ self showErrorAlertWithTitle:@"Alert" message:@"Email already exists" ];
                        
                    }
                    
                } else {
                    
                    [ self showErrorAlertWithTitle:@"Validation Error" message:@"Check Email Fields" ];
                }
                
            } else {
                
                [ self showErrorAlertWithTitle:@"Password Mismatch" message:@"Password Fields Don't Match" ];
                
            }
            
            
        } else {
            
            [ self showErrorAlertWithTitle:@"Missing Fields" message:@"All fields are mandatory" ];
            [ self.passwordTextField setText:@"" ];
            [ self.confirmPasswordTextField setText:@"" ];
            
        }
     
        [ self.signUpWaitingView setHidden:YES ];
        
        [ self.signUpActivityIndicator stopAnimating ];
        
    }];
}

-(void) showErrorAlertWithTitle:(NSString*)errorTitle message: (NSString*)errorMessage
{
    UIAlertView *ErrorAlert = [[UIAlertView alloc] initWithTitle: errorTitle
                                                         message: errorMessage
                                                        delegate: self
                                               cancelButtonTitle: @"OK"
                                               otherButtonTitles: nil];
    [ErrorAlert show];
}

@end
