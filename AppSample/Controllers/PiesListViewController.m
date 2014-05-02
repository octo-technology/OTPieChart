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
 * PiesListViewController implementation
 */

#import "PiesListViewController.h"

@implementation PiesListViewController

/**************************************************************************************************/
#pragma mark - Birth

- (id)initWithStyle:(UITableViewStyle)style
{
	self = [super initWithStyle:style];
	if (self)
	{
		// Custom initialization
	}
	return self;
}

/**************************************************************************************************/
#pragma mark - Getters & Setters

@synthesize delegate;


/**************************************************************************************************/
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"basicCell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

	if (cell == nil)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}

	NSString *text = nil;

	switch (indexPath.row)
	{
		case 0 :
			text = @"Simple Pie";
			break;

		case 1 :
			text = @"No inner radius (aka Classic Pie)";
			break;

		case 2 :
			text = @"Big inner radius (aka the Donut)";
			break;

		case 3 :
			text = @"Wide separation between slices";
			break;

		case 4 :
			text = @"No separation between slices";
			break;

		case 5 :
			text = @"Collision between legend labels";
			break;

		case 6 :
			text = @"Legend in slice";
			break;

		case 7 :
			text = @"Custom text color in label";
			break;

		case 8 :
			text = @"Custom view in label";
			break;

		default :
			break;
	}

	cell.textLabel.text = text;

	[cell.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:18.]];

	return cell;
}

/**************************************************************************************************/
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[self.delegate didSelectPieAtindex:indexPath.row];

	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
