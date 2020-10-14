//
//  NCHBaseModelManager.h
//  VLog
//
//  Created by szy on 2020/10/14.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol NCHBaseModelManagerDelegate <NSObject>

@optional
- (void)requestDataCompleted;
- (void)requestDataFailedErrorMessage:(NSString *)errorMessage;
@end

@interface NCHBaseModelManager : NSObject
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,weak) id<NCHBaseModelManagerDelegate> delegagte;


@end

NS_ASSUME_NONNULL_END
