//
//  ViewController.swift
//  TextFieldAndTableView
//
//  Created by student on 2018/12/5.
//  Copyright © 2018年 2016110316. All rights reserved.
//



import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    //teacher控件
    @IBOutlet weak var addText: UITextField!
    
    @IBOutlet weak var table: UITableView!

    @IBOutlet weak var chooseTeacher: UILabel!
    
    //student控件
    @IBOutlet weak var stuTable: UITableView!
    
    @IBOutlet weak var chooseStu: UILabel!
    
    @IBOutlet weak var stuAddText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        teachersArry.append("123456")
    }
    //学生数组
    var studentsArry = [Student]()
    //教师数组
    var teachersArry = [String]()
    //获取数量
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == table{
            return teachersArry.count
        }
        else{
            return studentsArry.count
        }
    }
    //cell的分别显示
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell
        if tableView == table {
            cell = table.dequeueReusableCell(withIdentifier: "teacherCell")!
            cell.textLabel?.text = teachersArry[indexPath.row]//.fullName
            return cell
        }
        else{
            cell = stuTable.dequeueReusableCell(withIdentifier: "stuCell")!
            cell.textLabel?.text = studentsArry[indexPath.row].fullName
            return cell
        }
        
    }
    //choose的分别显示
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == table{
            chooseTeacher.text = "You choose teacher: \(teachersArry[indexPath.row])"
        }
        else{
            chooseStu.text = "You choose student: \(studentsArry[indexPath.row])"
        }
    }
    //删除功能
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            if tableView == table{
                teachersArry.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            else{
                studentsArry.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    //移动功能
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        if tableView == table{
            let text = teachersArry.remove(at: sourceIndexPath.row)
            teachersArry.insert(text, at: destinationIndexPath.row)
        }
        else{
            let text = studentsArry.remove(at: sourceIndexPath.row)
            studentsArry.insert(text, at: destinationIndexPath.row)
        }
    }
    
    
    //添加功能
    @IBAction func add(_ sender: Any) {
        if let text = addText.text{
           //防止添加空数据
            if !text .isEmpty{
                teachersArry.append(text)
                table.reloadData()
                addText.resignFirstResponder()
                addText.text = nil
            }
        }
    }
    
    @IBAction func edit(_ sender: Any) {
        table.isEditing = !table.isEditing
    }
    
    
  
//---------学生的添加功能----------
    @IBAction func stuAddButton(_ sender: Any) {
        addStudent()
        stuTable.reloadData()
    }
    
    @IBAction func stuEditButton(_ sender: Any) {
        stuTable.isEditing = !stuTable.isEditing
    }
    
    
    
    
    /// 添加学生提示框
   var  alert:UIAlertController!
    @objc func addStudent() {
        
        alert = UIAlertController(title: "hh", message: "ss", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "学号"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "姓"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "名"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "性别:男或女,其他"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "年龄"
        }
        
        let OKBtn = UIAlertAction(title: "确定", style: .default) { (alert) in
            self.add()
        }
        let cancelBtn = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alert.addAction(OKBtn)
        alert.addAction(cancelBtn)
        //显示提示框
        self.present(alert, animated: true, completion: nil)
    }
    
    // 添加学生
    func add() {
        let no = Int(alert.textFields![0].text!)
        let firstName = alert.textFields![1].text!
        let lastName = alert.textFields![2].text!
        let gender: Gender
        switch alert.textFields![3].text! {
        case "男","male":
            gender = .male
        case "女","female":
            gender = .female
        default:
            gender = .unknow
        }
        let age = Int(alert.textFields![4].text!)
        let student = Student(stuNo: no!, firstName: firstName, lastName: lastName, age: age!, gender: gender)
        studentsArry.append(student)
    }
//--------------------------
   
    
}

