//
//  NetworkService.m
//  DevObjC-Lesson-3
//
//  Created by Евгений Иванов on 15/05/2019.
//  Copyright © 2019 Евгений Иванов. All rights reserved.
//

#import "NetworkService.h"

#define API_BREEDS_LIST_URL @"https://dog.ceo/api/breeds/list/all"
#define API_URL @"https://dog.ceo/api/breed/"

@interface NetworkService ()

@property (nonatomic, strong) NSString *tale;
@property (nonatomic, strong) NSString *numberOfPictures;

@end

@implementation NetworkService

+ (instancetype)sharedInstance {
    static NetworkService *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[NetworkService alloc] init];
    });
    return instance;
}

- (void)getListAllBreeds:(void(^)(NSDictionary *resultBreeds))completion {
    //
    [self load:API_BREEDS_LIST_URL withCompletion:^(id  _Nullable result) {
        NSDictionary *json = result;
        NSDictionary *resultBreeds = json[@"message"];
        
        completion(resultBreeds);
    }];
}

- (void)getPicturesByBreed:(NSString*)breed subBreed:(NSString*)subBreed numberOfPictures:(int)numberOfPictures withCompletion:(void(^)(NSArray *resultPictures))completion {
    NSString *resultURL = [[NSString alloc] init];
    if (![subBreed isEqual: @""]) {
        resultURL = [NSString stringWithFormat:@"%@%@/%@/%@%d", API_URL, breed, subBreed, @"images/random/", numberOfPictures];
    } else {
        resultURL = [NSString stringWithFormat:@"%@%@/%@%d", API_URL, breed, @"images/random/", numberOfPictures];
    }
    [self load:resultURL withCompletion:^(id  _Nullable result) {
        NSDictionary *json = result;
        NSArray *resultPictures = json[@"message"];
        
        completion(resultPictures);
    }];
}

- (void)load:(NSString*)url withCompletion:(void(^)(id _Nullable result))completion {
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        completion(result);
        
    }];
    [task resume];
}

@end
