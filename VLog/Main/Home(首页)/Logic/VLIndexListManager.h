//
//  VLIndexListManager.h
//  VLog
//
//  Created by szy on 2020/9/24.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VLIndexResponse.h"

NS_ASSUME_NONNULL_BEGIN

@protocol VLIndexListManagerDelegate <NSObject>

@optional
/**数据加载完成*/
-(void)requestDataCompleted;

@end

@interface VLIndexListManager : NSObject
@property (nonatomic,assign) NSInteger  page;//页码
@property (nonatomic,strong) NSArray<VLIndex_ListResponse*> * dataArray;//数据源
@property (nonatomic,weak) id<VLIndexListManagerDelegate> delegagte;

/**拉取数据*/
-(void)loadDataWithCatId:(NSInteger)catId;

@end

NS_ASSUME_NONNULL_END
