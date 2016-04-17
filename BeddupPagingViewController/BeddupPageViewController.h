//
//  BeddupPageViewController.h
//  PageViewControllerDemo
//
//  Created by Amay on 10/29/15.
//  Copyright © 2015 Beddup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BeddupPageViewController : UIViewController

-(instancetype)initWithSubTitles:(NSArray*)titles controllers:(NSArray*)viewControllers;

-(UIViewController*) currentViewController;

@end
