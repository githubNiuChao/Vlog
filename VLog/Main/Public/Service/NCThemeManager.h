//
//  NCThemeManager.h
//  VLog
//
//  Created by szy on 2020/9/23.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NCThemeManager : NSObject

+ (NCThemeManager *)defaultThemeManage;
/// 主题色
@property (strong, nonatomic) UIColor *themeColor;

@end

NS_ASSUME_NONNULL_END
