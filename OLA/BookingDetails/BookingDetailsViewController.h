//
//  BookingDetailsViewController.h
//  OLA
//
//  Created by Swapnil Patil on 07/02/15.
//  Copyright (c) 2015 Blackhat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CALayer+XibConfiguration.h"
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>

@interface BookingDetailsViewController : UIViewController

@property(nonatomic, retain) PFUser *user;

@end
