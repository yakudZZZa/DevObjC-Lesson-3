//
//  ViewController.m
//  DevObjC-Lesson-3
//
//  Created by Евгений Иванов on 14/05/2019.
//  Copyright © 2019 Евгений Иванов. All rights reserved.
//

#import "ViewController.h"
#import "NetworkService.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.breedTextField = [[UITextField alloc] initWithFrame:CGRectMake(10,
                                                                       100,
                                                                       self.view.bounds.size.width / 2 - 15,
                                                                       30)];
    [self.breedTextField setPlaceholder:@"Выбери пёселя"];
    [self.breedTextField setTextAlignment:NSTextAlignmentCenter];
    self.breedTextField.layer.borderWidth = 1;
    self.breedTextField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [self.view addSubview:self.breedTextField];
    
    self.subBreedTextField = [[UITextField alloc] initWithFrame:CGRectMake(self.view.bounds.size.width /2 + 5,
                                                                           100,
                                                                           self.view.bounds.size.width / 2 - 15,
                                                                           30)];
    self.subBreedTextField.layer.borderWidth = 1;
    self.subBreedTextField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [self.subBreedTextField setPlaceholder:@"Подвид пёселя"];
    [self.subBreedTextField setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:self.subBreedTextField];
    
    self.showDogs = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width / 2 - 170 / 2,
                                                          self.view.bounds.size.height / 2 - 30 / 2,
                                                          170,
                                                          30)];
    [self.showDogs setTitle:@"Найти пёселей" forState:UIControlStateNormal];
    self.showDogs.layer.cornerRadius = self.showDogs.frame.size.height / 2;
    [self.showDogs setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.showDogs.layer.borderWidth = 1;
    [self.showDogs addTarget:self action:@selector(pressSearchButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.showDogs];
    
    self.breedsOnly = [[NSMutableArray alloc] init];
    self.subBreedsOnly = [[NSMutableArray alloc] init];
    
    self.breedPicker = [[UIPickerView alloc] init];
    self.breedPicker.showsSelectionIndicator = YES;
    self.breedPicker.delegate = self;
    self.breedPicker.dataSource = self;
    
    self.subBreedPicker = [[UIPickerView alloc] init];
    self.subBreedPicker.showsSelectionIndicator = YES;
    self.subBreedPicker.delegate = self;
    self.subBreedPicker.dataSource = self;
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UIToolbar* toolbar = [[UIToolbar alloc] init];
    toolbar.barStyle = UIBarStyleDefault;
    [toolbar sizeToFit];
    
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Готово" style:UIBarButtonItemStyleDone target:self action:@selector(doneClicked:)];
    UIBarButtonItem* cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Отмена" style:UIBarButtonItemStylePlain target:self action:@selector(cancelClicked:)];
    [toolbar setItems:[NSArray arrayWithObjects:cancelButton, flexibleSpace, doneButton, nil]];
    
    self.breedTextField.inputView = self.breedPicker;
    self.breedTextField.inputAccessoryView = toolbar;
    self.subBreedTextField.inputView = self.subBreedPicker;
    self.subBreedTextField.inputAccessoryView = toolbar;
    
    [[NetworkService sharedInstance] getListAllBreeds:^(NSDictionary * _Nonnull breeds) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.breeds = breeds;
            self.breedsOnly = [[breeds allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        });
    }];
    
}


- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView == self.breedPicker) {
        return [self.breedsOnly count];
    } else {
        return [self.subBreedsOnly count];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (pickerView == self.breedPicker) {
        [self.breedTextField setText:self.breedsOnly[row]];
        self.subBreedsOnly = [self.breeds objectForKey:self.breedTextField.text];
        if (self.subBreedsOnly.count == 0) {
            self.subBreedTextField.text = nil;
        } else {
            [self.subBreedTextField setText:self.subBreedsOnly[0]];
        }
    } else if (self.subBreedsOnly.count != 0) {
        [self.subBreedTextField setText:self.subBreedsOnly[row]];
    } else {
        
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (pickerView == self.breedPicker) {
        return self.breedsOnly[row];
    } else if (self.subBreedsOnly.count != 0) {
        return self.subBreedsOnly[row];
    } else {
        return @"-";
    }
    
}

-(void)doneClicked:(id)sender {
    NSLog(@"%@", sender);
}

-(void)cancelClicked:(id)sender {
    NSLog(@"%@", sender);
}

- (void)pressSearchButton {
    [[NetworkService sharedInstance] getPicturesByBreed:self.breedTextField.text subBreed:self.subBreedTextField.text numberOfPictures:3 withCompletion:^(NSArray * _Nonnull resultBreeds) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.picturesList = resultBreeds;
        });
    }];
}

@end
