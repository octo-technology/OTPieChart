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
 * KBOTPieChartViewTests implementation
 */

#import "OTPieChartViewTests.h"

@interface OTPieChartView ()

- (void)addLegendsToView;

+ (BOOL)label:(UILabel *)firstLabel isInCollisionWithLabel:(UILabel *)secondLabel;
- (BOOL)isInCollisionWithLabel:(UILabel *)label;

@end

@implementation OTPieChartViewTests

/**************************************************************************************************/
#pragma mark - Getters & Setters

@synthesize superView;
@synthesize pieChart;
@synthesize slice1;
@synthesize slice2;
@synthesize slice3;
@synthesize slice4;
@synthesize conflictSliceWith4;

/**************************************************************************************************/
#pragma mark - Birth & Death

- (void)setUp {
	[super setUp];

	self.superView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1000, 1000)];
	self.pieChart = [[OTPieChartView alloc] initWithFrame:CGRectMake(0, 0, 400, 400)];
	[self.superView addSubview:self.pieChart];
	self.slice1 = [[OTSliceView alloc] init];
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
	self.slice1.titleLabel = label;
	self.slice1.sliceAngle = 10;

	self.slice2 = [[OTSliceView alloc] init];
	self.slice2.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 20, 20)];
	self.slice2.sliceAngle = 20;

	self.slice3 = [[OTSliceView alloc] init];
	self.slice3.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 20, 20, 20)];
	self.slice3.sliceAngle = 23;

	self.slice4 = [[OTSliceView alloc] init];
	self.slice4.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, 20, 20)];
	self.slice4.sliceAngle = 26;

	self.conflictSliceWith4 = [[OTSliceView alloc] init];
	self.conflictSliceWith4.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(19, 19, 20, 20)];
	self.conflictSliceWith4.sliceAngle = 30;



	self.pieChart.sliceLayerList = [NSMutableArray arrayWithObjects:slice1, slice2, conflictSliceWith4, nil];
}

- (void)tearDown {
	self.superView = nil;
	self.pieChart = nil;
	self.slice1 = nil;
	self.slice2 = nil;
	self.slice3 = nil;
	self.slice4 = nil;
	self.conflictSliceWith4 = nil;


	[super tearDown];
}

/**************************************************************************************************/
#pragma mark - test addLegendsToView:(NSArray *)legendLabels

- (void)testAddLegendsToView_with_Nil_return_NoView {
	// GIVEN
	self.pieChart.sliceLayerList = nil;

	// WHEN
	[self.pieChart addLegendsToView];

	// THEN
	NSUInteger subviewsCount = self.pieChart.subviews.count;

	XCTAssertTrue([[NSNumber numberWithInt:subviewsCount] isEqualToNumber:[NSNumber numberWithInt:0]]);
}

- (void)testAddLegendsToView_with_NoObject_return_NoView {
	// GIVEN
	self.pieChart.sliceLayerList = [NSArray array];

	// WHEN
	[self.pieChart addLegendsToView];

	// THEN
	NSUInteger subviewsCount = self.pieChart.subviews.count;

	XCTAssertTrue([[NSNumber numberWithInt:subviewsCount] isEqualToNumber:[NSNumber numberWithInt:0]]);
}

- (void)testAddLegendToView_with_OneView_return_One_View {
	// GIVEN
	self.pieChart.sliceLayerList = [NSArray arrayWithObject:self.slice1];

	// WHEN
	[self.pieChart addLegendsToView];

	// THEN
	NSUInteger subviewsCount = self.pieChart.subviews.count;

	XCTAssertTrue([[NSNumber numberWithInt:subviewsCount] isEqualToNumber:[NSNumber numberWithInt:1]]);
}

- (void)testAddLegendToView_with_twoViews_return_two_View {
	// GIVEN
	self.pieChart.sliceLayerList = [NSArray arrayWithObjects:self.slice1, self.slice2, nil];

	//WHEN
	[self.pieChart addLegendsToView];

	// THEN
	XCTAssertTrue([self.slice1.titleLabel isDescendantOfView:self.pieChart]);
	XCTAssertTrue([self.slice2.titleLabel isDescendantOfView:self.pieChart]);
}

- (void)testAddLegendToView_with_twoViews_Colision_return_one_View {
	// GIVEN

	self.pieChart.sliceLayerList = [NSArray arrayWithObjects:self.slice1, self.conflictSliceWith4, nil];

	//WHEN
	[self.pieChart addLegendsToView];

	// THEN
	XCTAssertFalse([self.slice1.titleLabel isDescendantOfView:self.pieChart]);
	XCTAssertTrue([self.conflictSliceWith4.titleLabel isDescendantOfView:self.pieChart]);
}

