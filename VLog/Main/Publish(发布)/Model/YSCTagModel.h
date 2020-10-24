//
//  YSCTagModel.h
//  VLog
//
//  Created by szy on 2020/9/21.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
//用于上传的标签数据
@interface YSCTagModel : NSObject
@property (assign, nonatomic) NSInteger path_index;
@property (copy, nonatomic) NSString *tag_text;
@property (assign, nonatomic) NSInteger goods_id;
@property (assign, nonatomic) NSInteger brand_id;
@property (assign, nonatomic) NSInteger top;
@property (assign, nonatomic) NSInteger left;

@end

NS_ASSUME_NONNULL_END
