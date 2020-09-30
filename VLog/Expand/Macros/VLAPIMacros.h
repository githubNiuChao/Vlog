//
//  VLAPIMacros.h
//  VLog
//
//  Created by szy on 2020/9/30.
//  Copyright © 2020 niuchao. All rights reserved.
//

#ifndef VLAPIMacros_h
#define VLAPIMacros_h

#define YSCAPI(path) [YSCBaseURL stringByAppendingString:path]
//测试
#define API_APP_INDEX YSCAPI(@"/index")

//首页
#define API_VLOG_INDEX YSCAPI(@"/user/short-video/message.html")


#endif /* VLAPIMacros_h */
