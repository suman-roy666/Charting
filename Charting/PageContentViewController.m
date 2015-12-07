//
//  PageContentViewController.m
//  Charting
//
//  Created by Suman Roy on 25/11/15.
//  Copyright (c) 2015 sourcebits. All rights reserved.
//

#import "PageContentViewController.h"
#import "RootViewController.h"
#import "SignInViewController.h"

@interface PageContentViewController ()

@end

@implementation PageContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.label.text = self.titleText;
    
    if ( self.pageIndex == self.lastPage ) {
        
        [self.endTutorialButton setHidden:NO];
    } else {
        
        [self.endTutorialButton setHidden:YES];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    
    NSLog(@"%lu",(unsigned long)self.pageIndex);
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)endTutorial:(id)sender {
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hasSeenTutorial"];
    
    SignInViewController *signInPage = [self.storyboard instantiateViewControllerWithIdentifier:@"UserSignInNavigationController"];
    
    [ self presentViewController:signInPage animated:YES completion:nil ];
    
    
}
@end
