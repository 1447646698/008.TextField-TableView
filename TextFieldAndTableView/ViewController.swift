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


    
    @IBOutlet weak var table: UITableView!

    @IBOutlet weak var chooseTeacher: UILabel!
    
    //student控件
    @IBOutlet weak var stuTable: UITableView!
    
    @IBOutlet weak var chooseStu: UILabel!
    

     
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        studentsArry.append(Student (stuNo: 1, firstName: "1", lastName: "1", age:1, gender: Gender(rawValue: 1)!))
    }
    //学生数组
    var studentsArry = [Student]()
    //教师数组
    var teachersArry = [Teacher]()
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
        
        let teacherCell = table.dequeueReusableCell(withIdentifier: "teacherCell")!
        let stuCell = stuTable.dequeueReusableCell(withIdentifier: "stuCell") as! stuTableViewCell
        if tableView == table {
            teacherCell.textLabel?.text = "Name:\(teachersArry[indexPath.row].fullName)"
            teacherCell.detailTextLabel?.text="Title:\(teachersArry[indexPath.row].title)"
            return teacherCell
        }
        else{
            stuCell.stuNum.text = "NO:\(String(studentsArry[indexPath.row].stuNo))"
            stuCell.stuName.text = "Name:\(studentsArry[indexPath.row].fullName)"
            stuCell.stuAge.text = "Age:\(String(studentsArry[indexPath.row].age))"
            return stuCell
        }
        
    }
    //choose的分别显示
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == table{
            chooseTeacher.text = "You choose teacher: \(teachersArry[indexPath.row].fullName)"
        }
        else{
            chooseStu.text = "You choose student: \(studentsArry[indexPath.row].stuNo)"
        }
    }
    //删除功能
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if tableView == table{
            if editingStyle == .delete{
                teachersArry.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                
            }
        }
        else if tableView == stuTable && editingStyle == .delete{
                studentsArry.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
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
        else if tableView == stuTable{
            let text = studentsArry.remove(at: sourceIndexPath.row)
            studentsArry.insert(text, at: destinationIndexPath.row)
        }
    }
    
    
    //teacher添加功能
    @IBAction func add(_ sender: Any) {
        addTeacher()
        
        
    }
    var  teacherAlert:UIAlertController!
    @objc func addTeacher(){
        teacherAlert = UIAlertController(title: "Teacher", message: "add", preferredStyle: .alert)
        teacherAlert.addTextField {(text) in
            text.placeholder = "姓"}
        teacherAlert.addTextField {(text) in
            text.placeholder = "名"}
        teacherAlert.addTextField {(text) in
            text.placeholder = "科目"}
        teacherAlert.addTextField {(text) in
            text.placeholder = "性别"}
        teacherAlert.addTextField {(text) in
            text.placeholder = "年龄"}
        teacherAlert.addTextField {(text) in
            text.placeholder = "公寓(1,2,3号公寓。默认为1)"}
        
        let OK = UIAlertAction(title: "确定", style: .default) { (teAlert) in
            self.TeachAdd()
            self.table.reloadData()
        }
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        teacherAlert.addAction(OK)
        teacherAlert.addAction(cancel)
        //显示提示框
        self.present(teacherAlert, animated: true, completion: nil)
    }
    func TeachAdd(){
        
        let firstN = teacherAlert.textFields![0].text!
        let lastN = teacherAlert.textFields![1].text!
        let title = teacherAlert.textFields![2].text!
        
        let gender: Gender
        switch teacherAlert.textFields![3].text! {
        case "男","male":
            gender = .male
        case "女","female":
            gender = .female
        default:
            gender = .unknow
        }
        let age = Int(teacherAlert.textFields![4].text!)
        let depart:Department
        switch teacherAlert.textFields![5].text! {
        case "1":
            depart = .one
        case "2":
            depart = .two
        case "3":
            depart = .three
        default:
            depart = .one
        }
        
        let teacher = Teacher(title: title, firstName: firstN, lastName: lastN, age: age!, gender: gender, department: depart)
        teachersArry.append(teacher)
    }
    
    @IBAction func edit(_ sender: Any) {
        table.isEditing = !table.isEditing
    }
    
    
  
//---------学生的添加功能----------
    @IBAction func stuAddButton(_ sender: Any) {
        addStudent()
        
    }
    
    @IBAction func stuEditButton(_ sender: Any) {
        stuTable.isEditing = !stuTable.isEditing
    }
    //
    
    
    // 添加学生提示框
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
            self.stuTable.reloadData()
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
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(notification:)), name:UIResponder.keyboardWillShowNotification, object: view.window)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name:UIResponder.keyboardWillHideNotification, object: view.window)
    }
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    @objc func keyboardDidShow(notification: Notification){
        if let userInfor = notification.userInfo {
            if let rect = userInfor[UIResponder.keyboardFrameBeginUserInfoKey] as? CGRect {
                self.view.frame.origin.y = -rect.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: Notification){
        self.view.frame.origin.y = 0
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

