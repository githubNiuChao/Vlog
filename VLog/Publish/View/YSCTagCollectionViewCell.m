//
//  YSCTagCollectionViewCell.m
//  VLog
//
//  Created by szy on 2020/9/18.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "YSCTagCollectionViewCell.h"
#import "YBTagView.h"
#import "HXPhotoEditStickerTrashView.h"

@interface YSCTagCollectionViewCell ()<YBTagViewDelegate>

@property (strong, nonatomic) HXPreviewImageView *imageView;
@property (strong, nonatomic) HXPhotoEditStickerTrashView *transhView;
//@property (assign, nonatomic) BOOL transhViewIsVisible;
//@property (assign, nonatomic) BOOL transhViewDidRemove;


@end

@implementation YSCTagCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup{
    
    [self.contentView addSubview:self.imageView];
    [self.imageView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        
        CGPoint point = [gestureRecoginzer locationInView:gestureRecoginzer.view];
        YBTagView *tagView = [[YBTagView alloc]initWithPoint:point];
//        tagView.block = ^(NSString *gestureString){
//            NSLog(@"......%@",gestureString);
//        };
        tagView.tagViewDelegate = self;
        [self.imageView addSubview:tagView];
        tagView.tagArray = @[@"可儿购ssssssssssss"];
    }];
}

- (void)setModel:(HXPhotoModel *)model{
    _model = model;
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    CGFloat imgWidth = self.model.endImageSize.width;
    CGFloat imgHeight = self.model.endImageSize.height;
    self.imageView.frame = CGRectMake(0, 0, imgWidth, imgHeight);
    self.imageView.center = CGPointMake(width / 2, height / 2);
    self.imageView.model = model;
    
}

#pragma mark -YBTagViewDelegate

- (void)tagView:(YBTagView *)tagvView panGesture:(UIPanGestureRecognizer *)panGestureRecognizer tagCenter:(CGPoint)center{
    NSLog(@"拖动了标签%@",NSStringFromCGPoint(center));
    HXWeakSelf
    if (panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        
        [self.imageView addSubview:weakSelf.transhView];
        [weakSelf showTranshView];
        CGPoint point = [panGestureRecognizer locationInView:self.imageView];
           if (CGRectContainsPoint(weakSelf.transhView.frame, point)) {
               weakSelf.transhView.inArea = YES;
           }else {
               weakSelf.transhView.inArea = NO;
           }
    }
    
    if (panGestureRecognizer.state == UIGestureRecognizerStateEnded ||
        panGestureRecognizer.state == UIGestureRecognizerStateCancelled) {
            CGPoint point = [panGestureRecognizer locationInView:self.imageView];
            if (CGRectContainsPoint(weakSelf.transhView.frame, point)) {
                  [UIView animateWithDuration:0.25 animations:^{
                      tagvView.alpha = 0;
                  } completion:^(BOOL finished) {
                      [tagvView removeFromSuperview];
                  }];
           
           }
        [weakSelf hideTranshView];
    }
    
}

- (void)tagView:(YBTagView *)tagvView tagInfoString:(NSString *)string {
    NSLog(@"点击了标签%@",string);
}


- (HXPhotoEditStickerTrashView *)transhView {
    if (!_transhView) {
        _transhView = [HXPhotoEditStickerTrashView initView];
        _transhView.hx_size = CGSizeMake(120, 50);
        _transhView.hx_centerX = self.imageView.hx_centerX;
        _transhView.hx_y = self.imageView.hx_h;
        _transhView.alpha = 0;
    }
    return _transhView;
}
- (void)showTranshView {
    [UIView animateWithDuration:0.25 animations:^{
        self.transhView.hx_y = self.imageView.hx_h - 10 - self.transhView.hx_h;
        self.transhView.alpha = 1;
    }];
}
- (void)hideTranshView {

    [UIView animateWithDuration:0.25 animations:^{
        self.transhView.hx_y = self.imageView.hx_h;
        self.transhView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.transhView removeFromSuperview];
        self.transhView.inArea = NO;
    }];
}


- (HXPreviewImageView *)imageView {
    if (!_imageView) {
        _imageView = [[HXPreviewImageView alloc] init];
        _imageView.clipsToBounds = YES;
        _imageView.userInteractionEnabled = YES;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        }
    return _imageView;
}

@end
