//
//  ViewController.m
//  DevObjC-Lesson-3
//
//  Created by Евгений Иванов on 14/05/2019.
//  Copyright © 2019 Евгений Иванов. All rights reserved.
//

#import "ViewController.h"
#import "NetworkService.h"
#import "DogsViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIBarButtonItem* doneButton;
@property (nonatomic, strong) UIBarButtonItem* cancelButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Найди пёселя 🐶";
    
    self.dogPic = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width / 2 - 165 / 2, 74, 165, 170)];
    [self.dogPic setContentMode:UIViewContentModeScaleAspectFill];
    self.dogPic.image = [UIImage imageNamed:@"dog"];
    [self.view addSubview:self.dogPic];
    
    self.breedTextField = [[UITextField alloc]
                           initWithFrame:CGRectMake(10,
                                                    self.dogPic.bounds.size.height + 64 + 20,
                                                    self.view.bounds.size.width / 2 - 15,
                                                    30)];
    [self.breedTextField setPlaceholder:@"Выбери пёселя"];
    [self.breedTextField setTextAlignment:NSTextAlignmentCenter];
    self.breedTextField.layer.borderWidth = 1;
    self.breedTextField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [self.view addSubview:self.breedTextField];
    
    self.subBreedTextField = [[UITextField alloc]
                              initWithFrame:CGRectMake(self.view.bounds.size.width /2 + 5,
                                                       self.dogPic.bounds.size.height + 64 + 20,
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
    
    UIToolbar* toolbarBreed = [[UIToolbar alloc] init];
    toolbarBreed.barStyle = UIBarStyleDefault;
    [toolbarBreed sizeToFit];
    UIToolbar* toolbarSubBreed = [[UIToolbar alloc] init];
    toolbarSubBreed.barStyle = UIBarStyleDefault;
    [toolbarSubBreed sizeToFit];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem* doneButtonBreed = [[UIBarButtonItem alloc] initWithTitle:@"Готово" style:UIBarButtonItemStyleDone target:self action:@selector(doneClickedBreed:)];
    UIBarButtonItem* cancelButtonBreed = [[UIBarButtonItem alloc] initWithTitle:@"Отмена" style:UIBarButtonItemStylePlain target:self action:@selector(cancelClickedBreed:)];
    UIBarButtonItem* doneButtonSubBreed = [[UIBarButtonItem alloc] initWithTitle:@"Готово" style:UIBarButtonItemStyleDone target:self action:@selector(doneClickedSubBreed:)];
    UIBarButtonItem* cancelButtonSubBreed = [[UIBarButtonItem alloc] initWithTitle:@"Отмена" style:UIBarButtonItemStylePlain target:self action:@selector(cancelClickedSubBreed:)];
    [toolbarBreed setItems:[NSArray arrayWithObjects:cancelButtonBreed, flexibleSpace, doneButtonBreed, nil]];
    [toolbarSubBreed setItems:[NSArray arrayWithObjects:cancelButtonSubBreed, flexibleSpace, doneButtonSubBreed, nil]];
    
    self.breedTextField.inputView = self.breedPicker;
    self.breedTextField.inputAccessoryView = toolbarBreed;
    self.subBreedTextField.inputView = self.subBreedPicker;
    self.subBreedTextField.inputAccessoryView = toolbarSubBreed;
    
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

-(void)doneClickedBreed:(id)sender {
    [self.breedTextField resignFirstResponder];
}

-(void)doneClickedSubBreed:(id)sender {
    [self.subBreedTextField resignFirstResponder];
}

-(void)cancelClickedBreed:(id)sender {
    [self.breedTextField resignFirstResponder];
    self.breedTextField.text = @"";
}

-(void)cancelClickedSubBreed:(id)sender {
    [self.subBreedTextField resignFirstResponder];
    self.subBreedTextField.text = @"";
}

- (void)pressSearchButton {
    if ([self.breedTextField.text isEqual:@""]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Так не найти пёселя" message:@"Нужно выбрать пёселя, чтобы найти его" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {}];
        [alertController addAction:action];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
    [[NetworkService sharedInstance] getPicturesByBreed:self.breedTextField.text subBreed:self.subBreedTextField.text numberOfPictures:3 withCompletion:^(NSArray * _Nonnull resultBreeds) {
        dispatch_async(dispatch_get_main_queue(), ^{
            DogsViewController *vc = [[DogsViewController alloc] initWithRateModel:resultBreeds];
            [self.navigationController pushViewController:vc animated:true];
        });
    }];
}

- (void)viewWillLayoutSubviews {
    NSLog(@"bounds.origin.y = %f, bounds.size.height = %f, frame.origin.y = %f, frame.size.height = %f", self.navigationController.navigationBar.bounds.origin.y, self.navigationController.navigationBar.bounds.size.height, self.navigationController.navigationBar.frame.origin.y, self.navigationController.navigationBar.frame.size.height);
    self.dogPic.frame = CGRectMake(self.view.bounds.size.width / 2 - 165 / 2, self.navigationController.navigationBar.frame.origin.y + self.navigationController.navigationBar.frame.size.height, 165, 170);
    
    self.breedTextField.frame = CGRectMake(10, self.dogPic.frame.size.height + self.dogPic.frame.origin.y + 20, self.view.bounds.size.width / 2 - 15, 30);
    
    self.subBreedTextField.frame = CGRectMake(self.view.bounds.size.width /2 + 5, self.dogPic.frame.size.height + self.dogPic.frame.origin.y + 20, self.view.bounds.size.width / 2 - 15, 30);
}

@end
