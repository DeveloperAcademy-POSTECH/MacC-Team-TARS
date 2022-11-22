//
//  SettingViewController.swift
//  Tars
//
//  Created by 김소현 on 2022/11/15.
//

import UIKit

class SettingViewController: UIViewController {
    
    let settingTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        return tableView
    }()
    
//    let settingTableView = UITableView(frame: .zero, style: .insetGrouped)
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        [settingTableView].forEach{ view.addSubview($0) }
        
        settingTableView.delegate = self
        settingTableView.dataSource = self
        configureConstraints()
        navigationItem.title = "설정"
        view.backgroundColor = .systemBackground
    }
    
    func configureConstraints() {
        
        settingTableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor)
        
    }
    
}

extension SettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Setting.allCases[section].numberOfRowInSections
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as? SettingTableViewCell else { return UITableViewCell() }
        
        cell.settingLabel.text = Setting.allCases[indexPath.section].contents[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(describing: Setting.allCases[section])
    }
    
}

extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Setting.allCases.count
    }
}

enum Setting: CaseIterable, CustomStringConvertible {
    case service
    case terms
    case etc
    
    var contents: [String] {
        switch self {
        case .service:
            return ["Team TARS", "인스타그램", "공지사항"]
        case .terms:
            return ["위치기반서비스 이용약관", "오픈소스 라이선스"]
        case .etc:
            return ["버전 정보"]
        }
    }
    
    var numberOfRowInSections: Int {
        return contents.count
    }
    
    var description: String {
        switch self {
        case .service:
            return "앱 서비스"
        case .terms:
            return "약관 및 정책"
        case .etc:
            return "앱 정보"
        }
    }
}
