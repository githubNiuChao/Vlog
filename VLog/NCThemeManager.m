//
//  NCThemeManager.m
//  VLog
//
//  Created by szy on 2020/9/23.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "NCThemeManager.h"

static NCThemeManager * _defaultThemeManage;

@implementation NCThemeManager

+ (NCThemeManager *)defaultThemeManage {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _defaultThemeManage = [NCThemeManager new];
    });
    return _defaultThemeManage;
}

- (UIColor *)themeColor {
    if (!_themeColor) {
        _themeColor = [UIColor jk_colorWithHexString:@"#E7414D"];
    }
    return _themeColor;
}
@end
