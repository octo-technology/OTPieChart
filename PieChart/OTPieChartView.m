// Copyright 2013 OCTO Technology
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.


/**
 * @author RVI
 *
 * @section Description
 * OTPieChartView implementation
 */

#import "OTPieChartView.h"

#import <math.h>

#import "UIFont+OTPieChart.h"

#define SLICE_SEPARATION               5
#define INNER_RADIUS                   60
#define OUTER_RADIUS                   140

#define LEGEND_OFFSET                  15

#define SHOULD_DRAW_GRADIENT_ON_SLICES YES

@interface OTPieChartView()

- (void)resetView;

// Legends
- (CGRect)computeLegendSizeForSlice:(OTSliceView *)sliceView;
- (void)addLegendForSlice:(OTSliceView *)slice withFrame:(CGRect)frame;
- (UILabel *)legendLabelForFrame:(CGRect)frame andText:(NSString *)text;
- (void)addLegendsToView;

// Collision
- (void)resetCollision;
- (void)removeOneLabel;
- (void)addAllRemainingLabels;
- (void)adjustLabelsSizeOfOverFill;
+ (BOOL)label:(UILabel *)firstLabel isInCollisionWithLabel:(UILabel *)secondLabel;
- (BOOL)isInCollisionWithLabel:(UILabel *)label;

// label tapped
- (void)labelTapped:(id)sender;

// Find slices selected
- (OTSliceView *)findSelectedSliceOnPoint:(CGPoint)aPoint;

// Slice selected
- (void)selectTouchedSliceOnTouch:(UITouch *)aTouch;

// Change slice
- (void)changeCurrentSliceWith:(OTSliceView *)selectedSlice;
- (void)deselectAllSlices;

// Slice default value
- (CGFloat)sliceSeparation;
- (CGFloat)sliceInnerRadius;
- (CGFloat)sliceOuterRadius;
- (BOOL)shouldDisplayLegendInsideSlice;

@end


@implementation OTPieChartView

/**************************************************************************/
#pragma mark - Getters and Setters

@synthesize delegate;
@synthesize datasource;
@synthesize sliceLayerList;

/**************************************************************************/
#pragma mark - Birth and Death

- (id)initWithFrame:(CGRect)frame
{
	if ((self = [super initWithFrame:frame]))
	{
		self.backgroundColor = [UIColor clearColor];
	}
	return self;
}

- (void)dealloc
{
	self.delegate = nil;
}

- (void)resetView
{
	for (CALayer *sublayer in self.sliceLayerList)
	{
		[sublayer removeFromSuperlayer];
	}

	for (UIView *view in self.subviews)
	{
		[view removeFromSuperview];
	}
}

/**************************************************************************************************/
#pragma mark - load Pie Chart

- (void)loadPieChart
{
	[self resetView];

	self.sliceLayerList = [NSMutableArray array];

	UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectTouchedSliceOnTouch:)];

	[self addGestureRecognizer:tapGesture];

	CGFloat startAngle = -M_PI / 2;
	NSUInteger numberOfSlice = [self.datasource numbertOfSliceForPieChartIndex:self];

    // Retrieve default value for slice
    CGFloat sliceSeparationValue = [self sliceSeparation];
    CGFloat sliceInnerRadiusValue = [self sliceInnerRadius];
    CGFloat sliceOuterRadiusValue = [self sliceOuterRadius];
    BOOL isLegendDisplayInsideSlice = [self shouldDisplayLegendInsideSlice];
    
	for (NSUInteger i = 0; i < numberOfSlice; i++)
	{
		CGFloat angle = [self.datasource pieChart:self getPercentageValue:i] * 2 * M_PI;

		OTSliceView *sliceLayer = [[OTSliceView alloc] init];
		sliceLayer.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
		sliceLayer.backgroundColor = [UIColor clearColor].CGColor;
		sliceLayer.startAngle = startAngle;
		sliceLayer.sliceAngle = angle;
		sliceLayer.sliceColor = [self.datasource pieChart:self getSliceColor:i];
		sliceLayer.shouldDisplayGradient = SHOULD_DRAW_GRADIENT_ON_SLICES;

        sliceLayer.sliceSeparation = sliceSeparationValue;
        sliceLayer.innerRadius = sliceInnerRadiusValue;
        sliceLayer.outerRadius = sliceOuterRadiusValue;
        sliceLayer.shouldDisplayLegendInsideSlice = isLegendDisplayInsideSlice;
        
		if ([self.datasource respondsToSelector:@selector(pieChart:getSliceLabel:)])
		{
			sliceLayer.title = [self.datasource pieChart:self getSliceLabel:i];
		}

		[self.layer addSublayer:sliceLayer];
		[self.sliceLayerList addObject:sliceLayer];
		[sliceLayer setNeedsDisplay];

		// If we want to display the legend outside of the slices (default behaviour)
		if (!sliceLayer.shouldDisplayLegendInsideSlice)
		{
			CGRect legendFrameValue = [self computeLegendSizeForSlice:sliceLayer];
			[self addLegendForSlice:sliceLayer withFrame:legendFrameValue];
		}

		startAngle += angle;
	}

	[self addLegendsToView];
}

