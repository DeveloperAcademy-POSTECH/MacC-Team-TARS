//
//  SettingTableViewCell.swift
//  Tars
//
//  Created by ParkJunHyuk on 2022/11/22.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    static let identifier: String = "SettingTableViewCell"
    
    var settingLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutSubviews()
        
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        [settingLabel].forEach {
            self.contentView.addSubview($0)
        }
        
        settingLabel.anchor(top: safeAreaLayoutGuide.topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: safeAreaLayoutGuide.trailingAnchor)
    }
}
