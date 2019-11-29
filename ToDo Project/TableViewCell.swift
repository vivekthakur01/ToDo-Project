//
//  TableViewCell.swift
//  ToDo Project
//
//  Created by Vivek Thakur on 21/11/19.
//  Copyright © 2019 Vivek Thakur. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    var img: Data?
    
    @IBOutlet weak var lblItem: UILabel!
    @IBOutlet weak var imgPerson: UIImageView!
    @IBOutlet weak var lblPerson: UILabel!
    @IBOutlet weak var temp: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
      //  let image = UIImage(data: (img as? Data)! )
     //   img = imgPerson.image?.jpegData(compressionQuality: 0) as NSData?
//        imgPerson.image = UIImage(data: img as! Data)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        

    }

}
