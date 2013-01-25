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
 * This controller is the parent of all the Pie'N'ViewController. It display a pie Chart.
 */

#import "OTPieChartView.h"

// For creating colors with RGB values
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface ContentViewController : UIViewController<OTPieChartDelegate,OTPieChartDataSource>

/**************************************************************************************************/
#pragma mark - Getters & Setters

@property (nonatomic, strong) NSMutableArray        *slices;
@property (nonatomic, strong) NSArray               *colors;
@property (nonatomic, strong) NSArray               *values;
@property (nonatomic, strong) NSArray               *labels;

@property (nonatomic, strong) OTPieChartView         *pie;

@end
