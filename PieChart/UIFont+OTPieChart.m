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
 * UIFont+OTPieChart implementation
 */

#import "UIFont+OTPieChart.h"

static NSString * const kFontName = @"HelveticaNeue-CondensedBold";
static const CGFloat kFontSize = 12.;

@implementation UIFont(OTPieChart)

+ (UIFont *)defaultFont
{
    return [UIFont fontWithName:kFontName size:kFontSize];
}

@end
