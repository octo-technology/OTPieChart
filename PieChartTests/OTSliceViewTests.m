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
 * KBOTSliceViewTests implementation
 */

#import "OTSliceViewTests.h"

@interface OTSliceView ()

- (NSComparisonResult)compareByAngle:(OTSliceView *)sliceToCompare;

@end

@implementation OTSliceViewTests

/**************************************************************************************************/
#pragma mark - Getters & Setters



@synthesize slice1;
@synthesize slice2;
@synthesize slice3;
@synthesize slice4;
@synthesize conflictSliceWith4;


/**************************************************************************************************/
#pragma mark - Birth & Death

- (void)setUp {
	[super setUp];



	self.slice1 = [[OTSliceView alloc] init];
	self.slice1.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
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
}

- (void)tearDown {
	self.slice1 = nil;
	self.slice2 = nil;
	self.slice3 = nil;
	self.slice4 = nil;

	[super tearDown];
}

/**************************************************************************************************/
#pragma mark - SortSliceLayerListBySliceAngle


- (void)testSortSliceLayerListBySliceAngle_With_Nil {
	// GIVEN
	NSArray *array = nil;

	// WHEN
	NSArray *result = [OTSliceView sortSliceLayerListBySliceAngle:array];

	// THEN
	XCTAssertNil(result);
}

- (void)testSortSliceLayerListBySliceAngle_With_NoObject {
	// GIVEN
	NSArray *array = [NSArray array];

	// WHEN
	NSArray *result = [OTSliceView sortSliceLayerListBySliceAngle:array];

	// THEN
	XCTAssertNil(result);
}

- (void)testSortSliceLayerListBySliceAngle_With_OneObject {
	// GIVEN
	NSArray *array = [NSArray arrayWithObject:self.slice1];

	// WHEN
	NSArray *result = [OTSliceView sortSliceLayerListBySliceAngle:array];

	// THEN

	XCTAssertTrue([result objectAtIndex:0] == self.slice1);
}

- (void)testSortSliceLayerListBySliceAngle_With_TwoObjects {
	// GIVEN
	NSArray *array = [NSArray arrayWithObjects:self.slice1, self.slice2, nil];

	// WHEN
	NSArray *result = [OTSliceView sortSliceLayerListBySliceAngle:array];

	// THEN

	XCTAssertTrue([result objectAtIndex:0] == self.slice1);
	XCTAssertTrue([result objectAtIndex:1] == self.slice2);
}

- (void)testSortSliceLayerListBySliceAngle_With_TwoObjects2 {
	// GIVEN
	NSArray *array = [NSArray arrayWithObjects:self.slice2, self.slice1, nil];

	// WHEN
	NSArray *result = [OTSliceView sortSliceLayerListBySliceAngle:array];

	// THEN

	XCTAssertTrue([result objectAtIndex:0] == self.slice1);
	XCTAssertTrue([result objectAtIndex:1] == self.slice2);
}

- (void)testSortSliceLayerListBySliceAngleWithGoodData1 {
	// GIVEN
	NSArray *array = [NSArray arrayWithObjects:self.slice1,  self.conflictSliceWith4, self.slice2, nil];

	// WHEN
	NSArray *result = [OTSliceView sortSliceLayerListBySliceAngle:array];

	// THEN
	XCTAssertTrue([result objectAtIndex:0] == self.slice1);
	XCTAssertTrue([result objectAtIndex:1] == self.slice2);
	XCTAssertTrue([result objectAtIndex:2] == self.conflictSliceWith4);
}

- (void)testSortSliceLayerListBySliceAngleWithGoodData2 {
	// GIVEN
	NSArray *array = [NSArray arrayWithObjects:self.slice1,  self.conflictSliceWith4, self.slice2, nil];

	// WHEN
	NSArray *result = [OTSliceView sortSliceLayerListBySliceAngle:array];

	// THEN
	XCTAssertTrue([result objectAtIndex:0] == self.slice1);
	XCTAssertTrue([result objectAtIndex:1] == self.slice2);
	XCTAssertTrue([result objectAtIndex:2] == self.conflictSliceWith4);
}

/**************************************************************************************************/
#pragma mark - Compare

- (void)testCompareByAngleWithNil {
	// THEN
	NSComparisonResult result = [self.slice1 compareByAngle:nil];

	XCTAssertEqual(result, NSOrderedDescending);
}

- (void)testCompareByAngleWith10and20 {
	// THEN
	NSComparisonResult result = [self.slice1 compareByAngle:self.slice2];

	XCTAssertEqual(result, NSOrderedAscending);
}

- (void)testCompareByAngleWith20and10 {
	// THEN
	NSComparisonResult result = [self.slice2 compareByAngle:self.slice1];

	XCTAssertEqual(result, NSOrderedDescending);
}

- (void)testCompareByAngleWith10and10 {
	// THEN
	NSComparisonResult result = [self.slice1 compareByAngle:self.slice1];

	XCTAssertEqual(result, NSOrderedSame);
}

@end