- (void)testAddLegendToView_with_threeViews_In_Colision_return_one_View {
	// GIVEN
	self.pieChart.sliceLayerList = [NSArray arrayWithObjects:self.slice2, self.conflictSliceWith4, self.slice1, nil];

	// WHEN
	[self.pieChart addLegendsToView];

	// THEN
	XCTAssertFalse([self.slice1.titleLabel isDescendantOfView:self.pieChart]);
	XCTAssertFalse([self.slice2.titleLabel isDescendantOfView:self.pieChart]);
	XCTAssertTrue([self.conflictSliceWith4.titleLabel isDescendantOfView:self.pieChart]);
}

- (void)testAddLegendToView_with_5_Views_In_Colision_return_3_View {
	// GIVEN
	self.pieChart.sliceLayerList = [NSArray arrayWithObjects:self.slice4, self.slice3, self.slice2, self.conflictSliceWith4, self.slice1, nil];

	// WHEN
	[self.pieChart addLegendsToView];

	// THEN
	XCTAssertFalse([self.slice1.titleLabel isDescendantOfView:self.pieChart]);
	XCTAssertFalse([self.slice2.titleLabel isDescendantOfView:self.pieChart]);
	XCTAssertTrue([self.conflictSliceWith4.titleLabel isDescendantOfView:self.pieChart]);
	XCTAssertTrue([self.slice3.titleLabel isDescendantOfView:self.pieChart]);
	XCTAssertTrue([self.slice4.titleLabel isDescendantOfView:self.pieChart]);
}

- (void)testAddLegendToView_with_4_Views_In_Colision_return_3_View {
	// GIVEN
	self.pieChart.sliceLayerList = [NSArray arrayWithObjects:self.slice4, self.slice3, self.slice2, self.conflictSliceWith4, nil];

	// WHEN
	[self.pieChart addLegendsToView];

	// THEN
	XCTAssertFalse([self.slice2.titleLabel isDescendantOfView:self.pieChart]);
	XCTAssertTrue([self.conflictSliceWith4.titleLabel isDescendantOfView:self.pieChart]);
	XCTAssertTrue([self.slice3.titleLabel isDescendantOfView:self.pieChart]);
	XCTAssertTrue([self.slice4.titleLabel isDescendantOfView:self.pieChart]);
}

/**************************************************************************************************/
#pragma mark - test Label:isInCollisionWithLabel:

- (void)testLabelisInCollisionWithLabelWithNilAndNIlReturnNo {
	BOOL isInCollision = NO;
	// WHEN
	isInCollision = [OTPieChartView label:nil isInCollisionWithLabel:nil];

	// THEN
	XCTAssertFalse(isInCollision);
}

- (void)testLabelisInCollisionWithLabelWithZeroFrameAndNIlReturnNo {
	// WHEN
	UILabel *firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
	UILabel *secondLabel = nil;

	BOOL isInCollision = [OTPieChartView label:firstLabel
	                                                 isInCollisionWithLabel:secondLabel];

	// THEN
	XCTAssertFalse(isInCollision);
}

- (void)testLabelisInCollisionWithLabelWithZeroFramesReturnNo {
	// WHEN
	UILabel *firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
	UILabel *secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
	BOOL isInCollision = [OTPieChartView label:firstLabel
	                                                 isInCollisionWithLabel:secondLabel];

	// THEN
	XCTAssertFalse(isInCollision);
}

- (void)testLabelisInCollisionWithLabelWithNormalFrameAndNIlReturnNo {
	// WHEN
	UILabel *firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
	UILabel *secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 20, 20)];
	BOOL isInCollision = [OTPieChartView label:firstLabel
	                                                 isInCollisionWithLabel:secondLabel];

	// THEN
	XCTAssertFalse(isInCollision);
}

- (void)testLabelisInCollisionWithLabelWithNormalFrameIntersectAndNIlReturnYES {
	// WHEN
	UILabel *firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
	UILabel *secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(19, 19, 20, 20)];
	BOOL isInCollision = [OTPieChartView label:firstLabel
	                                                 isInCollisionWithLabel:secondLabel];

	// THEN
	XCTAssertTrue(isInCollision);
}

/**************************************************************************************************/
#pragma mark - test isInCollisionWithLabel

- (void)testIsInCollisionWithLabelNilReturnNO {
	// GIVEN
	UILabel *label = nil;
	[self.pieChart addSubview:label];

	// WHEN
	BOOL result = [self.pieChart isInCollisionWithLabel:label];

	// THEN
	XCTAssertFalse(result);
}

