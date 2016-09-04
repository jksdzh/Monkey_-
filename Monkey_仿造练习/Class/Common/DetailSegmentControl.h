//
//  DetailSegmentControl.h
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/8/30.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailSegmentControl : UIView
@property (nonatomic,strong) UILabel *leftLabel;
@property (nonatomic,strong) UILabel *middleLabel;

@property (nonatomic,strong) UILabel *rightLabel;


@property (nonatomic,strong) UIButton *leftButton;
@property (nonatomic,strong) UIButton *middleButton;
@property (nonatomic,strong) UIButton *rightButton;

@property (nonatomic,strong) UILabel *leftTopButtonLabel;
@property (nonatomic,strong) UILabel *middleTopButtonLabel;
@property (nonatomic,strong) UILabel *rightTopButtonLabel;

@property (nonatomic,strong) UILabel *leftBottomButtonLabel;
@property (nonatomic,strong) UILabel *middleBottomButtonLabel;
@property (nonatomic,strong) UILabel *rightBottomButtonLabel;
@property (nonatomic,copy) void (^ButtonActionBlock)(int buttonTag);
-(void)swipeAction:(NSInteger)tag;


@end
