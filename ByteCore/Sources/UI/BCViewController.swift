//
//  BCViewController.swift
//  ByteCore
//
//  Created by Nico Christian on 13/09/23.
//  Copyright © 2023 NightByteStudio. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

/**
 * Reusable View Controller class with provided methods for setting up MVVM binding, setting up views, and state management
 * These methods are open for overriding
 * Make sure to call the super's implementation when subclassing from BCViewController and overriding the methods
 */
open class BCViewController: UIViewController, BaseUI {
    
    private let disposeBag: DisposeBag = .init()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
        setupViews()
        fetchData()
    }
    
    open func setupBinding() { }
    
    open func setupViews() {
        view.backgroundColor = .systemGroupedBackground
    }
    
    open func fetchData() { }
    
    open func startLoading() { }
    
    open func stopLoading() { }
    
    open func handleSuccess() { }
    
    open func handleSuccessWithData<T>(_ data: T) { }
    
    open func handleError(_ error: Error) { }
}

/**
 * Default extension for BCViewController to bind a BehaviorRelay object from a view model
 * This will make the view controller to automatically subscribe to the State changes and call the relevant methods accordingly
 */
public extension BCViewController {
    final func bindViewModelState<T>(_ state: BehaviorRelay<State<T>>) {
        /// Handle ViewModel loading state
        state.map { $0.isLoading }
            .subscribe(onNext: { [weak self] isLoading in
                isLoading ? self?.startLoading() : self?.stopLoading()
            })
            .disposed(by: disposeBag)
        
        /// Handle ViewModel success state without data
        state.map { $0.isSuccess }
            .subscribe(onNext: { [weak self] success in
                if success {
                    self?.handleSuccess()
                }
            })
            .disposed(by: disposeBag)
        
        /// Handle ViewModel success state with the data
        state.compactMap { $0.data }
            .subscribe(onNext: { [weak self] data in
                self?.handleSuccessWithData(data)
            })
            .disposed(by: disposeBag)
        
        /// Handle ViewModel error state with error
        state.compactMap { $0.isError }
            .subscribe(onNext: { [weak self] error in
                self?.handleError(error)
            })
            .disposed(by: disposeBag)
    }
}
