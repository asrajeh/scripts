#!/bin/bash
# A script to scrape articles from Shargh (a popular Iranian newspaper)
# Written by Abdullah Alrajeh, Sep 2020
# Use:
# scrapy crawl shargh > log2 2>&1 &
# scrapy shell http://sharghdaily.com
# scrapy shell http://sharghdaily.com/fa/main/page/2/1

import scrapy

class QuotesSpider(scrapy.Spider):
    name = "shargh"
    allowed_domains = ['www.sharghdaily.com']

    def start_requests(self):
        urls = [
            'http://www.sharghdaily.com/',
        ]
        for url in urls:
            yield scrapy.Request(url=url, callback=self.parse)

    def parse(self, response):
        with open('shargh.url', 'w') as f:
            f.write(response.url+'\n')

        #filename = 'shargh-index.html'
        #with open(filename, 'wb') as f:
        #    f.write(response.body)
        #self.log('Saved file %s' % filename)

        days = response.css('div.l30_main option::attr(value)').getall()[0:1600]
        print(days)

        for next_page in days:
            if next_page is not None:
                next_page = response.urljoin('http://www.sharghdaily.com/fa/main/page/'+next_page+'/1')
                yield scrapy.Request(next_page, callback=self.parse_day)

    def parse_day(self, response):
        with open('shargh.url', 'a') as f:
            f.write(response.url+'\n')

        day = response.url.split("/")[-2]
        papers = response.css('td.pubpage a::attr(href)').getall()[1:]
        papers.insert(0, '/fa/Main/Page/'+day+'/1/1')
        print('day:', day, ' papers: ', papers)

        #with open('shargh.url', 'a') as f:
        #    for paper in papers:
        #        f.write(paper+'\n')

        for next_page in papers:
            if next_page is not None:
                next_page = response.urljoin('http://www.sharghdaily.com'+next_page)
                yield scrapy.Request(next_page, callback=self.parse_paper)

    def parse_paper(self, response):
        with open('shargh.url', 'a') as f:
            f.write(response.url+'\n')

        day = response.url.split("/")[-3]
        paper = response.url.split("/")[-2]
        #filename = 'shargh-paper-%s-%s.html' % (day, paper)
        #with open(filename, 'wb') as f:
        #    f.write(response.body)
        #self.log('Saved file %s' % filename)

        articles = response.css('area::attr(href)').getall()

        print('day:', day, ' paper: ', paper, ' articles: ', articles)

        #with open('shargh.url', 'a') as f:
        #    for article in articles:
        #        f.write(article+'\n')

        for next_page in articles:
            if next_page is not None:
                next_page = response.urljoin('http://www.sharghdaily.com'+next_page)
                yield scrapy.Request(next_page, callback=self.parse_article, meta={'day': day, 'paper': paper})

    def parse_article(self, response):
        with open('shargh.url', 'a') as f:
            f.write(response.url+'\n')

        day = response.meta.get('day')
        paper = response.meta.get('paper')
        article = response.url.split("/")[-2]
        #filename = 'shargh-%s-%s-%s.html' % (day, paper, article)
        #with open(filename, 'wb') as f:
        #    f.write(response.body)
        #self.log('Saved file %s' % filename)

        filename = 'shargh-%s-%s-%s.txt' % (day, paper, article)
        with open(filename, 'w') as f:
            for t in response.xpath('//h3/text()').extract():
                f.write(t+'\n')
            for t in response.xpath('//h2/text()').extract():
                f.write(t+'\n')
            for t in response.xpath('//h1/text()').extract():
                f.write(t+'\n')
            for t in response.xpath('//p/text()').extract():
                f.write(t+'\n')
            for t in response.xpath('//div/text()').extract():
                f.write(t+'\n')
        self.log('Saved file %s' % filename)

        #articles = response.css('area::attr(href)').getall()
        #print('articles: ', articles)
        #for next_page in articles:
        #    if next_page is not None:
        #        next_page = response.urljoin('http://www.sharghdaily.com/fa/main/detail/'+next_page)
        #        yield scrapy.Request(next_page, callback=self.parse_article)
