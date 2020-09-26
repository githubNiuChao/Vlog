//
//  NCHMacroTools.m
//  VLog
//
//  Created by szy on 2020/9/26.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "NCHMacroTools.h"
#import <UIKit/UIKit.h>
#import <sys/sysctl.h>
#import <sys/utsname.h>

@implementation NCHMacroTools

/// 判断刘海屏，返回YES表示是刘海屏
+ (BOOL)isNotchScreen{
    /*
     https://kangzubin.com/iphonex-detect/
     https://www.theiphonewiki.com/wiki/Models
     iPhone X 对应的 device mode 为 iPhone10,3 和 iPhone10,6，而今年最新发布 iPhone XS 对应 iPhone11,2，iPhone XS Max 对应 iPhone11,4 和 iPhone11,6，iPhone XR 对应 iPhone11,8，完整的 device mode 数据参考这里：
     */
    static BOOL isiPhoneX = NO;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
#if TARGET_IPHONE_SIMULATOR
            // 获取模拟器所对应的 device model
        NSString *model = NSProcessInfo.processInfo.environment[@"SIMULATOR_MODEL_IDENTIFIER"];
#else
            // 获取真机设备的 device model
        struct utsname systemInfo;
        uname(&systemInfo);
        NSString *model = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
#endif
            // 判断 device model 是否为 "iPhone10,3" 和 "iPhone10,6" 或者以 "iPhone11," 开头就是 iPhone X
            // 以 "iPhone12," 开头就是 iPhone11
        isiPhoneX = [model isEqualToString:@"iPhone10,3"] || [model isEqualToString:@"iPhone10,6"] || [model hasPrefix:@"iPhone11,"] || [model hasPrefix:@"iPhone12,"];
    });
    
    return isiPhoneX;
}

@end
