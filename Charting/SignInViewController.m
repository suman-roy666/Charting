//
//  SignInViewController.m
//  Charting
//
//  Created by Suman Roy on 25/11/15.
//  Copyright (c) 2015 sourcebits. All rights reserved.
//

#import "SignInViewController.h"
#import "DiscoveryViewController.h"
#import "SignUpViewController.h"
#import "User.h"

@interface SignInViewController ()

@end

@implementation SignInViewController

static NSString *serverAddress = @"http://ec2-52-27-8-48.us-west-2.compute.amazonaws.com:8080/myscout/";
static NSString *userLoginURL = @"user/login/%@/%@/DIV005/0/";

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
    
    [ self.loginIndicator setHidden:NO ];
    [ self.loginIndicator startAnimating ];
    
    NSString *userName = @"suman.roy@sourcebits.com";//self.userNameTextField.text;
    NSString *userPass = @"admin1234";//self.passwordTextField.text;
    
    
    
    NSMutableURLRequest *request =
    [NSMutableURLRequest requestWithURL:[NSURL
                                         URLWithString:[serverAddress stringByAppendingString:[ NSString stringWithFormat:userLoginURL, userName, userPass ]]]
                            cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                        timeoutInterval:10
     ];
    
    [request setHTTPMethod: @"GET"];
    
    NSError *requestError = nil;
    NSURLResponse *urlResponse = nil;
    
    
    NSDictionary *responseArray = [NSJSONSerialization JSONObjectWithData:[NSURLConnection sendSynchronousRequest:request
                                                                                                returningResponse:&urlResponse error:&requestError]
                                                                  options:kNilOptions error:&requestError ];
    
    NSNumber *status = [ responseArray valueForKey:@"status"];
    NSString *uId = [ responseArray valueForKey:@"id" ];
    
    [ self.loginIndicator stopAnimating];
    [ self.loginIndicator setHidden:YES ];
    
    if ([status isEqualToNumber:[ NSNumber numberWithInt:1] ]) {
        
        [[ User getCurrentActiveUser ] setUserId:uId ];
        
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
    
}

- (IBAction)userSignUp:(id)sender {
    
    SignUpViewController *signUp = [self.storyboard instantiateViewControllerWithIdentifier:@"SignUpViewController"];
    
    [ self.navigationController pushViewController:signUp animated:YES ];
    
    
}
@end
