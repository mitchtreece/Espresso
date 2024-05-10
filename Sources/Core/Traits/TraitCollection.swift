//
//  TraitCollection.swift
//  Espresso
//
//  Created by Mitch Treece on 5/9/24.
//

import Foundation

/// A collection of traits that can be passed down, or inherited from.
public struct TraitCollection {
    
    /// The collection's traits.
    public private(set) var traits = [Trait]()
    
    /// Initializes a trait collection with a set of traits.
    /// - parameter traits: The traits to seed the collection with.
    public init(traits: [Trait]) {
        self.traits = traits
    }
    
    /// Initializes an empty trait collection.
    public init() {}
    
    /// Gets a trait from the collection using a given key.
    /// - parameter key: The trait's key.
    /// - returns: A trait, or `nil` if not found.
    public func trait(for key: String) -> Trait? {
        
        return self.traits
            .first(where: { $0.key == key })
        
    }
    
    /// Adds a trait to the collection.
    /// - parameter trait: The trait to add.
    ///
    /// If a trait with the same key already exists,
    /// this will be ignored.
    public mutating func add(trait: Trait) {
                
        guard self.trait(for: trait.key) == nil else {
            return
        }
        
        self.traits
            .append(trait)
        
    }
    
    /// Adds or updates a trait in the collection.
    /// - parameter trait: The trait to add or update.
    public mutating func addOrUpdate(trait: Trait) {
        
        if let idx = indexOfTrait(for: trait.key) {
            
            self.traits
                .remove(at: idx)
            
        }
        
        self.traits
            .append(trait)
        
    }
    
    /// Removes a trait from the collection using a given key.
    /// - parameter key: The key of the trait to remove.
    /// - returns: The removed trait, or `nil` if not found.
    @discardableResult
    public mutating func remove(for key: String) -> Trait? {
        
        guard let idx = indexOfTrait(for: key) else {
            return nil
        }
        
        let trait = self.traits[idx]
        
        self.traits
            .remove(at: idx)
        
        return trait
        
    }
    
    /// Removes all traits from the collection.
    public mutating func removeAll() {
        
        self.traits
            .removeAll()
        
    }
    
    /// Passes traits from this collection to another collection.
    ///
    /// - parameter other: The collection to pass traits to.
    ///
    /// When passing traits to another collection, the other
    /// collection's traits take priority over the ones passed down to it.
    ///
    /// For example, if collection **A** is passing traits to collection **B**
    /// and both contain different traits keyed under **"name"**,
    /// collection **B**'s trait will be taken over collection **A**'s.
    ///
    /// ```
    /// let a = TraitCollection(traits: [
    ///     .init(key: "name", value: "John Smith"),
    ///     .init(key: "age", value: 23)
    /// ])
    ///
    /// let b = TraitCollection(traits: [
    ///     .init(key: "name", value: "Jane Smith"),
    ///     .init(key: "favorite_color": value: "#aaf0d1")
    /// ])
    ///
    /// a.pass(to: b)
    ///
    /// b => TraitCollection [3] {
    ///     { key: "name", value: "Jane Smith" },
    ///     { key: "age", value: 23 },
    ///     { key: "favorite_color", value: "#aaf0d1" }
    /// }
    /// ```
    public func pass(to other: inout TraitCollection) {
        
        let traitsToPass = self.traits
            .filter { $0.isInheritable }
        
        var collection = TraitCollection(traits: traitsToPass)

        for trait in other.traits {
            
            collection
                .addOrUpdate(trait: trait)
            
        }
        
        other.traits = collection.traits
        
    }
    
    /// Constructs and returns a new trait collection by passing
    /// traits from this collection, to another collection.
    ///
    /// - parameter other: The collection to pass traits to.
    /// - returns: A new trait collection.
    ///
    /// When passing traits to another collection, the other
    /// collection's traits take priority over the ones passed down to it.
    ///
    /// For example, if collection **A** is passing traits to collection **B**
    /// and both contain different traits keyed under **"name"**,
    /// collection **B**'s trait will be taken over collection **A**'s.
    ///
    /// ```
    /// let a = TraitCollection(traits: [
    ///     .init(key: "name", value: "John Smith"),
    ///     .init(key: "age", value: 23)
    /// ])
    ///
    /// let b = TraitCollection(traits: [
    ///     .init(key: "name", value: "Jane Smith"),
    ///     .init(key: "favorite_color": value: "#aaf0d1")
    /// ])
    ///
    /// let c = a.collectionByPassing(to: b)
    ///
    /// c => TraitCollection [3] {
    ///     { key: "name", value: "Jane Smith" },
    ///     { key: "age", value: 23 },
    ///     { key: "favorite_color", value: "#aaf0d1" }
    /// }
    /// ```
    public func collectionByPassing(to other: TraitCollection) -> TraitCollection {
        
        let traitsToPass = self.traits
            .filter { $0.isInheritable }
        
        var collection = TraitCollection(traits: traitsToPass)
        
        for trait in other.traits {
            
            collection
                .addOrUpdate(trait: trait)
            
        }
        
        return collection
        
    }
    
