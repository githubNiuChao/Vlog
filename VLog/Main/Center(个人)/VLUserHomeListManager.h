//
//  VLUserHomeListManager.h
//  VLog
//
//  Created by szy on 2020/10/19.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "NCHBaseModelManager.h"
#import "VLUserHomeResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface VLUserHomeListManager : NCHBaseModelManager
@property (nonatomic,strong) NSMutableArray<VLVideoInfoModel*> * dataArray;//数据源
/**拉取数据*/
-(void)loadDataWithCatId:(NSInteger)catId;

@end

NS_ASSUME_NONNULL_END
