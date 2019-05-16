//
//  ViewController.h
//  DevObjC-Lesson-3
//
//  Created by Евгений Иванов on 14/05/2019.
//  Copyright © 2019 Евгений Иванов. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) UITextField *breedTextField;
@property (nonatomic, strong) UITextField *subBreedTextField;
@property (nonatomic, strong) NSDictionary *breeds;
@property (nonatomic, strong) NSArray *breedsOnly;
@property (nonatomic, strong) NSMutableArray *subBreedsOnly;
@property (nonatomic, strong) UIPickerView *breedPicker;
@property (nonatomic, strong) UIPickerView *subBreedPicker;
@property (nonatomic, strong) UIButton *showDogs;
@property (nonatomic, strong) NSArray *picturesList;

@end

