//
//  BookingViewController.m
//  OLA
//
//  Created by Swapnil Patil on 07/02/15.
//  Copyright (c) 2015 Blackhat. All rights reserved.
//

#import "BookingViewController.h"
#import "DataBaseHelper.h"
#import "BookingViewController.h"

@interface BookingViewController (){
    
    IBOutlet UIImageView *refresh;
}

@end

@implementation BookingViewController

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


-(void) viewDidAppear:(BOOL)animated{

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
    
    [DataBaseHelper  getNearestDriver:^(NSArray *usersArr) {
        if (usersArr) {
            if (usersArr.count > 0) {
                PFUser *user = [usersArr firstObject];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self stopAnimation];
                    BookingViewController *detailView = [[BookingViewController alloc] init];
                    [self.navigationController pushViewController:detailView animated:YES];
                });
            }
        }
    }];
}

@end
