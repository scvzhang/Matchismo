//
//  Deck.h
//  Matchismo
//
//  Created by 张 俊 on 14-2-11.
//  Copyright (c) 2014年 zhangjun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;

- (Card *)drawRandomCard;

@end