/**************************************************************************************************/
#pragma mark - Add legend to view

/**
 * This method compute the appropriate size for a label
 */
- (CGRect)computeLegendSizeForSlice:(OTSliceView *)sliceView
{
	UIFont *font = [UIFont defaultFont];

	// Here we compute the frame of the legend UILabel
	if ([self.datasource respondsToSelector:@selector(fontLegendForPieChart:)])
	{
		font = [self.delegate fontLegendForPieChart:self];
	}
	CGSize sizeOfLabel = [sliceView.title sizeWithFont:font];

	// put the label on 2 lines
	sizeOfLabel.width = sizeOfLabel.width / 1.5;
	sizeOfLabel.height = sizeOfLabel.height * 2;

	CGRect legendFrame = CGRectZero;
	legendFrame.size = sizeOfLabel;

	return legendFrame;
}

/**
 * This method add legend for slice.
 */
- (void)addLegendForSlice:(OTSliceView *)slice withFrame:(CGRect)frame
{
	UILabel *legendLabel = [self legendLabelForFrame:frame andText:slice.title];

	[legendLabel sizeToFit];

	CGRect labelFrame = [self computeLegendOriginForSlice:slice legendFrame:legendLabel.frame];
	legendLabel.frame = labelFrame;

	NSUInteger index = [self.sliceLayerList indexOfObject:slice];
	legendLabel.tag = index;

	// Add gesture
	legendLabel.userInteractionEnabled = YES;
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTapped:)];
	[legendLabel addGestureRecognizer:tap];

	slice.titleLabel = legendLabel;
}

/**
 * This method compute the origin of a label. It depends of the position of the label relative to the pie.
 */
- (CGRect)computeLegendOriginForSlice:(OTSliceView *)sliceView legendFrame:(CGRect)frame
{
	CGPoint center = [sliceView computeTopOfSliceDotWithOffset:LEGEND_OFFSET];
	CGFloat sliceAngle = [sliceView retrieveAngleOfSlice];
	CGSize sizeOfLabel = frame.size;
	CGPoint origin = CGPointMake(center.x, center.y);

	// to have a slice angle value < 2 Pi
	sliceAngle = fmod(sliceAngle, 2 * M_PI);


	// here we compute the origin of the legend label

	CGFloat delta = M_PI / 8;
	// If we are on the left part of the pie, we move the origin point to the left.
	if (sliceAngle > M_PI_2 + delta && sliceAngle <= 3 * M_PI_2 - delta)
	{
		origin.x -= sizeOfLabel.width;
	}

	// If we are on the top part of the pie, we move the origin point to the top.
	if (sliceAngle > M_PI + delta || sliceAngle <= 0 - delta)
	{
		origin.y -= sizeOfLabel.height;
	}


	// if we are close to Pi or close to zero
	// arround 0
	if ((sliceAngle > 0 - delta && sliceAngle <= 0 + delta)
	    // arroud Pi
		|| (sliceAngle > M_PI - delta && sliceAngle <= M_PI + delta))
	{
		origin.y -= sizeOfLabel.height / 2;
	}

	// if we are close to 3Pi/2 or close to Pi/2
	// arround 3Pi/2
	if ((sliceAngle > 3 * M_PI_2 - delta && sliceAngle <= 3 * M_PI_2 + delta)
	    // arroud Pi / 2
		|| (sliceAngle > M_PI_2 - delta && sliceAngle <= M_PI_2 + delta))
	{
		origin.x -= sizeOfLabel.width / 2;
	}

	origin.x = floor(origin.x);
	origin.y = floor(origin.y);

	frame.origin = origin;

	return frame;
}

