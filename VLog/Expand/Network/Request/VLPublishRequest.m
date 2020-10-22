//
//  VLPublishRequest.m
//  VLog
//
//  Created by szy on 2020/10/21.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLPublishRequest.h"

@implementation VLPublishRequest
{
    NSURL *_videoUrl;
}

- (id)initWithVideoUrl:(NSURL *)videoUrl {
    self = [super init];
    if (self) {
        _videoUrl = videoUrl;
//        self.uploadProgressBlock = _VLUploadProgressBlock;
    }
    return self;
}

- (AFConstructingBlock)constructingBodyBlock {
    return ^(id<AFMultipartFormData> formData) {
//        NSData *data = UIImageJPEGRepresentation(_image, 0.9);
//        NSString *name = @"image";
//        NSString *formKey = @"image";
//        NSString *type = @"image/jpeg";
//        [formData appendPartWithFileData:data name:formKey fileName:name mimeType:type];
        // 获得沙盒中的视频内容
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
        /*! 转化后直接写入Library---caches */
        NSString *videoWritePath = [NSString stringWithFormat:@"output-%@.mp4",[formatter stringFromDate:[NSDate date]]];
        NSString *outfilePath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@", videoWritePath];
        [formData appendPartWithFileURL:self->_videoUrl name:@"video" fileName:outfilePath mimeType:@"application/octet-stream" error:nil];
    };
}

- (NSString *)requestUrl{
   return API_VLOG_PUBLISH_UPLOAD_VIDEO;
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}


#pragma mark 上传进度
//- (AFURLSessionTaskProgressBlock) resumableUploadProgressBlock
//{
//    AFURLSessionTaskProgressBlock block = ^void(NSProgress * progress){
//        if (_VLUploadProgressBlock) {
//            _VLUploadProgressBlock(self,progress);
//        }
//    };
//    return block;
//}

@end
