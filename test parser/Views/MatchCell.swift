//
//  MatchCell.swift
//  test parser
//
//  Created by Mathieu Janneau on 20/06/2018.
//  Copyright © 2018 Mathieu Janneau. All rights reserved.
//

import UIKit

class MatchCell: UITableViewCell {

  @IBOutlet weak var matchTitle: UILabel!
  @IBOutlet weak var matchTable: UITableView!
  
  override func awakeFromNib() {
        super.awakeFromNib()
 
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension MatchCell {
  func setTableViewDataSourceDelegate<D: UITableViewDataSource & UITableViewDelegate> (_ dataSourceDelegate: D, forRow row: Int) {
    matchTable.delegate = dataSourceDelegate
    matchTable.dataSource = dataSourceDelegate
    matchTable.reloadData()
  }
}
