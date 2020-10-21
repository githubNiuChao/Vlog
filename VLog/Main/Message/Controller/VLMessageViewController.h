//
//  VLMessageViewController.h
//  VLog
//
//  Created by szy on 2020/10/20.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "NCHTableViewController.h"

NS_ASSUME_NONNULL_BEGIN


@interface VLMessageModel : NSObject

kProNSString(imageString)
kProNSString(titleString)
kProNSString(subTitleSring)
kProNSString(dateString)
kProNSString(messageNum)
kProNSString(className)

@end

@interface VLMessageCell : UITableViewCell
KProStrongType(VLMessageModel, messageModel)
KProStrongType(UIButton, imageButton)
@end

@interface VLMessageViewController : NCHTableViewController

@end

NS_ASSUME_NONNULL_END
