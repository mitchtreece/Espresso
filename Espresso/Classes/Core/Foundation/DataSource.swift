//
//  DataSource.swift
//  Espresso
//
//  Created by Mitch Treece on 3/10/19.
//

// NOTE: Still working on this.
// Will uncomment and release when ready.

//import Foundation
//
//public protocol DataSourceDelegate: class {
//
//    func dataSourceWillFetchData<T>(_ dataSource: DataSource<T>)
//    func dataSource<T>(_ dataSource: DataSource<T>, didFetchData newData: [T])
//    func dataSourceWillReloadData<T>(_ dataSource: DataSource<T>)
//    func dataSourceDidReloadData<T>(_ dataSource: DataSource<T>)
//
//}
//
//public extension DataSourceDelegate /* Optional */ {
//
//    func dataSourceWillFetchData<T>(_ dataSource: DataSource<T>) {}
//    func dataSource<T>(_ dataSource: DataSource<T>, didFetchData newData: [T]) {}
//    func dataSourceWillReloadData<T>(_ dataSource: DataSource<T>) {}
//    func dataSourceDidReloadData<T>(_ dataSource: DataSource<T>) {}
//
//}
//
//public class DataSource<T> {
//
//    public typealias Completion = ([T])->()
//    public typealias Request = (Completion)->()
//
//    private let request: Request
//    private var isLoading: Bool = false
//    private var isReloading: Bool = false
//
//    public private(set) var data = [T]()
//
//    public weak var delegate: DataSourceDelegate?
//
//    public init(_ request: @escaping Request) {
//        self.request = request
//    }
//
//    public func fetch() {
//
//        guard !self.isLoading else { return }
//        self.isLoading = true
//
//        self.delegate?.dataSourceWillFetchData(self)
//
//        func finish(newData: [T]) {
//
//            self.data.append(contentsOf: newData)
//            self.isLoading = false
//
//            self.delegate?.dataSource(self, didFetchData: newData)
//
//            if self.isReloading {
//
//                self.isReloading = false
//                self.delegate?.dataSourceDidReloadData(self)
//
//            }
//
//        }
//
//        self.request(finish)
//
//    }
//
//    public func reload() {
//
//        guard !self.isLoading else { return }
//
//        self.delegate?.dataSourceWillReloadData(self)
//
//        self.isReloading = true
//        self.data.removeAll()
//        fetch()
//
//    }
//
//}
