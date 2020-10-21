//
//  NCHSettingCell.h
//  VLog
//
//  Created by szy on 2020/9/12.
//  Copyright © 2020 niuchao. All rights reserved.
//

//

#import <UIKit/UIKit.h>

@class NCHWordItem;

@interface NCHSettingCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView andCellStyle:(UITableViewCellStyle)style;

/** 静态单元格模型 */
@property (nonatomic, strong)  NCHWordItem *item;

@end
