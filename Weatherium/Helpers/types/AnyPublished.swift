//
//  AnyPublished.swift
//  Weatherium
//
//  Created by Yurii Samoienko on 30.08.2022.
//

import Foundation
import Combine

/*
 It's the best way I know for using Combine's Published variables in NOT GENERIC protocols.
 AnyPublished allows ViewModel in MVVM to be accessed though abstract protocol
 
 Instead of:
 struct MyView<ViewModel>: View where ViewModel: ModelProtocol { @ObservedObject var viewModel: ViewModel }
 we just do:
 struct MyView: View { var viewModel: ModelProtocol }
 */

class AnyPublished<Value> {
    
    @Published var val: Value
    
    init(_ value: Value) {
        self.val = value
    }

}

/*
 AnyPublished<..> variable has the same .sink(..) functionality as @@ublished variable, but without '$' sign before the variable name.
 */
extension AnyPublished: Publisher {
    func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, Value == S.Input {
        $val.receive(subscriber: subscriber)
    }
    

    typealias Output = Value
    typealias Failure = Never
}
