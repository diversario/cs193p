//
//  Deck.h
//  Matchismo
//
//  Created by Ilya Shaisultanov on 4/29/14.
//  Copyright (c) 2014 Ilya Shaisultanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void) addCard:(Card *)card atTop:(BOOL)atTop;
- (void) addCard:(Card *)card;

- (Card *) drawRandomCard;

@end
