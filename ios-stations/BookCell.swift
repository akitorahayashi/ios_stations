//
//  BookCell.swift
//  ios-stations
//

import UIKit

class BookCell: UITableViewCell {
    var element: Book?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
}
