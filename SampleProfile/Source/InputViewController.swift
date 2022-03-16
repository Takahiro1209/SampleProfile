//
//  InputViewController.swift
//  SampleProfile
//
//  Created by eat.toyama003 on 2022/03/12.
//

import UIKit

protocol CatchInputProtocol{
    func catchInput(input: String)
}

class InputViewController: UIViewController {
    @IBOutlet weak var inputTitleLabel: UILabel!
    @IBOutlet weak var inputNumberLabel: UILabel!
    @IBOutlet weak var inputStringTextField: UITextField!
    
    var inputTitle: String!
    var inputString: String!
    var limitNumberOfString: Int!
    
    var delegate: CatchInputProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputTitleLabel.text = inputTitle
        inputStringTextField.text = inputString
        
        inputNumberLabel.text = "/\(String(limitNumberOfString))"
        // Do any additional setup after loading the view.
    }
    
    //入力した名前を保存して遷移元へ戻る
    @IBAction func tappedCompleteButton(_ sender: Any) {
        inputString = inputStringTextField.text
        delegate?.catchInput(input: inputString)
        self.dismiss(animated: true, completion: nil)
    }
    
    //保存せずに遷移元へ戻る
    @IBAction func tappeddismissButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
