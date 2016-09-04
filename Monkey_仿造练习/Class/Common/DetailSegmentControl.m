//
//  DetailSegmentControl.m
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/8/30.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "DetailSegmentControl.h"
@interface DetailSegmentControl(){
    int currentTag;
}

@end
@implementation DetailSegmentControl
-(void)segmentButtonClick:(UIButton*)sender{
    [self swipeAction:sender.tag];

}
-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        //initialization code
        //float height = 60 ;30 28 2

        UIColor * black = [UIColor blackColor];
    //float fontSize =15;
        UIFont * myFont = [UIFont boldSystemFontOfSize:16];
        float w =ScreenWidth-10;
//leftButton
        self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:self.leftButton];
        self.leftButton.frame =CGRectMake(0, 0, w/3, 58);
        self.leftButton.titleLabel.font =myFont;
        self.leftButton.tag =101;
        [self.leftButton setTitleColor:black forState:UIControlStateNormal];
        [self.leftButton addTarget:self action:@selector(segmentButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//leftTopButtonLabel
        self.leftTopButtonLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, w/3, 23)];
        self.leftTopButtonLabel.textColor=YiBlue;
        self.leftTopButtonLabel.textAlignment=NSTextAlignmentCenter;
        self.leftTopButtonLabel.font =myFont;
        [self.leftButton addSubview:self.   leftTopButtonLabel];
//leftBottomLabel
        self.leftBottomButtonLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 28, w/3, 23)];
        self.leftBottomButtonLabel.textColor=YiBlue;
        self.leftBottomButtonLabel.textAlignment=NSTextAlignmentCenter;
        self.leftBottomButtonLabel.text =@"Repositories";

        self.leftBottomButtonLabel.font =myFont;
        [self.leftButton addSubview:self.leftBottomButtonLabel];

//middleButton
        self.middleButton =[UIButton buttonWithType:UIButtonTypeCustom];

        self.middleButton.frame = CGRectMake(w/3, 0 , w/3   , 58);
        [self.middleButton setTitleColor:black  forState:UIControlStateNormal];
        self.middleButton.tag =102;
        [self.middleButton addTarget:self action:@selector(segmentButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.middleButton];

//middleTopButtonLabel
        self.middleTopButtonLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, w/3, 23)];
        self.middleTopButtonLabel.textColor=black;
        self.middleTopButtonLabel.textAlignment=NSTextAlignmentCenter;
        self.middleTopButtonLabel.font =myFont;
        self.middleTopButtonLabel.numberOfLines =1;
        [self.middleButton addSubview:self.middleTopButtonLabel];

//middleBottomButtonLabel
        self.middleBottomButtonLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 28, w/3, 23)];
        self.middleBottomButtonLabel.text =@"Following";
        self.middleBottomButtonLabel.textColor=black;
        self.middleBottomButtonLabel.textAlignment=NSTextAlignmentCenter;
        self.middleBottomButtonLabel.font =myFont;
        [self.middleButton addSubview:self.middleBottomButtonLabel];

//rightButton
        self.rightButton =[UIButton buttonWithType:UIButtonTypeCustom];

        self.rightButton.frame = CGRectMake(w/3+w/3, 0 , w/3   , 58);
        [self.rightButton setTitleColor:black forState:UIControlStateNormal
         ];
        self.rightButton.tag =103;
        [self.rightButton addTarget:self action:@selector(segmentButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.rightButton];

//rightTopButtonLabel
        self.rightTopButtonLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, w/3, 23)];
        self.rightTopButtonLabel.textColor=black;
        self.rightTopButtonLabel.textAlignment=NSTextAlignmentCenter;
        self.rightTopButtonLabel.font =myFont;
        [self.rightButton addSubview:self.rightTopButtonLabel];

//rightBottomButtonLabel
        self.rightBottomButtonLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 28, w/3, 23)];
        self.rightBottomButtonLabel.text =@"Follower";
        self.rightBottomButtonLabel.textColor=black;
        self.rightBottomButtonLabel.textAlignment=NSTextAlignmentCenter;
        self.rightBottomButtonLabel.font =myFont;
        [self.rightButton addSubview:self.rightBottomButtonLabel];

