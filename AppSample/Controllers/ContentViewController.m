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
 * ContentViewController implementation
 */

#import "ContentViewController.h"

#import "OTSlice.h"

@implementation ContentViewController

/**************************************************************************************************/
#pragma mark - Getters & Setters

@synthesize slices;
@synthesize pie;
@synthesize values;
@synthesize colors;
@synthesize labels;

/**************************************************************************************************/
#pragma mark - View Management

- (void)viewDidLoad {
	[super viewDidLoad];

	self.slices = [[NSMutableArray alloc] init];

	for (int i = 0; i < self.values.count; i++) {
		CGFloat value = [[self.values objectAtIndex:i] floatValue];
		UIColor *color = [self.colors objectAtIndex:i];

		NSString *label = nil;

		if (!self.labels) {
			label = [NSString stringWithFormat:@"Value : %.2f %%", value * 100];
		}
		else {
			label = [self.labels objectAtIndex:i];
		}
		OTSlice *slice = [[OTSlice alloc] initWithLabel:label percentageValue:value color:color];
		[self.slices addObject:slice];
	}

	self.pie = [[OTPieChartView alloc] initWithFrame:self.view.frame];
	CGPoint center = self.view.center;
	center = CGPointMake(floor(center.x), floor(center.y));
	[self.pie setCenter:center];
	self.pie.delegate = self;
	self.pie.datasource = self;
	[self.view addSubview:pie];

	[self.pie loadPieChart];
}

- (void)viewDidUnload {
	[super viewDidUnload];
}

/**************************************************************************************************/
#pragma mark - OTPieChartDatasource

- (NSUInteger)numbertOfSliceForPieChartIndex:(OTPieChartView *)thePieChart {
	return self.slices.count;
}

- (CGFloat)pieChart:(OTPieChartView *)thePieChart getPercentageValue:(NSUInteger)pieChartIndex {
	if ([slices count] > pieChartIndex) {
		OTSlice *slice = [self.slices objectAtIndex:pieChartIndex];
		return slice.percentageValue;
	}
	else {
		return 0.0;
	}
}

- (UIColor *)pieChart:(OTPieChartView *)thePieChart getSliceColor:(NSUInteger)pieChartIndex {
	if ([slices count] > pieChartIndex) {
		OTSlice *slice = [self.slices objectAtIndex:pieChartIndex];
		return slice.color;
	}
	else {
		return nil;
	}
}

- (NSString *)pieChart:(OTPieChartView *)thePieChart getSliceLabel:(NSUInteger)pieChartIndex {
	OTSlice *slice = [self.slices objectAtIndex:pieChartIndex];

	return slice.title;
}

- (UIView *)pieChart:(OTPieChartView *)thePieChart getView:(NSUInteger)pieChartIndex {
	OTSlice *slice = [self.slices objectAtIndex:pieChartIndex];

	return slice.view;
}

/**************************************************************************************************/
#pragma mark - OTPieChartDelegate

- (CGFloat)outerRadiusForPieChart:(OTPieChartView *)thePieChart {
	return 200.;
}

- (void)pieChart:(OTPieChartView *)thePieChart didSelectSliceAtIndex:(NSUInteger)pieChartIndex {
	DLog(@"pie clicked : %lu", (unsigned long)pieChartIndex);
}

@end
