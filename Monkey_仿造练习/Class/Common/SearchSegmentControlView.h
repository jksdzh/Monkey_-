//
//  SearchSegmentControlView.h
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/9/7.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchSegmentControlView : UIView
{
    UILabel * labelOne;
    UILabel * labelTwo;

}
@property (nonatomic,strong) UIButton *buttonOne;
@property (nonatomic,strong) UIButton *buttonTwo;
@property (nonatomic,copy) void (^ButtonActionBlock) (int buttonTag);
@end
