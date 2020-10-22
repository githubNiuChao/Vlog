//
//  VLTopicViewController.h
//  VLog
//
//  Created by szy on 2020/10/22.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "NCHBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SelectTopicBlock)(NSInteger topicid,NSString *topTitle);

@interface VLTopicViewController : NCHBaseViewController

@property(nonatomic, copy) SelectTopicBlock selectTopicBlock;

@end

NS_ASSUME_NONNULL_END
