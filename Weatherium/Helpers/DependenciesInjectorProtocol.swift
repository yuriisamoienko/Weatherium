//
//  DependenciesInjector.swift
//  Weatherium
//
//  Created by Yurii Samoienko on 22.08.2022.
//

import Foundation

protocol DependenciesInjectorProtocol {
    func inject()
}

class Dependencies {

    public static var root: Dependencies = {
        let instance = Dependencies()
        return instance
    }()

    private init() {}

    private var factories = [String: () -> Any]()

    public func add<T>(_ factory: @escaping () -> T) {
        let key = String(describing: T.self)
        factories[key] = factory
    }

    func resolve<T>() -> T {
        let key = String(describing: T.self)

        guard let component: T = factories[key]?() as? T else {
            fatalError("Dependency '\(T.self)' not resolved!")
        }

        return component
    }
}

@propertyWrapper
public struct Inject<Value> {

    public var wrappedValue: Value {
        Dependencies.root.resolve()
    }

    public init() {}
}


/* EXAMPLE
 
 open class DependenciesInjector: NSObject, DependenciesInjectorProtocol {
     
     public func add<T>(_ factory: @escaping () -> T) {
         Dependencies.root.add(factory)
     }

     open func inject() {
         let viewControllerFactory: ViewControllerFactoryProtocol = ViewControllerFactory()
         add({ viewControllerFactory as ViewControllerFactoryProtocol })
         
         let appRouter: AppRouterProtocol = AppRouter()
         add({ appRouter as AppRouterProtocol })
         
         let coreLogic: CoreLogicProtocol = CoreLogic()
         add({ coreLogic as CoreLogicProtocol })
         
         //crash and non fatal errors reporting
         let crashReporter: CrashReporterProtocol = FirebaseCrashlyticsFacade()
         add({ crashReporter as CrashReporterProtocol })
     }
 }

 
 */
