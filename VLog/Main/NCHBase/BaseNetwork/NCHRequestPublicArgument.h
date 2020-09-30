//
//  NCHRequestPublicArgument.h
//  VLog
//
//  Created by szy on 2020/9/29.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NCHRequestPublicArgument : NSObject

/**  当前客户端版本名称  */
@property (nonatomic, copy) NSString *version;
/**  时间戳 格式yyyyMMddHHmmss  */
@property (nonatomic, copy) NSString *timestamp;


@end

NS_ASSUME_NONNULL_END
