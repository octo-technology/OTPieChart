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

//
//  OTPieChartView.h
//  OTPieChart
//
//  Created by RVI.
//  Copyright (C) 2013, OCTO Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
// View
#import "OTSliceView.h"

@class OTPieChartView;

/**************************************************************************************************/
#pragma mark - OTPieChartDelegate

/**
 * Protocol called by the PieChartView to retrieve display infos about the PieChart display and alert of events.
 */
@protocol OTPieChartDelegate<NSObject>

@optional

/**
 * Tells the delegate when a slice is tapped
 */
- (void)pieChart:(OTPieChartView *)thePieChart didSelectSliceAtIndex:(NSUInteger)pieChartIndex;

/**
 * Implement this method if you want to display legend in the slices and return YES.
 */
- (BOOL)shouldDisplayLegendInSliceForPieChart:(OTPieChartView *)thePieChart;

/**
 * Implement this method to define the separation between 2 slices. Default value is 5.
 */
- (CGFloat)sliceSeparationForPieChart:(OTPieChartView *)thePieChart;

/**
 * Implement this method to define the font of the labels. Default value is Helvetica Neue Condensed Bold, size: 12.
 */
- (UIFont *)fontLegendForPieChart:(OTPieChartView *)thePieChart;

/**
 * Implement this method to define the text color of the labels. Default value is white.
 */
- (UIColor *)textColorForPieChart:(OTPieChartView *)thePieChart;

/**
 * Implement this method to define the inner radius of the pie chart. Default value is 60.
 */
- (CGFloat)innerRadiusForPieChart:(OTPieChartView *)thePieChart;

/**
 * Implement this method to define the outer radius of the pie chart. Default value is 140.
 */
- (CGFloat)outerRadiusForPieChart:(OTPieChartView *)thePieChart;

@end


/**************************************************************************************************/
#pragma mark - OTPieChartDataSource

/**
 * Protocol called by the PieChartView to retrieve data infos about the PieChart.
 */
@protocol OTPieChartDataSource<NSObject>

@required

/**
 * Asks the datasource the number of slices must be drawn.
 */
- (NSUInteger)numbertOfSliceForPieChartIndex:(OTPieChartView *)thePieChart;

/**
 * Asks the datasource the percentage of the given slice index.
 */
- (CGFloat)pieChart:(OTPieChartView *)thePieChart getPercentageValue:(NSUInteger)pieChartIndex;

/**
 * Asks the datasource the color of the given slice index.
 */
- (UIColor *)pieChart:(OTPieChartView *)thePieChart getSliceColor:(NSUInteger)pieChartIndex;

@optional

/**
 * Asks the datasource the legend to display of the given slice index.
 */
- (NSString *)pieChart:(OTPieChartView *)thePieChart getSliceLabel:(NSUInteger)pieChartIndex;

@end

/**
 * PieChart view.
 */
@interface OTPieChartView : UIView

/**************************************************************************/
#pragma mark - Getters and Setters

/** @name Properties */

/** Delegate of the the PieChart view. */
@property (nonatomic, assign) id<OTPieChartDelegate>    delegate;
/** Datasource fo the PieChart view. */
@property (nonatomic, assign) id<OTPieChartDataSource>  datasource;
/** Array of OTSlice object. */
@property (nonatomic, strong) NSMutableArray *sliceLayerList;

/**************************************************************************/
#pragma mark - Load Pie Chart

/** @name Load Pie Chart */

/**
 * Load and display PieChart view.
 */
- (void)loadPieChart;

@end