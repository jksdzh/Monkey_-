//
//  TrendingDataSource.m
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/9/2.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "TrendingDataSource.h"
#import "RepositoriesTableViewCell.h"
#import "RepositoryModel.h"
#import "UIImageView+WebCache.h"



@interface TrendingDataSource() 

@end
@implementation TrendingDataSource



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (tableView.tag) {
        case 11:
            return self.dailyDataSourceModel.dataSourceArray.count;
            break;
        case 12:
               return self.weeklyDataSourceModel.dataSourceArray.count;
            break;
        case 13:
              return self.monthlyDataSourceModel.dataSourceArray.count;
            break;

        default:
            break;
    }
    return self.dailyDataSourceModel.dataSourceArray.count;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RepositoriesTableViewCell * cell;
    switch (tableView.tag) {
        case 11:{
      static      NSString *reuseableIdentifier=@"reuseCellIdentifier";
              cell=[tableView dequeueReusableCellWithIdentifier:reuseableIdentifier];
            if(cell==nil){
                cell=[[RepositoriesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseableIdentifier];
                cell.selectionStyle =UITableViewCellSelectionStyleNone;
            }
            RepositoryModel *repositoryModel =[self.dailyDataSourceModel.dataSourceArray objectAtIndex:indexPath.row];
            cell.rankLabel.text =[NSString stringWithFormat:@"%ld",(indexPath.row +1)];
            cell.repositoryLabel.text = [NSString stringWithFormat:@"%@",repositoryModel.name];
            [cell.titleImageView sd_setImageWithURL:[NSURL URLWithString:repositoryModel.owner.avatar_url]];
            cell.descriptionLabel.text =[NSString stringWithFormat:@"%@",repositoryModel.Description];
            [cell.homePageButton setTitle:repositoryModel.homepage forState:UIControlStateNormal];
            cell.starLabel.text =[NSString stringWithFormat:@"Star:%ld",(long)repositoryModel.stargazers_count];
            cell.forkLabel.text =[NSString stringWithFormat:@"Fork:%ld",(long)repositoryModel.forks_count];

            return cell;
        }
            break;
        case 12:{
     static       NSString *reuseableIdentifier=@"reuseCellIdentifierOne";
            cell=[tableView dequeueReusableCellWithIdentifier:reuseableIdentifier];
            if(cell==nil){
                cell=[[RepositoriesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseableIdentifier];
                cell.selectionStyle =UITableViewCellSelectionStyleNone;
            }
            RepositoryModel *repositoryModel =[self.weeklyDataSourceModel.dataSourceArray objectAtIndex:indexPath.row];
            cell.rankLabel.text =[NSString stringWithFormat:@"%ld",(indexPath.row +1)];
            cell.repositoryLabel.text = [NSString stringWithFormat:@"%@",repositoryModel.name];
            [cell.titleImageView sd_setImageWithURL:[NSURL URLWithString:repositoryModel.owner.avatar_url]];
            cell.descriptionLabel.text =[NSString stringWithFormat:@"%@",repositoryModel.Description];
            [cell.homePageButton setTitle:repositoryModel.homepage forState:UIControlStateNormal];
            cell.starLabel.text =[NSString stringWithFormat:@"Star:%ld",(long)repositoryModel.stargazers_count];
            cell.forkLabel.text =[NSString stringWithFormat:@"Fork:%ld",(long)repositoryModel.forks_count];
            return cell;
        }
            break;
        case 13:{
     static       NSString *reuseableIdentifier=@"reuseCellIdentifierTwo";
            cell=[tableView dequeueReusableCellWithIdentifier:reuseableIdentifier];
            if(cell==nil){
                cell=[[RepositoriesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseableIdentifier];
                cell.selectionStyle =UITableViewCellSelectionStyleNone;
            }
            RepositoryModel *repositoryModel =[self.monthlyDataSourceModel.dataSourceArray objectAtIndex:indexPath.row];
            cell.rankLabel.text =[NSString stringWithFormat:@"%ld",(indexPath.row +1)];
            cell.repositoryLabel.text = [NSString stringWithFormat:@"%@",repositoryModel.name];
            [cell.titleImageView sd_setImageWithURL:[NSURL URLWithString:repositoryModel.owner.avatar_url]];
            cell.descriptionLabel.text =[NSString stringWithFormat:@"%@",repositoryModel.Description];
            [cell.homePageButton setTitle:repositoryModel.homepage forState:UIControlStateNormal];
            cell.starLabel.text =[NSString stringWithFormat:@"Star:%ld",(long)repositoryModel.stargazers_count];
            cell.forkLabel.text =[NSString stringWithFormat:@"Fork:%ld",(long)repositoryModel.forks_count];
            return cell;
        }
            break;

        default:
            break;
    }
    return cell;
}









@end
