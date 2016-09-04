//
//  LanguageViewController.h
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/8/29.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,LanguageEntranceType) {
    UserLanguageEntranceType =0,
    RepositoryLanguageEntranceType,
    TrendingLanguageEntranceType,
};
@interface LanguageViewController : UIViewController

@property (nonatomic,assign) LanguageEntranceType languageEntranceType;

@end
