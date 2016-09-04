//
//  LanguageViewController.m
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/8/29.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "LanguageViewController.h"
@interface LanguageViewController()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableViewOne;
    NSArray *languages;
}

@end
@implementation LanguageViewController
#pragma mark - lifeCycle
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated ];
    self.tabBarController.tabBar.hidden =YES;
}


-(void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden =NO;
}
-(void)viewDidLoad{
    [super viewDidLoad ];

    self.title =NSLocalizedString(@"Language"
                                  , nil);
    if (iOS7GE) {
        self.edgesForExtendedLayout = UIRectEdgeBottom |UIRectEdgeLeft |UIRectEdgeRight;

    }
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor  whiteColor];

    tableViewOne =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    [self.view addSubview:tableViewOne];
    tableViewOne.dataSource =self;
    tableViewOne.delegate =self;

    switch (self.languageEntranceType) {
        case RepositoryLanguageEntranceType:{
            languages =@[@"JavaScript",@"Java",@"PHP",@"Ruby",@"Python",@"CSS",@"CPP",@"C",@"Objective-C",@"Swift",@"Shell",@"R",@"Perl",@"Lua",@"HTML",@"Scala",@"Go"
                         ];
        }
            break;
        case UserLanguageEntranceType:{
            languages =@[NSLocalizedString(@"all languages"
                                           , @""
                                           ),@"JavaScript",@"Java",@"PHP",@"Ruby",@"Python",@"CSS",@"CPP",@"C",@"Objective-C",@"Swift",@"Shell",@"R",@"Perl",@"Lua",@"HTML",@"Scala",@"Go"];
        }
            break;
        case TrendingLanguageEntranceType:{
            languages =@[NSLocalizedString(@"all languages", @""),@"javascript",@"java",@"php",@"ruby",@"python",@"css",@"cpp",@"c",@"objective-c",@"swift",@"shell",@"r",@"perl",@"lua",@"html",@"scala",@"go"];
        }
            break;
        default:
            break;

    }


}


-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning ];

}


#pragma mark - UITableViewDataSource & UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return languages.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell;
    NSString *reuseableIdentifier=@"CellIdentifierOne";
     cell=[tableView dequeueReusableCellWithIdentifier:reuseableIdentifier];
    if(cell==nil){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseableIdentifier];
    }
    NSString *languageName = (languages)[indexPath.row];
    if ([languageName isEqualToString:@"cpp"]
) {
        languageName =@"c++";
    }else if ([languageName isEqualToString:@"CPP"
              ]){
        languageName =@"C++";
    }
    cell.textLabel.text = languageName;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (self.languageEntranceType) {
        case RepositoryLanguageEntranceType:{
            [[NSUserDefaults standardUserDefaults] setObject:@"2"
                                                      forKey:@"languageAppear1"

              ];
            [[NSUserDefaults standardUserDefaults] setObject:languages[indexPath.row] forKey:@"language1"

             ];
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case UserLanguageEntranceType:{
            [[NSUserDefaults standardUserDefaults] setObject:@"2"
                                                      forKey:@"languageAppear"

             ];
            [[NSUserDefaults standardUserDefaults] setObject:languages[indexPath.row] forKey:@"language"

             ];
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case TrendingLanguageEntranceType:{
            [[NSUserDefaults standardUserDefaults] setObject:@"2"forKey:@"trendingLanguageAppear"

             ];
            [[NSUserDefaults standardUserDefaults] setObject:languages[indexPath.row] forKey:@"language2"

             ];
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;

        default:
            break;
    }
}

















@end
