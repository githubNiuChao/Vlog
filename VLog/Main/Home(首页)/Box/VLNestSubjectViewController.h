//
//  VLNestSubjectViewController.h
//  VLog
//
//  Created by szy on 2020/9/25.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXCategoryView.h"

NS_ASSUME_NONNULL_BEGIN

@interface VLNestSubjectViewController : UIViewController<
JXCategoryListContentViewDelegate,
JXCategoryListContainerViewDelegate,
JXCategoryViewDelegate
>

@end

NS_ASSUME_NONNULL_END
