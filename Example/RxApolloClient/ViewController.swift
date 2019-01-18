//
//  ViewController.swift
//  RxApolloClient
//
//  Created by OhKanghoon on 01/17/2019.
//  Copyright (c) 2019 OhKanghoon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxOptional

class ViewController: UIViewController {

    // MARK:- Interface
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK:- Properties
    let disposeBag = DisposeBag()
    var viewModel = ViewModel(GithubService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.rx.text
            .orEmpty
            .filterEmpty()
            .throttle(0.3, scheduler: MainScheduler.instance)
            .map { ($0, nil) }
            .bind(to: viewModel.searchRelay)
            .disposed(by: disposeBag)
        
        viewModel.repoList
            .filterNil()
            .map { $0.items }
            .filterEmpty()
            .observeOn(MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: "repocell")) { (_, repo, cell) in
                cell.textLabel?.text = repo.name
            }.disposed(by: disposeBag)
        
        tableView.rx.contentOffset
            .asObservable()
            .filter { [weak self] offset in
                guard let self = self else { return false }
                let contentHeight = self.tableView.contentSize.height
                let tableViewHeight = self.tableView.frame.height
                guard tableViewHeight > 0,
                    contentHeight > tableViewHeight else { return false }
                return (offset.y + tableViewHeight) >= contentHeight - tableViewHeight / 2
            }.withLatestFrom(self.viewModel.repoList)
            .filterNil()
            .filter { $0.after != nil }
            .map { ($0.query, $0.after) }
            .bind(to: viewModel.searchRelay)
            .disposed(by: disposeBag)
    }
    
}

