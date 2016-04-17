//
//  TitleBarView.m
//  iosapp
//
//  Created by chenhaoxiang on 14-10-20.
//  Copyright (c) 2014年 oschina. All rights reserved.
//

#import "TitleBarView.h"

@interface TitleBarView ()

@property (nonatomic, strong) NSMutableArray *titleButtons;
@property (nonatomic, assign) NSUInteger currentIndex;


@end

@implementation TitleBarView

- (instancetype)initWithFrame:(CGRect)frame andTitles:(NSArray *)titles
{
    self = [super initWithFrame:frame];
    
    if (self) {
        _currentIndex = 0;
        _titleButtons = [NSMutableArray new];
        
        CGFloat buttonWidth = frame.size.width / titles.count;
        CGFloat buttonHeight = frame.size.height;

        _buttonTitleColor = [UIColor darkGrayColor];
        _selectedButtonTitleColor = [UIColor orangeColor];

        [titles enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL *stop) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.backgroundColor = [UIColor lightGrayColor];
            button.titleLabel.font = [UIFont systemFontOfSize:15];
            [button setTitleColor:self.buttonTitleColor forState:UIControlStateNormal];
            [button setTitle:title forState:UIControlStateNormal];
            
            button.frame = CGRectMake(buttonWidth * idx, 0, buttonWidth, buttonHeight);
            button.tag = idx;
            [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [_titleButtons addObject:button];
            [self addSubview:button];
            [self sendSubviewToBack:button];
        }];
        
        self.contentSize = CGSizeMake(frame.size.width, 25);
        self.showsHorizontalScrollIndicator = NO;
        UIButton *firstTitle = _titleButtons[0];
        [firstTitle setTitleColor:self.selectedButtonTitleColor forState:UIControlStateNormal];
        firstTitle.transform = CGAffineTransformMakeScale(1.15, 1.15);
    }
    
    return self;
}


- (void)onClick:(UIButton *)button
{
    if (_currentIndex != button.tag) {
        UIButton *preTitle = _titleButtons[_currentIndex];
        
        [preTitle setTitleColor:self.buttonTitleColor forState:UIControlStateNormal];
        preTitle.transform = CGAffineTransformIdentity;
        
        [button setTitleColor:self.selectedButtonTitleColor forState:UIControlStateNormal];
        button.transform = CGAffineTransformMakeScale(1.2, 1.2);
        
        _currentIndex = button.tag;
        _titleButtonClicked(button.tag);
    }
}

-(void)setButtonTitleColor:(UIColor *)buttonTitleColor{
    _buttonTitleColor = buttonTitleColor;
    for (UIButton* button in self.titleButtons) {
        if (self.currentIndex != button.tag) {
            [button setTitleColor:self.buttonTitleColor forState:UIControlStateNormal];
        }
    }
}
-(void)setSelectedButtonTitleColor:(UIColor *)selectedButtonTitleColor{
    _selectedButtonTitleColor = selectedButtonTitleColor;
    [(UIButton* )self.titleButtons[self.currentIndex] setTitleColor:self.selectedButtonTitleColor forState:UIControlStateNormal];
}
- (void)selectedButtonChanged:(NSUInteger)index animated:(BOOL)animated{
    if (index >= self.titleButtons.count) {
        return;
    }
    UIButton *titleFrom = self.titleButtons[self.currentIndex];
    UIButton *titleTo = self.titleButtons[index];

    [UIView transitionWithView:self duration:animated ? 0.1 : 0.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        [titleTo setTitleColor:self.selectedButtonTitleColor
                      forState:UIControlStateNormal];
        titleTo.transform = CGAffineTransformMakeScale(1.2, 1.2);
        [titleFrom setTitleColor:self.buttonTitleColor forState:UIControlStateNormal];
        titleFrom.transform = CGAffineTransformMakeScale(1, 1);

    } completion:nil];

    self.currentIndex = index;
}

@end
