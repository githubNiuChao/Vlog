//
//  YSCTagModel.h
//  VLog
//
//  Created by szy on 2020/9/21.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YSCTagModel : NSObject

@property (copy, nonatomic) NSString *tagInfo;
@property (assign, nonatomic) CGPoint tagPoint;
@property (assign, nonatomic) NSInteger tagId;

@end

NS_ASSUME_NONNULL_END
