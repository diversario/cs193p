//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Ilya Shaisultanov on 5/1/14.
//  Copyright (c) 2014 Ilya Shaisultanov. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards;
@property (nonatomic, strong) NSMutableArray* selectedCards;
@end

@implementation CardMatchingGame

const static int MISMATCH_PENALTY = 2;
const static int MATCH_BONUS = 4;
const static int COST_TO_CHOOSE = 1;

- (NSMutableArray *) cards {
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSInteger) maxSelectedCards {
    if (!_maxSelectedCards) _maxSelectedCards = 2;
    return _maxSelectedCards;
}

- (NSMutableArray*) selectedCards {
    if (!_selectedCards) _selectedCards = [[NSMutableArray alloc] init];
    return _selectedCards;
}

- (instancetype) initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck {
    self = [super init];
    
    if (!self) return self;
    
    for (int i = 0; i < count; i++) {
        Card *card = [deck drawRandomCard];
        
        if (!card) {
            self = nil;
            break;
        }
        
        [self.cards addObject:card];
    }
    
    return self;
}

- (Card *) cardAtIndex:(NSUInteger)index {
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (void) chooseCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    
    if (card.isMatched) return;
    
    if ([self.selectedCards containsObject:card]) {
        card.chosen = NO;
        [self.selectedCards removeObject:card];
        return;
    }
    
    [self.selectedCards addObject:card];

    self.score -= COST_TO_CHOOSE;
    card.chosen = YES;
    
    if ([self.selectedCards count] < self.maxSelectedCards) return;
    
    NSArray* otherCards = [self.selectedCards subarrayWithRange:NSMakeRange(1, self.maxSelectedCards - 1)];
    
    int matchScore = [[self.selectedCards firstObject] match:otherCards];
    
    if (matchScore) {
        self.score += matchScore * MATCH_BONUS;
        
        for (Card* c in self.selectedCards) c.matched = YES;
        
        self.selectedCards = [[NSMutableArray alloc] init];
    } else {
        self.score -= MISMATCH_PENALTY;
        for (Card* c in otherCards) {
            c.chosen = NO;
            [self.selectedCards removeObject:c];
        }
    }
}


@end