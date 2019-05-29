//
//  Dog+CoreDataProperties.m
//  DevObjC-Lesson-3
//
//  Created by Евгений Иванов on 29/05/2019.
//  Copyright © 2019 Евгений Иванов. All rights reserved.
//
//

#import "Dog+CoreDataProperties.h"

@implementation Dog (CoreDataProperties)

+ (NSFetchRequest<Dog *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Dog"];
}

@dynamic breed;
@dynamic subBreed;

@end
