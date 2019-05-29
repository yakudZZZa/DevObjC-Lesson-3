//
//  Dog+CoreDataProperties.h
//  DevObjC-Lesson-3
//
//  Created by Евгений Иванов on 29/05/2019.
//  Copyright © 2019 Евгений Иванов. All rights reserved.
//
//

#import "Dog+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Dog (CoreDataProperties)

+ (NSFetchRequest<Dog *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *breed;
@property (nullable, nonatomic, copy) NSString *subBreed;

@end

NS_ASSUME_NONNULL_END
