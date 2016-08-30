//
//  ViewController.swift
//  Swift - tableView的单元格多选功能的实现（获取多选值、多选删除）
//
//  Created by 道标朱 on 16/8/30.
//  Copyright © 2016年 道标朱. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    var items:[String] = ["条目1","条目2","条目3","条目4","条目5"]
    
    //存储选中单元格的索引
    var selectedIndexs = [Int]()
    
    var tableView:UITableView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView = UITableView(frame: self.view.frame, style: .Plain)
        self.tableView!.delegate = self;
        self.tableView!.dataSource = self;
        
        //创建一个重用的单元格
        self.tableView!.registerClass(UITableViewCell.self, forCellReuseIdentifier: "SwiftCell")
        self.view.addSubview(self.tableView!)
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //为了提供标表格显示性能，已创建的单元需要重复使用
        let identify:String = "SwiftCell"
        //同一形式的单元格重复使用，在声明时已经注册
        let cell = tableView.dequeueReusableCellWithIdentifier(identify, forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = self.items[indexPath.row]
        
        //判断是否选中（选中单元格尾部打钩）
        if selectedIndexs.contains(indexPath.row) {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        }else{
            cell.accessoryType = UITableViewCellAccessoryType.None
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //判断该行原先是否选中
        if let index = selectedIndexs.indexOf(indexPath.row) {
            selectedIndexs.removeAtIndex(index)//原来选中的取消选中
        }else{
            selectedIndexs.append(indexPath.row)//原来没选中的就选中
        }
        
        //刷新该行
        self.tableView?.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        
        //确定按钮点击
        func btnClick(sender: AnyObject) {
            print("选中项的索引为：", selectedIndexs)
            print("选中项的值为：")
            for index in selectedIndexs {
                print(items[index])
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

