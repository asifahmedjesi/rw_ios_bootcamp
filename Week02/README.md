
# rw_ios_bootcamp
This is an iOS bootcamp organized by raywenderlich.com/

# Week 02

**Class**

Classes are reference types. Reference types are not copied when they are pass around in code. Rather than a copy, a reference to the same existing instance is used. Classe's life scope does not end at the end of the current code blocks until all the references to that class are destroyed. I've used class to define the game object as it contains all the game logic and I need an instance of this object through the app. I don't want all the game logic to be copied when they are pass around in code as it will not be memory efficient. We can pass around the references of tha same game object wherever it is needed and can share all the data in the game object between different modules. Classes can introduce memory leaks but if wa are careful on tracking all the references of a class and later destroy all of them then we can avoid memory leaks.


**Struct**

Structs are value types. Values are always copied when they are pass around in code. Struct's life scope ends at the end of the current code blocks where they are defined. There are no references which are pointing to struct's address and thus there will be no memory leak. That's why I've used structs for storing simple data type which can be copied at any time they are needed without worrying about any memory leaks.