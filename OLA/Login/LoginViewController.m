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
    NSString *userType;
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
        userType = @"user";
    }else if([[userName.text lowercaseString] isEqualToString:@"swapnil"]){
        //[self.navigationController pushViewController:bookingViewController animated:YES];
        userType = @"driver";
    }else{
        userType = @"user";
        
    }
    [self saveUser];
    bookingViewController.type = userType;
    [self.navigationController pushViewController:bookingViewController animated:YES];
}

-(void) saveUser{
    
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectoryPath=[paths lastObject]?[paths objectAtIndex:0]:nil;
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:userName.text,@"uname",passWord.text,@"pwd",userType,@"ut", nil];
    
    [dict writeToFile:[documentsDirectoryPath stringByAppendingPathComponent:@"unp.ola"] atomically:YES];
    
}

@end
