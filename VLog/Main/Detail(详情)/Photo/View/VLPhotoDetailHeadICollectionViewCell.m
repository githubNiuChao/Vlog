//
//  VLPhotoDetailHeadICollectionViewCell.m
//  VLog
//
//  Created by szy on 2020/10/28.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLPhotoDetailHeadICollectionViewCell.h"
#import "UIView+SDExtension.h"

@implementation VLPhotoDetailHeadICollectionViewCell
{
    __weak UILabel *_titleLabel;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.tagViewarray = [[NSMutableArray alloc] init];
        [self setupImageView];
        [self setupTitleLabel];
    }
    
    return self;
}

- (void)setTitleLabelBackgroundColor:(UIColor *)titleLabelBackgroundColor
{
    _titleLabelBackgroundColor = titleLabelBackgroundColor;
    _titleLabel.backgroundColor = titleLabelBackgroundColor;
}

- (void)setTitleLabelTextColor:(UIColor *)titleLabelTextColor
{
    _titleLabelTextColor = titleLabelTextColor;
    _titleLabel.textColor = titleLabelTextColor;
}

- (void)setTitleLabelTextFont:(UIFont *)titleLabelTextFont
{
    _titleLabelTextFont = titleLabelTextFont;
    _titleLabel.font = titleLabelTextFont;
}

- (void)setupImageView
{
    UIImageView *imageView = [[UIImageView alloc] init];
    _imageView = imageView;
    _imageView.frame = self.bounds;
    _imageView.userInteractionEnabled = YES;
    CGFloat titleLabelW = self.sd_width;
    CGFloat titleLabelH = _titleLabelHeight;
    CGFloat titleLabelX = 0;
    CGFloat titleLabelY = self.sd_height - titleLabelH;
    _titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    [self.contentView addSubview:imageView];
}

- (void)setupTitleLabel
{
    UILabel *titleLabel = [[UILabel alloc] init];
    _titleLabel = titleLabel;
    _titleLabel.hidden = YES;
    [self.contentView addSubview:titleLabel];
}

- (void)setTitle:(NSString *)title
{
    _title = [title copy];
    _titleLabel.text = [NSString stringWithFormat:@"   %@", title];
    if (_titleLabel.hidden) {
        _titleLabel.hidden = NO;
    }
}

-(void)setTitleLabelTextAlignment:(NSTextAlignment)titleLabelTextAlignment
{
    _titleLabelTextAlignment = titleLabelTextAlignment;
    _titleLabel.textAlignment = titleLabelTextAlignment;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    if (self.onlyDisplayText) {
//        _titleLabel.frame = self.bounds;
//    } else {
//        _imageView.frame = self.bounds;
//        CGFloat titleLabelW = self.sd_width;
//        CGFloat titleLabelH = _titleLabelHeight;
//        CGFloat titleLabelX = 0;
//        CGFloat titleLabelY = self.sd_height - titleLabelH;
//        _titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
//    }
}



- (void)addTagWithPointWithTagModel:(VLDetail_TagListResponse *)tagListModel{
    
    if ([self.tagViewarray containsObject:@(tagListModel.tag_id)]) {
        return;
    }
    
//    YSCTagModel *tagModel = [[YSCTagModel alloc] init];
//    tagModel.tagInfo = infoStr;
//    tagModel.tagPoint = centerPoint;
    
    CGPoint centerPoint = CGPointMake(tagListModel.left, tagListModel.top);
    YBTagView *tagView = [[YBTagView alloc]initWithPoint:centerPoint];
    tagView.isPanGestureOnTagViewed = NO;
    tagView.tagViewDelegate = self;
    /*****一点要先添加TagView再加数组******/
    [self.imageView addSubview:tagView];
    tagView.tagArray = @[tagListModel.tag_text];
    tagView.tagModel = tagListModel;
    [self.tagViewarray addObject:@(tagListModel.tag_id)];

//    [self.pointArray addObject:@(centerPoint)];
}

- (void)tagView:(YBTagView *)tagView panGesture:(UIPanGestureRecognizer *)panGestureRecognizer tagCenter:(CGPoint)center {
    
}

- (void)tagView:(YBTagView *)tagView tagInfoString:(NSString *)string {
    
    if (self.delegate &&[self.delegate respondsToSelector:@selector(photoDetailHeadICollectionViewCell:didClickTagForViewModel:)]) {
        [self.delegate photoDetailHeadICollectionViewCell:self didClickTagForViewModel:tagView.tagModel];
    }
}


@end

