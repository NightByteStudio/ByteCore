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
    private let localViewModel: LocalRMViewModel = .init()
    
    private var charArray: [RMCharacter] = []
    
    override func setupViews() {
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
    
    override func setupBinding() {
        super.setupBinding()
        
        /// One by one
        bindViewModelState(viewModel.getCharactersState)
        bindViewModelState(viewModel.getCharacterDetailState)
        
        /// Local State Binding
        bindViewModelState(localViewModel.saveDataLocalState)
        bindViewModelState(localViewModel.getDataLocalState)
        bindViewModelState(localViewModel.deleteDataLocalState)
        bindViewModelState(localViewModel.initRealmState)
        
        /// All at once
        /// viewModel.getAllStates().forEach { $0.bind(to: self) }
        
        viewModel.getCharactersState
            .compactMap { $0.data }
            .bind(to: tableView.rx.items(cellIdentifier: "cell")) { indexPath, model, cell in
                cell.textLabel?.text = model.name
            }
            .disposed(by: disposeBag)
    }
    
    override func fetchData() {
        super.fetchData()
        viewModel.getCharacters()
    }
    
    override func startLoading() {
        super.startLoading()
        self.tableView.isHidden = true
        self.activityIndicatorView.startAnimating()
    }
    
    override func stopLoading() {
        super.stopLoading()
        self.tableView.isHidden = false
        self.activityIndicatorView.stopAnimating()
    }
    
    override func handleSuccess() {
        super.handleSuccess()
    }
    
    override func handleSuccessWithData<T>(_ data: T) {
        super.handleSuccessWithData(data)
        
        if let characters = data as? [RMCharacter] {
            print(characters.map { $0.name })
            self.charArray = characters
        }
        
        if let character = data as? RMCharacter {
            print(character.name)
            self.charArray.removeAll()
            self.charArray.append(character)
        }
        
        if let characters = data as? [LocalRMCharacter] {
            print(characters.map { $0.name })
        }
    }
    
    override func handleError(_ error: Error) {
        super.handleError(error)
    }
}

extension RMViewController: UITableViewDelegate {
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let usedChar = self.charArray[indexPath.row]
        localViewModel.saveData(id: usedChar.id, name: usedChar.name)
    }
}
