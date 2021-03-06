//
//  BookingViewController.m
//  OLA
//
//  Created by Swapnil Patil on 07/02/15.
//  Copyright (c) 2015 Blackhat. All rights reserved.
//

#import "BookingViewController.h"
#import "DataBaseHelper.h"
#import "BookingDetailsViewController.h"
#import "RideViewController.h"

@interface BookingViewController (){
    
    IBOutlet UIImageView *refresh;
    IBOutlet UIView *hidenView;
}

@end

@implementation BookingViewController
@synthesize type;
@synthesize vehicleNumberTextField;
@synthesize detectButton;

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
    [detectButton setTitle:@"Auto Search" forState:UIControlStateNormal];
    // Do any additional setup after loading the view from its nib.
    
    // Add a "textFieldDidChange" notification method to the text field control.
    [vehicleNumberTextField addTarget:self
                  action:@selector(textFieldDidChange:)
        forControlEvents:UIControlEventEditingChanged];
    
    
    if ([type isEqualToString:@"driver"]) {
        [vehicleNumberTextField setPlaceholder:@"Mobile number"];
        [detectButton setTitle:@"Send SMS" forState:UIControlStateNormal];
    }
}

-(void)textFieldDidChange :(UITextField *)theTextField{
    if (theTextField.text.length == 0) {
        [detectButton setTitle:@"Auto Search" forState:UIControlStateNormal];
    }
    else{
        if(![detectButton.titleLabel.text isEqualToString:@"Send SMS"] && ![detectButton.titleLabel.text isEqualToString:@"Verify Code"])
           [detectButton setTitle:@"Search" forState:UIControlStateNormal];
    }
}


-(void) viewWillAppear:(BOOL)animated{
    refresh.hidden = YES;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) startAnimation{
    hidenView.hidden = NO;
    refresh.hidden = NO;
    CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotation.fromValue = [NSNumber numberWithFloat:0];
    rotation.toValue = [NSNumber numberWithFloat:((360*M_PI)/180)];
    rotation.duration = 1;
    rotation.repeatCount = INFINITY;
    [refresh.layer addAnimation:rotation forKey:@"Spin"];
}

-(void) stopAnimation{
    
    //background.hidden = YES;
    [refresh.layer removeAllAnimations];
}

-(IBAction) onDetect:(id)sender{
    
    [self startAnimation];
    [vehicleNumberTextField resignFirstResponder];
    
    if ([((UIButton*)sender).titleLabel.text isEqualToString:@"Auto Search"]) {
    
        [DataBaseHelper  getNearestDriver:@"kiranjuikar" completion:^(NSArray *usersArr) {
            if (usersArr && usersArr.count > 0) {
                    PFUser *user = [usersArr firstObject];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self stopAnimation];
                        BookingDetailsViewController *detailView = [[BookingDetailsViewController alloc] init];
                        detailView.user = user;
                        [self.navigationController pushViewController:detailView animated:YES];
                    });
            }
            else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    refresh.hidden = YES;
                    hidenView.hidden = YES;
                    [self stopAnimation];
                    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"OLA" message:@"Unable to find the cab nearby. Please try searching vehicle number." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                });
            }
        }];
    }
    else if ([((UIButton*)sender).titleLabel.text isEqualToString:@"Search"]) {
        [DataBaseHelper  getNearestDriverByVehicle:vehicleNumberTextField.text username:@"kiranjuikar" completion:^(NSArray *usersArr) {
            if (usersArr && usersArr.count > 0) {
                    PFUser *user = [usersArr firstObject];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self stopAnimation];
                        BookingDetailsViewController *detailView = [[BookingDetailsViewController alloc] init];
                        detailView.user = user;
                        [self.navigationController pushViewController:detailView animated:YES];
                    });
            }
            else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    refresh.hidden = YES;
                    hidenView.hidden = YES;
                    [self stopAnimation];
                    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"OLA" message:@"Unable to find the vehicle" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                });
            }
        }];
    }
    else if ([((UIButton*)sender).titleLabel.text isEqualToString:@"Send SMS"]) {
        [PFCloud callFunctionInBackground:@"sendsms"
                           withParameters:@{@"username":@"swapnilpatil"}
                                    block:^(NSArray *users, NSError *error) {
                                        if (!error) {
                                            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"OLA" message:@"SMS sent successfully." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                            [alert show];
                                            
                                            [vehicleNumberTextField setPlaceholder:@"Verification Code"];
                                            [vehicleNumberTextField setText:@""];
                                            [refresh setHidden:YES];
                                            [detectButton setTitle:@"Verify Code" forState:UIControlStateNormal];
                                            
                                        }
                                    }];
    }
    else if ([((UIButton*)sender).titleLabel.text isEqualToString:@"Verify Code"]) {
        [PFCloud callFunctionInBackground:@"validatesms"
                           withParameters:@{@"username":@"swapnilpatil", @"code":vehicleNumberTextField.text}
                                    block:^(NSArray *users, NSError *error) {
                                        if (!error) {
                                             [refresh setHidden:YES];
                                            [vehicleNumberTextField setText:@""];
                                            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"OLA" message:@"SMS verified." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                            [alert show];
                                            
                                            RideViewController* ride = [[RideViewController alloc] init];
                                            [self.navigationController pushViewController:ride animated:YES];
                                            
                                        }
                                    }];
    }

}

@end
