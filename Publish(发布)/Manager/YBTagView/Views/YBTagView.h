//
//  YBTagView.h
//  YBTagView
//
//  //  Created by szy on 2020/9/16.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VLDetailResponse.h"
#import "YSCTagModel.h"

#define TagViewW  150 //标签底部view的宽
#define TagViewH  100 //标签底部view的高
#define TagLabelH 25 // 标签上文字label的高
#define CenterViewW 30 //中心点按钮的宽
#define CenterViewH 30 //中心点按钮的高
#define space 10  //从中心点到label之间的间隔距离
#define threeTagSpace 5 // 同上
#define perLabelH 40 //文字label的高
#define addLabelW 10 //

typedef void(^myBlock)(NSString *str);


@class YBTagView;

@protocol YBTagViewDelegate <NSObject>

/// 点击标签
- (void)tagView:(YBTagView *)tagView tagInfoString:(NSString *)string;

/// 拖动标签
- (void)tagView:(YBTagView *)tagView panGesture:(UIPanGestureRecognizer *)panGestureRecognizer tagCenter:(CGPoint )center;

@end

@interface YBTagView : UIView

/**按住拖动手势*/
@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;
/**是否打开按住拖动功能*/
@property (nonatomic, assign) BOOL isPanGestureOnTagViewed;
/**tag的数组*/
@property (nonatomic, strong) NSArray *tagArray;
@property (nonatomic, assign) CGPoint tagViewCenterPoint;
@property (nonatomic, assign) CGPoint selfCenter;
@property (nonatomic, weak) id<YBTagViewDelegate> tagViewDelegate;

@property (nonatomic, copy) myBlock block;

//详情接收的标签Model
@property (nonatomic, strong) VLDetail_TagListResponse *tagModel;
//用于发布的标签Model
@property (nonatomic, strong) YSCTagModel *pusblishTagModel;

/**
 *  根据点来确定加上的标签页
 *
 *  @param point 触摸屏幕时点中的点
 */
- (instancetype)initWithPoint:(CGPoint)point;
/**
 *  在图片上添加标签,添加完不可修改
 *
 *  @param point    触摸屏幕时点中的点
 *  @param array    有标签名字的数组
 *  @param tagStyle 标签的风格，传入的是枚举值
 */
- (instancetype)initWithPoint:(CGPoint)point array:(NSArray *)array tagStyle:(NSInteger)tagStyle;


@end
