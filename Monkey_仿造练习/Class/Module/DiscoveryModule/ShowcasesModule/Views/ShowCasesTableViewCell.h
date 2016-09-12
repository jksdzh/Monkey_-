//
//  ShowCasesTableViewCell.h
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/9/4.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShowcasesModel;
@interface ShowCasesTableViewCell : UITableViewCell
 @property (nonatomic,strong)UILabel *caseNameLabel;
@property (nonatomic,strong)UILabel *detailDescribeLabel;
@property (nonatomic,strong)UIImageView *iconImageView;
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) ShowcasesModel *model;
 
@end
