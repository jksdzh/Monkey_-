//
//  SearchDataSource.h
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/9/7.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchDataSource : NSObject<UITableViewDataSource>
@property (nonatomic,strong) DataSourceModel *userDataSourceModel;
@property (nonatomic,strong) DataSourceModel *repositoryDataSourceModel;

@end
