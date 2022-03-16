//
//  ViewController.swift
//  SampleProfile
//
//  Created by eat.toyama003 on 2022/03/12.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var profileButton: UIButton!
    
    var user: User!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ユーザーが設定されていないとき
        if user == nil{
            //デフォルトのユーザー設定
            user = User(userName: "たかし", message: "やるぜ！", age: "14", iconName: "icon_psyduck.png",backgroundName: "sa_pixar_virtualbg_incredibles2_16x9_149dbf8d.jpeg")
        }
        
        profileButton.setImage(UIImage(named: user.iconName), for: .normal)
        profileButton.imageView?.contentMode = .scaleAspectFit
        profileButton.contentMode = .scaleAspectFit
        profileButton.contentHorizontalAlignment = .fill// オリジナルの画像サイズを超えて拡大（水平)
        profileButton.contentVerticalAlignment = .fill // オリジナルの画像サイズを超えて拡大(垂直)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tapButton(_ sender: Any) {
        //プロフィール編集画面へ遷移
        performSegue(withIdentifier: "toProfileViewController", sender: nil)
    }

    @IBAction func shareProfile(_ sender: Any) {
        if user != nil{
            let name = user.userName
            let age = user.age
            let message = user.message
            let icon = UIImage(named: "\(user.iconName)")!
            let background = UIImage(named: "\(user.backgroundName)")!
            let activityItems = [name, age, message, icon, background] as [Any]
            let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
            //Twitter以外を共有から除外
            activityVC.excludedActivityTypes = [
                UIActivity.ActivityType.addToReadingList,
                UIActivity.ActivityType.airDrop,
                UIActivity.ActivityType.assignToContact,
                UIActivity.ActivityType.copyToPasteboard,
                UIActivity.ActivityType.mail,
                UIActivity.ActivityType.markupAsPDF,
                UIActivity.ActivityType.message,
                UIActivity.ActivityType.openInIBooks,
                UIActivity.ActivityType.postToFacebook,
                UIActivity.ActivityType.postToFlickr,
                UIActivity.ActivityType.postToTencentWeibo,
                UIActivity.ActivityType.postToVimeo,
                UIActivity.ActivityType.postToWeibo,
                UIActivity.ActivityType.print,
                UIActivity.ActivityType.saveToCameraRoll
            ]
            //activityViewControllerの表示
            self.present(activityVC, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let profileVC = (segue.destination as? ProfileViewController)!
        profileVC.user = user
        profileVC.delegate = self
    }
    
}

extension ViewController: CatchUserProtocol{
    func catchUser(user: User) {
        self.user = user
        profileButton.imageView?.image = UIImage(named: user.iconName)
    }
}
