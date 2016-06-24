//
//  FISPrimeTimeTableViewController.m
//  PrimeTime
//
//  Created by Matt Amerige on 6/23/16.
//  Copyright © 2016 FIS. All rights reserved.
//

#import "FISPrimeTimeTableViewController.h"

@interface FISPrimeTimeTableViewController ()

@property (nonatomic, strong) NSMutableDictionary *primeNumbersDictionary;

@property (nonatomic, strong) NSMutableArray *primesArray;

@end

@implementation FISPrimeTimeTableViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.tableView.accessibilityIdentifier = @"table";
}

- (NSMutableArray *)primesArray
{
	if (!_primesArray) {
		// Starting with 2 as the first prime
		_primesArray = [[NSMutableArray alloc] initWithObjects:@2, nil];
	}
	return _primesArray;
}

- (NSMutableDictionary *)primeNumbersDictionary
{
	if (!_primeNumbersDictionary) {
		_primeNumbersDictionary = [[NSMutableDictionary alloc] init];
	}
	return _primeNumbersDictionary;
}



#pragma mark - TableView Delegate & Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *basicCell = [tableView dequeueReusableCellWithIdentifier:@"BasicCell"];
	
	basicCell.textLabel.text = [NSString stringWithFormat:@"%lu", [self primeNumber:indexPath.row + 1 + 5000]];
	
	return basicCell;
}


#pragma mark - Prime Number Stuff


- (NSUInteger)primeNumber:(NSInteger)target
{
	NSUInteger result = 0;
	for (NSUInteger i = 1; i <= target; i++) {
		result = [self helper_primeNumber:i];
	}
	
	return result;
}

/**
 To find individual small primes trial division works well. 
 To test n for primality (to see if it is prime) just divide by all of the primes less than the square root of n. 
 For example, to show is 211 is prime, we just divide by 2, 3, 5, 7, 11, and 13.
 */

/**
 Returns the primeth number
 */
- (NSUInteger)helper_primeNumber:(NSInteger)target
{
	// Check if we already have a value for this prime
	if (self.primesArray.count >= target) {
		// subtract 1 to account for zero based array
		return [self.primesArray[target - 1] integerValue];
	}
	
	NSUInteger lastPrime = [[self.primesArray lastObject] integerValue];
	NSUInteger lastPrimeIndex = self.primesArray.count;
	NSUInteger maybePrime = lastPrime;
	
	while (lastPrimeIndex != target) {
		maybePrime++;
		
		if ([self isPrime:maybePrime forArray:self.primesArray]) {
			lastPrimeIndex++;
		}
		
	}
	
	// Adding the next prime
	[self.primesArray addObject:@(maybePrime)];
	
	return maybePrime;
}

/**
 @return Returns YES if the specified integer is a prime number, meaning it is divisible by all numbers in the array otherwise returns NO
 */
- (BOOL)isPrime:(NSUInteger)maybePrime forArray:(NSArray *)array
{
	for (NSNumber *number in array) {
		if (maybePrime % number.unsignedIntegerValue == 0) {
			return NO;
		}
	}
	return YES;
}


@end
