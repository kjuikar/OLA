//
//  BookingConfirmationViewController.m
//  OLA
//
//  Created by Swapnil Patil on 08/02/15.
//  Copyright (c) 2015 Blackhat. All rights reserved.
//

#import "BookingConfirmationViewController.h"
#import "DataBaseHelper.h"
#import "RideViewController.h"

@interface BookingConfirmationViewController (){
    
    IBOutlet UILabel *messageLabel;
}


@end

@implementation BookingConfirmationViewController

@synthesize message;

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

-(void) viewWillAppear:(BOOL)animated{
    
    messageLabel.numberOfLines = 3;
    messageLabel.text = message;
}

-(IBAction)didConfirmBooking:(id)sender{
    
    [DataBaseHelper confirmBooking:@"Accepted" completion:^(NSString *user) {
        
        RideViewController *rideView = [[RideViewController alloc] init];
        [self.navigationController pushViewController:rideView animated:YES];
        return;
    }];
}

-(IBAction)didRejectBooking:(id)sender{
    
    [DataBaseHelper confirmBooking:@"Rejected" completion:^(NSString *user) {
        return;
    }];
}

@end
