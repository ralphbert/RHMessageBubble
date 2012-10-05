//
//  RHMessageBubble.m
//  BMWBoerseUniversal
//
//  Created by Ralph Harrer on 28.06.11.
//

#import <QuartzCore/QuartzCore.h>
#import "RHMessageBubble.h"


@interface RHMessageBubble (hidden)
/**
 * this methods are private! it is only for internal purpose.
 * this method returns a ready configured RHBubbleView with a text and an optional spinner if not set to nil
 * @param text a thext message to be shown in the bubble
 * @param spinner if true a UIActivityIndicator will be added to the bubble above the text
 * @return a RHBubbleView object containing the message and a spinner if not set to nil
 */
+ (RHBubbleView*)getViewWithSpinnerAndText:(NSString*)text;

+ (RHBubbleView*)getViewWithSpinner;

+ (RHBubbleView*)getViewWithText:(NSString*)text;

+ (RHBubbleView*)getViewWithText:(NSString*)text andImageNamed:(NSString*)imageName;

+ (void)addBackground:(UIView*)view;

+ (void)addTopView:(UIView*)topView andBottomView:(UIView*)bottomView toView:(UIView*)view;

+ (UILabel*)getLabelWithText:(NSString*)text;

+ (void)addView:(UIView*)view centeredToParent:(UIView*)parent;

+ (void)addView:(UIView*)view toParent:(UIView*)parent onPosition:(CGPoint)position;

/**
 * shows the given buble view. but if already a bubble view exists in the parent view it will just be replaced without animation
 */
+ (void)showOrReplaceBubbleView:(RHBubbleView*)bubbleView inParent:(UIView*)view;

/**
 * shows the given buble view. but if already a bubble view exists in the parent view it will just be replaced without animation. after the given time a selector will be performed
 */
+ (void)showOrReplaceBubbleView:(RHBubbleView*)bubbleView inParent:(UIView*)view andPerformSelector:(SEL)action target:(id)target after:(NSTimeInterval)time;

/**
 * returns the RHBubbleView which "view" contains. nil will be returned if "view" does not contain a RHBubbleView instance.
 */
+ (RHBubbleView*)bubbleViewInView:(UIView*)view;
@end

//####################################################//
//################  RHMessageBubble  #################//
//####################################################//

@implementation RHMessageBubble

/*#### Shortcuts ####*/

+ (void)bubbleWithSuccessAddToView:(UIView*)view
{
    [RHMessageBubble bubbleWithSuccessWithMessage:nil addToView:view];
}

+ (void)bubbleWithSuccessWithMessage:(NSString *)message addToView:(UIView *)view
{
    [RHMessageBubble bubbleWithString:message andImageNamed:RH_MESSAGE_BUBBLE_SUCCESS_IMAGE ToView:view forSeconds:RH_MESSAGE_BUBBLE_DEFAULT_TIME];
}

+ (void)bubbleWithErrorAddToView:(UIView *)view
{
    [RHMessageBubble bubbleWithErrorWithMessage:nil addToView:view];
}

+ (void)bubbleWithErrorWithMessage:(NSString *)message addToView:(UIView *)view
{
    [RHMessageBubble bubbleWithString:message andImageNamed:RH_MESSAGE_BUBBLE_ERROR_IMAGE ToView:view forSeconds:RH_MESSAGE_BUBBLE_DEFAULT_TIME];
}

/*#### String ####*/

+ (void)bubbleWithString:(NSString*)text toView:(UIView*)parent
{
	[RHMessageBubble bubbleWithString:text toView:parent forSeconds:-1];
}

+ (void)bubbleWithString:(NSString*)text toView:(UIView*)parent onPosition:(CGPoint)position 
{
	[RHMessageBubble bubbleWithString:text toView:parent forSeconds:-1 onPosition:position];
}

+ (void)bubbleWithString:(NSString*)text toView:(UIView*)parent forSeconds:(CGFloat)seconds
{
    RHBubbleView* view = [RHMessageBubble getViewWithText:text];
    
    if (seconds > 0) {
		[RHMessageBubble showOrReplaceBubbleView:view inParent:parent andPerformSelector:@selector(hideAndRemove) target:view after:seconds];
	} else {
		[RHMessageBubble showOrReplaceBubbleView:view inParent:parent];
	}
}

