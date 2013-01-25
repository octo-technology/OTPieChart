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
 * OTSliceView implementation
 */

#import "OTSliceView.h"

// 3 is the minimum value for the inner radius
#define INNER_RADIUS_MIN_VALUE 3.

#define FONT_SIZE 15.
#define X_OFFSET_TEXT 12.
#define Y_OFFSET_TEXT 2.
#define TOUCH_DEPTH_VALUE 425.0f

@interface OTSliceView()

- (NSComparisonResult)compareByAngle:(OTSliceView *)sliceToCompare;

@end

@implementation OTSliceView

/**************************************************************************/
#pragma mark - Getters and Setters

@synthesize titleLabel;

@synthesize startAngle;
@synthesize sliceAngle;
@synthesize sliceColor;
@synthesize title;
@synthesize innerRadius;
@synthesize outerRadius;
@synthesize sliceSeparation;
@synthesize slicePath;
@synthesize isSelected;
@synthesize shouldDisplayGradient;
@synthesize shouldDisplayLegendInsideSlice;
@synthesize titleLabelIsInConflict;

- (void)setInnerRadius:(CGFloat)newInnerRadius
{
	if (newInnerRadius >= INNER_RADIUS_MIN_VALUE)
	{
		innerRadius = newInnerRadius;
	}
}

/**************************************************************************************************/
#pragma mark - Birth

- (id)init
{
	self = [super init];
	if (self)
	{
		shouldDisplayLegendInsideSlice = DISPLAY_LEGEND_INSIDE_SLICE;
		innerRadius = INNER_RADIUS_MIN_VALUE;
	}
	return self;
}

/**************************************************************************/
#pragma mark - manage animation pie chart

- (void)drawInContext:(CGContextRef)context
{
	CGMutablePathRef path = CGPathCreateMutable();
	CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));

	// Compute the different angles according to the separation
	CGFloat angle1 = startAngle;
	CGFloat angle2 = startAngle;
	CGFloat angle3 = startAngle + sliceAngle;
	CGFloat angle4 = startAngle + sliceAngle;

	CGFloat alpha1 = 2 * asinf(self.sliceSeparation / (2 * self.innerRadius));
	CGFloat alpha2 = 2 * asinf(self.sliceSeparation / (2 * self.outerRadius));

	angle1 += alpha1;
	angle2 += alpha2;
	angle3 -= alpha2;
	angle4 -= alpha1;

	CGFloat midAngle = startAngle + sliceAngle / 2;
	if (angle4 < angle1)
	{
		angle1 = angle4 = startAngle + sliceAngle / 2;
	}
	if (angle3 < angle2)
	{
		angle2 = angle3 = startAngle + sliceAngle / 2;
	}


	// First segment
	float x = center.x + innerRadius * cosf(angle1);
	float y = center.y + innerRadius * sinf(angle1);
	CGPathMoveToPoint(path, NULL, x, y);

	x = center.x + outerRadius * cosf(angle2);
	y = center.y + outerRadius * sinf(angle2);
	CGPathAddLineToPoint(path, NULL, x, y);

	// Outer arc
	CGPathAddArc(path, NULL, center.x, center.y, outerRadius, angle2, angle3, false);

	// Second segment
	x = center.x + cosf(angle4) * innerRadius;
	y = center.y + sinf(angle4) * innerRadius;
	CGPathAddLineToPoint(path, NULL, x, y);

	// Inner arc
	CGPathAddArc(path, NULL, center.x, center.y, innerRadius, angle4, angle1, true);

	// Fill the path to get a shadow
	// CGContextSetShadowWithColor(context, CGSizeMake(1, -2), 11, [UIColor colorWithWhite:0.2 alpha:1].CGColor);
	CGContextSetFillColorWithColor(context, sliceColor.CGColor);
	CGContextAddPath(context, path);
	CGContextFillPath(context);

	// Gradient
	CGContextSaveGState(context);

	CGContextAddPath(context, path);
	CGContextClip(context);


	if (self.shouldDisplayGradient)
	{
		CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
		const CGFloat *gradientColor = CGColorGetComponents(sliceColor.CGColor);

		CGFloat components[8] = { gradientColor[0], gradientColor[1], gradientColor[2], gradientColor[3],
								  gradientColor[0] - 0.2, gradientColor[1] - 0.2, gradientColor[2] - 0.2, gradientColor[3] };
		CGFloat locations[2] = { 0.0, 1.0 };
		CGGradientRef gradient = CGGradientCreateWithColorComponents(space, components, locations, 2);

		CGContextDrawRadialGradient(context, gradient, center, innerRadius, center, outerRadius, 0);
		CGGradientRelease(gradient);
		CGColorSpaceRelease(space);
	}

	slicePath = CGPathCreateCopy(path);
	CGPathRelease(path);
	CGContextRestoreGState(context);

	// Legend in slice
	if (title && shouldDisplayLegendInsideSlice)
	{
		CGContextSelectFont(context, "Helvetica-Bold", FONT_SIZE, kCGEncodingMacRoman);
		CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
		CGAffineTransform transform = CGAffineTransformMake(1, 0, 0, -1, 0, 0);
		CGContextSetTextMatrix(context, transform);
		const char *text = [title cStringUsingEncoding:NSMacOSRomanStringEncoding];

		float xText = center.x + cosf(midAngle) * (self.innerRadius + (self.outerRadius - self.innerRadius) / 2) - X_OFFSET_TEXT;
		float yText = center.y + sinf(midAngle) * (self.innerRadius + (self.outerRadius - self.innerRadius) / 2) + Y_OFFSET_TEXT;
		CGContextShowTextAtPoint(context, xText, yText, text, strlen(text));
	}
}

