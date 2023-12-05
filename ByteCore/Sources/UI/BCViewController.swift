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
    
    /// Overridable method to execute view models binding to the view controller
    open func setupBinding() { }
    
    /// Overridable method to setup the view hierarchy (e.g. setting up any constraints, adding child views, etc)
    open func setupViews() {
        view.backgroundColor = .systemGroupedBackground
    }
    
    /// Overridable method to call APIs, this method can then be recalled when there are any refresh logic
    open func fetchData() { }
    
    /// Overridable method that automatically called when the binded view model state enters loading. To show loading state of the view
    open func startLoading() { }
    
    /// Overridable method that automatically called when the binded view model state exits loading. To hide the loading state of the view
    open func stopLoading() { }
    
    /// Overridable method that automatically called when the binded view model state returns success. Passed in the data to the view controller
    /// successState: SuccessState<T> is a success state enum that can contains data or no data
    open func handleSuccess<T>(_ successState: SuccessState<T>) { }
    
    /// Overridable method that automatically called when the binded view model state returns failure. Passed in the error to the view controller
    open func handleError(_ error: Error) { }
    
    /// Overridable method that automatically called when the binded view model state returns empty.
    open func handleEmpty() { }
}

/**
 * Default extension for BCViewController to bind a BehaviorRelay object from a view model
 * This will make the view controller to automatically subscribe to the State changes and call the relevant methods accordingly
 */
public extension BCViewController {
    final func bindViewModelState<T>(_ state: BehaviorRelay<State<T>>) {
        /// Handle ViewModel error state with error
        state.compactMap { $0.error }
            .subscribe(onNext: { [weak self] error in
                self?.handleError(error)
            })
            .disposed(by: disposeBag)
        
        /// Handle ViewModel loading state
        state.map { $0.isLoading }
            .subscribe(onNext: { [weak self] isLoading in
                isLoading ? self?.startLoading() : self?.stopLoading()
            })
            .disposed(by: disposeBag)
        
        /// Handle ViewModel success state without data
        state.compactMap { $0.success }
            .subscribe(onNext: { [weak self] success in
                self?.handleSuccess(success)
            })
            .disposed(by: disposeBag)
        
        state.map { $0.isEmpty }
            .subscribe(onNext: { [weak self] isEmpty in
                if isEmpty {
                    self?.handleEmpty()
                }
            })
            .disposed(by: disposeBag)
    }
}