- (void)testIsInCollisionWithLabel_NotInCollision_ReturnNO {
	// GIVEN
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(-60, 0, 30, 30)];
	[self.pieChart addSubview:label];

	// WHEN
	BOOL result = [self.pieChart isInCollisionWithLabel:label];

	// THEN
	XCTAssertFalse(result);
}

- (void)testIsInCollisionWithLabel_inCollision_ReturnYES {
	// GIVEN
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(-10, 0, 30, 30)];
	[self.pieChart addSubview:label];

	// WHEN
	BOOL result = [self.pieChart isInCollisionWithLabel:label];

	// THEN
	XCTAssertTrue(result);
}

- (void)testIsInCollisionWithLabel_inCollisionForOneLine_ReturnNO {
	// GIVEN
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 30, 30)];
	[self.pieChart addSubview:label];


	// WHEN
	BOOL result = [self.pieChart isInCollisionWithLabel:label];

	// THEN
	XCTAssertFalse(result);
}

- (void)testIsInCollisionWithLabel_inCollisionForOnePixek_ReturnYES {
	// GIVEN
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(-1, 10, 30, 30)];
	[self.pieChart addSubview:label];

	// WHEN
	BOOL result = [self.pieChart isInCollisionWithLabel:label];

	// THEN
	XCTAssertTrue(result);
}

- (void)testIsInCollisionWithLabel_contained_ReturnNO {
	// GIVEN
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
	[self.pieChart addSubview:label];

	// WHEN
	BOOL result = [self.pieChart isInCollisionWithLabel:label];

	// THEN
	XCTAssertFalse(result);
}

- (void)testIsInCollisionWithLabelNil_PieOriginNotZero_ReturnNO {
	// GIVEN
	UILabel *label = nil;
	[self.pieChart addSubview:label];
	[self.pieChart setFrame:CGRectMake(20, 20, 400, 400)];

	// WHEN
	BOOL result = [self.pieChart isInCollisionWithLabel:label];

	// THEN
	XCTAssertFalse(result);
}

- (void)testIsInCollisionWithLabel__PieOriginNotZero_NotInCollision_ReturnNO {
	// GIVEN
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(-60, 0, 30, 30)];
	[self.pieChart addSubview:label];
	[self.pieChart setFrame:CGRectMake(20, 20, 400, 400)];

	// WHEN
	BOOL result = [self.pieChart isInCollisionWithLabel:label];

	// THEN
	XCTAssertFalse(result);
}

- (void)testIsInCollisionWithLabel__PieOriginNotZero_NotinCollision_ReturnNO {
	// GIVEN
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
	[self.pieChart addSubview:label];
	[self.pieChart setFrame:CGRectMake(20, 20, 400, 400)];

	// WHEN
	BOOL result = [self.pieChart isInCollisionWithLabel:label];

	// THEN
	XCTAssertFalse(result);
}

- (void)testIsInCollisionWithLabel__PieOriginNotZero_inCollisionForOneLine_ReturnNO {
	// GIVEN
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 30, 30)];
	[self.pieChart setFrame:CGRectMake(20, 20, 400, 400)];

	// WHEN
	BOOL result = [self.pieChart isInCollisionWithLabel:label];

	// THEN
	XCTAssertFalse(result);
}

- (void)testIsInCollisionWithLabel__PieOriginNotZero_inCollisionForOnePixek_ReturnYES {
	// GIVEN
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(-1, 10, 30, 30)];
	[self.pieChart addSubview:label];
	[self.pieChart setFrame:CGRectMake(20, 20, 400, 400)];

	// WHEN
	BOOL result = [self.pieChart isInCollisionWithLabel:label];

	// THEN
	XCTAssertTrue(result);
}

- (void)testIsInCollisionWithLabel__PieOriginNotZero_contained_ReturnNO {
	// GIVEN
	[self.pieChart setFrame:CGRectMake(20, 20, 400, 400)];
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
	[self.pieChart addSubview:label];


	// WHEN
	BOOL result = [self.pieChart isInCollisionWithLabel:label];

	// THEN
	XCTAssertFalse(result);
}

- (void)testIsInCollisionWithLabel__PieOriginNotZero_leftCollision_ReturnYES {
	// GIVEN
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(370, 100, 50, 30)];
	[self.pieChart addSubview:label];
	[self.pieChart setFrame:CGRectMake(20, 20, 400, 400)];

	// WHEN
	BOOL result = [self.pieChart isInCollisionWithLabel:label];

	// THEN
	XCTAssertTrue(result);
}

@end
