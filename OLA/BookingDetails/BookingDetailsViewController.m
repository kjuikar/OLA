//
//  BookingDetailsViewController.m
//  OLA
//
//  Created by Swapnil Patil on 07/02/15.
//  Copyright (c) 2015 Blackhat. All rights reserved.
//

#import "BookingDetailsViewController.h"


@interface BookingDetailsViewController (){
    
    IBOutlet UILabel *name;
    IBOutlet UILabel *vehicleNo;
    IBOutlet UILabel *vehicleType;
    IBOutlet UILabel *vehicleRate;
    IBOutlet UILabel *driverStatus;
    IBOutlet PFImageView *imageView;
    
    NSString *status;
}

@end

@implementation BookingDetailsViewController
@synthesize user;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        status = @"Waiting for Confirmation";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateStatus:) name:@"status" object:status];
}

-(void) updateStatus:(NSString *) newStatus{
    driverStatus.text = newStatus;
    status = newStatus;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewDidAppear:(BOOL)animated{
    
    name.text = [user objectForKey:@"username"];
    vehicleNo.text = [user objectForKey:@"vehicleNo"];
    vehicleRate.text = [user objectForKey:@"vehicleRate"];
    vehicleType.text = [user objectForKey:@"vehicleType"];
    driverStatus.text = status;
    
    [imageView setFile:[user objectForKey:@"headshot"]];
    [imageView loadInBackground];
}

@end
