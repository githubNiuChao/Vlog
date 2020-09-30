//
//  PersonListCollectionViewCell.h
//  MiAiApp
//
//  Created by 徐阳 on 2017/7/14.
//  Copyright © 2017年 徐阳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VLIndexModel.h"

@interface PersonListCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong) VLIndexModel *personModel;
@property (strong, nonatomic) UIImageView *imgView;

@end
