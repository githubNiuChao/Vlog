//
//  VLIndexModel.h
//  VLog
//
//  Created by szy on 2020/9/24.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VLIndexPicturesModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface VLIndexModel : NSObject

@property (nonatomic, copy) NSString *age;
@property (nonatomic, assign) NSInteger channel;
@property (nonatomic, assign) NSInteger sex;
@property (nonatomic, copy) NSString *weixin;
@property (nonatomic, strong) NSArray<VLIndexPicturesModel *> *pictures;
@property (nonatomic, copy) NSString *picture;
@property (nonatomic, copy) NSString *headImg;
@property (nonatomic, copy) NSString *requires;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, assign) float height;
@property (nonatomic, assign) float width;
@property (nonatomic, copy) NSString *hobbys;
@property (nonatomic,assign) float hobbysHeight;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *objectId;
@property (nonatomic, copy) NSString *job;
@property (nonatomic, copy) NSString *introduce;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, copy) NSString *imageAve;
@property (nonatomic, copy) NSString *juli;

@end

NS_ASSUME_NONNULL_END
