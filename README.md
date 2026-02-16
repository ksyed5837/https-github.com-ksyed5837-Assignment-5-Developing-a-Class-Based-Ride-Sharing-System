# Assignment 5 -- Developing a Class-Based Ride Sharing System

##  Overview

This project implements a class-based Ride Sharing System in both
**C++** and **Smalltalk**.\
The objective of this assignment is to demonstrate core object-oriented
programming (OOP) principles including:

-   Encapsulation\
-   Inheritance\
-   Polymorphism

Although C++ and Smalltalk use different syntax and programming styles,
both implementations follow the same object-oriented design principles.



##  System Architecture

###  Ride (Base Class)

Represents a general ride with shared attributes:

-   rideID\
-   pickupLocation\
-   dropoffLocation\
-   distance

Methods: - displayDetails()\
- fare() (virtual in C++)


###  StandardRide (Subclass)

Inherits from Ride.

-   Uses standard pricing rate\
-   Overrides the fare() method


###  PremiumRide (Subclass)

Inherits from Ride.

-   Uses higher pricing rate\
-   Overrides the fare() method



###  Driver

-   Stores assigned rides\
-   Adds rides using controlled methods


###  Rider

-   Requests rides\
-   Stores requested rides



##  OOP Concepts Demonstrated

###  Encapsulation

-   C++: Private data members with public methods\
-   Smalltalk: Controlled access through message passing\
-   Protects internal object state

###  Inheritance

-   StandardRide and PremiumRide extend Ride\
-   Shared attributes reused\
-   Specialized fare calculation implemented

###  Polymorphism

-   Ride objects stored in collections\
-   Calling fare() dynamically selects correct subclass implementation\
-   C++ uses virtual functions\
-   Smalltalk uses dynamic method dispatch



##  Running the C++ Version

This program was executed using OnlineGDB.

1. To run the program:

2. Open https://www.onlinegdb.com

3. Select C++ as the language.

4. Copy and paste the source code into the editor.

5. Click the Run button.

The output will appear in the console window below the editor.


##  Running the Smalltalk Version

1.  Open your Smalltalk environment.\
2.  Load class definitions.\
3.  Execute the test script.\
4.  Observe dynamic behavior and output.



##  Screenshots

Screenshots of successful execution for both C++ and Smalltalk versions
are included in this repository.



##  Learning Outcomes

By completing this project, I demonstrated:

-   Practical application of OOP principles\
-   Cross-language comparison of object-oriented design\
-   Implementation of dynamic polymorphism\
-   System modeling using class-based architecture

------------------------------------------------------------------------
