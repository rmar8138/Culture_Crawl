# Culture Crawl

https://culturecrawl.herokuapp.com/

Culture Crawl is a two-sided marketplace built on Ruby on Rails for the Coder Academy Fast Track Bootcamp.

## Purpose

Culture Crawl connects people who are passionate about discovering different cultures with people who are passionate about sharing their knowledge on these cultures. These passionate people are able to share knowledge not only of their cultural heritage, but the culture of the things that matter most to them outside that. For example, one might be interested in sharing knowledge about the photography culture in their area, or the architectural culture in their area, or maybe even the vintage watch or vintage records culture.

The app is targeted to not only those with a focused interest on niche communities and cultures, but to the wider audience in general. A user who has zero knowledge on design may sign up for a design-themed crawl, and can learn something that they may not have ever had the chance to learn, from someone who is well versed in that sphere. Culture Crawl aims to facilitate a cultural exchange, which is open to everyone who wishes to partake.

## Tech Stack

- Ruby on Rails
- HTML + CSS (ERB + Sass)
- JavaScript
- Stripe (Payments)
- AWS S3 (Image hosting)
- Heroku (Deployment)

## Features/Functionality

Every one knows what a pub crawl is, but a culture crawl takes it to a different level where passionate experts of these different cultures are able to guide like-minded and interested individuals in their own curated walk, or 'crawl' throughout their own town's hottest locations. Users are able to sign up and create these crawls that relate to whatever it is they are passionate about or feel connected to, and other users are able to book these crawls and experience a view of culture that they may not otherwise be able to experience. After the crawl, those who attended are able to leave a review and a score up to 5. These reviews are then aggregated and a score is assigned to the crawl, which then contributes to the overall score of the user who uploaded the crawl. This rating system allows users to see which users offer the best experiences.

While there are similar services that offer tour guide experiences, Culture Crawl aims to differentiate itself by focusing solely on niche, curated areas of interests and bridge the gap between different communities and different cultures.

Further functionality and features to be implemented are:

- Airbnb style listing
- Google maps integration
- Community pages
- Highest rated crawls
- Private messaging

**Airbnb style listing**

Currently, due to time constraints and complexity, the app functions more in a 'Meetup' style, where users post a crawl on a certain date, and when that date passes, the crawl is then marked as finished, which is when reviews can be made. A more practical solution to this would be to integrate more of an 'Airbnb' style listing, in which users can upload crawls as 'templates' which can then be offered on multiple dates, in regularity or irregularity. This stops the user from having to constantly create crawls that they have previously done, and allow a more rigorous review system for the specific crawl, as reviews will be left on the crawl template themselves.

**Google maps integration**

A client side feature that will be implemented in the future is the use of Google Maps API, wherein users who upload crawls can select locations via Google Maps, which is then saved to the database as a geolocation. A crawl route can then be traced which is displayed on the page which can then show users a more detailed route of the crawl. This feature can be seen in the initial wireframes.

**Community Pages**

Community pages allow crawls to belong to certain communities, which allow for a better user experiences in terms of searching, creating and discussing crawls. For example, there could be a 'music' community page which will feature all the music-related crawls, and highlight the best crawls in that category. In addition to this, users can also interact with each other openly here, and create posts and comments, and discuss about certain crawls and perhaps talk about future crawls that either exist or don't. Whether these community pages are admin or user created is still undecided.

**Highest rated crawls**

This is a feature that would be implemented following the Airbnb style listing feature, where the highest ratet crawls would be featured on the home page, as well as in each community page.

**Private messaging**

This is of course a crucial feature, which allows users to privately message each other in real time. Users would be able to interact with their hosts about the nature of the crawls, and ask any relevant questions pertaining to the crawl.

## Sitemap

The following is a sitemap of the site as of the latest commit.

![Sitemap](../resources/sitemap.png)

## Screenshots

## User Stories

## Wireframes

## ERD

## High Level Components

## Third Party Services

## Models

## Database Relations

## Database Schema

## Task Tracking
