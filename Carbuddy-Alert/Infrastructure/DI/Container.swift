//
//  Container.swift
//  Carbuddy-Alert
//
//  Created by agmcoder on 10/25/25.
//

protocol Container {
    func register<T>(_ type: T.Type, factory: @escaping () -> T)
    func resolve<T>(_ type: T.Type) throws -> T
}

final class DependencyContainer: Container {
    
    static let shared: Container = DependencyContainer()
    
    private var storage: [ObjectIdentifier: () -> Any] = [:]
    
    enum ResolutionError: Error, CustomStringConvertible {
        case notRegistered(type: Any.Type)
        case typeMismatch(expected: Any.Type, actual: Any.Type)

        var description: String {
            switch self {
            case .notRegistered(let type):
                return "No factory registered for \(type)"
            case .typeMismatch(let expected, let actual):
                return "Factory for \(expected) returned incompatible type: \(actual)"
            }
        }
    }
    
    // MARK: - Main Functions
    
    func register<T>(_ type: T.Type, factory: @escaping () -> T) {
        let key = ObjectIdentifier(type)
        storage[key] = factory
    }
    
    func resolve<T>(_ type: T.Type) throws -> T {
        let key = ObjectIdentifier(type)
        guard let factory = storage[key] else {
            throw ResolutionError.notRegistered(type: type)
        }
        let instance = factory()
        if let typed = instance as? T {
            return typed
        } else {
            throw ResolutionError.typeMismatch(expected: type, actual: Swift.type(of: instance))
        }
    }
}


