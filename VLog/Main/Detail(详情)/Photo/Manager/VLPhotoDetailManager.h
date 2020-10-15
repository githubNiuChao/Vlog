//
//  VLPhotoDetailManager.h
//  VLog
//
//  Created by szy on 2020/10/14.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "NCHBaseModelManager.h"
#import "VLPhotoDetailResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface VLPhotoDetailManager : NCHBaseModelManager

KProStrongType(VLPhotoDetailResponse,dataModel)

-(void)loadDataWithVideoId:(NSString *)videoid;

@end

NS_ASSUME_NONNULL_END
