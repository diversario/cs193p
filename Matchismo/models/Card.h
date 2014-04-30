//
//  Card.h
//  Matchismo
//
//  Created by Ilya Shaisultanov on 4/29/14.
//  Copyright (c) 2014 Ilya Shaisultanov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject
@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter = isChosen) BOOL chosen;
@property (nonatomic, getter = isMatched) BOOL matched;

- (int) match: (NSArray *) otherCards;

@end
