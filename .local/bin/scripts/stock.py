#!/usr/bin/env python
import robin_stocks as r
import config

login = r.login(config.USERNAME, config.PASSWORD)

portfolio = r.build_holdings()

for key,value in portfolio.items():
    #print(key + ": " + value['price'] + " | ", end = '')
    print(key + ": " + value['equity_change'] + " | ", end = '')
