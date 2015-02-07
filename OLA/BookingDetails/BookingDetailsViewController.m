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
    IBOutlet PFImageView *imageView;
}

@end

@implementation BookingDetailsViewController
@synthesize user;

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

-(void) viewDidAppear:(BOOL)animated{
    
    name.text = [user objectForKey:@"username"];
    vehicleNo.text = [user objectForKey:@"vehicleNo"];
    vehicleRate.text = [user objectForKey:@"vehicleRate"];
    vehicleType.text = [user objectForKey:@"vehicleType"];
    
    [imageView setFile:[user objectForKey:@"headshot"]];
    [imageView loadInBackground];
}

@end
