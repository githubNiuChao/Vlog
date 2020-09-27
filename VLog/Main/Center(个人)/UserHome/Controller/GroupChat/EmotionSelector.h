//
//  EmotionSelector.h
//  VLog
//
//  Created by szy on 2020/9/21.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <UIKit/UIKit.h>

#define EmotionSelectorHeight   220 + SafeAreaBottomHeight

@protocol EmotionSelectorDelegate
@required
-(void)onDelete;
-(void)onSend;
-(void)onSelect:(NSString *)emotionKey;
@end

@interface EmotionSelector : UIView
@property (nonatomic, strong) UIView                     *container;
@property (nonatomic, strong) UICollectionView           *collectionView;
@property (nonatomic, weak) id<EmotionSelectorDelegate>  delegate;
-(void)addTextViewObserver:(UITextView *)textView;
- (void)removeTextViewObserver:(UITextView *)textView;
@end

@interface EmotionCell:UICollectionViewCell
@property (nonatomic, strong) UIImageView     *emotion;
@property (nonatomic, copy) NSString          *emotionKey;
- (void)setDelete;
- (void)initData:(NSString *)key;
@end
