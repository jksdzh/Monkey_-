//
//  RepositoryModel.h
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/8/25.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
@class Owner,Parent;

@interface RepositoryModel: NSObject
//
//@property (nonatomic, copy) NSString *keys_url;
//
//@property (nonatomic, copy) NSString *statuses_url;
//
//@property (nonatomic, copy) NSString *issues_url;
//
//@property (nonatomic, copy) NSString *pushed_at;
//
//@property (nonatomic, copy) NSString *issue_events_url;
//@property (nonatomic,strong) UserModel *userModel;
@property (nonatomic, assign) NSInteger UserId;

@property (nonatomic, strong) Owner *owner;
@property (nonatomic,strong)  Parent *parent;
//
//@property (nonatomic, copy) NSString *events_url;
//
//@property (nonatomic, copy) NSString *subscription_url;
//
//@property (nonatomic, copy) NSString *git_commits_url;
//
//@property (nonatomic, copy) NSString *clone_url;
//
//@property (nonatomic, copy) NSString *subscribers_url;
//
//@property (nonatomic, assign) BOOL has_wiki;
//
//@property (nonatomic, copy) NSString *url;
//
//@property (nonatomic, copy) NSString *pulls_url;

@property (nonatomic, assign) BOOL fork;

//@property (nonatomic, copy) NSString *notifications_url;

@property (nonatomic, copy) NSString *Description;

//@property (nonatomic, copy) NSString *collaborators_url;
//
//@property (nonatomic, copy) NSString *deployments_url;
//
//@property (nonatomic, copy) NSString *languages_url;
//
//@property (nonatomic, assign) BOOL has_issues;
//
//@property (nonatomic, copy) NSString *comments_url;
//
//@property (nonatomic, assign) BOOL private;
//
//@property (nonatomic, assign) NSInteger size;
//
//@property (nonatomic, copy) NSString *git_tags_url;
//
//@property (nonatomic, copy) NSString *updated_at;
//
//@property (nonatomic, copy) NSString *ssh_url;

@property (nonatomic, strong) NSString *name;
//
//@property (nonatomic, copy) NSString *archive_url;
//
//@property (nonatomic, copy) NSString *contents_url;
//
//@property (nonatomic, copy) NSString *milestones_url;
//
//@property (nonatomic, copy) NSString *blobs_url;
//
//@property (nonatomic, copy) NSString *contributors_url;
//
//@property (nonatomic, assign) NSInteger open_issues_count;
//
//@property (nonatomic, strong) Permissions *permissions;

@property (nonatomic, assign) NSInteger forks_count;

//@property (nonatomic, copy) NSString *svn_url;

@property (nonatomic, copy) NSString *mirror_url;

//@property (nonatomic, copy) NSString *commits_url;
//
//@property (nonatomic, copy) NSString *trees_url;
//
//@property (nonatomic, copy) NSString *forks_url;
//
//@property (nonatomic, assign) BOOL has_downloads;

@property (nonatomic, copy) NSString *created_at;

@property (nonatomic, copy) NSString *homepage;

//@property (nonatomic, copy) NSString *teams_url;
//
//@property (nonatomic, copy) NSString *branches_url;
//
//@property (nonatomic, copy) NSString *issue_comment_url;
//
//@property (nonatomic, copy) NSString *merges_url;
//
//@property (nonatomic, copy) NSString *git_refs_url;
//
//@property (nonatomic, copy) NSString *git_url;
//
//@property (nonatomic, copy) NSString *hooks_url;

@property (nonatomic, copy) NSString *html_url;

//@property (nonatomic, copy) NSString *releases_url;
//
//@property (nonatomic, copy) NSString *assignees_url;
//
//@property (nonatomic, copy) NSString *compare_url;

@property (nonatomic, copy) NSString *full_name;

//@property (nonatomic, copy) NSString *stargazers_url;
//
//@property (nonatomic, copy) NSString *tags_url;
//
@property (nonatomic, copy) NSString *language;

//@property (nonatomic, copy) NSString *labels_url;
//
//@property (nonatomic, copy) NSString *downloads_url;

@property (nonatomic, assign) NSInteger stargazers_count;

//@property (nonatomic, assign) NSInteger watchers_count;
//
//@property (nonatomic, copy) NSString *default_branch;
//
//@property (nonatomic, assign) BOOL has_pages;
//

@property (nonatomic,strong) UserModel *userModel;


+(RepositoryModel *)modelWithDict:(NSDictionary *)dict;
@end
//
@interface Owner : NSObject
//
//@property (nonatomic, assign) NSInteger id;
//
//@property (nonatomic, copy) NSString *organizations_url;
//
//@property (nonatomic, copy) NSString *received_events_url;
//
//@property (nonatomic, copy) NSString *following_url;

@property (nonatomic, strong) NSString *login;

@property (nonatomic, copy) NSString *avatar_url;
//
//@property (nonatomic, copy) NSString *url;
//
//@property (nonatomic, copy) NSString *subscriptions_url;
//
//@property (nonatomic, copy) NSString *type;
//
//@property (nonatomic, copy) NSString *repos_url;
//
@property (nonatomic, copy) NSString *html_url;
//
//@property (nonatomic, copy) NSString *events_url;
//
//@property (nonatomic, assign) BOOL site_admin;
//
//@property (nonatomic, copy) NSString *starred_url;
//
//@property (nonatomic, copy) NSString *gists_url;
//
//@property (nonatomic, copy) NSString *gravatar_id;
//
//@property (nonatomic, copy) NSString *followers_url;
//
@end
//
//@interface Permissions : NSObject
//
//@property (nonatomic, assign) BOOL admin;
//
//@property (nonatomic, assign) BOOL push;
//
//@property (nonatomic, assign) BOOL pull;


//detail
@interface Parent : NSObject
//@property (nonatomic,strong) <#Class#> *<#object#>;

@end