+ (void)bubbleWithString:(NSString*)text toView:(UIView*)parent forSeconds:(CGFloat)seconds onPosition:(CGPoint)position
{
	[RHMessageBubble removeBubbleFromView:parent];
	
	RHBubbleView* view = [RHMessageBubble getViewWithText:text];
	
	[RHMessageBubble addView:view toParent:parent onPosition:position];
	
	if (seconds > 0) {
		[view showAndPerformSelector:@selector(hideAndRemove) target:view after:seconds];
	} else {
		[view show];
	}
}

/*#### Spinner ####*/

+ (void)bubbleWithSpinnerToView:(UIView*)parent
{
	[RHMessageBubble bubbleWithSpinnerToView:parent forSeconds:-1];
}

+ (void)bubbleWithSpinnerToView:(UIView*)parent onPosition:(CGPoint)position
{
	[RHMessageBubble bubbleWithSpinnerToView:parent forSeconds:-1 onPosition:position];
}

+ (void)bubbleWithSpinnerToView:(UIView*)parent forSeconds:(CGFloat)seconds
{
	RHBubbleView* view = [RHMessageBubble getViewWithSpinner];
	
	if (seconds > 0) {
		[RHMessageBubble showOrReplaceBubbleView:view inParent:parent andPerformSelector:@selector(hideAndRemove) target:view after:seconds];
	} else {
		[RHMessageBubble showOrReplaceBubbleView:view inParent:parent];
	}
}

+ (void)bubbleWithSpinnerToView:(UIView*)parent forSeconds:(CGFloat)seconds onPosition:(CGPoint)position
{
	[RHMessageBubble removeBubbleFromView:parent];
	
	RHBubbleView* view = [RHMessageBubble getViewWithSpinner];
	
	[RHMessageBubble addView:view toParent:parent onPosition:position];
	
	if (seconds > 0) {
		[view showAndPerformSelector:@selector(hideAndRemove) target:view after:seconds];
	} else {
		[view show];
	}
}

/*#### Spinner & String ####*/

+ (void)bubbleWithSpinnerAndString:(NSString*)text toView:(UIView*)parent
{
	[RHMessageBubble bubbleWithSpinnerAndString:text toView:parent forSeconds:-1];
}

+ (void)bubbleWithSpinnerAndString:(NSString*)text toView:(UIView*)parent onPosition:(CGPoint)position
{
	[RHMessageBubble bubbleWithSpinnerAndString:text toView:parent forSeconds:-1 onPosition:position];
}

+ (void)bubbleWithSpinnerAndString:(NSString*)text toView:(UIView*)parent forSeconds:(CGFloat)seconds
{
	RHBubbleView* view = [RHMessageBubble getViewWithSpinnerAndText:text];
	
	if (seconds > 0) {
		[RHMessageBubble showOrReplaceBubbleView:view inParent:parent andPerformSelector:@selector(hideAndRemove) target:view after:seconds];
	} else {
		[RHMessageBubble showOrReplaceBubbleView:view inParent:parent];
	}
}

+ (void)bubbleWithSpinnerAndString:(NSString*)text toView:(UIView*)parent forSeconds:(CGFloat)seconds onPosition:(CGPoint)position
{
	[RHMessageBubble removeBubbleFromView:parent];
	
	RHBubbleView* view = [RHMessageBubble getViewWithSpinnerAndText:text];
	
	[RHMessageBubble addView:view toParent:parent onPosition:position];
	
	if (seconds > 0) {
		[view showAndPerformSelector:@selector(hideAndRemove) target:view after:seconds];
	} else {
		[view show];
	}
}

/*#### String & Image ####*/

+ (void)bubbleWithString:(NSString*)text andImageNamed:(NSString*)imgName ToView:(UIView*)parent
{
	[RHMessageBubble bubbleWithString:text andImageNamed:imgName ToView:parent forSeconds:-1];
}

+ (void)bubbleWithString:(NSString*)text andImageNamed:(NSString*)imgName ToView:(UIView*)parent onPosition:(CGPoint)position
{
	[RHMessageBubble bubbleWithString:text andImageNamed:imgName ToView:parent forSeconds:-1 onPosition:position];
}

+ (void)bubbleWithString:(NSString*)text andImageNamed:(NSString*)imgName ToView:(UIView*)parent forSeconds:(CGFloat)seconds
{
	RHBubbleView* view = [RHMessageBubble getViewWithText:text andImageNamed:imgName];
		
	if (seconds > 0) {
		[RHMessageBubble showOrReplaceBubbleView:view inParent:parent andPerformSelector:@selector(hideAndRemove) target:view after:seconds];
	} else {
		[RHMessageBubble showOrReplaceBubbleView:view inParent:parent];
	}
}

