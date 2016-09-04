//
//  BaseNavigationController.m
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/8/26.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "BaseNavigationController.h"

@implementation BaseNavigationController
-(instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    self = [super initWithRootViewController:rootViewController ];
    if (self) {
        self.statusBarStyle = UIStatusBarStyleLightContent;
        self.navigationBar.hidden =NO;
    }
    return self;

}
- (UIStatusBarStyle )preferredStatusBarStyle{
    return self.statusBarStyle;
}
@end
