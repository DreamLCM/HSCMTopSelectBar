//
//  ViewController.swift
//  HSCMTopSelectBar
//
//  Created by 953330953@qq.com on 05/24/2020.
//  Copyright (c) 2020 953330953@qq.com. All rights reserved.
//

import UIKit
import HSCMTopSelectBar

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let viewSelectContent = HSCMTopSelectBar()
        viewSelectContent.frame = CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: 60)
        viewSelectContent.delegate = self
        viewSelectContent.dataSource = self
        view.addSubview(viewSelectContent)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: HSCMTopSelectBarViewDelegate, HSCMTopSelectBarViewDataSource{
    
    func topSelectBarViewArrayTitle() -> [String] {
        return ["签约信息","递增设置","递增设置"]
    }
    
    func topSelectBarView(didSelectItemAt index: Int) {
        print("当前点击\(index)")
    }
}
