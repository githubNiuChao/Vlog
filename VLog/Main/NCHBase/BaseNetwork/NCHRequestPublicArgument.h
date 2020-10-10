//
//  NCHRequestPublicArgument.h
//  VLog
//
//  Created by szy on 2020/9/29.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString * const NCHRequestPublicArgument_UserAgent_Key;
extern NSString * const NCHRequestPublicArgument_SzyVersion_Key;

@interface NCHRequestPublicArgument : NSObject<YTKUrlFilterProtocol>

+ (NCHRequestPublicArgument *)filterWithArguments:(NSDictionary *)arguments;

@end

NS_ASSUME_NONNULL_END
