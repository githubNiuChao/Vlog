//
//  PictureInfo.h
//  VLog
//
//  Created by szy on 2020/9/21.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "BaseModel.h"

@interface PictureInfo :BaseModel

@property (nonatomic, copy) NSString      *file_id;
@property (nonatomic, copy) NSString      *url;
@property (nonatomic, assign) NSInteger   width;
@property (nonatomic, assign) NSInteger   height;
@property (nonatomic, copy) NSString      *type;

@end
