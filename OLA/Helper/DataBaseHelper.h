//
//  DataBaseHelper.h
//  OLA
//
//  Created by Swapnil Patil on 07/02/15.
//  Copyright (c) 2015 Blackhat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface DataBaseHelper : NSObject

+ (void) getNearestDriver:(NSString *) userName
               completion:(void (^)(NSArray *usersArr)) completionBlock;

+ (void) getNearestDriverByVehicle:(NSString *) vehicle
                          username:(NSString*) username
                        completion:(void (^)(NSArray *usersArr)) completionBlock;

+(void) confirmBooking:(NSString *) status completion:(void (^)(NSString * status)) completionBlock;

@end