+ (void)bubbleWithString:(NSString*)text andImageNamed:(NSString*)imgName ToView:(UIView*)parent forSeconds:(CGFloat)seconds onPosition:(CGPoint)position
{
	[RHMessageBubble removeBubbleFromView:parent];
	
	RHBubbleView* view = [RHMessageBubble getViewWithText:text andImageNamed:imgName];
	[RHMessageBubble addView:view toParent:parent onPosition:position];
	
	if (seconds > 0) {
		[view showAndPerformSelector:@selector(hideAndRemove) target:view after:seconds];
	} else {
		[view show];
	}
}

+ (void)removeBubbleFromView:(UIView *)parent
{
	for (UIView* subview in [parent subviews]) {
		if (subview.tag == RH_MESSAGE_BUBBLE_TAG && [subview class] == [RHBubbleView class]) {
			[((RHBubbleView*)subview) hideAndRemove];
		}
	}
}


#pragma mark -
#pragma mark Private

/*#########################*/
/*#### Private methods ####*/
/*#########################*/

+ (RHBubbleView*)getViewWithSpinnerAndText:(NSString*)text
{
	CGSize maxSize = CGSizeMake(RH_MESSAGE_BUBBLE_SIDE_LENGTH, RH_MESSAGE_BUBBLE_SIDE_LENGTH);
	
	RHBubbleView* view = [[[RHBubbleView alloc] initWithFrame:CGRectMake(0, 0, maxSize.width, maxSize.height)] autorelease];
	view.backgroundColor = [UIColor clearColor];
	
	UILabel* label = [RHMessageBubble getLabelWithText:text];

	UIActivityIndicatorView* activityIndicator = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] autorelease];
	[activityIndicator startAnimating];

	[RHMessageBubble addBackground:view];
	[RHMessageBubble addTopView:activityIndicator andBottomView:label toView:view];
	
	return view;
}

+ (RHBubbleView*)getViewWithSpinner
{
	RHBubbleView* view = [[[RHBubbleView alloc] initWithFrame:CGRectMake(0, 0, RH_MESSAGE_BUBBLE_SIDE_LENGTH, RH_MESSAGE_BUBBLE_SIDE_LENGTH)] autorelease];
	view.backgroundColor = [UIColor clearColor];
	
	UIActivityIndicatorView* activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	[view addSubview:activityIndicator];
	[activityIndicator startAnimating];
	[activityIndicator release];
	
	CGRect spinnerFrame = activityIndicator.frame;
	spinnerFrame.origin = CGPointMake((NSInteger)(view.frame.size.width / 2 - 
									  activityIndicator.frame.size.width / 2), 
									  (NSInteger)(view.frame.size.height / 2 - 
									  activityIndicator.frame.size.height / 2));
	activityIndicator.frame = spinnerFrame;
	
	[RHMessageBubble addBackground:view];
	[view bringSubviewToFront:activityIndicator];
	
	return view;
}

+ (RHBubbleView*)getViewWithText:(NSString*)text
{
	CGSize maxSize = CGSizeMake(RH_MESSAGE_BUBBLE_SIDE_LENGTH, RH_MESSAGE_BUBBLE_SIDE_LENGTH);
	
	RHBubbleView* view = [[[RHBubbleView alloc] initWithFrame:CGRectMake(0, 0, maxSize.width, maxSize.height)] autorelease];
	view.backgroundColor = [UIColor clearColor];
	
	UILabel* label = [RHMessageBubble getLabelWithText:text];
	[RHMessageBubble addView:label centeredToParent:view];
	[RHMessageBubble addBackground:view];
	[view bringSubviewToFront:label];
	
	return view;
}

+ (UILabel*)getLabelWithText:(NSString*)text
{
	// adding the text label to the bubble view
    UIFont* font = [UIFont boldSystemFontOfSize:17];
    CGSize size = [text sizeWithFont:font constrainedToSize:CGSizeMake((NSInteger)(RH_MESSAGE_BUBBLE_SIDE_LENGTH - 2 * RH_MESSAGE_BUBBLE_PADDING), (NSInteger)(RH_MESSAGE_BUBBLE_IMAGE_MAX_WIDTH_HEIGHT / (3.f/5.f))) lineBreakMode:NSLineBreakByWordWrapping];
    
    CGRect frame = CGRectMake(0, 0, size.width, size.height);
    UILabel* label = [[UILabel alloc] initWithFrame:frame];
	[label setText:text];
	label.font = font;
	label.numberOfLines = 0;
	label.textAlignment = UITextAlignmentCenter;
	label.textColor = [UIColor whiteColor];
	label.backgroundColor = [UIColor clearColor];
    [label setMinimumFontSize:13];
    [label setAdjustsFontSizeToFitWidth:YES];
	
	return [label autorelease];
}

