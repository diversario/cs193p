//
//  Deck.m
//  Matchismo
//
//  Created by Ilya Shaisultanov on 4/29/14.
//  Copyright (c) 2014 Ilya Shaisultanov. All rights reserved.
//

#import "Deck.h"

@interface Deck()
@property (strong, nonatomic) NSMutableArray *cards;
@end

@implementation Deck

- (NSMutableArray *) cards {
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (void) addCard:(Card *)card atTop:(BOOL)atTop {
    if (atTop) {
        [self.cards insertObject:card atIndex:0];
    } else {
        [self.cards addObject:card];
    }
}
- (void) addCard:(Card *)card {
    [self addCard:card atTop:NO];
}

- (Card *) drawRandomCard {
    Card *card = nil;
    
    if ([self.cards count]) {
        unsigned index = arc4random() % [self.cards count];
        card = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }

    return card;
}

@end
