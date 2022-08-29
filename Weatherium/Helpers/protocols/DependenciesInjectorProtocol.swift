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

extension DependenciesInjectorProtocol {
    
    func addDependency<T>(_ factory: @escaping () -> T) {
        Dependencies.root.add(factory)
    }
    
    func resolve<T>() -> T { // in case if you can't use property wrapper @Inject
        Dependencies.root.resolve()
    }
    
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
     
     open func inject() {
         let viewControllerFactory: ViewControllerFactoryProtocol = ViewControllerFactory()
         addDependency({ viewControllerFactory as ViewControllerFactoryProtocol })
                 
         addDependency appRouter: AppRouterProtocol = AppRouter()
         addDependency({ appRouter as AppRouterProtocol })
         
         let coreLogic: CoreLogicProtocol = CoreLogic()
         addDependency({ coreLogic as CoreLogicProtocol })
         
         //crash and non fatal errors reporting
         addDependency crashReporter: CrashReporterProtocol = FirebaseCrashlyticsFacade()
         add({ crashReporter as CrashReporterProtocol })
     }
 }

 
 */
