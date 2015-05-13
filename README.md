# BuySmart
BuySmart is written in Swift, but uses eTilbudsavis SDK, which is written in Objective C.
Therefore a bridging header is included in the code. 

In order to use the app, the eTilbudsavis SDK must be installed.
The easiest way to install the eTilbudsavis SDK is by using CocoaPods.

As the podfile is already created, just run pod install in your project directory.
This will add the ETA SDK to your project, and manage all the dependencies.

If there are problems with the bridging header file, look at this:

http://stackoverflow.com/questions/24002369/how-to-call-objective-c-code-from-swift

See the documentation on the CocoaPods website if you are new to them.
