//
//  MockViewController.swift
//  ByteCoreTests
//
//  Created by Nico Christian on 19/10/23.
//  Copyright © 2023 NightByteStudio. All rights reserved.
//

import UIKit
import ByteCore

internal final class MockViewController: BCViewController {
    
    internal var status: String?
    
    internal let viewModel: MockViewModel
    
    internal init(viewModel: MockViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    internal required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func startLoading() {
        self.status = "loading"
    }
    
    override func handleSuccessWithData<T>(_ data: T?) {
        self.status = (data as? MockModel)?.status
    }
    
    override func handleError(_ error: Error?) {
        self.status = "error"
    }
    
    override func handleEmpty() {
        self.status = "empty"
    }
}
