//
//  LogInViewController.m
//  RottenMangoes
//
//  Created by Alain  on 2015-06-08.
//  Copyright (c) 2015 Alain . All rights reserved.
//

#import "LogInViewController.h"


@interface LogInViewController ()

@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    [testObject setObject:@"bar" forKey:@"foo"];
//    testObject[@"foo"] = @"bar"; this is the same as the line above just literal notation (less clear as this point)
    [testObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        
        //
        if (error) {
            NSLog(@"error in saveInBackround is %@", error);
        }
        if (succeeded){
            NSLog(@"Succeeded is: %@", succeeded ? @"True" : @"False"); // not needed just a reference
        } // keep in mind you can log any parameter as I've done here
        
        // [self performSegueWithIdentifier:@"showLogin" sender:self];
        
    }];

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

@end
