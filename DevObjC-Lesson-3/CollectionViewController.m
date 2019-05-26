//
//  CollectionViewController.m
//  DevObjC-Lesson-3
//
//  Created by Евгений Иванов on 23/05/2019.
//  Copyright © 2019 Евгений Иванов. All rights reserved.
//

#import "CollectionViewController.h"

@interface CollectionViewController () <UICollectionViewDataSource>

@property (strong, nonatomic) UICollectionView *collectionView;

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 20.0;
    layout.minimumInteritemSpacing = 10.0;
    layout.itemSize = CGSizeMake(150, 150);
    layout.sectionInset = UIEdgeInsetsMake(10, (self.view.bounds.size.width - layout.itemSize.width * 2) / 3, 10, (self.view.bounds.size.width - layout.itemSize.width * 2) / 3);
    NSLog(@"%f", (self.view.bounds.size.width - layout.itemSize.width * 2) / 3);
    
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    [self.collectionView setDataSource:self];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CollectionCell"];
    
    [self.view addSubview:self.collectionView];
    
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor purpleColor];
    return cell;
    
}

//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    
//}

@end