    /// Inherits traits from another collection, to this collection.
    ///
    /// - parameter other: The collection to inherit traits from.
    ///
    /// When inheriting traits from another collection, this collection's
    /// traits take priority over the ones passed down to it.
    ///
    /// For example, if collection **B** is inheriting traits from collection **A**
    /// and both contain different traits keyed under **"name"**,
    /// collection **B**'s trait will be taken over collection **A**'s.
    ///
    /// ```
    /// let a = TraitCollection(traits: [
    ///     .init(key: "name", value: "John Smith"),
    ///     .init(key: "age", value: 23)
    /// ])
    ///
    /// let b = TraitCollection(traits: [
    ///     .init(key: "name", value: "Jane Smith"),
    ///     .init(key: "favorite_color": value: "#aaf0d1")
    /// ])
    ///
    /// b.inherit(from: a)
    ///
    /// b => TraitCollection [3] {
    ///     { key: "name", value: "Jane Smith" },
    ///     { key: "age", value: 23 },
    ///     { key: "favorite_color", value: "#aaf0d1" }
    /// }
    /// ```
    public mutating func inherit(from other: TraitCollection) {
        
        let traitsToInherit = other.traits
            .filter { $0.isInheritable }
        
        var collection = TraitCollection(traits: traitsToInherit)

        for trait in self.traits {
            
            collection
                .addOrUpdate(trait: trait)
            
        }
        
        self.traits = collection.traits
        
    }
    
    /// Constructs and returns a new trait collection by inheriting
    /// traits from another collection, to this collection.
    ///
    /// - parameter other: The collection to inherit traits from.
    ///
    /// When inheriting traits from another collection, this collection's
    /// traits take priority over the ones passed down to it.
    ///
    /// For example, if collection **B** is inheriting traits from collection **A**
    /// and both contain different traits keyed under **"name"**,
    /// collection **B**'s trait will be taken over collection **A**'s.
    ///
    /// ```
    /// let a = TraitCollection(traits: [
    ///     .init(key: "name", value: "John Smith"),
    ///     .init(key: "age", value: 23)
    /// ])
    ///
    /// let b = TraitCollection(traits: [
    ///     .init(key: "name", value: "Jane Smith"),
    ///     .init(key: "favorite_color": value: "#aaf0d1")
    /// ])
    ///
    /// let c = b.collectionByInheriting(from: a)
    ///
    /// c => TraitCollection [3] {
    ///     { key: "name", value: "Jane Smith" },
    ///     { key: "age", value: 23 },
    ///     { key: "favorite_color", value: "#aaf0d1" }
    /// }
    /// ```
    public func collectionByInheriting(from other: TraitCollection) -> TraitCollection {
        
        let traitsToInherit = other.traits
            .filter { $0.isInheritable }
        
        var collection = TraitCollection(traits: traitsToInherit)
        
        for trait in self.traits {
            
            collection
                .addOrUpdate(trait: trait)
            
        }
        
        return collection
        
    }
    
    // MARK: Private
    
    private func indexOfTrait(for key: String) -> Int? {
        
        guard let idx = self.traits
            .firstIndex(where: { $0.key == key }) else { return nil }
        
        return Int(idx)
        
    }
    
}

extension TraitCollection: CustomStringConvertible,
                           CustomDebugStringConvertible {
    
    public var description: String {
        
        var message = "TraitCollection [\(self.traits.count)]"
        
        guard !self.traits.isEmpty else {
            
            message += " {}"
            
            return message
            
        }
        
        message += " {\n"
        
        for i in 0..<self.traits.count {
            
            let trait = self.traits[i]
            let isLast = (i == (self.traits.count - 1))
            
            message += "  \"\(trait.key)\": \(type(of: trait.value))"
            message += isLast ? "\n" : ",\n"
            
        }
        
        message += "}"
        
        return message
        
    }
    
    public var debugDescription: String {
        return self.description
    }
    
}
