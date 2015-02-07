//
//  DataBaseHelper.m
//  OLA
//
//  Created by Swapnil Patil on 07/02/15.
//  Copyright (c) 2015 Blackhat. All rights reserved.
//

#import "DataBaseHelper.h"


@implementation DataBaseHelper

+ (void) getNearestDriver:(void (^)(NSArray *users)) completionBlock{
    
    [PFCloud callFunctionInBackground:@"nearestdriver"
                       withParameters:@{}
                                block:^(NSArray *users, NSError *error) {
                                    if (!error) {
                                        completionBlock(users);
                                    }
                                }];
}

@end
