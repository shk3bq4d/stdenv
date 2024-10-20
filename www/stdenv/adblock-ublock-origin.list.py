#!/usr/bin/env python
# -*- coding: utf-8 -*-
# /* ex: set filetype=python ts=4 sw=4 expandtab: */
# http://jlighttpd.ly.lan/charlotte.py
import os
import cgi
import sys
import cgitb
import datetime
import time
import re
cgitb.enable() # Optional; for debugging only


form = cgi.FieldStorage()

q = None
if 'q' in form:
    q = form['q'].value
    q = q.strip()
    qattr = q.replace('&', '&amp;').replace('"', '&quot;')


redirection = None

if redirection is not None:
    print(
"""Status: 302 Moved
Location: {}

""".format(redirection))
    sys.exit(0)

def usercentrics():
    usercentrics_domains = "www.rts.ch www.hornbach.ch www.post.ch".split()
    for domain in usercentrics_domains:
        print(f"""
! 2024-04-07 https://www.rts.ch
{domain}###usercentrics-root
{domain}##body:remove-class(overflowHidden)
{domain}##body:watch-attr(class):remove-class(overflowHidden)
{domain}###uc-cross-domain-bridge
{domain}###uc-overflow-style
# block iframe from user centric
||app.usercentrics.eu^$subdocument,domain={domain}
            """)

