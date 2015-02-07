//
//  LoginViewController.m
//  OLA
//
//  Created by Swapnil Patil on 07/02/15.
//  Copyright (c) 2015 Blackhat. All rights reserved.
//

#import "LoginViewController.h"
#import "BookingViewController.h"

@interface LoginViewController(){
    
    IBOutlet UITextField *userName;
    IBOutlet UITextField *passWord;
}

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction) onLogin:(id)sender{
    
    BookingViewController *bookingViewController = [[BookingViewController alloc] init];
    
    if ([[userName.text lowercaseString] isEqualToString:@"kiran"]) {
        [self.navigationController pushViewController:bookingViewController animated:YES];
    }else if([[userName.text lowercaseString] isEqualToString:@"swapnil"]){
        [self.navigationController pushViewController:bookingViewController animated:YES];
    }
}

@end
