//
//  SignInViewController.m
//  Charting
//
//  Created by Suman Roy on 25/11/15.
//  Copyright (c) 2015 sourcebits. All rights reserved.
//

#import "SignInViewController.h"
#import "DiscoveryViewController.h"

@interface SignInViewController ()

@end

@implementation SignInViewController

static NSString *serverAddress = @"http://ec2-52-27-8-48.us-west-2.compute.amazonaws.com:8080/myscout/";
static NSString *userLoginURL = @"user/login/ashwini.desai@sourcebits.com/admin123/DIV005/0/";

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


- (IBAction)userSignIn:(id)sender {
    
    [ self.loginIndicator setHidden:NO ];
    [ self.loginIndicator startAnimating ];
    
    //NSString *userName = self.userNameTextField.text;
    //NSString *userPass = self.passwordTextField.text;
    
    
    
    NSMutableURLRequest *request =
    [NSMutableURLRequest requestWithURL:[NSURL
                                         URLWithString:[serverAddress stringByAppendingString:userLoginURL ]]
                            cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                        timeoutInterval:10
     ];
    
    [request setHTTPMethod: @"GET"];
    
    NSError *requestError = nil;
    NSURLResponse *urlResponse = nil;
    
    
    NSData *response1 =
    [NSURLConnection sendSynchronousRequest:request
                          returningResponse:&urlResponse error:&requestError];
    
    NSDictionary *responseArray = [NSJSONSerialization JSONObjectWithData:response1 options:kNilOptions error:&requestError ];
    
    NSNumber *status = [ responseArray valueForKey:@"status"];
    
    if ([status isEqualToNumber:[ NSNumber numberWithInt:1] ]) {
        
        DiscoveryViewController *main = [self.storyboard instantiateViewControllerWithIdentifier:@"DiscoveryViewController"];
        
        [ self presentViewController:main animated:YES completion:nil];
        
    }
}

- (IBAction)userSignUp:(id)sender {
}
@end
