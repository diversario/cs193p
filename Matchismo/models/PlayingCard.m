//
//  PlayingCard.m
//  Matchismo
//
//  Created by Ilya Shaisultanov on 4/29/14.
//  Copyright (c) 2014 Ilya Shaisultanov. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

+ (NSArray *) rankStrings {
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSArray *) validSuits {
    return @[@"♥", @"♦",@"♠",@"♣"];
}

+ (NSUInteger) maxRank {
    return [[self rankStrings] count] - 1;
}

- (NSString *) contents {
    NSArray *rankedStrings = [PlayingCard rankStrings];
    
    return [rankedStrings[self.rank] stringByAppendingString: self.suit];
}

@synthesize suit = _suit;

- (NSString *) suit {
    return _suit ? _suit : @"?";
}

- (void) setSuit:(NSString *)suit {
    if ([[PlayingCard validSuits] containsObject: suit]) {
        _suit = suit;
    }
}

- (void) setRank:(NSUInteger)rank {
    if (rank <= [PlayingCard maxRank]) _rank = rank;
}

- (int) match:(NSArray *)otherCards {
    int score = 0;
    
    for (PlayingCard *c in otherCards) {
        if (c != self) {
            if (c.rank == self.rank) {
                score += 4;
            } else if ([c.suit isEqualToString:self.suit]) {
                score += 1;
            }
        }
    }
    
    return score;
}

@end
