//
//  RMViewController.swift
//  ByteCore
//
//  Created by Nico on 19/09/23.
//  Copyright © 2023 NightByteStudio. All rights reserved.
//

import RxSwift
import RxCocoa

internal final class RMViewController: BCViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.hidesWhenStopped = true
        return activityIndicatorView
    }()
    
    private let viewModel: RMViewModel = .init()
    private let disposeBag: DisposeBag = .init()
    
    override internal func setupViews() {
        super.setupViews()
        title = "RM"
        
        view.addSubview(tableView)
        view.addSubview(activityIndicatorView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            activityIndicatorView.heightAnchor.constraint(equalToConstant: 36),
            activityIndicatorView.widthAnchor.constraint(equalToConstant: 36),
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        tableView.delegate = self
    }
    
    override internal func setupBinding() {
        super.setupBinding()
        
        /// One by one
        bindViewModelState(viewModel.getCharactersState)
        bindViewModelState(viewModel.getCharacterDetailState)
        
        /// All at once
        /// viewModel.getAllStates().forEach { $0.bind(to: self) }
        
        viewModel.getCharactersState
            .compactMap { $0.success?.data }
            .bind(to: tableView.rx.items(cellIdentifier: "cell")) { indexPath, model, cell in
                cell.textLabel?.text = model.name
            }
            .disposed(by: disposeBag)
    }
    
    override internal func fetchData() {
        super.fetchData()
        viewModel.getCharacters()
    }
    
    override internal func startLoading() {
        super.startLoading()
        self.tableView.isHidden = true
        self.activityIndicatorView.startAnimating()
    }
    
    override internal func stopLoading() {
        super.stopLoading()
        self.tableView.isHidden = false
        self.activityIndicatorView.stopAnimating()
    }
    
    override internal func handleSuccess<T>(_ successState: SuccessState<T>) {
        switch successState {
            case let .withData(data):
                if let characters = data as? [RMCharacter] {
                    print(characters.map { $0.name })
                }
                
                if let character = data as? RMCharacter {
                    print(character.name)
                }
            case .noData:
                break
        }
    }
    
    override internal func handleError(_ error: Error) {
        super.handleError(error)
    }
}

extension RMViewController: UITableViewDelegate {
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
