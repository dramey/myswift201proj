//
//  TodoListStore.swift
//  todoList
//
//  Created by Deb Ramey on 10/24/16.
//  Copyright © 2016 Deb Ramey. All rights reserved.
//

import UIKit


class TodoListStore{
    static let shared = TodoListStore()
    
    fileprivate var todosList = [[TodoList]]()
    
    var selectedImage: UIImage?
    
    init(){
        let filePath = archiveFilePath()
        let fileManager = FileManager.default
        
        if fileManager.fileExists(atPath:filePath){
            todosList = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as! [[TodoList]]
        }else{
            todosList = [[],[],[]]

            save()
            
        }
        sort()
        
    }
    
    //MARK: - Public functions
    
    func getTodoList(_ index: Int, category: Int) -> TodoList{
        return todosList[category][index]
    }
    
    func addTodoList(_ todoList: TodoList, category: Int){
        todosList[category].insert(todoList, at: 0)
      

    }
    
    func updateTodoList(_ todoList: TodoList, index: Int,       category: Int){
        todosList[category][index] = todoList
    }
    
    func deleteTodoList(_ index: Int, category: Int){
        todosList[category].remove(at: index)
    }
    
    func getCount(category: Int) -> Int{
        return todosList[category].count
    }
    
    func whatPriority(category: Int) -> Double{
        var priority = 0.0
        for task in todosList[category]{
            priority = max(priority, task.priority)
        }
        return priority + 1.0
    }
    
    func save(){
        NSKeyedArchiver.archiveRootObject(todosList, toFile: archiveFilePath())
    }
    
    func sort(){
        
    }
    //MARK: - PRIVATE FUNCTIONS
    fileprivate func archiveFilePath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths.first!
        let path = (documentsDirectory as NSString).appendingPathComponent("TodoListStore.plist")  //plist short for property list
        return path
    }
}
