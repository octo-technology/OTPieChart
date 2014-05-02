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
 * OTSlice implementation
 */

#import "OTSlice.h"

@implementation OTSlice

/**************************************************************************/
#pragma mark - Getters and Setters

@synthesize title;
@synthesize color;
@synthesize percentageValue;

/**************************************************************************/
#pragma mark - Birth

- (id)initWithLabel:(NSString *)aLabel
	percentageValue:(CGFloat)aPercentageValue
			  color:(UIColor *)aColor
{
	if (self = [super init])
	{
		title = aLabel;
		percentageValue = aPercentageValue;
		color = aColor;
	}
	return self;
}

/**************************************************************************************************/
#pragma mark - Description

- (NSString *)description
{
	return [NSString stringWithFormat:@"Slice [\r\
            title : %@\r\
            percentage : %f]", self.title, self.percentageValue];
}

@end
