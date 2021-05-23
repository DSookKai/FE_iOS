//
//  ShowTableViewCell.swift
//  FE_iOS-main
//
//  Created by JoSoJeong on 2021/05/23.
//

import UIKit

class ShowTableViewCell: UITableViewCell {

    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var hour: UILabel!
     
    static let identifier = "ShowTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "ShowTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(model: course){
        location.text = model.courseName
        hour.text = "\(model.courseTime)시"
        date.text = "\(model.date)"
        count.text = "\(model.travelorInfo.count)명"
    }
    
}
