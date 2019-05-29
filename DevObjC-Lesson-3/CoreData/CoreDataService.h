//
//  CoreDataService.h
//  DevObjC-Lesson-3
//
//  Created by Евгений Иванов on 26/05/2019.
//  Copyright © 2019 Евгений Иванов. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Dog+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface CoreDataService : NSObject

+(instancetype)sharedInstance;
- (void)addDogWithBreed:(NSString *)breed withSubbreed:(NSString *)subBreed withImages:(NSArray *)images;
- (NSArray*)dogs;
- (void)removeDog:(Dog *)dog;

@end

NS_ASSUME_NONNULL_END
