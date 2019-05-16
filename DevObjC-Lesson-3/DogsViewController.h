//
//  DogsViewController.h
//  DevObjC-Lesson-3
//
//  Created by Евгений Иванов on 16/05/2019.
//  Copyright © 2019 Евгений Иванов. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DogsViewController : UIViewController

@property (nonatomic, strong) NSArray *pictureList;
- (instancetype)initWithRateModel:(NSArray*)pictureList;

@end

NS_ASSUME_NONNULL_END
