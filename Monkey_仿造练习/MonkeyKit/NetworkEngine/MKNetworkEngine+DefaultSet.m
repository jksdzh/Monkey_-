//
//  MKNetworkEngine+DefaultSet.m
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/8/26.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "MKNetworkEngine+DefaultSet.h"

@implementation MKNetworkEngine (DefaultSet)
-(id)initWithDefaultSet{
    NSMutableDictionary *header = [NSMutableDictionary dictionaryWithObject:@"application/vnd.github.v3+json"forKey:@"Accept"];
    self = [self initWithHostName:@"api.github.com"customHeaderFields:header];
    return self;
}


@end
