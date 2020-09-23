//
//  AppDelegate.m
//  VLog
//
//  Created by szy on 2020/9/12.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "AppDelegate.h"
#import "YISVlogTabBarController1.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];

    self.window.rootViewController = [[YISVlogTabBarController1 alloc]initWithContext:@""];
    [self.window makeKeyAndVisible];
    
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    
    return YES;
}


@end
