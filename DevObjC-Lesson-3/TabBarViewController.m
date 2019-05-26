//
//  TabBarViewController.m
//  DevObjC-Lesson-3
//
//  Created by Евгений Иванов on 23/05/2019.
//  Copyright © 2019 Евгений Иванов. All rights reserved.
//

#import "TabBarViewController.h"
#import "ViewController.h"
#import "CollectionViewController.h"

@interface TabBarViewController ()

@property (strong, nonatomic) ViewController *firstVC;
@property (strong, nonatomic) CollectionViewController *secondVC;

@end

@implementation TabBarViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.firstVC = [ViewController new];
        UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:self.firstVC];
        firstNav.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemSearch tag:0];
        
        self.secondVC = [CollectionViewController new];
        self.secondVC.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMore tag:1];
        
        self.viewControllers = @[firstNav, self.secondVC];
        self.selectedIndex = 0;
        
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}

@end
