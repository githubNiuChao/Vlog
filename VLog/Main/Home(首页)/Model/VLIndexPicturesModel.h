//
//  VLIndexPicturesModel.h
//  VLog
//
//  Created by szy on 2020/9/24.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

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
