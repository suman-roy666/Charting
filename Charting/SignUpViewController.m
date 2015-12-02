//
//  SignUpViewController.m
//  Charting
//
//  Created by Suman Roy on 30/11/15.
//  Copyright (c) 2015 sourcebits. All rights reserved.
//

#import "SignUpViewController.h"
#import "User.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController{
    
    NSData *signUpResponseData;
}

static NSString *serverAddress = @"http://ec2-52-27-8-48.us-west-2.compute.amazonaws.com:8080/myscout/";
static NSString *userSignUpURL = @"user/createUser";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [ self.signUpActivityIndicator setHidden:YES ];
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

- (IBAction)userSignUp:(id)sender {
    
    NSString *newUserData = [ NSString stringWithFormat: @"{\"name\":\"%@\","
    "\"password\":\"%@\","
    "\"emailId\":\"%@\","
    "\"instagramId\":\"\","
    "\"deviceId\":\"DIV0005\","
    "\"description\":\"\","
    "\"websiteUrl\":\"\","
    "\"facebookUrl\":\"\","
    "\"twitterUrl\":\"\","
    "\"instagramUrl\":\"\""
    ",\"photoUrl\" :\"\","
    "\"deviceType\":0,"
    "\"city\":\"\","
    "\"state\":\"\","
    "\"country\":\"\","
    "\"role\":3}", self.userNameTextField.text, self.passwordTextField.text, self.emailTextField.text ];
    
    NSData *postData = [newUserData dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[newUserData length]];

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
                                    initWithURL:[NSURL URLWithString:[serverAddress stringByAppendingString:userSignUpURL]]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [ request setHTTPBody:postData ];
    
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [ self.signUpActivityIndicator startAnimating ];
    
    if(conn) {
        NSLog(@"Connection Successful");
    } else {
        NSLog(@"Connection could not be made");
    }


}

#pragma mark NSURLConnection delegates
// This method is used to receive the data which we get using post method.
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData*)data{
    
    signUpResponseData = [[ NSData alloc] initWithData:data ];
    
}

// This method receives the error report in case of connection is not made to server.
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                        message:@"No Network Connection"
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"OK",nil];
    [alertView show];
    
}

// This method is used to process the data after connection has made successfully.
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    [ self.signUpActivityIndicator stopAnimating ];
    
    NSError *signUpError = [[ NSError alloc] init ];
    
    NSString *signUpResponseString = [[NSString alloc] initWithData: signUpResponseData encoding:NSUTF8StringEncoding];
    NSLog(@"Response Json : %@", signUpResponseString);
    
    NSDictionary *signUpResponse = [ NSJSONSerialization JSONObjectWithData:signUpResponseData options:kNilOptions error:&signUpError];
    
    if( [ signUpResponse objectForKey:@"EmailStatus"] != nil ){
        
        [[ User getCurrentActiveUser ] setUserId:[ signUpResponse valueForKey:@"id" ]];
        
        UITabBarController *mainTabBar = [ self.storyboard instantiateViewControllerWithIdentifier:@"TabBarController"];
        
        [ self presentViewController:mainTabBar animated:YES completion:nil ];
        
    } else {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:@"Email already exists"
                                                           delegate:self
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"OK",nil];
        [alertView show];
        
    }
    
}

@end
