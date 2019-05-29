//
//  CoreDataService.m
//  DevObjC-Lesson-3
//
//  Created by Евгений Иванов on 26/05/2019.
//  Copyright © 2019 Евгений Иванов. All rights reserved.
//

#import "CoreDataService.h"

@interface CoreDataService ()

@property (strong, nonatomic) NSPersistentContainer *persistentContainer;
@property (strong, nonatomic) NSManagedObjectContext *context;

@end

@implementation CoreDataService

+ (instancetype)sharedInstance {
    static CoreDataService *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[CoreDataService alloc] init];
        [instance setup];
    });
    
    return instance;
}

- (void)setup {
    self.persistentContainer = [[NSPersistentContainer alloc] initWithName:@"Model"];
    [self.persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription * persistance, NSError * error) {
        if (error != nil) {
            NSLog(@"Ошибка инициализации CoreData");
            abort();
        }
        self.context = self.persistentContainer.viewContext;
    }];
}

- (void)save {
    NSError *error;
    [self.context save:&error];
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }
}

- (void)addDogWithBreed:(NSString *)breed withSubbreed:(NSString *)subBreed withImages:(NSArray *)images {
    Dog *tempDog = [NSEntityDescription insertNewObjectForEntityForName:@"Dog" inManagedObjectContext:self.context];
    tempDog.breed = breed;
    tempDog.subBreed = subBreed;
    tempDog.images = images;
    [self save];
}

- (NSArray*)dogs {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Dog"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"breed" ascending:true]];
    return [self.context executeFetchRequest:request error:nil];
}

- (void)removeDog:(Dog *)dog {
    [self.context deleteObject:dog];
    [self save];
}

@end