/**************************************************************************/
#pragma mark - manage animation pie chart

- (void)movetoDepth:(CGFloat)depth
{
	CATransform3D transform = CATransform3DIdentity;

	transform.m34 = 1.0 / -2000;
	self.transform = transform;

	NSNumber *value = [NSNumber numberWithFloat:depth];
	[self setValue:value forKeyPath:@"transform.translation.z"];
}

- (void)movetoFront
{
	[self movetoDepth:TOUCH_DEPTH_VALUE];
}

- (void)bringToBackIfSelected
{
	if (self.isSelected)
	{
		[self movetoDepth:0.0f];
		self.isSelected = NO;
	}
}

/**************************************************************************************************/
#pragma mark - Legend Dot

/**
 * This method return the dot on the Top of the slice, at the midAngle. Most of the time, we use this method to place
 * the legend outside of the Slice. We can give an offset if we want.
 */
- (CGPoint)computeTopOfSliceDotWithOffset:(CGFloat)offset
{
	CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
	CGFloat midAngle = [self retrieveAngleOfSlice];

	CGFloat xText = center.x + cosf(midAngle) * (self.outerRadius + offset);
	CGFloat yText = center.y + sinf(midAngle) * (self.outerRadius + offset);

	return CGPointMake(xText, yText);
}

- (CGFloat)retrieveAngleOfSlice
{
	CGFloat midAngle = startAngle + sliceAngle / 2;

	return midAngle;
}

/**************************************************************************************************/
#pragma mark - Description

- (NSString *)description
{
	return [NSString stringWithFormat:@"%@ conflict : %d  title label : %@ slice angle : %f",
			self.title,
			titleLabelIsInConflict,
			titleLabel,
			sliceAngle];
}

/**************************************************************************************************/
#pragma mark - Utils

/**
 * This method sort the givenList of OTSliceView from the minimum slice angle, to the maximum.
 */
+ (NSArray *)sortSliceLayerListBySliceAngle:(NSArray *)givenList
{
	NSArray *result = nil;

	if ([givenList isKindOfClass:[NSArray class]] && givenList.count > 0)
	{
		result = [givenList sortedArrayUsingSelector:@selector(compareByAngle:)];
	}

	return result;
}

/**
 * This method retrieve a SliceView with the minimum slice angle with a title in conflict of the given list
 */
+ (OTSliceView *)retrieveSliceViewWithSmallestSliceAngleFromList:(NSArray *)givenList
{
	OTSliceView *result = nil;
	CGFloat min = MAXFLOAT;

	if ([givenList isKindOfClass:[NSArray class]] && givenList.count > 0)
	{
		for (OTSliceView *slice in givenList)
		{
			if (min > slice.sliceAngle && slice.titleLabelIsInConflict)
			{
				min = slice.sliceAngle;
				result = slice;
			}
		}
	}
	return result;
}

/**************************************************************************************************/
#pragma mark - Compare

- (NSComparisonResult)compareByAngle:(OTSliceView *)sliceToCompare
{
	NSNumber *selfNumber = [NSNumber numberWithFloat:self.sliceAngle];
	NSNumber *numberToCompare = [NSNumber numberWithFloat:sliceToCompare.sliceAngle];

	return [selfNumber compare:numberToCompare];
}

@end