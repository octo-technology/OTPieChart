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
 * Test the OTPieChartView class
 */

#import <SenTestingKit/SenTestingKit.h>

#import "OTPieChartView.h"

@interface OTPieChartViewTests : SenTestCase

@property (nonatomic, strong) OTPieChartView    *pieChart;

@property (nonatomic, strong) UIView            *superView;
@property (nonatomic, strong) OTSliceView       *slice1;
@property (nonatomic, strong) OTSliceView       *slice2;
@property (nonatomic, strong) OTSliceView       *slice3;
@property (nonatomic, strong) OTSliceView       *slice4;
@property (nonatomic, strong) OTSliceView       *conflictSliceWith4;

@end
