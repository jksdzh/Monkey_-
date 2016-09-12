//
//  SearchSegmentControlView.m
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/9/7.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "SearchSegmentControlView.h"
@interface SearchSegmentControlView(){
    int currentTag;
}

@end
@implementation SearchSegmentControlView
-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];

    if (self) {
        UIColor * black = [UIColor blackColor];
        UIFont * myFont = [UIFont boldSystemFontOfSize:16];
        float width = ScreenWidth-10;
//buttonOne
        self.buttonOne =[UIButton buttonWithType:UIButtonTypeCustom];
        self.buttonOne.frame = CGRectMake(0, 0 ,width/2,28);
        [self.buttonOne setTitle:@"Users" forState:UIControlStateNormal];
        [self.buttonOne setTitleColor:black forState:UIControlStateNormal];
         self.buttonOne.tag =101;
        [self.buttonOne addTarget:self action:@selector(SearchSegmentButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.buttonOne];

        self.buttonOne.titleLabel.font =myFont;
//buttonTwo
        self.buttonTwo =[UIButton buttonWithType:UIButtonTypeCustom];
        self.buttonTwo.frame = CGRectMake(width/2, 0 ,width/2,28);
          self.buttonTwo.tag =102;
        [self.buttonTwo addTarget:self action:@selector(SearchSegmentButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonTwo  setTitle:@"Repositories" forState:UIControlStateNormal];
        [self.buttonTwo setTitleColor:black forState:UIControlStateNormal];
        [self addSubview:self.buttonTwo];

        self.buttonTwo.titleLabel.font =myFont;
        [self.buttonTwo setTitleColor:black forState:UIControlStateNormal];

//labelOne         #F1A042
        labelOne =[[UILabel alloc]initWithFrame:CGRectMake(0 +(width/2-50)/2, 28, 50, 2)];
        [self addSubview:labelOne];
        labelOne.backgroundColor =YiBlue;
//labelTwo
        labelTwo =[[UILabel alloc]initWithFrame:CGRectMake(width/2 +(width/2-50)/2, 28, 50, 2)];
        [self addSubview:labelTwo];
        labelTwo.backgroundColor =YiBlue;
        labelOne.hidden =YES;
        labelTwo.hidden =YES;
//默认情况
        currentTag =101;
        labelOne.hidden =NO;
        [self.buttonOne setTitleColor:YiBlue forState:UIControlStateNormal ];
    }
    return self;

}
-(void)SearchSegmentButtonClick:(UIButton*)button{
    UIColor * black =[UIColor blackColor];
    switch (button.tag){
        case 101:{

            labelOne.hidden =NO;
            labelTwo.hidden =YES;
            currentTag =101;
            [self.buttonOne  setTitleColor:YiBlue forState:UIControlStateNormal];
            [self.buttonTwo setTitleColor:black forState:UIControlStateNormal];
    }
            break;
            case 102:
        {    
            labelOne.hidden =YES;
            labelTwo.hidden =NO;
            currentTag =102;
            [self.buttonOne  setTitleColor:black forState:UIControlStateNormal];
            [self.buttonTwo setTitleColor:YiBlue forState:UIControlStateNormal ];
        }
            break;
        default:
            break;
    }
    if (self.ButtonActionBlock) {
        self.ButtonActionBlock(currentTag);
    }

}





@end
