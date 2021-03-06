//
//  BookingDetailsViewController.m
//  OLA
//
//  Created by Swapnil Patil on 07/02/15.
//  Copyright (c) 2015 Blackhat. All rights reserved.
//

#import "BookingDetailsViewController.h"
#import "EnjoyRideViewController.h"

@interface BookingDetailsViewController (){
    
    IBOutlet UILabel *name;
    IBOutlet UILabel *vehicleNo;
    IBOutlet UILabel *vehicleType;
    IBOutlet UILabel *vehicleRate;
    IBOutlet UILabel *driverStatus;
    IBOutlet PFImageView *imageView;
    IBOutlet UIImageView *refresh;
    
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateStatus:) name:@"status" object:nil];
}

-(void) updateStatus:(NSNotification *) userInfo{
     dispatch_async(dispatch_get_main_queue(), ^(void) {
         
         status = [userInfo.userInfo objectForKey:@"status"];
         driverStatus.text = [NSString stringWithFormat:@"(%@)",status];
         
         if ([status isEqualToString:@"Accepted"] ||[status isEqualToString:@"Rejected"] ) {
             if ([status isEqualToString:@"Accepted"]) {
                 EnjoyRideViewController* enjoy = [[EnjoyRideViewController alloc] init];
                 [self.navigationController pushViewController:enjoy animated:YES];
             }
             [self stopAnimation];
         }else{
             [self startAnimation];
             
         }
        // status = newStatus;
     });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewDidAppear:(BOOL)animated{

    if ([status isEqualToString:@"Accepted"] ||[status isEqualToString:@"Rejected"] ) {
        
        [self stopAnimation];
        
    }else{
        [self startAnimation];

    }

    name.text = [user objectForKey:@"name"];
    vehicleNo.text = [user objectForKey:@"vehicleNo"];

    vehicleRate.text = [user objectForKey:@"vehicleRate"];
    vehicleType.text = [NSString stringWithFormat:@"(%@)",[user objectForKey:@"vehicleType"]];
    driverStatus.text = [NSString stringWithFormat:@"(%@)",status];
    
    [imageView setFile:[user objectForKey:@"headshot"]];
    [imageView loadInBackground];
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
    
    refresh.hidden = YES;
    [refresh.layer removeAllAnimations];
}

@end
