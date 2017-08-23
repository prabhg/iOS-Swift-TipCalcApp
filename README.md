# iOS-Swift-TipCalcApp
basic tip calculator app with hamburger menu (using SWRevealViewController), settings page and navigation controllers

Tip Calculator built using SWIFT 3

# Pre-work - TipCalc

TipCalc is a tip calculator application for iOS.

Submitted by: Prabhjeet Ghuman

Time spent: 7 hours spent in total

## User Stories

The following **required** functionality is complete:

* [x] User can enter a bill amount, choose a tip percentage, and see the tip and total values.
* [x] Settings page to change the default tip percentage.

The following **optional** features are implemented:
* [ ] UI animations
* [ ] Remembering the bill amount across app restarts (if <10mins)
* [ ] Using locale-specific currency and currency thousands separators.
* [x] Making sure the keyboard is always visible and the bill amount is always the first responder. This way the user doesn't have to tap anywhere to use this app. Just launch the app and start typing.

The following **additional** features are implemented:

- [x] Added hamburger menu (using SWRevealViewController). It was not necessary, but I wanted to learn how to build hamburger menus

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

![alt tag](https://raw.githubusercontent.com/prabhg/iOS-Swift-TipCalcApp/master/TipCalc_iOS_Walkthru.gif)

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Project Analysis

As part of your pre-work submission, please reflect on the app and answer the following questions below:

**Question 1**: "What are your reactions to the iOS app development platform so far? How would you describe outlets and actions to another developer? Bonus: any idea how they are being implemented under the hood? (It might give you some ideas if you right-click on the Storyboard and click Open As->Source Code")

**Answer:** Coming from experience with languages like Java, Javascript and Python, I used to find syntax of Objective-C little cumbersome to understand, but swift removed that barrier for me. I have developer for Android in the past where views were specified in XML, so use of drag/drop on Storyboard was a breath of fresh air. Also liked the drag/drop ability to create outlets and actions. But I struggled so far to easily understand and provide constraints for auto-layouts. Also I find Apple uses really long and weird names for methods and properties, but XCode is powerful IDE and simplifies most of the annoyances I have experienced so far, albeit it is very strict about language and its syntax, so I spent lot of time trying to understand optionals and various error messages Xcode threw at me. I wanted to learn how to add sliding hamburger menus to app. Initially I tried to do it without using SWRevealViewController, but I did not understand what was happening while following tutorials. Later I used SWRevealViewController, but struggled to implement the functionality of "Done" button which will dismiss the settings view but not reinitialize the main tip-calculator view. Most of Stackoverflow answers are for Objective-C language, so finding my way around was harder, but not impossible. Overall, testing development of iOS apps so far has been a positive experience for me, and I am looking forward to delve deeper into Swift programming language.

*Outlets and Actions*: Outlets are programmatic references to the views defined in Storyboard, and actions handle various events associated with those views. Outlets allow you to changes propeties of a view/control e.g. changing size/text/color/font etc of a label, value of a text field, visibility etc, whereas actions are functions which get triggered upon a certain event associated with the view and thereby allow you to run some code when that event occurs. For example, you may show/hide something when a button is clicked by registering an action to such event.

Question 2: "Swift uses [Automatic Reference Counting](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/AutomaticReferenceCounting.html#//apple_ref/doc/uid/TP40014097-CH20-ID49) (ARC), which is not a garbage collector, to manage memory. Can you explain how you can get a strong reference cycle for closures? (There's a section explaining this concept in the link, how would you summarize as simply as possible?)"

**Answer:** 
A strong reference cycle can occur if you end up assigning a closure to a property of a class instance, and that closure captures "self" pointer to class instance. This will happen if closure's body references a property or method of class instance using "self" keyword. Now class intance has a strong reference to the closure, and closure has a strong reference to class instance (via self keyword). In order to break the strong reference, the closure body should provide a `closure capture list`, which is a comma separated list of all strong references to class instance or it's properties that closure will be capturing, but with `weak` or `unowned` keywords. This signal's swift that references being made inside closure are not strong, thereby breaking the strong reference cycle.


## License

    Copyright [2017] [Prabhjeet Ghuman]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

