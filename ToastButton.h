//
//  ToastButton.h
//  ToastButton
//
//  Created by Carl on 2013-04-05.
//  Copyright (c) 2013 Carl. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    /** */
    ToastButtonBtnMode,
    /**  */
	ToastButtonToastMode,
    /**  */
	ToastButtonCustomViewMode,
	/**  */
	ToastButtonModeNum
} ToastButtonMode;

@interface ToastButton : UIView
{
    UIView *toastSetView;
    UILabel *toastTextLabel;
    UIImage *toastImage;
    UIImageView *toastImageView;
    UIView *customView;
    UIButton *toastBtn;
    UIFont *toastTextFont;
    BOOL isAnimated;
    ToastButtonMode toastMode;
    CGFloat initSuperViewWidth;
    CGFloat initSuperViewHeight;
    UIView *backgroundView;
}

+ (ToastButton *)showToastTo:(UIView *)view animated:(BOOL)animated;
+ (ToastButton *)showToastTo:(UIView *)view animated:(BOOL)animated hideAfter:(NSTimeInterval)secs;

- (void)Show;
- (void)ShowAfterDelay:(NSTimeInterval)delay;
- (void)Hide;
- (void)HideAfterDelay:(NSTimeInterval)delay;
- (void)setTarget:(id)target Action:(SEL)Selector;
- (void)setToastText:(NSString *)text;
- (void)setToastImage:(UIImage *)image;
- (void)setCustomView:(UIView *)view;

@property BOOL removeFromSuperViewAfterHide;

@end
