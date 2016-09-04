//
//  UserRankDataSource.h
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/8/27.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserRankDataSource : NSObject<UITableViewDataSource>
@property (nonatomic,strong) DataSourceModel *DataSourceOfPageListObjectOne;//city datasource
@property (nonatomic,strong) DataSourceModel *DatasourceOfPageListObjectTwo;//country datasource
@property (nonatomic,strong) DataSourceModel *DatasourceOfPageListObjectThree;//world datasource



@end
