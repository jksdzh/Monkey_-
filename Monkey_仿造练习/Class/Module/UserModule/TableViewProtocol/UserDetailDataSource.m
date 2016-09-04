//
//  UserDetailDataSource.m
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/8/30.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "UserDetailDataSource.h"
#import "RankTableViewCell.h"
#import "RepositoriesTableViewCell.h"
#import "RepositoryModel.h"
#import "UIImageView+WebCache.h"

@implementation UserDetailDataSource



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (self.currentIndex) {
        case 1:
            return
            self.repositoryDataSourcePageListObject.dataSourceArray.count;
            break;
        case 2:
            return
            self.followingDataSourcePageListObject.dataSourceArray.count;
            break;
        case 3:
          return
            self.followerDataSourcePageListObject.dataSourceArray.count;
            break;

        default:
            break;
    }
    return 1;



}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.currentIndex ==1) {
         NSString *reuseableIdentifier=@"reuseCellIdentifier";
        RepositoriesTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:reuseableIdentifier];
        if(cell==nil){
            cell=[[RepositoriesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseableIdentifier];
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            cell.titleImageView.hidden =YES;
        }
        RepositoryModel * model = [self.repositoryDataSourcePageListObject.dataSourceArray objectAtIndex:indexPath.row];
        cell.rankLabel.text = [NSString stringWithFormat:@"%ld",(long)(indexPath.row +1)];
        cell.repositoryLabel.text = [NSString stringWithFormat:@"%@",model.name];
        if (model.fork) {
            cell.userLabel.text = [NSString stringWithFormat:@"fork  %@",model.language];
        } else{
            cell.userLabel.text =  [NSString stringWithFormat:@"owner %@",model.language];
        }
        cell.descriptionLabel.text =  [NSString stringWithFormat:@"%@",model.Description];
        [cell.homePageButton setTitle:model.homepage forState:UIControlStateNormal];
        cell.starLabel.text  = [NSString stringWithFormat:@"Star:%ld",(long)model.stargazers_count];
        cell.forkLabel.text = [NSString stringWithFormat:@"Fork:%ld",(long)model.forks_count];


        return cell;
    }else if (self.currentIndex ==2){
        NSString *reuseableIdentifier=@"reuseCellIdentifierOne";
        RankTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:reuseableIdentifier];
        if(cell==nil){
            cell=[[RankTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseableIdentifier];
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
        }
        UserModel * userModel = [self.followingDataSourcePageListObject.dataSourceArray objectAtIndex:indexPath.row];
        cell.rankLabel.text =[NSString stringWithFormat:@"%ld",(indexPath.row+1)];
        cell.mainLabel.text =[NSString stringWithFormat:@"%@",userModel.login];
        cell.detailLabel.text =[NSString stringWithFormat:@"id:%ld",(long)userModel.userId];
        [cell.titleImageView sd_setImageWithURL:[NSURL URLWithString:userModel.avatar_url]];
        return cell;

    }else if (self.currentIndex ==3){
        NSString *reuseableIdentifier=@"reuseCellIdentifierTwo";
        RankTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:reuseableIdentifier];
        if(cell==nil){
            cell=[[RankTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseableIdentifier];
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
        }
        UserModel * userModel = [self.followerDataSourcePageListObject.dataSourceArray objectAtIndex:indexPath.row];
        cell.rankLabel.text =[NSString stringWithFormat:@"%ld",(long)(indexPath.row+1)];
        cell.mainLabel.text =[NSString stringWithFormat:@"%@",userModel.login];
        cell.detailLabel.text =[NSString stringWithFormat:@"id:%ld",(long)userModel.userId];
        [cell.titleImageView sd_setImageWithURL:[NSURL URLWithString:userModel.avatar_url]];
        return cell;

    }
    return nil;
}












@end
