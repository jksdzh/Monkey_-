//
//  UserModel.h
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/8/25.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject
@property(nonatomic,assign) double myID;

@property(nonatomic,strong) NSString *categoryLocation;
@property(nonatomic,strong) NSString *categoryLanguage;
@property (nonatomic, copy) NSString *location;

@property (nonatomic, assign) BOOL hireable;

@property (nonatomic, assign) NSInteger public_gists;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *following_url;

@property (nonatomic, copy) NSString *events_url;

@property (nonatomic, copy) NSString *received_events_url;

@property (nonatomic, copy) NSString *company;

@property (nonatomic, copy) NSString *updated_at;

@property (nonatomic, copy) NSString *bio;

@property (nonatomic, copy) NSString *avatar_url;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *subscriptions_url;

@property (nonatomic, copy) NSString *gists_url;

@property (nonatomic, assign) NSInteger userId;

@property (nonatomic, copy) NSString *starred_url;

@property (nonatomic, copy) NSString *organizations_url;

@property (nonatomic, copy) NSString *repos_url;

@property (nonatomic, assign) BOOL site_admin;

@property (nonatomic, copy) NSString *email;

@property (nonatomic, copy) NSString *login;

@property (nonatomic, copy) NSString *blog;

@property (nonatomic, assign) NSInteger public_repos;

@property (nonatomic, assign) NSInteger followers;

@property (nonatomic, assign) NSInteger following;

@property (nonatomic, copy) NSString *created_at;

@property (nonatomic, copy) NSString *gravatar_id;

@property (nonatomic, copy) NSString *followers_url;

@property (nonatomic, copy) NSString *html_url;

@property(nonatomic,assign) int rank;

+(UserModel *)modelWithDict:(NSDictionary * )dict;


@end
