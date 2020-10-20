//
//  VLVideoDetailViewController.h
//  VLog
//
//  Created by szy on 2020/10/20.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "NCHBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
@class VLVideoInfoModel;
@interface VLVideoDetailViewController : NCHBaseViewController

@property (nonatomic, strong) UITableView                       *tableView;
@property (nonatomic, assign) NSInteger                         currentIndex;

-(instancetype)initWithVideoData:(NSMutableArray<VLVideoInfoModel *> *)data currentIndex:(NSInteger)currentIndex pageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize uid:(NSString *)uid;

kProNSString(video_id)

@end
NS_ASSUME_NONNULL_END