// #F1A042
        //leftLabel
        self.leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(0+(w/3-50)/2, 58, 50, 2)];
        [self addSubview:self.leftLabel];
        self.leftLabel.backgroundColor = YiBlue;
        //middleLabel
        self.middleLabel = [[UILabel alloc]initWithFrame:CGRectMake(w/3+(w/3-50)/2, 58, 50, 2)];
        [self addSubview:self.middleLabel];
        self.middleLabel.backgroundColor = YiBlue;
        //rightLabel
        self.rightLabel = [[UILabel alloc]initWithFrame:CGRectMake((w/3*2)+(w/3-50)/2, 58, 50, 2)];
        [self addSubview:self.rightLabel];
        self.rightLabel.backgroundColor = YiBlue;

        self.leftLabel.hidden =YES;
        self.middleLabel.hidden =YES;
        self.rightLabel.hidden =YES;

        //default situation
        currentTag =101;
        self.leftLabel.hidden =NO;
        [self.leftButton setTitleColor:YiBlue forState:UIControlStateNormal];


    }
    return self;

}


-(void)swipeAction:(NSInteger)tag{
    UIColor * black = [UIColor blackColor];
    switch (tag) {
        case 101:
            //hidden
            self.leftLabel.hidden =NO;
            self.middleLabel.hidden =YES;
            self.rightLabel.hidden =YES;
//currentTag
            currentTag =101;
            //buttonTitleColor
            [self.leftButton setTitleColor:YiBlue forState:UIControlStateNormal ];
            [self.middleButton setTitleColor:black forState:UIControlStateNormal ];
            [self.rightButton setTitleColor:black forState:UIControlStateNormal ];
            //buttonLabelColor
            self.leftTopButtonLabel.textColor =YiBlue;
            self.leftBottomButtonLabel.textColor =YiBlue;
            self.middleTopButtonLabel.textColor =black;
            self.middleBottomButtonLabel.textColor =black;
            self.rightTopButtonLabel.textColor =black;
            self.rightBottomButtonLabel.textColor =black;


            break;
        case 102:
            //hidden
            self.leftLabel.hidden =YES;
            self.middleLabel.hidden =NO;
            self.rightLabel.hidden =YES;
            //currentTag
            currentTag =102;
            //buttonTitleColor
            [self.leftButton setTitleColor:black forState:UIControlStateNormal ];
            [self.middleButton setTitleColor:YiBlue forState:UIControlStateNormal ];
            [self.rightButton setTitleColor:black forState:UIControlStateNormal ];
            //buttonLabelColor
            self.leftTopButtonLabel.textColor =black;
            self.leftBottomButtonLabel.textColor =black;
            self.middleTopButtonLabel.textColor =YiBlue;
            self.middleBottomButtonLabel.textColor =YiBlue;
            self.rightTopButtonLabel.textColor =black;
            self.rightBottomButtonLabel.textColor =black;
            break;
        case 103:
            //hidden
            self.leftLabel.hidden =YES;
            self.middleLabel.hidden =YES;
            self.rightLabel.hidden =YES;
            //currentTag
            currentTag =103;
            //buttonTitleColor
            [self.leftButton setTitleColor:black forState:UIControlStateNormal ];
            [self.middleButton setTitleColor:black forState:UIControlStateNormal ];
            [self.rightButton setTitleColor:YiBlue forState:UIControlStateNormal ];
            //buttonLabelColor
            self.leftTopButtonLabel.textColor =black;
            self.leftBottomButtonLabel.textColor =black;
            self.middleTopButtonLabel.textColor =black;
            self.middleBottomButtonLabel.textColor =black;
            self.rightTopButtonLabel.textColor =YiBlue;
            self.rightBottomButtonLabel.textColor =YiBlue;
            break;

        default:
            break;
    }
    if (self.ButtonActionBlock) {
        self.ButtonActionBlock(currentTag);
    }


}




@end
