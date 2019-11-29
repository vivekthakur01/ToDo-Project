//
//  AddViewController.swift
//  ToDo Project
//
//  Created by Vivek Thakur on 21/11/19.
//  Copyright © 2019 Vivek Thakur. All rights reserved.
//

import UIKit


class AddViewController: UIViewController,PassData{
   
    
    var i = Int()
    let imagePicker = UIImagePickerController()
    var temp = NSData()
    var update = Bool()
    var objectDic : [String: Any]?
    
    @IBOutlet weak var itemText: UITextField!
    @IBOutlet weak var personText: UITextField!
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(saveImage))
        saveImage()
        imgView.isUserInteractionEnabled = true
        imgView.addGestureRecognizer(tap)
        imagePicker.delegate = self
        imgView.layer.cornerRadius = self.imgView.frame.height / 2

        if let dict = objectDic {
            itemText.text = (dict["item"] as! String)
            personText.text = (dict["person"] as! String)
            imgView.image = UIImage(data: Data(referencing: dict["image"] as! NSData))
        }
       // temp = imgView.image?.jpegData(compressionQuality: 0) as NSData? ?? temp
    }
    
    
    @IBAction func saveBtn(_ sender: UIButton) {
        
        var dict = ["person":personText.text!,"item":itemText.text!] as [String : Any]
        let show = storyboard?.instantiateViewController(withIdentifier: "ViewController")as! ViewController
        show.delegate = self
        temp = (imgView.image?.jpegData(compressionQuality: 0.2)! as NSData?)! 
        dict["image"] = temp
//      show.tableView.reloadData()
        if update == true {
            Database.shareInstance.editData(object: dict, i: i)
        }else{
            Database.shareInstance.save(object: dict)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @objc func saveImage(){
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker,animated: true, completion: nil)
        
    }
    func data(object: [String : Any],index:Int,editable:Bool) {
        personText.text = object["person"] as? String
        itemText.text = object["item"] as? String
        temp = object["image"] as? NSData ?? temp
        i = index
        update = editable
    }
    

}
extension AddViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage]{
            imgView.image = image as? UIImage
        
        }
        dismiss(animated: true, completion: nil)
    }
   
}
