//
//  HeaderSegmentControl.m
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/8/26.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "HeaderSegmentControl.h"
@interface HeaderSegmentControl(){
int currentTag;
    UIColor *black;
    UIColor *light;
    UIFont *normalFont;
    UIFont *lightFont;
}
@end
@implementation HeaderSegmentControl
-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];

    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1];
        float h =35;
        float space = 0;
        float width =(ScreenWidth)/4 -space;
        float height =h;
        float w =space + width;
        black = [UIColor  colorWithRed:0.35 green:0.35 blue:0.35 alpha:1];
        light =YiBlue;

        normalFont = [UIFont systemFontOfSize:12];
        if (ScreenWidth <=320) {
            lightFont =normalFont;
        } else {
            lightFont =[UIFont systemFontOfSize:14];
        }
        self.buttonOne =[UIButton buttonWithType:UIButtonTypeCustom];

        self.buttonOne.frame = CGRectMake(space, (h -height)/2 , width   , height);
        [self.buttonOne setTitle:@"北京"
  forState:UIControlStateNormal];
        [self.buttonOne setTitleColor:black forState:UIControlStateNormal];
        self.buttonOne.tag =101;
        self.buttonOne.titleLabel.font =normalFont;

        [self.buttonOne addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.buttonOne];
        self.buttonTwo =[UIButton buttonWithType:UIButtonTypeCustom];
        self.buttonTwo.tag =102;
        self.buttonTwo.frame = CGRectMake(w+space,  (h -height)/2, width   , height);
        [self.buttonTwo setTitle:@"china"

                                    forState:UIControlStateNormal];
        [self.buttonTwo setTitleColor:black forState:UIControlStateNormal];
        [self.buttonTwo addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        self.buttonTwo.titleLabel.font =normalFont;
        [self addSubview:self.buttonTwo];
        self.buttonThree =[UIButton buttonWithType:UIButtonTypeCustom];

        self.buttonThree.frame = CGRectMake(w*2+space, (h -height)/2 , width   , height);
        [self.buttonThree setTitle:@"wolrd"
  forState:UIControlStateNormal];
        self.buttonThree.tag =103;
        [self.buttonThree setTitleColor:black forState:UIControlStateNormal];
        [self.buttonThree addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        self.buttonThree.titleLabel.font = normalFont;
       [self addSubview:self.buttonThree];
        self.buttonFour =[UIButton buttonWithType:UIButtonTypeCustom];

        self.buttonFour.frame = CGRectMake(w *3 +space +5, (h - 20)/2 , width -5   , 20);
        [self.buttonFour setTitle:@""
 forState:UIControlStateNormal];
        [self.buttonFour setTitleColor:black forState:UIControlStateNormal];
        self.buttonFour.titleLabel.font = normalFont;
        [self.buttonFour addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonFour setBackgroundColor:YiBlue];
        [self.buttonFour setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.buttonFour.tag = 104;
        [self addSubview:self.buttonFour];
        //默认情况 default situation
        currentTag =101;
        [self.buttonOne  setTitleColor:light forState:UIControlStateNormal];
        self.buttonOne.titleLabel.font =lightFont;



    }
    return self;

}

-(void)buttonClick:(UIButton *)button{
    [self swipeAction:button.tag];

}
-(void)swipeAction:(NSInteger)tag{
    switch (tag) {
        case 101:
            currentTag = 101;
            [self.buttonOne setTitleColor:light forState:UIControlStateNormal];
            [self.buttonTwo  setTitleColor:black forState:UIControlStateNormal];
            [self.buttonThree setTitleColor:black forState:UIControlStateNormal];
            self.buttonOne.titleLabel.font = lightFont;
            self.buttonTwo.titleLabel.font =normalFont;
            self.buttonThree.titleLabel.font =normalFont;


            break;
        case 102:
            currentTag =102;
            [self.buttonOne setTitleColor:black     forState:UIControlStateNormal];
            [self.buttonTwo  setTitleColor:light    forState:UIControlStateNormal];
            [self.buttonThree setTitleColor:black forState:UIControlStateNormal];
            self.buttonOne.titleLabel.font = normalFont ;
            self.buttonTwo.titleLabel.font =lightFont;
            self.buttonThree.titleLabel.font =normalFont;
            break;

            case 103:
            if (self.buttonCount <=2) {
                break;
            }
            currentTag =103;
            [self.buttonOne setTitleColor:black     forState:UIControlStateNormal];
            [self.buttonTwo  setTitleColor:black    forState:UIControlStateNormal];
            [self.buttonThree setTitleColor:light forState:UIControlStateNormal];
            self.buttonOne.titleLabel.font = normalFont ;
            self.buttonTwo.titleLabel.font =normalFont;
            self.buttonThree.titleLabel.font =lightFont;
            break;
            case 104:
            if (self.buttonCount<=3) {
                break;
            }
            currentTag =104;
            [self.buttonOne setTitleColor:black     forState:UIControlStateNormal];
            [self.buttonTwo  setTitleColor:black    forState:UIControlStateNormal];
            [self.buttonThree setTitleColor:black forState:UIControlStateNormal];
            self.buttonOne.titleLabel.font = normalFont ;
            self.buttonTwo.titleLabel.font =normalFont;
            self.buttonThree.titleLabel.font = normalFont;
            break;
        default:
            break;
    }
    if (self.ButtonActionBlock) {
        self.ButtonActionBlock(currentTag);
    }
}



@end
