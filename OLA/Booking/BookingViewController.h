//
//  BookingViewController.h
//  OLA
//
//  Created by Swapnil Patil on 07/02/15.
//  Copyright (c) 2015 Blackhat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CALayer+XibConfiguration.h"
#import <Parse/Parse.h>

@interface BookingViewController : UIViewController

@property(nonatomic, retain) NSString *type;
@property(nonatomic, retain) IBOutlet UITextField *vehicleNumberTextField;
@property(nonatomic, retain) IBOutlet UIButton *detectButton;
@end