+ (RHBubbleView*)getViewWithText:(NSString*)text andImageNamed:(NSString*)imageName
{
	UIImage* img = [UIImage imageNamed:imageName];
	
	if (img) {
		UIImageView* imgView = [[[UIImageView alloc] initWithImage:img] autorelease];
		[imgView setContentMode:UIViewContentModeScaleAspectFit];
        [imgView setClipsToBounds:YES];
		
		CGRect imgRect = imgView.frame;
		
		if (imgRect.size.width > RH_MESSAGE_BUBBLE_IMAGE_MAX_WIDTH_HEIGHT) {
			imgRect.size.width = RH_MESSAGE_BUBBLE_IMAGE_MAX_WIDTH_HEIGHT;
		}
		
		if (imgRect.size.height > RH_MESSAGE_BUBBLE_IMAGE_MAX_WIDTH_HEIGHT) {
			imgRect.size.height = RH_MESSAGE_BUBBLE_IMAGE_MAX_WIDTH_HEIGHT;
		}
		
		CGPoint pos = CGPointMake(0, 0);
		imgRect.origin = pos;
		imgView.frame = imgRect;
		
		RHBubbleView* view = [[[RHBubbleView alloc] initWithFrame:CGRectMake(0, 0, RH_MESSAGE_BUBBLE_SIDE_LENGTH, RH_MESSAGE_BUBBLE_SIDE_LENGTH)] autorelease];
		view.backgroundColor = [UIColor clearColor];
		[RHMessageBubble addBackground:view];
		
        if (text != nil) {
            // adding label
            UILabel* label = [RHMessageBubble getLabelWithText:text];
            [RHMessageBubble addTopView:imgView andBottomView:label toView:view];
            [view bringSubviewToFront:label];
        } else {
            imgView.center = view.center;
            [view addSubview:imgView];
        }
        
		[view bringSubviewToFront:imgView];
		
		return view;
	} else {
		return [RHMessageBubble getViewWithText:text];
	}
}

+ (void)addBackground:(UIView*)view
{
	// adding transparent background to the bubble view
	UIView* backgroundView = [[UIView alloc] initWithFrame:view.frame];
	backgroundView.backgroundColor = [UIColor blackColor];
	backgroundView.alpha = 0.7;
	backgroundView.layer.cornerRadius = RH_MESSAGE_BUBBLE_CORNER_RADIUS;
	[view addSubview:backgroundView];
	[backgroundView release];
}

+ (void)addTopView:(UIView*)topView andBottomView:(UIView*)bottomView toView:(UIView*)view
{
    NSInteger paddingBetween = 7;
    UIView* container = [[UIView alloc] init];
    
    CGFloat height = topView.frame.size.height + bottomView.frame.size.height + paddingBetween;
    CGFloat maxHeight = RH_MESSAGE_BUBBLE_SIDE_LENGTH - 2*RH_MESSAGE_BUBBLE_PADDING;
    CGFloat maxWidth = maxHeight;
    CGFloat newTopHeight = topView.frame.size.height;
    
    if (height > maxHeight) {
        height = maxHeight;
        CGFloat newHeightForTop = maxHeight - bottomView.frame.size.height - paddingBetween;
        newTopHeight = newHeightForTop;
    }
    
    // calculate y-coordinate to center both views within the container
    CGFloat deltaTop = (NSInteger)((maxHeight - height) / 2.0f);
    
    // resize top view to fit content
    CGRect newFrameTop = topView.frame;
    newFrameTop.size = CGSizeMake(maxWidth, newTopHeight);
    newFrameTop.origin = CGPointMake(0, deltaTop);
    topView.frame = newFrameTop;
    
    // resize bottom view to fit content
    CGRect newFrameBottom = bottomView.frame;
    newFrameBottom.origin = CGPointMake(0, newFrameTop.origin.y + newFrameTop.size.height + paddingBetween);
    newFrameBottom.size = CGSizeMake(maxWidth, newFrameBottom.size.height);
    bottomView.frame = newFrameBottom;
    
    // position container
    container.frame = CGRectMake(RH_MESSAGE_BUBBLE_PADDING, RH_MESSAGE_BUBBLE_PADDING, maxWidth, maxHeight);
    [container addSubview:topView];
    [container addSubview:bottomView];
    
    [view addSubview:container];
}

