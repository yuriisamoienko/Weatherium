//
//  CollectionExtension.swift
//  Weatherium
//
//  Created by Yurii Samoienko on 20.08.2022.
//

import Foundation


extension Sequence {
    
    func asyncForEach(
        _ operation: (Element) async throws -> Void
    ) async rethrows {
        for element in self {
            try await operation(element)
        }
    }
    
    /// Transform the sequence into an array of new values using
    /// an async closure.
    ///
    /// The closure calls will be performed in order, by waiting for
    /// each call to complete before proceeding with the next one. If
    /// any of the closure calls throw an error, then the iteration
    /// will be terminated and the error rethrown.
    ///
    /// - parameter transform: The transform to run on each element.
    /// - returns: The transformed values as an array. The order of
    ///   the transformed values will match the original sequence.
    /// - throws: Rethrows any error thrown by the passed closure.
    func asyncMap<T>(
        _ transform: (Element) async throws -> T
    ) async rethrows -> [T] {
        var values = [T]()
        
        for element in self {
            try await values.append(transform(element))
        }
        
        return values
    }
    
    /// Transform the sequence into an array of new values using
    /// an async closure.
    ///
    /// The closure calls will be performed concurrently, but the call
    /// to this function won't return until all of the closure calls
    /// have completed.
    ///
    /// - parameter priority: Any specific `TaskPriority` to assign to
    ///   the async tasks that will perform the closure calls. The
    ///   default is `nil` (meaning that the system picks a priority).
    /// - parameter transform: The transform to run on each element.
    /// - returns: The transformed values as an array. The order of
    ///   the transformed values will match the original sequence.
    func asyncMap<T>(
        withPriority priority: TaskPriority? = nil,
        _ transform: @escaping (Element) async -> T
    ) async -> [T] {
        let tasks = map { element in
            Task(priority: priority) {
                await transform(element)
            }
        }
        
        return await tasks.asyncMap { task in
            await task.value
        }
    }
    
    /// Transform the sequence into an array of new values using
    /// an async closure.
    ///
    /// The closure calls will be performed concurrently, but the call
    /// to this function won't return until all of the closure calls
    /// have completed. If any of the closure calls throw an error,
    /// then the first error will be rethrown once all closure calls have
    /// completed.
    ///
    /// - parameter priority: Any specific `TaskPriority` to assign to
    ///   the async tasks that will perform the closure calls. The
    ///   default is `nil` (meaning that the system picks a priority).
    /// - parameter transform: The transform to run on each element.
    /// - returns: The transformed values as an array. The order of
    ///   the transformed values will match the original sequence.
    /// - throws: Rethrows any error thrown by the passed closure.
    func asyncMap<T>(
        withPriority priority: TaskPriority? = nil,
        _ transform: @escaping (Element) async throws -> T
    ) async throws -> [T] {
        let tasks = map { element in
            Task(priority: priority) {
                try await transform(element)
            }
        }
        
        return try await tasks.asyncMap { task in
            try await task.value
        }
    }
    
    /// Returns the result of combining the elements of the asynchronous sequence using the given closure, given a mutable initial value.
    ///
    /// - Parameters:
    ///   - initialResult: The value to use as the initial accumulating value. The `nextPartialResult` closure receives `initialResult` the first time the closure executes.
    ///   - nextPartialResult: A closure that combines an accumulating value and an element of the asynchronous sequence into a new accumulating value, for use in the next call of the `nextPartialResult closure or returned to the caller.
    /// - Returns: The final accumulated value. If the sequence has no elements, the result is `initialResult`.
    func asyncReduce<Result>(
        into initialResult: Result,
        _ updateAccumulatingResult: (inout Result, Self.Element) async throws -> Void
    ) async rethrows -> Result {
        var result = initialResult
        for element in self {
            try await updateAccumulatingResult(&result, element)
        }
        return result
    }

}
