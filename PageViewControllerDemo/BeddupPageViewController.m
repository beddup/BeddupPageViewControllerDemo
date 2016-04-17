//
//  BeddupPageViewController.m
//  PageViewControllerDemo
//
//  Created by Amay on 10/29/15.
//  Copyright © 2015 Beddup. All rights reserved.
//

#import "BeddupPageViewController.h"
#import "TitleBarView.h"

@interface BeddupPageViewController ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate>

@property(weak,nonatomic)TitleBarView* titleBar;

@property(strong,nonatomic)UIPageViewController* pageViewController;

@property(strong,nonatomic)NSArray* titles;
@property(strong, nonatomic)NSArray* controllers;

@property(nonatomic)NSUInteger indexToBeVisible;
@property(nonatomic)NSUInteger currentIndex;


@end

@implementation BeddupPageViewController


-(instancetype)initWithSubTitles:(NSArray*)titles controllers:(NSArray*)viewControllers{
    self = [super init];
    if (self) {

        self.edgesForExtendedLayout = UIRectEdgeNone;
        _controllers = viewControllers;
        _titles = titles;

        // configure titleBar
        TitleBarView* titleBar = [[TitleBarView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 36) andTitles:self.titles];
        [self.view addSubview:titleBar];
        _titleBar = titleBar;
        __weak BeddupPageViewController* weakSelf = self;
        titleBar.titleButtonClicked = ^(NSUInteger index){
            if (index == weakSelf.currentIndex || index >= self.controllers.count) {
                return ;
            }
            [self.pageViewController setViewControllers:@[self.controllers[index]] direction:index > self.currentIndex ? UIPageViewControllerNavigationDirectionForward : UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];

            weakSelf.currentIndex = index;
        };

        // configure UIPageViewController
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        _pageViewController.delegate  = self;
        _pageViewController.dataSource = self;
        _pageViewController.view.backgroundColor = [UIColor whiteColor];
        [_pageViewController setViewControllers:@[viewControllers[0]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
        [self addChildViewController:_pageViewController];
        
        [self.view addSubview:_pageViewController.view];

    }
    return self;
}

- (void)viewDidLoad {

    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidLayoutSubviews{

    self.pageViewController.view.frame = CGRectMake(0, 36, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 36);

}

-(UIViewController*) currentViewController{
    if (self.currentIndex <= self.controllers.count) {
        return self.controllers[self.currentIndex];
    }
    return nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIPageViewControllerDatasource and delegate
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSInteger index = [self.controllers indexOfObject:viewController];
    if (index == 0) {
        return nil;
    }else{
        return self.controllers[index - 1];
    }


}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSInteger index = [self.controllers indexOfObject:viewController];
    if (index == self.controllers.count - 1) {
        return nil;
    }else{
        return self.controllers[index + 1];
    }

}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers NS_AVAILABLE_IOS(6_0){

    NSInteger index = [self.controllers indexOfObject:pendingViewControllers[0]];
    self.indexToBeVisible = index;

}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{

    if (self.currentIndex == self.indexToBeVisible) {
        return;
    }
    
    if (completed && finished) {

        self.currentIndex = self.indexToBeVisible;

        [self.titleBar selectedButtonChanged:self.currentIndex animated:YES];

    }
    
}

@end
