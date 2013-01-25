OTPieChart
==========


Did you ever dreamt to create really nice pie chart without the help of a good designer ?

Dream is over. We made it with love, just for you !

We made a demo project, feel free to test it.

![Why OTPieChart](https://raw.github.com/octo-online/OTPieChart/master/images/why.png)


How to get it on your project ?
---------------------------------

### Add files to your project

It's really simple : 

* __Download__ the project
* __Copy & Paste__ the pie chart folder into your project folder
* __Add__ the files in Xcode
* __Add__ QuartzCore framework to your project (Build phases of your target) like the following :

![Add QuartzCore step 1](https://raw.github.com/octo-online/OTPieChart/master/images/QuartzCore1.png)

And then :

![Add QuartzCore step 2](https://raw.github.com/octo-online/OTPieChart/master/images/QuartzCore2.png)


Now your project should build correctly.


### Create a basic pie chart

Then, add the datasource and the delegate. Don't forget to import OTPieChartView.h :

	#import "OTPieChartView.h" 

	@interface ViewController : UIViewController <OTPieChartDataSource, OTPieChartDelegate>

	@property (nonatomic, strong) NSArray        *slices;


And in the implementation file, copy & paste the following code : 

	/**************************************************************************************************/
	#pragma mark - Getters & Setters

	@synthesize slices;

	/**************************************************************************************************/
	#pragma mark - view management

	- (void)viewDidLoad
	{
	    [super viewDidLoad];

	    
	    NSArray *colors = [NSArray arrayWithObjects:
	                       UIColorFromRGB(0x1a4ada),
	                       UIColorFromRGB(0x3d40be),
	                       UIColorFromRGB(0x6035a3),
	                       UIColorFromRGB(0x832b87),
	                       UIColorFromRGB(0xa6206c),
	                       UIColorFromRGB(0xc91650),
	                       UIColorFromRGB(0xec0b35),
	                       UIColorFromRGB(0xea5601),
	                       UIColorFromRGB(0xfeb003),
	                       UIColorFromRGB(0xeacb01),
	                       nil];
	    
	    CGFloat percentageValue = 0.1;
	    NSString *label = [NSString stringWithFormat:@"Value : %.2f %%", percentageValue];
	    
	    NSMutableArray *tmpSlices = [NSMutableArray array];
	    
	    // Create the slices :
	    for (UIColor *color in colors) {
	        
	        OTSlice *slice = [[OTSlice alloc] initWithLabel:label
	                                        percentageValue:percentageValue
	                                                  color:color
	                                      representedObject:nil];
	        [tmpSlices addObject:slice];
	    }
	    
	    self.slices = [NSArray arrayWithArray:tmpSlices];
	    
	    // Create the pie Chart
	    
	    OTPieChartView *pieChartView = [[OTPieChartView alloc] initWithFrame:CGRectMake(20, 20, 400, 400)];
	    pieChartView.delegate = self;
	    pieChartView.datasource = self;
	    [self.view addSubview:pieChartView];
	    [pieChartView loadPieChart];
	}


	/**************************************************************************************************/
	#pragma mark - OTPieChartDatasource

	- (NSUInteger)numbertOfSliceForPieChartIndex:(OTPieChartView *)thePieChart
	{
		return slices.count;
	}

	- (CGFloat)pieChart:(OTPieChartView *)thePieChart getPercentageValue:(NSUInteger)pieChartIndex
	{
		if ([slices count] > pieChartIndex)
		{
			OTSlice *slice = [slices objectAtIndex:pieChartIndex];
			return slice.percentageValue;
		}
		else
		{
			return 0.0;
		}
	}

	- (UIColor *)pieChart:(OTPieChartView *)thePieChart getSliceColor:(NSUInteger)pieChartIndex
	{
		if ([slices count] > pieChartIndex)
		{
			OTSlice *slice = [slices objectAtIndex:pieChartIndex];
			return slice.color;
		}
		else
		{
			return nil;
		}
	}

	- (NSString *)pieChart:(OTPieChartView *)thePieChart getSliceLabel:(NSUInteger)pieChartIndex
	{
		OTSlice *slice = [slices objectAtIndex:pieChartIndex];
	    
		return slice.title;
	}

	/**************************************************************************************************/
	#pragma mark - OTPieChartDelegate

	- (void)pieChart:(OTPieChartView *)thePieChart didSelectSliceAtIndex:(NSUInteger)pieChartIndex
	{
		NSLog(@"pie clicked : %d", pieChartIndex);
	}


That's it !

Generate documentation
----------------------

OTPieChart use AppleDoc to generate its doc.

In the Tools directory, you can find documentation.sh file.
Edit it to set the correct path to your AppleDoc executable.
