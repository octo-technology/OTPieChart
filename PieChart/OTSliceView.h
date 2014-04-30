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
//  OTSliceView.h
//  OTSliceView
//
//  Created by RVI.
//  Copyright (C) 2013, OCTO Technology. All rights reserved.
//


#import <QuartzCore/QuartzCore.h>

#define DISPLAY_LEGEND_INSIDE_SLICE NO

/**
 * A slice view of a pie chart.
 */
@interface OTSliceView : CALayer

/**************************************************************************/
#pragma mark - Getters and Setters

// UI
/** @name UI Properties */

/** Title dislpayed along with the slice. */
@property (nonatomic, strong) UIView *titleView;

// Data
/** @name Data Properties */

/** Color used to display the slice. */
@property (nonatomic, strong) UIColor *sliceColor;
/** Title. */
@property (nonatomic, strong) NSString *title;
/** Starting angle in the PieChart. */
@property (nonatomic, assign) CGFloat startAngle;
/** Angle of the slice. */
@property (nonatomic, assign) CGFloat sliceAngle;
/** Inner radius. */
@property (nonatomic, assign) CGFloat innerRadius;
/** Outer radius. */
@property (nonatomic, assign) CGFloat outerRadius;
/** Thickness of the separation of the slice between others. */
@property (nonatomic, assign) CGFloat sliceSeparation;
/** Path of the slice. */
@property (nonatomic, assign) CGPathRef slicePath;
/** Return the selected status of the slice. */
@property (nonatomic, assign) BOOL isSelected;
/** Switch the slice view to a gradient mode. */
@property (nonatomic, assign) BOOL shouldDisplayGradient;
/** Switch legend display in or out the slice. */
@property (nonatomic, assign) BOOL shouldDisplayLegendInsideSlice;
/** Return the states of conflict between the title and the label. */
@property (nonatomic, assign) BOOL titleViewIsInConflict;

/**************************************************************************/
#pragma mark - manage animation pie chart

/** @name Manage animation pie chart */

/**
 * @param depth
 */
- (void)movetoDepth:(CGFloat)depth;
/**
 */
- (void)movetoFront;
/**
 */
- (void)bringToBackIfSelected;


/**************************************************************************************************/
#pragma mark - Legend Dot

/** @name Legend Dot */

/**
 * @param offset
 * @return
 */
- (CGPoint)computeTopOfSliceDotWithOffset:(CGFloat)offset;
/**
 * @return
 */
- (CGFloat)retrieveAngleOfSlice;

/**************************************************************************************************/
#pragma mark - Utils

/** @name Utils */

/**
 * @param givenList
 * @return
 */
+ (NSArray *)sortSliceLayerListBySliceAngle:(NSArray *)givenList;
/**
 * @param givenList
 * @return
 */
+ (OTSliceView *)retrieveSliceViewWithSmallestSliceAngleFromList:(NSArray *)givenList;

@end
