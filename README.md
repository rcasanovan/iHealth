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