//
//  VLIndexListManager.h
//  VLog
//
//  Created by szy on 2020/9/24.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "NCHBaseModelManager.h"
#import "VLIndexResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface VLIndexListManager : NCHBaseModelManager
@property (nonatomic,strong) NSArray<VLVideoInfoModel*> * dataArray;//数据源
/**拉取数据*/
-(void)loadDataWithCatId:(NSInteger)catId;

@end

NS_ASSUME_NONNULL_END
