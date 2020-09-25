//
//  YISIndexViewController.m
//  VLog
//
//  Created by szy on 2020/9/14.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "YISIndexViewController.h"


#define COLOR_WITH_RGB(R,G,B,A) [UIColor colorWithRed:R green:G blue:B alpha:A]

@interface YISIndexViewController ()

@end

@implementation YISIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = COLOR_WITH_RGB(arc4random()%255/255.0, arc4random()%255/255.0, arc4random()%255/255.0, 1);
}

#pragma mark - JXCategoryListContentViewDelegate

- (void)listDidAppear{

}

- (UIView *)listView {
    return self.view;
}

@end
