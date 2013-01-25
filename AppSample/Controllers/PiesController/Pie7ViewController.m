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
 * Pie7ViewController implementation
 */

#import "Pie7ViewController.h"

@implementation Pie7ViewController


/**************************************************************************************************/
#pragma mark - Birth

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:@"ContentViewController" bundle:nibBundleOrNil];
	if (self)
	{
		self.values = [NSArray arrayWithObjects:
					   [NSNumber numberWithFloat:0.10],
					   [NSNumber numberWithFloat:0.1],
					   [NSNumber numberWithFloat:0.1],
					   [NSNumber numberWithFloat:0.10],
					   [NSNumber numberWithFloat:0.10],
					   [NSNumber numberWithFloat:0.1],
					   [NSNumber numberWithFloat:0.1],
					   [NSNumber numberWithFloat:0.10],
					   [NSNumber numberWithFloat:0.1],
					   [NSNumber numberWithFloat:0.1],
					   nil];

		self.colors = [NSArray arrayWithObjects:
					   UIColorFromRGB(0x1a4ada),
					   UIColorFromRGB(0x3d40be),
					   UIColorFromRGB(0x6035a3),
					   UIColorFromRGB(0x832b87),
					   UIColorFromRGB(0xa6206c),
					   UIColorFromRGB(0xc91650),
					   UIColorFromRGB(0xec0b35),
					   UIColorFromRGB(0xea5601),
					   UIColorFromRGB(0xfeb003),
					   UIColorFromRGB(0xeacb01),
					   nil];


		NSMutableArray *mutableLabels = [NSMutableArray array];

		for (NSNumber *number in self.values)
		{
			NSString *string = [NSString stringWithFormat:@"%.0f %%", [number floatValue] * 100];
			[mutableLabels addObject:string];
		}

		self.labels = [NSArray arrayWithArray:mutableLabels];
	}
	return self;
}


/**************************************************************************************************/
#pragma mark - OTPieChartDelegate

- (BOOL)shouldDisplayLegendInSliceForPieChart:(OTPieChartView *)thePieChart
{
	return YES;
}

@end