+ (void)addView:(UIView*)view centeredToParent:(UIView*)parent
{
	CGRect frameRect = view.frame;
	CGPoint loc = CGPointMake((NSInteger)((parent.frame.size.width - frameRect.size.width)/2),
							  (NSInteger)((parent.frame.size.height - frameRect.size.height)/2));
	[RHMessageBubble addView:view toParent:parent onPosition:loc];
}

+ (void)addView:(UIView*)view toParent:(UIView*)parent onPosition:(CGPoint)position
{
	CGRect frameRect = view.frame;
	frameRect.origin = position;
	
	view.frame = frameRect;
	[view setUserInteractionEnabled:NO];
	[parent addSubview:view];
	[parent bringSubviewToFront:view];
}

+ (void)showOrReplaceBubbleView:(RHBubbleView*)bubbleView inParent:(UIView*)view
{
    RHBubbleView* oldBubbleView = [RHMessageBubble bubbleViewInView:view];
    
    if (oldBubbleView) {
        // TODO add swap animation if needed
        [RHMessageBubble addView:bubbleView centeredToParent:view];
        
        for (UIView* subview in [view subviews]) {
            if (subview.tag == RH_MESSAGE_BUBBLE_TAG && [subview class] == [RHBubbleView class] && subview != bubbleView) {
                [subview removeFromSuperview];
            }
        }
    } else {
        [RHMessageBubble addView:bubbleView centeredToParent:view];
        [bubbleView show];
    }
}

+ (void)showOrReplaceBubbleView:(RHBubbleView*)bubbleView inParent:(UIView*)view andPerformSelector:(SEL)action target:(id)target after:(NSTimeInterval)time
{
    [RHMessageBubble showOrReplaceBubbleView:bubbleView inParent:view];
    [target performSelector:action withObject:nil afterDelay:time];
}


+ (RHBubbleView*)bubbleViewInView:(UIView*)view
{
    for (UIView* subview in [view subviews]) {
		if (subview.tag == RH_MESSAGE_BUBBLE_TAG && [subview class] == [RHBubbleView class]) {
			return (RHBubbleView*)subview;
		}
	}
    return nil;
}

@end

//####################################################//
//##################  RHBubbleView  ##################//
//####################################################//

@implementation RHBubbleView

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	
	if (self) {
		self.tag = RH_MESSAGE_BUBBLE_TAG;
		self.backgroundColor = [UIColor clearColor];
	}
	
	return self;
}

- (id)init
{
	self = [super initWithFrame:CGRectMake(0, 0, RH_MESSAGE_BUBBLE_SIDE_LENGTH, RH_MESSAGE_BUBBLE_SIDE_LENGTH)];
	
	if (self) {
		self.tag = RH_MESSAGE_BUBBLE_TAG;
		self.backgroundColor = [UIColor clearColor];
	}
	
	return self;
}

- (void)show
{
	self.alpha = 0.0;
	self.transform = CGAffineTransformMakeScale(3.0, 3.0);
	self.hidden = NO;
	
    [UIView animateWithDuration:0.3 
                          delay:0 
                        options:UIViewAnimationOptionAllowUserInteraction 
                     animations:^{
                         self.transform = CGAffineTransformIdentity;
                         self.alpha = 1.0;
                     } 
                     completion:nil];
}

- (void)showAndPerformSelector:(SEL)action target:(id)target after:(CGFloat)seconds
{
	self.alpha = 0.0;
	self.transform = CGAffineTransformMakeScale(3.0, 3.0);
	self.hidden = NO;
	
    [UIView animateWithDuration:0.3 
                          delay:0 
                        options:UIViewAnimationOptionAllowUserInteraction 
                     animations:^{
                         self.transform = CGAffineTransformIdentity;
                         self.alpha = 1.0;
                     } 
                     completion:^(BOOL finished){
                         if ([target respondsToSelector:action]) {
                             [target performSelector:action withObject:nil afterDelay:seconds];
                         }
                     }];
}

- (void)hideAndRemove
{
    [UIView animateWithDuration:0.3 
                          delay:0 
                        options:UIViewAnimationOptionAllowUserInteraction 
                     animations:^{
                         self.alpha = 0;
                         self.transform = CGAffineTransformMakeScale(0.5, 0.5);
                     } 
                     completion:^(BOOL finished){
                         [self removeFromSuperview];
                     }];
}

- (void)remove
{
    [self removeFromSuperview];
}

- (void)dealloc
{
    [super dealloc];
}

@end