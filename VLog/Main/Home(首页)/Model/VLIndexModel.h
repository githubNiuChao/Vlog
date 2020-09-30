//
//  VLIndexModel.h
//  VLog
//
//  Created by szy on 2020/9/24.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class VLIndexPicturesModel;

@interface VLIndexModel : NSObject

@property (nonatomic, copy) NSString *age;
@property (nonatomic, assign) NSInteger channel;
@property (nonatomic, assign) NSInteger sex;
@property (nonatomic, copy) NSString *weixin;

@property (nonatomic, strong) NSArray<VLIndexPicturesModel *> *pictures;
@property (nonatomic, strong) NSArray *imageArray;


@property (nonatomic, copy) NSString *picture;
@property (nonatomic, copy) NSString *headImg;
@property (nonatomic, copy) NSString *requires;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, assign) float imageHeight;
@property (nonatomic, assign) float imageWidth;
@property (nonatomic, copy) NSString *hobbys;

@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *objectId;
@property (nonatomic, copy) NSString *job;
@property (nonatomic, copy) NSString *introduce;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, copy) NSString *imageAve;
@property (nonatomic, copy) NSString *juli;

@property (nonatomic,assign) float imageCacheHeight;//适配瀑布流缓存的图片高度
@property (nonatomic,assign) float hobbysCacheHeight;//适配瀑布流缓存文本高度

KProBool(islike);
KProBool(isvideo);

@end

@interface VLIndexPicturesModel : NSObject

@property (nonatomic, copy) NSString *format;
@property (nonatomic, assign) NSInteger height;
@property (nonatomic, copy) NSString *mimeType;
@property (nonatomic, copy) NSString *userid;
@property (nonatomic, copy) NSString *imageAve;
@property (nonatomic, assign) NSInteger size;
@property (nonatomic, copy) NSString *objectId;
@property (nonatomic, assign) NSInteger width;
@property (nonatomic, copy) NSString *pictureType;
@property (nonatomic, copy) NSString *urlWithName;
@property (nonatomic, copy) NSString *url;
@end

NS_ASSUME_NONNULL_END
