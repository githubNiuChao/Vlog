//
//  NSNotification+Extension.m
//  VLog
//
//  Created by szy on 2020/9/21.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "NSNotification+Extension.h"

@implementation NSNotification (Extension)

- (CGFloat)keyBoardHeight {
    NSDictionary *userInfo = [self userInfo];
    CGSize size = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    return UIInterfaceOrientationIsLandscape(orientation) ? size.width : size.height;
}

@end
