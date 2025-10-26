//
//  Carbuddy_AlertTests.swift
//  Carbuddy-AlertTests
//
//  Created by agmcoder on 10/3/25.
//

import Testing
@testable import Carbuddy_Alert
import Combine

@Suite("Dependency Container Tests")
@MainActor
struct DependencyContainerTests {

    @Test
    func registerNewInstanceEveryTime() throws {
        for _ in 0..<10 {
            DependencyContainer.shared.register((any ViewModel).self, factory: { MockViewModel() })
        }
        var resolvedInstances: [any ViewModel] = []
        for _ in 0..<10 {
            let vm: any ViewModel = try DependencyContainer.shared.resolve((any ViewModel).self)
            // Ensure the resolved type matches what we registered
            #expect(vm is MockViewModel)
            resolvedInstances.append(vm)
        }
        // Ensure each resolve returns a distinct instance
        let objectIDs = resolvedInstances.map { ObjectIdentifier($0 as AnyObject) }
        #expect(Set(objectIDs).count == resolvedInstances.count)
    }
}

// MARK: - Mocks

protocol ViewModel: ObservableObject {}

final class MockViewModel: ViewModel {}
