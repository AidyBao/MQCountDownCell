//
//  ViewController.swift
//  MQCountDownCell
//
//  Created by 120v on 2018/9/14.
//  Copyright © 2018年 MQ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var dataList: Array<MQTimeModel>        = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       self.tableView.register(UINib.init(nibName:String.init(describing: MQTableViewCell.self), bundle: nil), forCellReuseIdentifier: MQTableViewCell.MQTableViewCellID)
        self.testData()
        
        // 启动倒计时管理
        ZXCountDownManager.share.start()
    }
    
    func testData() {
        for _ in 0..<20 {
            let model = MQTimeModel()
            model.nextDatetime = 2000000
            model.systime = 200000
            self.dataList.append(model)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }
    
    deinit {
        ZXCountDownManager.share.invalidate()
        ZXCountDownManager.share.reload()
    }

}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellH: CGFloat = 60.0
        return cellH
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = self.dataList.count
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MQTableViewCell = tableView.dequeueReusableCell(withIdentifier: MQTableViewCell.MQTableViewCellID, for: indexPath) as! MQTableViewCell
        if self.dataList.count > 0 {
            cell.zx_loadData(self.dataList[indexPath.row],indexPath.row)
        }
        cell.zxFCallBack = { model in
            if model.timeOut {
                
            }
        }
        return cell
    }
}


