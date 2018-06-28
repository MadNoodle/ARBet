//
//  EventCell.swift
//  test parser
//
//  Created by Mathieu Janneau on 20/06/2018.
//  Copyright © 2018 Mathieu Janneau. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {

  @IBOutlet weak var tableHeight: NSLayoutConstraint!
  var data = [Match]()
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var eventTable: UITableView!
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    eventTable.register(UINib(nibName: "MatchCell", bundle: nil), forCellReuseIdentifier: "reuseId")
    eventTable.dataSource = self
    DispatchQueue.main.async {
      self.eventTable.rowHeight = UITableViewAutomaticDimension
      self.eventTable.estimatedRowHeight = 44
      var frame = self.eventTable.frame
      frame.size.height = self.eventTable.contentSize.height;
      self.eventTable.frame = frame
    self.tableHeight.constant = self.eventTable.contentSize.height
      self.layoutIfNeeded()
    
    }
     
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
      self.selectionStyle = .none
        // Configure the view for the selected state
    }

}

extension EventCell: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = eventTable.dequeueReusableCell(withIdentifier: "reuseId", for: indexPath) as! MatchCell
    cell.matchTitle.text = data[indexPath.row].name
    cell.layoutIfNeeded()
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count
  }
}

