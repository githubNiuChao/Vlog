//
//  VLVideoListViewController.h
//  VLog
//
//  Created by szy on 2020/10/18.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, AwemeType) {
    AwemeWork        = 0,
    AwemeFavorite    = 1
};

@class Aweme;
@class VLVideoInfoModel;
@interface VLVideoListViewController : BaseViewController

@property (nonatomic, strong) UITableView                       *tableView;
@property (nonatomic, assign) NSInteger                         currentIndex;

-(instancetype)initWithVideoData:(NSMutableArray<VLVideoInfoModel *> *)data currentIndex:(NSInteger)currentIndex pageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize awemeType:(AwemeType)type uid:(NSString *)uid;
@end

NS_ASSUME_NONNULL_END
