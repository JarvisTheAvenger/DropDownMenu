//
//  CustomView.swift
//  UICreationComponent
//
//  Created by Rahul Umap on 14/02/19.
//  Copyright © 2019 Rahul Umap. All rights reserved.
//

import UIKit

protocol CustomViewDatasource: class {
    func doSomething(_ arr: [String])
}

class CustomView: UIView {
    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var dropDownButton: UIButton!
    @IBOutlet private weak var heightConstraint: NSLayoutConstraint!
    
    weak var datasource: CustomViewDatasource?
    
    var dataSource = [String]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("CustomView", owner: self, options: nil)
        addSubview(contentView)
        setupContentView()
        setupTableView()
    }
    
    private func setupContentView() {
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
    }
    
    private func setupTableView() {
       tableView.delegate = self
       tableView.dataSource = self
       let nib = UINib(nibName: "ListTableViewCell", bundle: nil)
       tableView.register(nib, forCellReuseIdentifier: "cell")
    }
    
    @IBAction func dropDownButtonAction(_ sender: Any) {
        animateDropDown()
    }
    
    func animateDropDown() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.85, initialSpringVelocity: 0.20, options: .curveEaseInOut, animations: {
            self.heightConstraint.constant = self.heightConstraint.constant == 0 ? 200 : 0
            self.superview?.layoutIfNeeded()
        })
    }
}


extension CustomView : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ListTableViewCell
        cell.setupCell(dataSource[indexPath.row])
        return cell
     }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dropDownButton.setTitle(dataSource[indexPath.row], for: .normal)
        animateDropDown()
    }
    
}
