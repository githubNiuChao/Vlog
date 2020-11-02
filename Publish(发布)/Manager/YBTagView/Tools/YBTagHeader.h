
//
//  YBTagHeader.h
//  YBTagView
//
//  Created by szy on 2020/9/16.
//  Copyright © 2020 niuchao. All rights reserved.
//

#ifndef YBTagHeader_h
#define YBTagHeader_h

//屏幕的宽和高
#define FULL_WIDTH    [UIScreen mainScreen].bounds.size.width
#define FULL_HEIGHT   [UIScreen mainScreen].bounds.size.height

#define VIEW_W  FULL_WIDTH/375
#define VIEW_H  FULL_HEIGHT/667

//警告
#define   SHOW_ALTER(str)  [[[UIAlertView alloc]initWithTitle:@"点击了" message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil] show]

#import "UIView+Extension.h"
#import "YBTagStyle.h"
#import "YBTagView.h"
#import "YBTagLabel.h"
#import "YBCenterView.h"
#import "YBFocusLayer.h"
#import "YBBranchLayer.h"
#import "YBTagGestureRecognizer.h"

#endif /* YBTagHeader_h */
