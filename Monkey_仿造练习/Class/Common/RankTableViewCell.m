//
//  RankTableViewCell.m
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/8/26.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "RankTableViewCell.h"

@implementation RankTableViewCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if ( self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        float height = 70.5;
        float originX =0;
        float width =ScreenWidth -originX *2;
        float preWidth =15;
        float rankWidth = 45;
        float sufRankWidth =10;
        float imageViewWidth = 50;
        float sufImageViewWidth = 25;
        float labelWidth = width - 2 *preWidth -rankWidth -sufRankWidth - imageViewWidth -sufImageViewWidth;
        self.contentView.backgroundColor = YiGray;
        UIView * backGroundView = [[UIView alloc]initWithFrame:CGRectMake(originX, 0, width, height)]
        ;
       [ self.contentView addSubview:backGroundView];
        backGroundView.backgroundColor = [UIColor whiteColor];
        _rankLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,( height -30)/2, rankWidth +preWidth, 30)];
        [backGroundView addSubview:self.rankLabel];
        self.titleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(preWidth +rankWidth + sufRankWidth,( height -imageViewWidth)/2, imageViewWidth, imageViewWidth)];

        [backGroundView addSubview:self.titleImageView];
        self.mainLabel = [[UILabel alloc]initWithFrame:CGRectMake(preWidth +rankWidth +sufRankWidth +imageViewWidth +sufImageViewWidth,( height -imageViewWidth)/2, labelWidth, imageViewWidth/2)];
        self.detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(preWidth +rankWidth+sufRankWidth +imageViewWidth +sufImageViewWidth, height/2, labelWidth, imageViewWidth/2)];
        [backGroundView addSubview:self.mainLabel];
        [backGroundView addSubview:self.detailLabel];
        self.mainLabel.numberOfLines =0;
        self.rankLabel.textColor =YiBlue;
        self.mainLabel.textColor =YiBlue;
        self.detailLabel.textColor =YiGray;
        self.rankLabel.textAlignment =NSTextAlignmentCenter;
        self.mainLabel.font = [UIFont systemFontOfSize:18]
        ;
        self.detailLabel.font =[UIFont  systemFontOfSize:13];
        self.mainLabel.textAlignment =NSTextAlignmentLeft;
        self.detailLabel.textAlignment =NSTextAlignmentLeft;

        self.titleImageView.layer.masksToBounds =YES;
        self.titleImageView.layer.cornerRadius =10;
        self.titleImageView.layer.borderColor =YiGray.CGColor;
        self.titleImageView.layer.borderWidth =0.3;


    }
    return self;
}

@end
