//
//  RepositoriesTableViewCell.m
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/8/30.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "RepositoriesTableViewCell.h"

@implementation RepositoriesTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

  self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // initialization code
        float height =94.5; //orginY*2+repositoryLabelHeight*4+spacce*2=96
        float heightSpace =2;
        float originX = 0;
        float width =ScreenWidth -originX *2;
        float preWidth =10;
        float rankWidth =40;
        float sufRankWidth =10;
        float repositoryLabelWidth =180;
        float userLabelWidth =110;
        float imageViewWidth =30;
        float labelWidth =width-2 *preWidth -rankWidth-sufRankWidth;
        float repositoryLabelHeight =20;
        float originY =5;

        self.contentView.backgroundColor = YiGray;

        UIView *backGroundView = [[UIView alloc]initWithFrame:CGRectMake(originX, 0, width, height)];
        [self.contentView addSubview:backGroundView];
        backGroundView.backgroundColor = [UIColor whiteColor];
//rankLabel
        self.rankLabel =[[UILabel alloc]initWithFrame:CGRectMake(preWidth, originY, rankWidth, repositoryLabelHeight)];
        self.rankLabel.textColor =YiBlue;
        self.rankLabel.textAlignment =NSTextAlignmentCenter;

        [backGroundView addSubview:self.rankLabel];
//repositoryLabel
        self.repositoryLabel = [[UILabel alloc]initWithFrame:CGRectMake(preWidth+rankWidth +sufRankWidth, originY, repositoryLabelWidth, repositoryLabelHeight)];
        self.repositoryLabel.textColor =YiBlue;
        [backGroundView addSubview:self.repositoryLabel];
//userLabel
        self.userLabel = [[UILabel alloc]initWithFrame:CGRectMake(preWidth +rankWidth +sufRankWidth, originY +repositoryLabelHeight +heightSpace, userLabelWidth, repositoryLabelHeight)];
        [backGroundView addSubview:self.userLabel];
        self.userLabel.font =[UIFont systemFontOfSize:12];
        self.userLabel.textColor =YiTextGray;

        self.descriptionLabel = [[UILabel alloc]initWithFrame:CGRectMake(preWidth +rankWidth+sufRankWidth, originY +repositoryLabelHeight *2+heightSpace *2, labelWidth, repositoryLabelHeight *2)];
        [backGroundView addSubview:self.descriptionLabel];

 //todo
        self.titleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(preWidth+(rankWidth -imageViewWidth)/2, originY +30+heightSpace, imageViewWidth, imageViewWidth)];
        [backGroundView addSubview:self.titleImageView];
//starLabel
        self.starLabel =[[UILabel alloc]initWithFrame:CGRectMake(preWidth +rankWidth+sufRankWidth+repositoryLabelWidth, originY, 65, repositoryLabelHeight)];
        self.starLabel.font =[UIFont systemFontOfSize:13];
        self.starLabel.textColor =YiTextGray;


        [backGroundView addSubview:self.starLabel];
//folkLabel
        self.forkLabel =  [[UILabel alloc]initWithFrame:CGRectMake(preWidth +rankWidth+sufRankWidth+65+5+repositoryLabelWidth, originY, 65, repositoryLabelHeight)];
//        [backGroundView addSubview:self.forkLabel];
        self.forkLabel.font =[UIFont systemFontOfSize:12];
        self.forkLabel.textColor =YiTextGray;

//homePageButton
        self.homePageButton =[UIButton buttonWithType:UIButtonTypeCustom];
        [self.homePageButton setTitleColor:YiBlue forState:UIControlStateNormal];
        self.homePageButton.titleLabel.font =[UIFont systemFontOfSize:12];
        self.homePageButton.frame = CGRectMake(preWidth+rankWidth+sufRankWidth+userLabelWidth, originY+repositoryLabelHeight+heightSpace , labelWidth-userLabelWidth   , repositoryLabelHeight);
        self.homePageButton.contentHorizontalAlignment =UIControlContentHorizontalAlignmentLeft;
//      self.homePageButton.titleLabel.lineBreakMode =NSLineBreakByTruncatingTail;       //default
        [backGroundView addSubview:self.homePageButton];
    }

    return self;

}








@end
