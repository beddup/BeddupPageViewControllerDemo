//
//  TitleBarView.h
//  iosapp
//
//  Created by chenhaoxiang on 14-10-20.
//  Copyright (c) 2014年 oschina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleBarView : UIScrollView

@property(strong,nonatomic)UIColor* buttonTitleColor;
@property(strong,nonatomic)UIColor* selectedButtonTitleColor;

@property (nonatomic, copy) void (^titleButtonClicked)(NSUInteger index);

- (instancetype)initWithFrame:(CGRect)frame andTitles:(NSArray*)titles;

- (void)selectedButtonChanged:(NSUInteger)index animated:(BOOL)animated;

@end
