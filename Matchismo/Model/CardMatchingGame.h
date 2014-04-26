//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by 张 俊 on 14-2-15.
//  Copyright (c) 2014年 zhangjun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"

@interface CardMatchingGame : NSObject
- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

- (void)reSet;

@property (nonatomic, readonly) NSInteger score;

//模式 匹配个数，1表示匹配1张牌，即2张牌比较
@property (nonatomic, readwrite) NSInteger mode;

//提示信息
@property (nonatomic, readonly) NSMutableString *hint;
@end