print("Content-type: text/plain; charset=utf-8\n")
print(
"""
! Title: Stdenv
! Description: Stdenv description
! Version: 1.7.0
! Last modified: 2023-10-23 22:49
! Expires: 1 weeks (update frequency)
! Homepage: https://github.com/shk3bq4d/stdenv/blob/master/www/stdenv/adblock.list
! License:  https://github.com/shk3bq4d/stdenv/blob/master/LICENSE.md
! Url: http://127.0.0.1:57155/www/stdenv/adblock.list

! 2024-01-02 https://www.sbb.ch
www.sbb.ch##.ot-fade-in.onetrust-pc-dark-filter
www.sbb.ch##.ot-sdk-container

www.nba.com##.ot-sdk-row

www.bluewin.ch###wisepops-root
www.bluewin.ch##video
www.bluewin.ch##.m-teaser__details
www.bluewin.ch##.m-mediaimage
www.bluewin.ch##.free-html-embed
www.bluewin.ch##.c-brightcove-teaser-v2

! cookie acceptance using a widely deployed framework across multiple sites
###onetrust-consent-sdk

stackoverflow.com##div:has(div:has-text(Join Stack Overflow to find))
stackoverflow.com##.s-sidebarwidget:has-text(people chatting)
stackoverflow.com##.s-sidebarwidget:has-text(The Overflow Blog)
stackoverflow.com##.s-sidebarwidget:has-text(Featured on Meta)

reddit.com##reddit-cookie-banner
reddit.com###credential_picker_container

login.swisspass.ch###onetrust-consent-sdk

! 2023-12-15 https://en.wikipedia.org
en.wikipedia.org##.vector-sitenotice-container

! 2023-12-17 https://en.wikipedia.org
en.wikipedia.org##.frb-country-CH.frb-rml-disabled.frb
en.wikipedia.org##.frb-nag-link

www.instagram.com##.x1n2onr6.xg6iff7.xdt5ytf.x78zum5

! 2024-01-04 https://www.lequipe.fr
www.lequipe.fr##.CmpUnsubscriber--swg.CmpUnsubscriber.Cmp
www.lequipe.fr##.layout.OfferBanner__layout
www.lequipe.fr##.ReactionSummary
www.lequipe.fr###ReactionSummary
www.lequipe.fr##.Article__paywall
www.lequipe.fr###credential_picker_container
||accounts.google.com/gsi/iframe/select?client_id=362438483275-gda92b30hlr90oad60h7n4d1c13erd12.apps.googleusercontent.com&ux_mode=popup&ui_mode=card&as=iuldG55yWO4S4E1Ln0hiOQ&channel_id=708e3446585123f3944ae73ca9147e3a9eef097ea978a9f00a023a2a38d35e6b&origin=https%3A%2F%2Fwww.lequipe.fr$subdocument

! jumbobot always on right
www.jumbo.ch###frontnow-advisor-launcher

! self-ad on bottom
www.jumbo.ch##.newsletterTeaser

www.jumbo.ch##.supercard-teaser__head
www.jumbo.ch##.supercard-teaser__body

www.jumbo.ch##.header__trust-elements-container

www.jumbo.ch##.swc-cookie-banner

www.teletext.ch##.ot-sdk-container > .ot-sdk-row
www.teletext.ch##.ot-fade-in.onetrust-pc-dark-filter
www.teletext.ch###onetrust-consent-sdk


!www.youtube.com##tp-yt-paper-dialog.ytd-popup-container.style-scope
www.youtube.com##tp-yt-iron-overlay-backdrop

! >>>>>> https://raw.githubusercontent.com/gijsdev/ublock-hide-yt-shorts/master/list.txt

! Hide all videos containing the phrase "#shorts"
youtube.com##ytd-grid-video-renderer:has(#video-title:has-text(#shorts))
youtube.com##ytd-grid-video-renderer:has(#video-title:has-text(#Shorts))
youtube.com##ytd-grid-video-renderer:has(#video-title:has-text(#short))
youtube.com##ytd-grid-video-renderer:has(#video-title:has-text(#Short))

! Hide all videos with the shorts indicator on the thumbnail
youtube.com##ytd-grid-video-renderer:has([overlay-style="SHORTS"])
youtube.com##ytd-rich-item-renderer:has([overlay-style="SHORTS"])
youtube.com##ytd-video-renderer:has([overlay-style="SHORTS"])
youtube.com##ytd-item-section-renderer.ytd-section-list-renderer[page-subtype="subscriptions"]:has(ytd-video-renderer:has([overlay-style="SHORTS"]))

! Hide shorts button in sidebar
youtube.com##ytd-guide-entry-renderer:has-text(Shorts)
youtube.com##ytd-mini-guide-entry-renderer:has-text(Shorts)

! Hide shorts section on homepage
youtube.com##ytd-rich-section-renderer:has(#rich-shelf-header:has-text(Shorts))
youtube.com##ytd-reel-shelf-renderer:has(.ytd-reel-shelf-renderer:has-text(Shorts))

! Hide shorts tab on channel pages
! Old style
youtube.com##tp-yt-paper-tab:has(.tp-yt-paper-tab:has-text(Shorts))
! New style (2023-10)
youtube.com##yt-tab-shape:has-text(/^Shorts$/)

! Remove empty spaces in grid
youtube.com##ytd-rich-grid-row,#contents.ytd-rich-grid-row:style(display: contents !important)


!!! MOBILE !!!

! Hide all videos in home feed containing the phrase "#shorts"
m.youtube.com##ytm-rich-item-renderer:has(#video-title:has-text(#shorts))
m.youtube.com##ytm-rich-item-renderer:has(#video-title:has-text(#Shorts))
m.youtube.com##ytm-rich-item-renderer:has(#video-title:has-text(#short))
m.youtube.com##ytm-rich-item-renderer:has(#video-title:has-text(#Short))

! Hide all videos in subscription feed containing the phrase "#shorts"
m.youtube.com##ytm-item-section-renderer:has(#video-title:has-text(#shorts))
m.youtube.com##ytm-item-section-renderer:has(#video-title:has-text(#Shorts))
m.youtube.com##ytm-item-section-renderer:has(#video-title:has-text(#short))
m.youtube.com##ytm-item-section-renderer:has(#video-title:has-text(#Short))

! Hide shorts button in the bottom navigation bar
m.youtube.com##ytm-pivot-bar-item-renderer:has(.pivot-shorts)

! Hide all videos with the shorts indicator on the thumbnail
m.youtube.com##ytm-video-with-context-renderer:has([data-style="SHORTS"])

! Hide shorts sections
m.youtube.com##ytm-rich-section-renderer:has(ytm-reel-shelf-renderer:has(.reel-shelf-title-wrapper:has-text(Shorts)))
m.youtube.com##ytm-reel-shelf-renderer.item:has(.reel-shelf-title-wrapper:has-text(Shorts))

! Hide shorts tab on channel pages
m.youtube.com##.single-column-browse-results-tabs>a:has-text(Shorts)
! <<<<<< https://raw.githubusercontent.com/gijsdev/ublock-hide-yt-shorts/master/list.txt

!2024-05-17 commenting out the next thing
www.google.com##[aria-label="Before you continue to Google Search"]
www.google.com##body:style(overflow: auto !important)

! May 28, 2024 https://www.npr.org
www.npr.org##.tp-modal

! May 30, 2024 https://www.landi.ch
www.landi.ch##.ccm-root
""")
usercentrics()
