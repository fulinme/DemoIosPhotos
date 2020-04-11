#  Requirement


- Functionality:  my understanding is just present thumbnail(maybe to check whether  present other informations from json?)

- Don't use 3-party libraries




# Architecture

mvc’s issue:
massive viewcontroller,  view and data model interact with each other, not easy for unit testing.


mvvm is a mvp with reactive programming.
Base on the purpose of this project,  and my degree of familiarity with reactive,  it is better not use reactive this time.





# UI design
How to present thumbnail？
Follow the Apple photos app’s design.  
Uicollectionview with flow layout

