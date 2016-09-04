//
//  HeaderSegmentControl.h
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/8/26.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderSegmentControl : UIView
@property (nonatomic,strong) UIButton *buttonOne;
@property (nonatomic,strong) UIButton *buttonTwo;
@property (nonatomic,strong) UIButton *buttonThree;
@property (nonatomic,strong) UIButton *buttonFour;
@property (nonatomic,copy) void(^ButtonActionBlock)(int buttonTag);
@property (nonatomic,assign) int buttonCount;
-(void)swipeAction:(NSInteger)tag;
@end
