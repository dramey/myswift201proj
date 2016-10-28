//
//  TodoListTableViewController.swift
//  TodoList
//
//  Created by Deb Ramey on 10/24/16.
//  Copyright © 2016 Deb Ramey. All rights reserved.
//

import UIKit

class TodoListTableViewController: UITableViewController {
    
    var onlyIfComplete = false
    
    @IBAction func showOnlyComplete(_ sender: AnyObject) {
        onlyIfComplete = !onlyIfComplete
        tableView.reloadData()
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isEditing = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        // Uncomment the following line to preserve selection between presentations
        //self.clearsSelectionOnViewWillAppear = false
        
        
        // self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        //like contacts app on your phone each letter has a section--we do not need multiple sections. We
        //want a row for each todoList
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return TodoListStore.shared.getCount(category: section)
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case 0:
            return "Home"
        case 1:
            return "Work"
        case 2:
            return "Other"
        default:
            return "Doesn't Exist"
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //dequeue takes off the top and adds to bottom
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TodoListTableViewCell.self)) as! TodoListTableViewCell
        
        cell.setupCell(TodoListStore.shared.getTodoList(indexPath.row, category: indexPath.section))
        // Configure the cell...
        if onlyIfComplete == false {
            if cell.todoList.completion == true {
                cell.isHidden = true
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return.delete
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    
    //Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            TodoListStore.shared.deleteTodoList(indexPath.row, category: indexPath.section)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
    }
    override func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        if sourceIndexPath.section == proposedDestinationIndexPath.section{
            return proposedDestinationIndexPath
        } else {
            return sourceIndexPath
        }
    }
    
    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //where we tell the segue to work
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditTodoListSegue" {
            let todoListDetailVC = segue.destination as! TodoListDetailViewController
            let tableCell = sender as! TodoListTableViewCell
            todoListDetailVC.todoList = tableCell.todoList
            
            
            // Get the new view controller using segue.destinationViewController.
            // Pass the selected object to the new view controller.
        }
        
    }
    //MARK: -  Unwind Segue
    @IBAction func saveTodoListDetail(_ segue: UIStoryboardSegue){
        let todoListDetailVC = segue.source as! TodoListDetailViewController
        if let indexPath = tableView.indexPathForSelectedRow{
            // DID NOT ACTUALLY NEED TodoListStore.shared.updateTodoList(todoListDetailVC.todoList, index: indexPath.row)
            TodoListStore.shared.sort()
            
            var indexPaths: [IndexPath] = []
            for index in 0...indexPath.row{
                indexPaths.append(IndexPath(row:index, section: indexPath.section))
            }
            
            tableView.reloadRows(at: indexPaths, with: .automatic)
        }else{
            TodoListStore.shared.addTodoList(todoListDetailVC.todoList, category: todoListDetailVC.todoList.category)
            tableView.reloadData()
            
        }
    }
}

