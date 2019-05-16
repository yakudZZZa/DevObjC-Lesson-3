//
//  NetworkService.h
//  DevObjC-Lesson-3
//
//  Created by Евгений Иванов on 15/05/2019.
//  Copyright © 2019 Евгений Иванов. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetworkService : NSObject

+ (instancetype)sharedInstance;
- (void)getListAllBreeds:(void(^)(NSDictionary *resultBreeds))completion;
- (void)getPicturesByBreed:(NSString*)breed subBreed:(NSString*)subBreed numberOfPictures:(int)numberOfPictures withCompletion:(void(^)(NSArray *resultPictures))completion;

@end

NS_ASSUME_NONNULL_END
