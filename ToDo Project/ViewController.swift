//
//  ViewController.swift
//  ToDo Project
//
//  Created by Vivek Thakur on 21/11/19.
//  Copyright © 2019 Vivek Thakur. All rights reserved.
//

import UIKit

protocol PassData {
    func data(object:[String:Any],index:Int,editable: Bool)
}

class ViewController: UIViewController {
    
    var invent = [Inventary]()
    
    var delegate:PassData?

    var refreshControl: UIRefreshControl!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var temp: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subView.layer.cornerRadius = 35
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        invent = Database.shareInstance.fetchData()
        tableView.reloadData()
    }
    
    @objc func refreshData() {
        invent = Database.shareInstance.fetchData()
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    @IBAction func goToBtn(_ sender: UIBarButtonItem) {
        let goTo = storyboard?.instantiateViewController(withIdentifier: "AddViewController")as! AddViewController
        navigationController?.pushViewController(goTo, animated: true)
    }
    

}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return invent.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")as! TableViewCell
        cell.lblPerson.text = invent[indexPath.row].person
        cell.lblItem.text = invent[indexPath.row].item
        cell.imgPerson.image = UIImage(data: invent[indexPath.row].image! as! Data)
        
        //To Customise cell
        cell.lblItem.layer.cornerRadius = 10
        cell.lblItem.clipsToBounds = true
        cell.lblPerson.clipsToBounds = true
        cell.lblPerson.layer.cornerRadius = 10
    cell.imgPerson.layer.cornerRadius = 12    //cell.imgPerson.frame.height / 2
        cell.imgPerson.clipsToBounds = true
        cell.temp.clipsToBounds = true
        cell.temp.layer.cornerRadius = 8
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            
            invent = Database.shareInstance.deleteData(index: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dic = ["person":invent[indexPath.row].person!,"item":invent[indexPath.row].item!,"image":invent[indexPath.row].image!] as [String : Any]
        delegate?.data(object: dic, index: indexPath.row, editable: true)
        
        let goTo = storyboard?.instantiateViewController(withIdentifier: "AddViewController")as! AddViewController
        goTo.objectDic = dic
        goTo.update = true
        navigationController?.pushViewController(goTo, animated: true)
    }
    
}

