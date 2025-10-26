//
//  Carbuddy_AlertTests.swift
//  Carbuddy-AlertTests
//
//  Created by agmcoder on 10/3/25.
//

import Testing
import Combine

@testable import Carbuddy_Alert


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
    
    @Test
    func registerSingleton() throws {
        let dependency: any ViewModel = MockViewModel()
        let container = DependencyContainer.shared
        
        container.register((any ViewModel).self, factory: {dependency})
        
        let vm: any ViewModel = try container.resolve((any ViewModel).self)
        #expect(vm as! MockViewModel === dependency as! MockViewModel)
        
        let vm2: MockViewModel = try container.resolve((any ViewModel).self) as! MockViewModel
        #expect(vm2 === dependency as! MockViewModel)
    }
    
    @Test
    func TypeNotRegistered() throws {
        let dependency: any ViewModel = MockViewModel()
        let container = DependencyContainer.shared
        
        container.register((any ViewModel).self, factory: {dependency})
        
        do {
            _ = try container.resolve(MockViewModel.self)
            Issue.record( "Expected resolve(MockViewModel.self) to throw, but it succeeded" )
        } catch let error as DependencyContainer.ResolutionError {
            switch error {
                case .notRegistered(let type):
                    #expect(ObjectIdentifier(type) != ObjectIdentifier((any ViewModel).self))
                    #expect(String(describing: type) != String(describing: (any ViewModel).self))
                case .typeMismatch(expected: let expected, actual: let actual):
                    Issue.record("Expected to resolve \(expected), but got \(actual)")
            }
        }
    }

    // MARK: - Mocks

    protocol ViewModel: ObservableObject {}

    final class MockViewModel: ViewModel {}
}
