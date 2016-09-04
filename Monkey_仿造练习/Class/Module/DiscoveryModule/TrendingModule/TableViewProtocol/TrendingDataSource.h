//
//  TrendingDataSource.h
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/9/2.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrendingDataSource : NSObject<UITableViewDataSource>
@property (nonatomic,strong) DataSourceModel *dailyDataSourceModel;
@property (nonatomic,strong) DataSourceModel *weeklyDataSourceModel;
@property (nonatomic,strong) DataSourceModel *monthlyDataSourceModel;
@end
