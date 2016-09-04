//
//  LoginWebViewController.h
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/8/31.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginWebViewController : UIViewController

@property (nonatomic,strong) NSString  *urlString;
 // LoginWebViewController 's url
@property (nonatomic,copy) void (^callback)(NSString *code); //login callback
@end
