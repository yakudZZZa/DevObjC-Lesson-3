//
//  MyTableViewCell.m
//  DevObjC-Lesson-3
//
//  Created by Евгений Иванов on 16/05/2019.
//  Copyright © 2019 Евгений Иванов. All rights reserved.
//

#import "MyTableViewCell.h"

@interface MyTableViewCell ()

@property (nonatomic, strong) UIImageView *image;

@end

@implementation MyTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.image = [[UIImageView alloc] initWithFrame:self.bounds];
        [self.image setContentMode:UIViewContentModeScaleAspectFit];
        [self.contentView addSubview:self.image];
        
    }
    
    return self;
}

- (void)layoutSubviews{
    self.image.frame = CGRectMake(10, 10, self.bounds.size.width - 20, 260);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void) configWithImages:(NSString*)imageURL {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *url = [NSURL URLWithString:imageURL];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage* image = [[UIImage alloc]initWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.image setImage:image];
        });
    });
}

@end
