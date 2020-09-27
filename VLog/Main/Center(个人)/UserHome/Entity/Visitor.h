//
//  Visitor.h
//  VLog
//
//  Created by szy on 2020/9/21.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "BaseModel.h"
#import "PictureInfo.h"
@interface Visitor :BaseModel
@property (nonatomic , copy) NSString              *uid;
@property (nonatomic , copy) NSString              *udid;
@property (nonatomic , strong) PictureInfo         *avatar_thumbnail;
@property (nonatomic , strong) PictureInfo         *avatar_medium;
@property (nonatomic , strong) PictureInfo         *avatar_large;
-(NSString *)formatUDID;
@end
