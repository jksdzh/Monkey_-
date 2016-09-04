//
//  ShowcasesModel.h
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/8/25.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShowcasesModel : NSObject
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *slug;
@property (nonatomic,strong) NSString  *showcasesDescription;
@property (nonatomic,strong) NSString *image_url;
+ (ShowcasesModel *)modelWithDict:(NSDictionary *)dict;
@end
