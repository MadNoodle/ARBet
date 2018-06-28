//
//  HomeViewController.swift
//  test parser
//
//  Created by Mathieu Janneau on 20/06/2018.
//  Copyright © 2018 Mathieu Janneau. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

  private let reuseId = "cellId"
  private var data = [Sport]()
  @IBOutlet weak var tableView: UITableView!
  private var viewModel = ViewModel()
  

  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupTableview()
    configuredata()
    
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tableView.beginUpdates()
    tableView.endUpdates()
  }
  private func configuredata() {
    viewModel.getRSSFeed() { result in
      self.data  = result
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }
  
  private func setupTableview() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.estimatedRowHeight = UITableViewAutomaticDimension
    tableView.register( UINib(nibName: "EventCell", bundle: nil), forCellReuseIdentifier: reuseId)
     tableView.estimatedRowHeight = 300
    tableView.rowHeight = UITableViewAutomaticDimension
    
  }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return data.count
  }
  
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return self.data[section].title
    
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return  data[section].events.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath) as! EventCell
  let currentSection = data[indexPath.section]
    let events = currentSection.events
    cell.titleLabel.text = events[indexPath.row].title
    cell.data = events[indexPath.row].match
    cell.eventTable.reloadData()
    cell.setNeedsLayout()
    cell.layoutIfNeeded()
    cell.layoutSubviews()
    return cell
  }

}