/**
 * The method create a legend label and return it.
 */
- (UILabel *)legendLabelForFrame:(CGRect)frame andText:(NSString *)text
{
	UILabel *label = [[UILabel alloc] initWithFrame:frame];

	UIFont *font = [UIFont defaultFont];

	if ([self.datasource respondsToSelector:@selector(fontLegendForPieChart:)])
	{
		font = [self.delegate fontLegendForPieChart:self];
	}
	[label setFont:font];
	[label setMinimumFontSize:10.];
	[label setNumberOfLines:2];
	[label setShadowOffset:CGSizeMake(0, 1)];
	[label setShadowColor:[UIColor colorWithWhite:0. alpha:1.]];

	UIColor *color = [UIColor whiteColor];
	if ([self.delegate respondsToSelector:@selector(textColorForPieChart:)])
	{
		color = [self.delegate textColorForPieChart:self];
	}
	[label setTextColor:color];
	[label setBackgroundColor:[UIColor clearColor]];
	[label setText:text];

	return label;
}

/**
 * This method check if there's some collisions between legend's labels and add them
 * to the view if not.
 */
- (void)addLegendsToView
{
	BOOL noMoreCollision;

	do
	{
		// By default, we assume there's no more collision
		noMoreCollision = YES;

		[self resetCollision];

		// check for collision
		for (NSUInteger i = 0; i < self.sliceLayerList.count; i++)
		{
			OTSliceView *slice1 = [self.sliceLayerList objectAtIndex:i];
			UILabel *firstLabel = slice1.titleLabel;

			for (NSUInteger j = 0; j < self.sliceLayerList.count; j++)
			{
				if (i == j)
				{
					continue;
				}

				OTSliceView *slice2 = [self.sliceLayerList objectAtIndex:j];
				UILabel *secondLabel = slice2.titleLabel;

				// If there is a collision, we marked the slice as 'in conflict'
				if (firstLabel
					&& secondLabel
					&& firstLabel != secondLabel
					&& [OTPieChartView label:firstLabel isInCollisionWithLabel:secondLabel])
				{
					slice1.titleLabelIsInConflict = YES;
					noMoreCollision = NO;
					break;
				}
			}
		}

		// If there is a conflict, we remove only one label and again, we run the loop to see if some conflicts are remaining.
		if (!noMoreCollision)
		{
			[self removeOneLabel];
		}
	}
	while (!noMoreCollision);

	[self addAllRemainingLabels];
	[self adjustLabelsSizeOfOverFill];
}

/**
 * This method is called to put all the collision flag  to NO in the SliceViews
 */
- (void)resetCollision
{
	for (OTSliceView *slice in self.sliceLayerList)
	{
		slice.titleLabelIsInConflict = NO;
	}
}

/**
 * Remove only one label. This method will remove the label of the smallest slice in conflict.
 */
- (void)removeOneLabel
{
	OTSliceView *slice = [OTSliceView retrieveSliceViewWithSmallestSliceAngleFromList:self.sliceLayerList];

	slice.titleLabel = nil;
}

/**
 * Add all labels which are not in conflict (e.g. not allocated)
 */
- (void)addAllRemainingLabels
{
	for (OTSliceView *slice in self.sliceLayerList)
	{
		[self addSubview:slice.titleLabel];
	}
}

/**
 * Check if all the labels don't overfill the pie chart view and adjust them sizes if needed
 * This method will constrained label frame to self.frame.
 */
- (void)adjustLabelsSizeOfOverFill
{
	for (OTSliceView *slice in self.sliceLayerList)
	{
		if ([self isInCollisionWithLabel:slice.titleLabel])
		{
			CGRect labelFrame = [self convertRect:slice.titleLabel.frame toView:self.superview];
			CGRect newFrame = CGRectIntersection(labelFrame, self.frame);
			newFrame = [self convertRect:newFrame fromView:self.superview];

			[slice.titleLabel setFrame:newFrame];
		}
	}
}

