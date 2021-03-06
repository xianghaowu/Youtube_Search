//
//  SearchViewController+TableView.swift
//  Youtube_Test
//
//  Created by MeiXiang Wu on 7/11/22.
//

import UIKit

// MARK: - UITableView Data Source
extension SearchViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return Constants.height
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.count()
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let itemViewModel = viewModel.dataSource[indexPath.row]
    let cell = tableView.dequeueReusableCell(for: indexPath) as SearchItemTableViewCell
    cell.setup(viewModel: itemViewModel)
    return cell
  }
}

// MARK: - UITableView Delegate
extension SearchViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let itemViewModel = viewModel.dataSource[indexPath.row]
    let youtubePlayerViewController = YoutubePlayerViewController(itemViewModel: itemViewModel)
    self.navigationController?.pushViewController(youtubePlayerViewController, animated: true)
  }
}
