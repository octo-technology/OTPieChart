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
//  OTSlice.h
//  OTSlice
//
//  Created by RVI.
//  Copyright (C) 2013, OCTO Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * This class is the model of a slice.
 */
@interface OTSlice : NSObject

/**************************************************************************/
#pragma mark - Getters and Setters 

/** @name Properties */

/** Slice title */
@property (nonatomic, strong) NSString  *title;
/** Value related to the slice in percent.
 *
 * Authorized: 0.0 < value < 1.0.
 */
@property (nonatomic, assign) CGFloat   percentageValue;
/** Color used to display the slice. */
@property (nonatomic, strong) UIColor   *color;

/**************************************************************************/
#pragma mark - Birth

/** @name Creating a Slice */

/**
 * Create a new slice.
 * @param label Label appearing on the slice.
 * @param percentageValue Percent associated to the slice.
 * @param color Color of the slice.
 */
- (id)initWithLabel:(NSString *)label 
    percentageValue:(CGFloat)percentageValue 
              color:(UIColor *)color; 

@end
