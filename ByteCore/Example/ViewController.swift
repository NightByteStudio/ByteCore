//
//  ViewController.swift
//  ByteCore
//
//  Created by Stefan Adisurya on 07/09/23.
//

import UIKit

public final class ViewController: UIViewController {
    // MARK: - Views

    private var label: UILabel
    
    // MARK: - Properties
    
    private let numbers: [Int] = [100000, 501298, 00001, 0101010, 9999999999, 74, 92812]
    
    private var number: Int {
        numbers.randomElement() ?? 0
    }
    
    // MARK: - Life Cycle
    
    public init() {
        label = UILabel(frame: .zero)
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        label = UILabel(frame: .zero)
        super.init(coder: coder)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupLabel()
    }
    
    // MARK: - Functions
    
    private func setupLabel() {
        label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 20))
        label.center = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
        label.textAlignment = .center
        label.text = "\(number.currencyDescription)"
        view.addSubview(label)
    }
}
