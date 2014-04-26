//
//  Deck.m
//  Matchismo
//
//  Created by 张 俊 on 14-2-11.
//  Copyright (c) 2014年 zhangjun. All rights reserved.
//

#import "Deck.h"

@interface Deck()
@property (strong, nonatomic) NSMutableArray *cards;
@end

/**
 此类是一叠牌（一副牌）的概念。是用于控制一叠牌的操作。
 **/
@implementation Deck

//只重写setter，不需要标明synthesize.
//如果重写setter和getter，需要标明synthesize
- (NSMutableArray *)cards{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

- (void)addCard:(Card *)card atTop:(BOOL)atTop{
    if (atTop) {
        [self.cards insertObject:card atIndex:0];
    }else{
        [self.cards addObject:card];
    }
}

- (void)addCard:(Card *)card{
    [self addCard:card atTop:NO];
}

- (Card *)drawRandomCard{
    Card *randomCard = nil;
    if ([self.cards count]) {
        unsigned index = arc4random() % [self.cards count];
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    return randomCard;
}



@end
