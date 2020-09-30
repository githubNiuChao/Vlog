//
//  NCHRequestPublicArgument.m
//  VLog
//
//  Created by szy on 2020/9/29.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "NCHRequestPublicArgument.h"

@implementation NCHRequestPublicArgument

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _version = ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]);
        _timestamp = [NSString stringWithFormat:@"%ld", (long)([[NSDate date] timeIntervalSince1970])];
    }
    return self;
}
@end
