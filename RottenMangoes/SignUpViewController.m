//
//  SignUpViewController.m
//  RottenMangoes
//
//  Created by Alain  on 2015-06-08.
//  Copyright (c) 2015 Alain . All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (weak, nonatomic) IBOutlet UIPickerView *criticTypePickerView;

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;



@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.criticTypePickerView.delegate = self;
    

}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - UIImagePickerController

- (IBAction)addProfilePicture:(UIButton *)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else{
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }

    imagePicker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:imagePicker.sourceType]; //mediaTypes are either the camera itself or the camera roll
    
    [self presentViewController:imagePicker animated:YES completion:nil];
    // UIImagePicker is a viewcontroller (it's a subclass of UIViewController) even though you can't see it on storyboard

}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{ // "didFinishMediaWithInfo" means what happens when the photo is chosen (it's also the protocol method)
    
    self.profilePicture.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}

#pragma mark - PickerView 

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 2;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component{
    NSString *title; // another way to do this would be to have multiple returns but it is not best practice
    if (row == 0){
        title = @"Casual Movie Critic";
    
    }else if (row ==1){
        title = @"Movie Critic";
    }
    return title;
}

#pragma mark - Sign Up IBAction

- (IBAction)signUpWasPressed:(UIButton *)sender {
    NSString *username = self.usernameTextField.text; //text is a property of UITextField (of which usernameTextField is an instance). everything starting at stringByTrimming just ensures no spaces are included in the user input.
    NSString *password = self.passwordTextField.text;
    NSString *email = self.emailTextField.text;
    
    /*if I wanted to ensure spaces were removed from the user input on both ends the code would look like:
         NSString *username = [self.usernameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]; */
    
    if ((username.length == 0) || (password.length == 0) || (email.length == 0)){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!"
                                                        message:@"Make sure you enter a username, password, and email."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        
        [alertView show]; // getting the alertView to actually show up
    }else{
        PFUser *newUser = [PFUser user];
        newUser.username = self.usernameTextField.text; // this has nothing to do with username defined above. username here is a property of PFUser that you can find on the Parse API Reference/Documentation
        newUser.password = self.passwordTextField.text;
        newUser.email = self.emailTextField.text;
        
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
            if (error) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry"
                                                                    message:[error.userInfo objectForKey:@"error"]
                                                                  delegate:nil
                                                         cancelButtonTitle:@"OK"
                                                         otherButtonTitles:nil];
                [alertView show]; // without this line it says *alertView is an unused variable
            }else{
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            
            
         
        }]; // was missing this initially, pay more attention
            
        }
        
    
}



@end







