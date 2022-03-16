//
//  ProfileViewController.swift
//  SampleProfile
//
//  Created by eat.toyama003 on 2022/03/12.
//

import UIKit

protocol CatchUserProtocol{
    func catchUser(user: User)
}

struct User{
    var userName: String
    var message: String
    var age: String
    var iconName: String
    var backgroundName: String
    
    init(userName:String, message: String, age:String, iconName: String, backgroundName: String){
        self.userName = userName
        self.message = message
        self.age = age
        self.iconName = iconName
        self.backgroundName = backgroundName
    }
}

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileTableView: UITableView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    //ユーザープロフィールの項目
    let itemNames: [String] = ["名前", "年齢", "ステータス"]
    var user: User!
    //タップしたセルの名前
    var selectedItemName: String!
    
    var delegate: CatchUserProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //スクロールの非有効化
        profileTableView.isScrollEnabled = false
        
        //プロフィール画像
        let iconImage = UIImage(named: user.iconName)
        iconImageView.image = iconImage
        //角を丸くする
        iconImageView.layer.cornerRadius = iconImageView.frame.size.width * 0.4
        let backgroundImage = UIImage(named: user.backgroundName)
        backgroundImageView.image = backgroundImage
        
        // Do any additional setup after loading the view.
    }
    
    //画面遷移時
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //編集画面へ遷移する場合、タップしたセルに対応するプロフィール項目の名前と、現在の値を渡す
        
        switch segue.identifier {
        case "toInputViewController":
            //遷移先のViewController
            let inputVC = (segue.destination as? InputViewController)!
            //渡したい変数
            inputVC.inputTitle = selectedItemName
            
            //選択されたセルによって渡す値を変える
            if selectedItemName == itemNames[0]{
                inputVC.inputString = user.userName
                inputVC.limitNumberOfString = 10
            } else if selectedItemName == itemNames[1]{
                inputVC.inputString = user.age
                inputVC.limitNumberOfString = 3
            } else if selectedItemName == itemNames[2]{
                inputVC.inputString = user.message
                inputVC.limitNumberOfString = 20
            }
            
            //遷移先から値を受け取る宣言のdelegate
            inputVC.delegate = self
            
        case "toSelectIconViewController":
            //遷移先のViewController
            let selectIconVC = (segue.destination as? SelectIconViewController)!
            selectIconVC.selectedIconName = user.iconName
            //遷移先から値を受け取る宣言のdelegate
            selectIconVC.delegate = self
            
        case "toSelectBackgroundViewController":
            let selectBackgroundVC = (segue.destination as? SelectBackgroundViewController)!
            selectBackgroundVC.selectedBackgroundName = user.backgroundName
            selectBackgroundVC.delegate = self
        default:
            print("不明な遷移")
        }
    }
    
    //アイコン画像の編集画面へ遷移
    @IBAction func toSelectIconViewController(_ sender: Any) {
        performSegue(withIdentifier: "toSelectIconViewController", sender: nil)
    }
    
    //背景画像の編集画面へ遷移
    @IBAction func toSelectBackgroundViewController(_ sender: Any) {
        performSegue(withIdentifier: "toSelectBackgroundViewController", sender: nil)
    }
    
    //トップ画面へ戻る
    @IBAction func tappedBackButton(_ sender: Any) {
        delegate?.catchUser(user: user)
        dismiss(animated: true, completion: nil)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}


extension ProfileViewController: UITableViewDataSource, UITableViewDelegate{
    //セルの数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemNames.count
    }
    
    //配置するセルの設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //storyboardで配置したデフォルトセル
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        let titleLabel = cell.contentView.viewWithTag(1) as! UILabel
        titleLabel.text = itemNames[indexPath.row]
        let itemLabel = cell.contentView.viewWithTag(2) as! UILabel
        if indexPath.row == 0{
            itemLabel.text = user.userName
        } else if indexPath.row == 1{
            itemLabel.text = user.age
        } else if indexPath.row == 2{
            itemLabel.text = user.message
        }
        
        return cell
    }
    
    //セルがタップされた時、そのセルに対応したプロフィール項目の編集画面へ遷移する
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedItemName = itemNames[indexPath.row]
        self.performSegue(withIdentifier: "toInputViewController", sender: nil)
    }
}

extension ProfileViewController: CatchIconNameProtocol, CatchInputProtocol, CatchBackgroundProtocol{
    
    //inputVCからのプロトコル
    func catchInput(input: String) {
        if selectedItemName == itemNames[0]{
            user.userName = input
        } else if selectedItemName == itemNames[1]{
            user.age = input
        } else if selectedItemName == itemNames[2]{
            user.message = input
        }
        
        profileTableView.reloadData()
    }
    
    //selectIconVCからのプロトコル
    func catchIconName(iconName: String) {
        user.iconName = iconName
        iconImageView.image = UIImage(named: user.iconName)
    }
    
    //selectBackgroundVCからのプロトコル
    func catchBackgroundProtocol(backgroundName: String) {
        user.backgroundName = backgroundName
        print(user.backgroundName)
        backgroundImageView.image = UIImage(named: user.backgroundName)
    }
}
