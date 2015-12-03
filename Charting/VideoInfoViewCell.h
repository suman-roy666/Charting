//
//  VideoInfoViewCell.h
//  Charting
//
//  Created by Suman Roy on 26/11/15.
//  Copyright (c) 2015 sourcebits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoInfoViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *videoUserNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *videoNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *videoDurationLabel;
@property (weak, nonatomic) IBOutlet UILabel *videoLikeCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videoCommentCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videoViewCountLabel;
@property (weak, nonatomic) IBOutlet UIView *userNameView;
@property (weak, nonatomic) IBOutlet UIImageView *videoThumbnail;



@end
