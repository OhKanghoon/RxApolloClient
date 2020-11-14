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

final class ViewController: UIViewController {

  // MARK: UI

  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var tableView: UITableView!


  // MARK: Properties

  private let viewModel = ViewModel(GithubService(client: .init()))
  private let disposeBag = DisposeBag()


  // MARK: View Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    self.bindSearch()
    self.bindTableView()
  }

  private func bindSearch() {
    self.searchBar.rx.text
      .orEmpty
      .filterEmpty()
      .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
      .map { ($0, nil) }
      .bind(to: self.viewModel.searchRelay)
      .disposed(by: self.disposeBag)
  }

  private func bindTableView() {
    self.viewModel.repoList
      .map { $0.items }
      .filterEmpty()
      .drive(self.tableView.rx.items(cellIdentifier: "repocell")) { (_, repo, cell) in
        cell.textLabel?.text = repo.name
      }
      .disposed(by: self.disposeBag)

    self.tableView.rx.contentOffset
      .asObservable()
      .filter { [weak self] offset in
        guard let self = self else { return false }
        let contentHeight = self.tableView.contentSize.height
        let tableViewHeight = self.tableView.frame.height
        guard tableViewHeight > 0, contentHeight > tableViewHeight else { return false }
        return (offset.y + tableViewHeight) >= contentHeight - tableViewHeight / 2
      }
      .withLatestFrom(self.viewModel.repoList)
      .filter { $0.after != nil }
      .map { ($0.query, $0.after) }
      .bind(to: self.viewModel.searchRelay)
      .disposed(by: self.disposeBag)
  }
}

