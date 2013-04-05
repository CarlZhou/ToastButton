/*
 
 ToastButton.m
 
 MIT LICENSE
 
 Copyright (c) 2013 Zian ZHOU
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
 */

#import "ToastButton.h"
#import "QuartzCore/QuartzCore.h"

@interface ToastButton()
    
- (void)setDisplayToast:(BOOL)animated;

@end

@implementation ToastButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        backgroundView = [[UIView alloc] init];
        backgroundView.alpha = 0.0f;
        backgroundView.layer.cornerRadius = 5.0f;
        [backgroundView setBackgroundColor:[UIColor blackColor]];
        [self addSubview:backgroundView];
        toastBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:toastBtn];
        toastTextLabel = [[UILabel alloc] init];
        toastTextLabel.textColor = [UIColor whiteColor];
        toastTextLabel.backgroundColor = [UIColor clearColor];
        toastTextLabel.numberOfLines = 0;
        toastTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
        toastTextLabel.textAlignment = NSTextAlignmentCenter;
        toastTextLabel.alpha = 0.0f;
        [self addSubview:toastTextLabel];
        toastImage = nil;
        toastImageView = nil;
        toastTextFont = nil;
        customView = nil;
        isAnimated = YES;
        [self setMode:ToastButtonToastMode];
        self.removeFromSuperViewAfterHide = YES;
        [self setInitFrame];
        [self resizeSubviewsForToastButton];
    }
    return self;
}

- (void)setInitFrame
{
    CGFloat originX, originY;
	UIInterfaceOrientation orientation = (UIInterfaceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
	switch (orientation) {
		case UIInterfaceOrientationPortrait:
        case UIInterfaceOrientationPortraitUpsideDown:
		{
            originX = (toastSetView.frame.size.width - 40)/2;
            originY = (toastSetView.frame.size.height - 40)/2;
            [self setFrame:CGRectMake(originX, originY, 40, 40)];
            initSuperViewWidth = toastSetView.frame.size.width;
            initSuperViewHeight = toastSetView.frame.size.height;
			break;
		}
		case UIInterfaceOrientationLandscapeLeft:
		case UIInterfaceOrientationLandscapeRight:
		{
            originX = (toastSetView.frame.size.height - 40)/2;
            originY = (toastSetView.frame.size.width - 40)/2;
            [self setFrame:CGRectMake(originX, originY, 40, 40)];
            initSuperViewWidth = toastSetView.frame.size.height;
            initSuperViewHeight = toastSetView.frame.size.width;
			break;
		}
		default:
			break;
	}
}

-(id)initWithView:(UIView *)view
{
    if (!view)
    {
		[NSException raise:@"ViewIsNillException"
					format:@"The view is nil."];
	}
    
    toastSetView = view;
    
    return [self initWithFrame:view.bounds];
}

+ (ToastButton *)showToastTo:(UIView *)view animated:(BOOL)animated
{
	ToastButton *toastBtn = [[ToastButton alloc] initWithView:view];
	[view addSubview:toastBtn];
	[toastBtn Show];
	return toastBtn;
}

+ (ToastButton *)showToastTo:(UIView *)view animated:(BOOL)animated hideAfter:(NSTimeInterval)secs
{
    ToastButton *toastBtn = [[ToastButton alloc] initWithView:view];
	[view addSubview:toastBtn];
	[toastBtn Show];
    [toastBtn HideAfterDelay:0.3+secs];
	return toastBtn;
}

- (void)setDisplayToast:(BOOL)animated
{
    isAnimated = animated;
}

- (void)ShowWithAnimation:(BOOL)animated
{
    if (animated)
    {
        backgroundView.alpha = 0.0f;
        toastTextLabel.alpha = 0.0f;
        toastImageView.alpha = 0.0f;
        [UIView animateWithDuration:0.3 animations:^{
            backgroundView.alpha = 0.7f;
            toastTextLabel.alpha = 1.0f;
            toastImageView.alpha = 1.0f;
        }completion:^(BOOL finished){
            // TODO:After animation actions
        }];
    }
    else
    {
        toastTextLabel.alpha = 1.0f;
        toastImageView.alpha = 1.0f;
        backgroundView.alpha = 0.7f;
    }
}

- (void)Show
{
    [self bringSubviewToFront:toastImageView];
    [self ShowWithAnimation:isAnimated];
}

- (void)ShowAfterDelay:(NSTimeInterval)delay
{
    [self performSelector:@selector(ShowWithAnimation:) withObject:[NSNumber numberWithBool:isAnimated] afterDelay:delay];
}

- (void)HideWithAnimation:(BOOL)animated
{
    if (animated)
    {
        backgroundView.alpha = 0.7f;
        toastTextLabel.alpha = 1.0f;
        toastImageView.alpha = 1.0f;
        [UIView animateWithDuration:0.3 animations:^{
            backgroundView.alpha = 0.0f;
            toastTextLabel.alpha = 0.0f;
            toastImageView.alpha = 0.0f;
        }completion:^(BOOL finished){
            // TODO:After animation actions
            if (self.removeFromSuperViewAfterHide)
                [self removeFromSuperview];
        }];
    }
    else
    {
        backgroundView.alpha = 0.0f;
        toastImageView.alpha = 0.0f;
        toastTextLabel.alpha = 0.0f;
        if (self.removeFromSuperViewAfterHide)
            [self removeFromSuperview];
    }
}

- (void)Hide
{
    [self HideWithAnimation:isAnimated];
}

- (void)HideAfterDelay:(NSTimeInterval)delay
{
    [self performSelector:@selector(HideWithAnimation:) withObject:[NSNumber numberWithBool:isAnimated] afterDelay:delay];
}

- (void)setToastText:(NSString *)text
{
    toastTextLabel.text = text;
    [self resizeSubviewsForToastButton];
}

- (void)setToastImage:(UIImage *)image
{
    toastImage = image;
    if (!toastImageView)
    {
        toastImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 30, 30)];
        [self addSubview:toastImageView];
    }
    
    [toastImageView setImage:toastImage];
    [self resizeSubviewsForToastButton];
}

