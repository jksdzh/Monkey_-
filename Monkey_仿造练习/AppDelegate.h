//
//  AppDelegate.h
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/8/25.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YiNetworkEngine.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong) YiNetworkEngine *apiEngine;//a api engine

@end

