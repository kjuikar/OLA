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

@interface BookingViewController (){
    
    IBOutlet UIImageView *refresh;
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
}

-(void)textFieldDidChange :(UITextField *)theTextField{
    if (theTextField.text.length == 0) {
        [detectButton setTitle:@"Auto Search" forState:UIControlStateNormal];
    }
    else{
        [detectButton setTitle:@"Search" forState:UIControlStateNormal];
    }
}

-(void) viewDidAppear:(BOOL)animated{

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
                    [self stopAnimation];
                    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"OLA" message:@"Unable to find the cab nearby. Please try searching vehicle number." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                });
            }
        }];
    }
    else{
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
                    [self stopAnimation];
                    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"OLA" message:@"Unable to find the vehicle" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                });
            }
        }];
    }
}

@end
