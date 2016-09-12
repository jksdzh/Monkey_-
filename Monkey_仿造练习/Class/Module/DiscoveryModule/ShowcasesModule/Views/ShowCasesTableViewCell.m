//
//  ShowCasesTableViewCell.m
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/9/4.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "ShowCasesTableViewCell.h"
#import <SDAutoLayout.h>
#import "ShowcasesModel.h"
#import "UIImageView+WebCache.h"
#import "UIView+AutoLayout.h"
#import "PropertyListReformerKeys.h"


@interface ShowCasesTableViewCell(){
   
}

@end
@implementation ShowCasesTableViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame ];
    if (self) {
        [self setUp];
    }
    return self;
}
-(void)setUp{
    //caseLabel


    self.caseNameLabel = [[UILabel alloc]init];
    [self.contentView  addSubview:self.caseNameLabel];


    self.caseNameLabel.textColor=YiBlue;
    self.caseNameLabel.textAlignment=NSTextAlignmentLeft;
    self.caseNameLabel.font =[UIFont systemFontOfSize:20];
//iconImageView


    self.iconImageView =[[UIImageView alloc]init];
    [self.contentView addSubview:self.iconImageView];

    self.iconImageView.layer.masksToBounds =YES;
    self.iconImageView.layer.cornerRadius =self.iconImageView.bounds.size.width/2;
    self.iconImageView.sd_layout.topSpaceToView(self.contentView,5).leftSpaceToView(self.contentView,5).rightSpaceToView(self.contentView,300).bottomSpaceToView(self.contentView,50);

//describeLabel
    self.detailDescribeLabel = [[UILabel alloc]init];



    self.detailDescribeLabel.textColor=YiTextGray;
    self.detailDescribeLabel.textAlignment=NSTextAlignmentCenter;
    self.detailDescribeLabel.font =[UIFont systemFontOfSize:12];
    self.detailDescribeLabel.numberOfLines =0;
    [self.contentView addSubview:self.detailDescribeLabel];
    self.detailDescribeLabel.sd_layout.topSpaceToView(self.contentView,60).leftSpaceToView(self.contentView,35).rightSpaceToView(self.contentView,5).bottomSpaceToView(self.contentView,5);
    

}
-(void)setModel:(ShowcasesModel *)model{
    _model =model;
    self.caseNameLabel.text =model.name;
    self.detailDescribeLabel.text =model.DS;
      [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.image_url]]];

}
-(void)configWithData:(NSDictionary*)data{
    self.caseNameLabel.text =data[kPropertyListDataKeyName];
    self.detailTextLabel.text =data [kPropertyListDataKeyDescription];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",data[kPropertyListDataKeyImage] ]]];

}


@end
