//
//  PopularChannelViewController.m
//  Charting
//
//  Created by Suman Roy on 01/12/15.
//  Copyright (c) 2015 sourcebits. All rights reserved.
//

#import "PopularChannelViewController.h"
#import "Video.h"
#import "VideoInfoViewCell.h"

@implementation PopularChannelViewController

static NSString *videoInfoViewCellIdentifier = @"VideoInfoViewCell";

-(void)viewDidLoad{
    
    
    [ self.tableView registerNib:[ UINib nibWithNibName:videoInfoViewCellIdentifier
                                                      bundle:nil]
               forCellReuseIdentifier:videoInfoViewCellIdentifier ];
    
    

}

- (void)viewDidAppear:(BOOL)animated{
    
    
    [ self.tableView setFrame: CGRectMake(self.tableView.frame.origin.x,
                                          self.tableView.frame.origin.y,
                                          self.tableView.frame.size.width,
                                          (self.tableView.frame.size.height - self.bottomMargin*2))];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [ self.videoList count ];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    VideoInfoViewCell *cell = [ self.tableView dequeueReusableCellWithIdentifier:videoInfoViewCellIdentifier ];
    
    Video *cellVideo = self.videoList[ indexPath.row ];
    
    cell.videoNameLabel.text = cellVideo.videoName;
    cell.videoUserNameLabel.text = cellVideo.userName;
    cell.videoLikeCountLabel.text = [ NSString stringWithFormat:@"%@", cellVideo.likeCount ];
    cell.videoCommentCountLabel.text = [ NSString stringWithFormat:@"%@", cellVideo.commentCount ];
    cell.videoViewCountLabel.text = [ NSString stringWithFormat:@"%@", cellVideo.viewCount ];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    VideoInfoViewCell *cell = [ self.tableView dequeueReusableCellWithIdentifier:videoInfoViewCellIdentifier ];
    
    return cell.frame.size.height;
    
}

@end
