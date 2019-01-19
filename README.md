# iHealth

This is a simple iOS app to integrate HealthKit to show some info for the user

## 🚨 Important note 🚨

This project is using cocoapods. Please be sure to run the **pod install** command before running the project.

If you have any doubt about cocoapods you can check the reference [here](https://cocoapods.org).

## Project Architecture 
![alt tag](https://github.com/rcasanovan/iHealth/blob/master/Images/projectArchitecture.jpeg?raw=true)

References:
* [Viper architecture](https://www.objc.io/issues/13-architecture/viper/)
* [Viper for iOS](https://medium.com/@smalam119/viper-design-pattern-for-ios-application-development-7a9703902af6)

## How did I implement VIPER?

Basically I have a protocol file for each scene in the app. This file defines the interaction between each layer as following:

* View - Presenter: protocols to notify changes and to inject information to the UI.
* Presenter - Interactor: protocols to request / receive information to / from the interator.
* Presenter - Router: protocol to define the transitions between scenes (I skiped this protocols for the demo because I have only a scene there).

Whith this protocols file is really easy to know how each layer notify / request / information to the other ones so we don't have any other way to communicate all the layers.

Another important point is because I'm using protocols it's really easy to define mocks views / presenters / interactors / routers for testing.

```swift
// View / Presenter
protocol GoalsViewInjection : class {
    func showProgress(_ show: Bool, status: String)
    func showProgress(_ show: Bool)
    func showMessageWith(title: String, message: String, actionTitle: String)
    func loadGoals(_ viewModels: [GoalViewModel])
}

protocol GoalsPresenterDelegate : class {
    func viewDidLoad()
    func refresh()
}

// Presenter / Interactor

typealias GoalsGetGoalsCompletionBlock = (_ viewModel: [GoalViewModel]?, _ success: Bool, _ error: ResultError?) -> Void

protocol GoalsInteractorDelegate : class {
    func getGoalsList(completion: @escaping GoalsGetGoalsCompletionBlock)
    func clear()
}
```

## First at all. Where is the data came from?

I'm using the following endpoint to get the goals list -> https://thebigachallenge.appspot.com/_ah/api/myApi/v1/goals/.

## Data models

### Network data models

```swift
public struct GoalsResponse: Decodable {
    
    let items: [GoalResponse]
    
}

public struct GoalResponse: Decodable {
    
    let id: String
    let title: String
    let description: String
    let type: String
    let goal: Int
    let reward: RewardResponse
    
}

public struct RewardResponse: Decodable {
    
    let trophy: String
    let points: Int
    
}
```

I'm using a Swift Standard Library decodable functionality in order to manage a type that can decode itself from an external representation (I really ❤ this from Swift).

Reference: [Apple documentation](https://developer.apple.com/documentation/swift/swift_standard_library/encoding_decoding_and_serialization)

### Local goals data model

This model is used for the local goals

```swift
class LocalGoal: Object {
    
    @objc dynamic var goalId: String?
    @objc dynamic var title: String = ""
    @objc dynamic var goalDescription: String = ""
    @objc dynamic var type: String = ""
    @objc dynamic var goal: Int = 0
    @objc dynamic var trophy: String = ""
    @objc dynamic var points: Int = 0
    
    override class func primaryKey() -> String? {
        return "goalId"
    }
    
}
```

As I'm using Realm for this it's important to define a class to manage each model in the database. In this case we only have one model (LocalGoal)

Reference: [Realm](https://realm.io/docs/swift/latest)

## Managers

I think using managers is a good idea but be careful!. Please don't create managers as if the world were going to end tomorrow.

I'm using only 4 here:

### ShareManager

Used to share the current progress using UIActivityViewController.

### ReachabilityManager

Used to manage the reachability. In this case I would like to notify a little issue related with the simulator. *It seems Xcode has an issue with the simulator because if you try to turn off the wifi and turning on again, the observer for the state change is not triggering. It's working 100% fine in a real device*.

### LocalGoalManager

Used to save the goals locally using a Realm database.

### HealthManager

Used to manage all the connections and requests with the HealthKit framework.

## How it looks like?

### General goals and my personal goals
![alt tag](https://github.com/rcasanovan/iHealth/blob/master/Images/01.PNG?raw=true)
![alt tag](https://github.com/rcasanovan/iHealth/blob/master/Images/02.PNG?raw=true)

### Share option && permission request
![alt tag](https://github.com/rcasanovan/iHealth/blob/master/Images/03.PNG?raw=true)
![alt tag](https://github.com/rcasanovan/iHealth/blob/master/Images/04.PNG?raw=true)

### No internet connection screen
![alt tag](https://github.com/rcasanovan/iHealth/blob/master/Images/05.PNG?raw=true)

## What's left in the demo?

* Realm migration process: It would be nice to add a process to migrate the realm database to a new model (just in case you need to add a new field into the database).
* Localizable strings from server (goals list): It would be nice to have an option to retrieve the goals list with localizable strings according with the device language.

## Programming languages && Development tools

* Swift 4.2
* Xcode 10.1
* [Cocoapods](https://cocoapods.org) 1.5.3
* Minimun iOS version: 12.1

## Third-Party Libraries

* [RealmSwift](https://github.com/realm/realm-cocoa) (3.7.6): A mobile database that runs directly inside phones, tablets or wearables
* [SVProgressHUD](https://github.com/SVProgressHUD/SVProgressHUD) (2.2.5): A clean and lightweight progress HUD for your iOS and tvOS app.
* [XYPieChart](https://github.com/xyfeng/XYPieChart) (0.2): A library to create pie charts for iOS and MacOS.

## Support && contact

### Email

You can contact me using my email: ricardo.casanova@outlook.com

### Twitter

Follow me [@rcasanovan](http://twitter.com/rcasanovan) on twitter.
