//
//  DataBaseHelper.m
//  OLA
//
//  Created by Swapnil Patil on 07/02/15.
//  Copyright (c) 2015 Blackhat. All rights reserved.
//

#import "DataBaseHelper.h"


@implementation DataBaseHelper

+ (void) getNearestDriver:(NSString *) userName
               completion:(void (^)(NSArray *usersArr)) completionBlock{
    
    [PFCloud callFunctionInBackground:@"getnearestdriver"
                       withParameters:@{@"username":userName}
                                block:^(NSArray *users, NSError *error) {
                                    if (!error) {
                                        completionBlock(users);
                                    }
                                }];
}

+ (void) getNearestDriverByVehicle:(NSString *) vehicle
                          username:(NSString*) username
               completion:(void (^)(NSArray *usersArr)) completionBlock{
    
    [PFCloud callFunctionInBackground:@"getdriverbyvehiclenumber"
                       withParameters:@{@"vehicle":[vehicle lowercaseString], @"username":username}
                                block:^(NSArray *users, NSError *error) {
                                    if (!error) {
                                        completionBlock(users);
                                    }
                                }];
}

+(void) confirmBooking:(NSString *) statusM completion:(void (^)(NSString * status)) completionBlock{
    //confirmbooking
    
    [PFCloud callFunctionInBackground:@"confirmbooking"
                       withParameters:@{@"status":statusM}
                                block:^(NSString *returnStatus, NSError *error) {
                                    if (!error) {
                                        completionBlock(returnStatus);
                                    }
                                }];
}


@end
