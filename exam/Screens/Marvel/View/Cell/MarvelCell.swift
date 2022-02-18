//
//  MarvelCell.swift
//  exam
//
//  Created by Moises Lugo on 16/02/22.
//

import UIKit

class MarvelCell: UITableViewCell {

    @IBOutlet var idLabel: UILabel!
    class var identifier: String { return String(describing: self) }
        class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    var cellViewModel: FigureCellViewModel? {
            didSet {
                idLabel.text = cellViewModel?.name
              //  nameLabel.text = cellViewModel?.name
               
            }
        }

    override func awakeFromNib() {
        super.awakeFromNib()
        initView()
    }

    func initView() {
           // Cell view customization
           backgroundColor = .clear
           
           // Line separator full width
           preservesSuperviewLayoutMargins = false
           separatorInset = UIEdgeInsets.zero
           layoutMargins = UIEdgeInsets.zero
       }
    
    override func prepareForReuse() {
          super.prepareForReuse()
          idLabel.text = nil
       
      }
    
    
}
