//
//  DataSourceModel.m
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/8/25.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "DataSourceModel.h"

@implementation DataSourceModel
- (id)init
{
    self = [super init];
    if (self) {
        self.dataSourceArray = [[NSMutableArray alloc] initWithCapacity:32];
        self.page =0;

    }
    return self;
}
-(void)reset{
    self.page = 0;
    [self.dataSourceArray removeAllObjects];

}


@end
