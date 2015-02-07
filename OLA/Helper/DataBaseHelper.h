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

+ (void) getNearestDriver:(void (^)(NSArray *usersArr)) completionBlock;

@end
