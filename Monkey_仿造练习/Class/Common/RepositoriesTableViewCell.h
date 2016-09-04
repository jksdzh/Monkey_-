//
//  RepositoriesTableViewCell.h
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/8/30.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RepositoriesTableViewCell : UITableViewCell
@property (nonatomic,strong) UILabel *rankLabel;
@property (nonatomic,strong) UILabel *repositoryLabel;
@property (nonatomic,strong) UILabel *userLabel;
@property (nonatomic,strong) UILabel * descriptionLabel;
@property (nonatomic,strong) UILabel *starLabel;
@property (nonatomic,strong) UILabel *forkLabel;
@property (nonatomic,strong) UIImageView *titleImageView;
@property (nonatomic,strong) UIButton *homePageButton;
@end
