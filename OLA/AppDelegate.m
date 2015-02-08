//
//  AppDelegate.m
//  OLA
//
//  Created by Kiran Juikar on 07/02/15.
//  Copyright (c) 2015 Blackhat. All rights reserved.
//
#import <Parse/Parse.h>
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "BookingViewController.h"
#import "BookingConfirmationViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // [Optional] Power your app with Local Datastore. For more info, go to
    // https://parse.com/docs/ios_guide#localdatastore/iOS
    [Parse enableLocalDatastore];
    
    // Initialize Parse.
    [Parse setApplicationId:@"o1I4bkQkMuJMqTufjZRm441SjHJr08tyD26EL201"
                  clientKey:@"Ykd36SMOLetpYnFpOgwmn3KUs7JvVEDf6NDWa1u9"];
    
    // [Optional] Track statistics around application opens.
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
#ifdef __IPHONE_8_0
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIRemoteNotificationTypeBadge
                                                                                             |UIRemoteNotificationTypeSound
                                                                                             |UIRemoteNotificationTypeAlert) categories:nil];
        [application registerUserNotificationSettings:settings];
#endif
    } else {
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
        [application registerForRemoteNotificationTypes:myTypes];
    }
    
    NSDictionary *user = [self getUser];
    if (user) {
        if (launchOptions) {
            NSDictionary* userInfo = [launchOptions objectForKey:@"UIApplicationLaunchOptionsRemoteNotificationKey"];
            if (userInfo && [userInfo isKindOfClass:[NSDictionary class]]) {
                [self handleRemoteNotification:userInfo];
                return YES;
            }
            
        }
        
        BookingViewController *cpvc = [[BookingViewController alloc] init];
        cpvc.type = [user objectForKey:@"ut"];
        UINavigationController *navcon = [[UINavigationController alloc] initWithRootViewController:cpvc];
        //self.navigationController = navcon;
        [self.window setRootViewController:navcon];
        //self.window.backgroundColor = [UIColor whiteColor];
        [self.window makeKeyAndVisible];
        
    }else{
        
        LoginViewController *cpvc = [[LoginViewController alloc] init];
        UINavigationController *navcon = [[UINavigationController alloc] initWithRootViewController:cpvc];
        //self.navigationController = navcon;
        [self.window setRootViewController:navcon];
        //self.window.backgroundColor = [UIColor whiteColor];
        [self.window makeKeyAndVisible];
    }
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Store the deviceToken in the current installation and save it to Parse.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    currentInstallation.channels = @[ @"driver" ];
    [currentInstallation saveInBackground];
}

-(void) application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
    [self handleRemoteNotification:userInfo];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void) handleRemoteNotification:(NSDictionary*)userInfo{
    
    NSDictionary *user = [self getUser];
    if (user) {

        NSString *userType = [user objectForKey:@"ut"];
        
        if ([userInfo objectForKey:@"type"] && [[userInfo objectForKey:@"type"] isEqualToString:@"booking"] && [userType isEqualToString:@"driver"]) {
            
            BookingConfirmationViewController *cpvc = [[BookingConfirmationViewController alloc] init];
            cpvc.message = [NSString stringWithFormat:@"Mr. %@(%@) wants to book your cab. Are you ready to serve him?",[userInfo objectForKey:@"name"],[userInfo objectForKey:@"mob"]];
            UINavigationController *navcon = [[UINavigationController alloc] initWithRootViewController:cpvc];
            //self.navigationController = navcon;
            [self.window setRootViewController:navcon];
            //self.window.backgroundColor = [UIColor whiteColor];
            [self.window makeKeyAndVisible];
        }else if ([userInfo objectForKey:@"type"] && [[userInfo objectForKey:@"type"]isEqualToString:@"confirm"]) {

            [[NSNotificationCenter defaultCenter] postNotificationName:@"status" object:nil userInfo:userInfo];
        }
    }
}

-(NSDictionary *) getUser{
    
    NSDictionary *dict = nil;
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectoryPath=[paths lastObject]?[paths objectAtIndex:0]:nil;
    documentsDirectoryPath = [documentsDirectoryPath stringByAppendingPathComponent:@"unp.ola"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:documentsDirectoryPath]) {
        dict = [NSDictionary dictionaryWithContentsOfFile:documentsDirectoryPath];
    }
    return dict;
}


@end
