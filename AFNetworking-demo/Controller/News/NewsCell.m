//
//  NewsCell.m
//  AFNetworking-demo
//
//  Created by Jakey on 14-7-22.
//  Copyright (c) 2014年 Jakey. All rights reserved.
//

#import "NewsCell.h"
#import "UIImageView+AFNetworking.h"
#import "News.h"
@implementation NewsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)configCell:(News*)item{
    self.newsTitle.text = item.title;
    self.newsDetail.text = item.descr;
    [self.newsImage setImageWithURL:[NSURL URLWithString:item.imgurl]];
}
-(void)prepareForReuse{
    self.newsImage.image =nil;
}
@end
