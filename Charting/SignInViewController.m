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

-(void) showErrorAlertWithTitle:(NSString*)errorTitle message: (NSString*)errorMessage;

@end

@implementation SignInViewController{
    
    NSOperationQueue *loginQueue;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.loginIndicator setHidden:YES ];
    
    loginQueue = [[NSOperationQueue alloc] init];
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
    
    
    [ loginQueue addOperationWithBlock:^{
        
        NSString *userName = @"a@b.c";// self.userNameTextField.text;
        NSString *userPass = @"abc";//self.passwordTextField.text;
        
        BOOL isAnyTextFieldEmpty = (
                                    ( [ userName isEqualToString:@"" ]      || userName == nil )  ||
                                    ( [ userPass isEqualToString:@"" ]     || userPass == nil )
                                    
                                    );
        
        if (!isAnyTextFieldEmpty) {
            
            NSError *error = NULL;
            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]"
                                                                                   options:NSRegularExpressionCaseInsensitive
                                                                                     error:&error];
            
            if (error) {
                
                NSLog(@"error %@", error);
            }
            
            NSRange textRange = NSMakeRange(0, userName.length);
            
            NSRange matchRange = [regex rangeOfFirstMatchInString:userName options:NSMatchingReportProgress range:textRange];
            
            if (matchRange.location != NSNotFound){
                
                
                BOOL signIn = [ UserDataController loginUser:userName password:userPass ];
                
                
                if (signIn) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        UITabBarController *main = [self.storyboard instantiateViewControllerWithIdentifier:@"TabBarController"];
                        
                        [ self presentViewController:main animated:YES completion:nil];
                        
                    });
                    
                } else {
                    
                    
                    
                    self.userNameTextField.text = @"";
                    self.passwordTextField.text = @"";
                    
                    [ self showErrorAlertWithTitle:@"Login Failed" message:@"Incorrect credentials or connection error. Please check both and try again." ];
                    
                }
            } else {
                
                [ self showErrorAlertWithTitle:@"Invalid Email" message:@"Email address is not in a valid format" ];
            }
            
        } else {
            
            [ self showErrorAlertWithTitle:@"Empty Fields" message:@"Cannot login without credentials" ];
            
        }
        
        [ self.loginIndicator stopAnimating ];
        [ self.loginWaitingView setHidden:YES ];
        
    }];
    
}

- (IBAction)userSignUp:(id)sender {
    
    SignUpViewController *signUp = [self.storyboard instantiateViewControllerWithIdentifier:@"SignUpViewController"];
    
    [ self.navigationController pushViewController:signUp animated:YES ];
    
    
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
