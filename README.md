# Crowdsource-fact-checker
Hack the North 2021 Submission 

## Inspiration 🧠
It's Canadian federal election season! When thinking about this we realized a huge problem in modern media is the amount of incorrect information and confusion. We wanted to create a way for people to easily verify facts in a reliable and trustworthy way.

## What it does 🥳
Introducing Crowdcheck! Crowdcheck is a crowdsource fact-checking app that allows users to interact forum style to determine the truthfulness of facts posted on the platform.

In simpler terms, we like to think of it as the stack overflow of fact-checking!

## User Journey 🧑
If you are a user that wants to get a "fact" checked here's what the process looks like:

1. Create a post with your "fact"
2. Other users will discuss it to decide if it's truthful or not by adding comments. They will also add references with their comments which you can easily check to make your own decision.
3. After other users respond, a rating will appear on your fact that will tell you how truthful it is out of 10. 10/10 being completely true and 0/10 being a complete lie.
4. Lastly your post and truthfulness rating is now available for you to see as well as anyone else who may be wondering if the "fact" you added is truthful or not.

Full Feature List:
- Built-in user profile and user stats
- Form based submissions to submit a post for fact-checking (Twitter thread, Facebook post, Instagram post, news article) 
- Share posts across platforms
- Verified crowdcheck experts and advisors
- What's trending page 
- Comment on the post threads and contribute to the crowdcheck community!

## How we built it 🛠️
We used Flutter to build the UI for our app. 
In total, we built 6 different app pages with many different Flutter widgets.
We also used Firebase to store our app content and sync it across devices and platforms.
We used Firebase Storage to store the images in our app such as user profile pictures.
We used a Firestore Database to store the posts and comments.

## Challenges we ran into ❌
Setting Firebase up to work with our Flutter app took some time and was a bit of a struggle. We had to add dependencies to our app "cloud_firestore" and "firebase_core". However after some time and debugging we managed to link our app to the firebase instance successfully!

The learning curve for Flutter was also a bit of a challenge for us. Flutter is written in dart which is not as common as other languages but it is similar to Java which made it easier for us. Also, the hierarchical UI structure for Flutter is similar to HTML which made it easy to use once we started to get the hang of all the different widgets.


## Accomplishments that we're proud of 👏
- Building a cross-platform app for Android and IOS.
- Building a backend for the app using a Firestore Database.
- Successfully linking our app with Firebase.
- Creating a ton of Flutter widgets and app functionality.

## What we learned 📚
So much about Flutter! Flutter is such a cool way to make cross-platform apps with beautiful UI. 

Without Flutter, we for sure would not have been able to get as many features built as we did.

We also learned a ton about Firebase integration and storing data in a Firestore Database. We now know how to retrieve and update data from our Firestore Database and we also know how to use Firebase Storage to store app content such as images. 

## What's next for crowdcheck 👩🏽‍💻👨🏽‍💻
Unfortunately, we ran out of time to implement some of the features we wanted. Some things we would like to add in the future include:
- A points system where users get more points by making high-quality posts.
- A moderator system where users with a lot of points are able to moderate the forum by flagging posts as spam and remove low-quality ones.
- An authentication system to allow new users to sign up for the app.
- A way to filter posts by tags and interests.

## Business Viability 💼
We also believe that our project has the opportunity to be a viable business, where it can transform into a real world company! It is important to consider all factors that help us with being a viable business: Strength, weaknesses, opportunities, threats, considering the status quo, the market, along with the business/revenue model we implement. In terms of strengths, our potential company provides users with reliable information that is supported by crowdcheck experts, in order to stay informed during important events that happen at a regional, provincial, federal, and international level. In terms of weaknesses, since we are currently a small team, we hope to add more technical analysts and User Experience (UX) designers. In terms of opportunities, we hope to continue to develop features for crowdcheck, along with completing user testing and iterating on the project. After researching potential threats and companies that were part of the status quo, we found PolitiFact, which was a fact-checking platform of its own (by rating the fact on a scale of true or false). We realized that there were a series of issues with the platform, where it was less community-driven, had no custom profile, was filled with advertisements, and was limited to posts on Facebook, Instagram, TikTok, and viral images. In terms of the market and long-term market, our current market includes the communications/coverage around the Canadian Federal Election and the COVID-19 pandemic, and our long-term market is news and social media communications beyond these two events.