- (void)resizeSubviewsForToastButton
{
    [self resizeTextLabel];
    [self resizeToastImageView];
    [self resizeButtonAndBackgroundView];
}

- (void)resizeTextLabel
{
    if ([toastTextLabel.text isEqualToString:@""])
        return;
    CGSize textSize = [toastTextLabel.text sizeWithFont:toastTextLabel.font constrainedToSize:CGSizeMake(toastSetView.frame.size.width-100, toastSetView.frame.size.width-100)  lineBreakMode:NSLineBreakByWordWrapping];
    
        if (textSize.width > self.frame.size.width)
        {
            CGFloat originX, originY;
            if (textSize.height > self.frame.size.height)
            {
                originX = (initSuperViewWidth - textSize.width)/2 - 5;
                originY = (initSuperViewHeight - textSize.height)/2 - 5;
            }
            else
            {
                originX = (initSuperViewWidth - textSize.width)/2 - 5;
                originY = self.frame.origin.y;
            }
            
            [self setFrame:CGRectMake(originX, originY, textSize.width+10, textSize.height+10)];
            [toastTextLabel setFrame:CGRectMake(5, 5, textSize.width, textSize.height)];
        }
        else
        {
            CGFloat textLabelOriginX = (self.frame.size.width - textSize.width)/2;
            CGFloat textLabelOriginY = (self.frame.size.height - textSize.height)/2;
            
            [toastTextLabel setFrame:CGRectMake(textLabelOriginX, textLabelOriginY, textSize.width, textSize.height)];
        }
}

- (void)resizeToastImageView
{
    if (!toastImageView)
        return;

    CGFloat newHeight, newWidth, originX, originY, newHeightStartLine;
    
    if (self.frame.size.height < 41 && self.frame.size.width < 41)
    {
        newHeight = 30 + 40 + 5;
        newWidth = newHeight;
        originX = (initSuperViewWidth - newWidth)/2;
        originY = (initSuperViewHeight - newHeight)/2;
        [self setFrame:CGRectMake(originX, originY, newWidth, newHeight)];
    }
    else
    {
        newHeight = self.frame.size.width + 5;
        newWidth = newHeight;
        originX = (initSuperViewWidth - newWidth)/2;
        originY = (initSuperViewHeight - newHeight)/2;
        [self setFrame:CGRectMake(originX, originY, newWidth, newHeight)];
    }
    
    newHeightStartLine = (self.frame.size.height - (toastImageView.frame.size.height + toastTextLabel.frame.size.height + 5))/2;
    
    if (newHeightStartLine > 15)
    {
        newHeight = newHeight-(newHeightStartLine-15)*2;
        originY = (initSuperViewHeight - newHeight)/2;
        [self setFrame:CGRectMake(originX, originY, newWidth, newHeight)];
        newHeightStartLine = 15;
    }
    
    [toastImageView setFrame:CGRectMake((self.frame.size.width - toastImageView.frame.size.width)/2, newHeightStartLine+2.5, toastImageView.frame.size.width, toastImageView.frame.size.height)];
    
    [toastTextLabel setFrame:CGRectMake(toastTextLabel.frame.origin.x, newHeightStartLine + 7.5 + toastImageView.frame.size.height, toastTextLabel.frame.size.width, toastTextLabel.frame.size.height)];
    
}

- (void)resizeButtonAndBackgroundView
{
    [toastBtn setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [backgroundView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}

- (void)setTarget:(id)target Action:(SEL)Selector
{
    [toastBtn addTarget:target action:Selector forControlEvents:UIControlEventTouchUpInside];
    [self setMode:ToastButtonBtnMode];
}

- (void)setMode:(ToastButtonMode)mode
{
    toastMode = mode;
    
    switch (toastMode)
    {
        case ToastButtonBtnMode:
            toastBtn.enabled = YES;
            break;
        case ToastButtonToastMode:
            toastBtn.enabled = NO;
            break;
        case ToastButtonCustomViewMode:
            // TODO: RESIZE!
            [toastBtn setTitle:@"" forState:UIControlStateNormal];
            [toastImageView removeFromSuperview];
            break;
        default:
            break;
    }
}

- (void)setCustomView:(UIView *)view
{
    customView = view;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