/**************************************************************************/
#pragma mark - Slice selected

/**
 * This method is called each time a touch is detected in the pie chart view.
 */
- (void)selectTouchedSliceOnTouch:(UITouch *)aTouch
{
	CGPoint touchPoint = [aTouch locationInView:self];
	OTSliceView *selectedSlice = [self findSelectedSliceOnPoint:touchPoint];

	[self changeCurrentSliceWith:selectedSlice];
}

/**
 * This method find the slice tapped and return it.
 */
- (OTSliceView *)findSelectedSliceOnPoint:(CGPoint)aPoint
{
	OTSliceView *result = 0;

	for (NSUInteger i = 0; i < self.sliceLayerList.count; i++)
	{
        OTSliceView *sliceView = [self.sliceLayerList objectAtIndex:i];
		if (CGPathContainsPoint([sliceView slicePath], NULL, aPoint, false)
			&& [self.delegate respondsToSelector:@selector(pieChart:didSelectSliceAtIndex:)])
		{
			[self.delegate pieChart:self didSelectSliceAtIndex:i];
			result = sliceView;
		}
	}

	return result;
}

/**
 * When a label is tapped, we pop his slice.
 */
- (void)labelTapped:(id)sender
{
	UITapGestureRecognizer *gesture = (UITapGestureRecognizer *)sender;
	UIView *view = gesture.view;

	if ([self.delegate respondsToSelector:@selector(pieChart:didSelectSliceAtIndex:)])
	{
		[self.delegate pieChart:self didSelectSliceAtIndex:view.tag];
	}
}

/**************************************************************************/
#pragma mark - Change slice

/**
 * This method is called to change the layout of a tapped slice.
 */
- (void)changeCurrentSliceWith:(OTSliceView *)selectedSlice
{
    [self deselectAllSlices];
    
	if (selectedSlice != nil && !selectedSlice.isSelected)
	{
		[selectedSlice movetoFront];
		selectedSlice.isSelected = YES;
	}
}

- (void)deselectAllSlices
{
    for (OTSliceView *currentSlice in self.sliceLayerList)
    {
        [currentSlice bringToBackIfSelected];
    }
}

/**************************************************************************************************/
#pragma mark - Collision

+ (BOOL)label:(UILabel *)firstLabel isInCollisionWithLabel:(UILabel *)secondLabel
{
	return CGRectIntersectsRect(firstLabel.frame, secondLabel.frame);
}

/**
 * This method determine if a Label frame goes outside of the pie chart frame
 */
- (BOOL)isInCollisionWithLabel:(UILabel *)label
{
	CGRect labelFrame = [self convertRect:label.frame toView:self.superview];

	return !CGRectContainsRect(self.frame, labelFrame) &&
		   CGRectIntersectsRect(self.frame, labelFrame);
}

/**************************************************************************************************/
#pragma mark - Slice defautl value

- (CGFloat)sliceSeparation
{
    CGFloat value = SLICE_SEPARATION;
    if ([self.delegate respondsToSelector:@selector(sliceSeparationForPieChart:)])
    {
        value = [self.delegate sliceSeparationForPieChart:self];
    }
    
    return value;
}

- (CGFloat)sliceInnerRadius
{
    CGFloat value = INNER_RADIUS;
    if ([self.delegate respondsToSelector:@selector(innerRadiusForPieChart:)])
    {
        value = [self.delegate innerRadiusForPieChart:self];
    }
    
    return value;
}

- (CGFloat)sliceOuterRadius
{
    CGFloat value = OUTER_RADIUS;
    if ([self.delegate respondsToSelector:@selector(outerRadiusForPieChart:)])
    {
        value = [self.delegate outerRadiusForPieChart:self];
    }
    
    return value;
}

- (BOOL)shouldDisplayLegendInsideSlice
{
    BOOL isLegendDisplayInsideSlice = DISPLAY_LEGEND_INSIDE_SLICE;
    if ([self.delegate respondsToSelector:@selector(shouldDisplayLegendInSliceForPieChart:)])
    {
        isLegendDisplayInsideSlice = [self.delegate shouldDisplayLegendInSliceForPieChart:self];
    }
    
    return isLegendDisplayInsideSlice;
}

@end