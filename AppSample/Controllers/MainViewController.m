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
 * MainViewController implementation
 */

#import "MainViewController.h"

#import "Pie1ViewController.h"
#import "Pie2ViewController.h"
#import "Pie3ViewController.h"
#import "Pie4ViewController.h"
#import "Pie5ViewController.h"
#import "Pie6ViewController.h"
#import "Pie7ViewController.h"
#import "Pie8ViewController.h"


@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
	{
		Pie1ViewController *contentViewContoller = [[Pie1ViewController alloc] initWithNibName:nil bundle:nil];
		PiesListViewController *tableViewController = [[PiesListViewController alloc] initWithStyle:UITableViewStylePlain];
		tableViewController.delegate = self;

		self.viewControllers = [NSArray arrayWithObjects:tableViewController, contentViewContoller, nil];
	}
    
	return self;
}

/**************************************************************************************************/
#pragma mark - UIViewController

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}

/**************************************************************************************************/
#pragma mark - PiesListDelegate

- (void)didSelectPieAtindex:(NSUInteger)index
{
	ContentViewController *contentViewController = nil;

	switch (index)
	{
		case 0 :
		{
			contentViewController = [[Pie1ViewController alloc] initWithNibName:nil bundle:nil];
			break;
		}
		case 1 :
		{
			contentViewController = [[Pie2ViewController alloc] initWithNibName:nil bundle:nil];
			break;
		}
		case 2 :
		{
			contentViewController = [[Pie3ViewController alloc] initWithNibName:nil bundle:nil];
			break;
		}
		case 3 :
		{
			contentViewController = [[Pie4ViewController alloc] initWithNibName:nil bundle:nil];
			break;
		}
		case 4 :
		{
			contentViewController = [[Pie5ViewController alloc] initWithNibName:nil bundle:nil];
			break;
		}
        case 5 :
		{
			contentViewController = [[Pie6ViewController alloc] initWithNibName:nil bundle:nil];
			break;
		}
        case 6 :
		{
			contentViewController = [[Pie7ViewController alloc] initWithNibName:nil bundle:nil];
			break;
		}
		case 7 :
		{
			contentViewController = [[Pie8ViewController alloc] initWithNibName:nil bundle:nil];
			break;
		}
		default :
			return;
	}


	NSMutableArray *controllers = [NSMutableArray arrayWithArray:self.viewControllers];
	[controllers setObject:contentViewController atIndexedSubscript:1];
	self.viewControllers = controllers;
}

@end