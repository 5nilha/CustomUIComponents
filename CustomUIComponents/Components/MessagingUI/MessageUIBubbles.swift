//
//  MessageUIBubbles.swift
//  CustomUIComponents
//
//  Created by Fabio Quintanilha on 5/3/20.
//  Copyright © 2020 TaskHackers. All rights reserved.
//

import UIKit

class MessageUIBubbles: UITableView {
  
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //Mark: TableView Configuration
    private func configTableView() {
        self.delegate = self
        self.dataSource = self
        self.register(MessageUIBubbleCell.self, forCellReuseIdentifier: "MessageUIBubbleCell")
    }
}

extension MessageUIBubbles: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MessageUIBubbleCell", for: indexPath) as? MessageUIBubbleCell else {
            return UITableViewCell()
        }
        return cell
    }
}
