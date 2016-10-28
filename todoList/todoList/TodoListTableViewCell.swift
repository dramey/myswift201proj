//
//  TodoListTableViewCell.swift
//  todoList
//
//  Created by Deb Ramey on 10/24/16.
//  Copyright © 2016 Deb Ramey. All rights reserved.
//

import UIKit

class TodoListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var todoListTitleLabel: UILabel!
    @IBOutlet weak var todoListTextLabel: UILabel!
    @IBOutlet weak var todoListDateLabel: UILabel!
    @IBOutlet weak var dueDate: UILabel!
    
    @IBOutlet weak var completeLabel: UILabel!
    weak var todoList: TodoList!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
  
    
    func setupCell(_ todoList: TodoList){
        self.todoList = todoList
        todoListTitleLabel.text = todoList.title
        todoListTextLabel.text = todoList.text
        todoListDateLabel.text = todoList.dateString
        dueDate.text = todoList.dueDate
        completeLabel.text = todoList.completion ? "Complete" : ""
    }
}
    

