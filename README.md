# xp

[![Code Climate](https://codeclimate.com/github/kronosapiens/xp.png)](https://codeclimate.com/github/kronosapiens/xp)
[![Build Status](https://travis-ci.org/kronosapiens/xp.svg?branch=master)](https://travis-ci.org/kronosapiens/xp)
[![Coverage Status](https://coveralls.io/repos/kronosapiens/xp/badge.png?branch=master)](https://coveralls.io/r/kronosapiens/xp?branch=master)

## Description

A skillshare-like learning platform for the Flatiron community

['Flatiron School Presents' Meetup Presentation, April 17, 2014](http://prezi.com/qaaqtitg3dfr/introducing-xp/#)

[Walkthrough Video](https://vimeo.com/92742438)

Home Page:
![Landing Page](/public/images/01_root.png "Landing Page")

## Background

Flatiron students are an eclectic and talented bunch. Our alumni and admitted students also are, doubly so. We wanted to create a platform to help connect those with things to teach to those with a desire to learn, and help promote the flow of knowlege with the Flatiron community.

We specifically hope to help admitted students find guidance as they progress through the Flatiron pre-work, which has traditionally been done independently.

## Features

* Ability to filter lessons based on interest and availability
* Easy to request or offer lessons based on interest or need
* Community-oriented design makes it easy to assess interest before committing resources to teaching
* Integration with github to calculate 'github score' based on user's repositories

## Technology

* JavaScript, jQuery, AJAX
* Chosen
* Octokit
* Twitter Bootstrap
* FactoryGirl
* Capybara

## Usage

Users log on through github, and can immediately browse for available courses, request new courses, or volunteer to teach a course. Potential teachers can browse for requested courses and volunteer to teach them. Potential students can browse courses on offer and sign up to take them. Students may also request courses, and multiple students can sign on and show interest -- helping potential teachers identify and meet those needs.

## Development/Contribution

Scheduling features! Once students and teachers have been connected, how can we make help them find a time to meet?
Auto-pruning: A weekly task which messages students to confirm interest, or else it automatically drops them from the lesson -- important to prevent large numbers of abandoned lessons.

## Future Features

* Built-in calendar system to improve coordinating of lessons
* Regular notifications to encourage active maintenance of lessons

## Creators

Sam Schlinkert: [@sts10](https://github.com/sts10)

Daniel Kronovet: [@kronosapiens](https://github.com/kronosapiens)

## Relevant Blog Posts

[Using Chosen with Rails](http://sts10.github.io/blog/2014/04/02/chosen/)

[A Dynamic and Generally Efficient Front-End Filtering Algorithm, with Rails and jQuery](http://kr0nos4piens.wordpress.com/2014/03/31/a-dynamic-and-relatively-efficient-front-end-filtering-algorithm-with-rails-and-javascript/)

[How We Used the Data-Remote=True Pattern for AJAXing New Comments in XP](http://sts10.github.io/blog/2014/04/12/data-remote-true/)

## Screenshots

![Lessons Index](/public/images/02_lessons_index.png "Lessons Index")
![Lessons Show](/public/images/03_lessons_show.png "Lessons Show")
![User Show](/public/images/04_user_show.png "User Show")
![Lessons New](/public/images/05_lessons_new.png "Lessons New")
![Tags Show](/public/images/06_tags_show.png "Tags Show")

## License

xp is GNU v2 Licensed. See LICENSE for details.
