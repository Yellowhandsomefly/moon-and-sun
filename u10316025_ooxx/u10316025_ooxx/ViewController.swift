//
//  ViewController.swift
//  u10316025_ooxx
//
//  Created by user on 2017/5/3.
//  Copyright © 2017年 user. All rights reserved.
// scentsome@gmail.com

import UIKit

class ViewController: UIViewController {

    var count = 0
    var blevel = 1
    var rlevel = 1
    var bn = 0
    var current_id = -1
    var sb = 10
    var mb = 10
    var take_number = 1
    var m_take = 0
    var s_take = 0
    var count_symbol : [String] = ["☼","☾"]
    
    @IBOutlet weak var mw: UILabel!
    @IBOutlet weak var sw: UILabel!
    @IBOutlet weak var mm: UILabel!
    @IBOutlet weak var sm: UILabel!
    @IBOutlet weak var mt: UILabel!
    @IBOutlet weak var st: UILabel!
    @IBOutlet weak var moon_b: UILabel!
    @IBOutlet weak var sun_b: UILabel!
    @IBOutlet weak var sun: UIButton!
    @IBOutlet weak var moon: UIButton!
 
    @IBAction func move(_ sender: UIButton) {
        sw.text = " "
        mw.text = " "
        if bn == 0 && sender.currentTitle != "♜" && (sender.currentTitle?.hasPrefix(count_symbol[count]))!{
            //print("\(sender.currentTitle)")
            if(sender.currentTitle != " "){
                current_id = Int(sender.accessibilityIdentifier!)!
                bn += 1
                enabledelet(n:current_id)
                sun.isEnabled = false
                moon.isEnabled = false
            }
            
        }else if (bn == 1){
            let button_id  = Int(sender.accessibilityIdentifier!)!
            if xyvalue[current_id].currentTitle != xyvalue[button_id].currentTitle {
                if !overrange(pn: current_id, nn: button_id){
                    if button_id < 30{
                        xyvalue[button_id].setTitle("\(xyvalue[current_id].currentTitle!)", for: .normal)
                        xyvalue[current_id].setTitle(" ", for: .normal)
                    
                    }else if button_id == 30 {
                        sb -= 1
                        var bl = ""
                        var count = sb
                        while count > 0{
                            bl += "♜"
                            count -= 1
                        }
                        sun_b.text = "HP : " + bl
                        check(sb,"☼")

                    }else if button_id == 31 {
                        mb -= 1
                        var bl = ""
                        var count = mb
                        while count > 0{
                            bl += "♜"
                            count -= 1
                        }
                        moon_b.text = "HP : " + bl
                        check(mb,"☾")
                    }
                    if count == 1 {
                        m_take -= 1
                        decreaseMP_text(mp:m_take, symbol:count_symbol[count])
                        end_turn(taken: m_take)
                    }else if count == 0{
                        s_take -= 1
                        decreaseMP_text(mp:s_take, symbol:count_symbol[count])
                        end_turn(taken: s_take)
                    }
                }else{
                    ws(count ,0)
                }
                bn = 0
                enableopen()
                sun.isEnabled = true
                moon.isEnabled = true
            }
        }
    }
    
    @IBAction func generate_blue(_ sender: UIButton) {
        sw.text = " "
        mw.text = " "
        if(count == 1){
            var n  = 25 + Int(arc4random_uniform(5))
            print(n)
            var xn = 0
            if !over_number(symbol: "☾") {
                while xyvalue[n].currentTitle != " " && xn < 5{
                    n  = 25 + Int(arc4random_uniform(5))
                    xn += 1
                }
                if xn < 5{
                    xyvalue[n].setTitle("☾ \(blevel)", for: .normal)
                    m_take -= 1
                    decreaseMP_text(mp:m_take, symbol:"☾")
                    end_turn(taken: m_take)
                }
            }else{
                ws(count ,1)
            }
        }
    }
    @IBAction func generate_red(_ sender:UIButton) {
        sw.text = " "
        mw.text = " "
        if (count == 0){
            var n  = Int(arc4random_uniform(5))
            print(n)
            var xn = 0
            if !over_number(symbol: "☼"){
                while xyvalue[n].currentTitle != " " && xn < 5{
                    n  = Int(arc4random_uniform(5))
                    xn += 1
                }
                if xn < 5{
                    xyvalue[n].setTitle("☼ \(rlevel)", for: .normal)
                    s_take -= 1
                    decreaseMP_text(mp:s_take, symbol:"☼")
                    end_turn(taken: s_take)
                }
            }else{
                ws(count ,1)
            }
        }
    }
    @IBOutlet var xyvalue: [UIButton]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        m_take = take_number
        s_take = take_number
        decreaseMP_text(mp:m_take,symbol:"☾")
        decreaseMP_text(mp:s_take,symbol:"☼")
        
        count = Int(arc4random_uniform(100)) % 2
        if(count == 0){
            st.text = "your turn"
            mt.text = " "
        }else{
            st.text = " "
            mt.text = "your turn"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func over_number(symbol : String) -> Bool{
        var n = 0
        var overn = false
        for i in 0 ... 29{
            if (xyvalue[i].currentTitle?.hasPrefix(symbol))!{
                n += 1
            }
        }
        print(n)
        if n >= 5{
            overn = true
        }
        return overn
    }
    
    func enabledelet(n: Int){
        for i in 0 ... 14{
            xyvalue[i].backgroundColor = UIColor.orange
        }
        for i in 15 ... 29{
            xyvalue[i].backgroundColor = UIColor.init(red: 0.135, green: 0.206, blue: 0.250, alpha: 0.5)

        }
        xyvalue[n].backgroundColor = UIColor.white
        if n % 5 == 0{
            xyvalue[n + 1].backgroundColor = UIColor.white
            xyvalue[n + 4].backgroundColor = UIColor.white
        }else if(n % 5 == 4){
            xyvalue[n - 1].backgroundColor = UIColor.white
            xyvalue[n - 4].backgroundColor = UIColor.white
        }else{
            xyvalue[n - 1].backgroundColor = UIColor.white
            xyvalue[n + 1].backgroundColor = UIColor.white
        }
        if (xyvalue[n].currentTitle?.hasPrefix("☼"))!{
            if !(n == 29 || n == 28 || n == 27 || n == 26 || n == 25){
                xyvalue[n + 5].backgroundColor = UIColor.white
            }else if (n == 29 || n == 28 || n == 27 || n == 26 || n == 25){
                xyvalue[31].backgroundColor = UIColor.white
            }
            
        }else{
            if !(n == 0 || n == 1 || n == 2 || n == 3 || n == 4){
                xyvalue[n - 5].backgroundColor = UIColor.white
            }else if (n == 0 || n == 1 || n == 2 || n == 3 || n == 4){
                xyvalue[30].backgroundColor = UIColor.white
            }
        }
    }
    
    func overrange(pn: Int, nn: Int) -> Bool{
        var is_over = false
        
        if (xyvalue[pn].currentTitle?.hasPrefix("☼"))!{
            if !(pn == 29 || pn == 28 || pn == 27 || pn == 26 || pn == 25){
                if pn % 5 == 0{
                    if !(nn == pn + 1 || nn == pn + 4 || nn == pn + 5){
                        is_over = true
                    }
                }else if(pn % 5 == 4){
                    if !(nn == pn - 1 || nn == pn - 4 || nn == pn + 5){
                        is_over = true
                    }
                }else{
                    if !(nn == pn - 1 || nn == pn + 1 || nn == pn + 5){
                        is_over = true
                    }
                }
            }else if (pn == 29 || pn == 28 || pn == 27 || pn == 26 || pn == 25){
                if pn % 5 == 0{
                    if !(nn == pn + 1 || nn == pn + 4 || nn == 31){
                        is_over = true
                    }
                }else if(pn % 5 == 4){
                    if !(nn == pn - 1 || nn == pn - 4 || nn == 31){
                        is_over = true
                    }
                }else{
                    if !(nn == pn - 1 || nn == pn + 1 || nn == 31){
                        is_over = true
                    }
                }
            }
            
        }else{
            if !(pn == 0 || pn == 1 || pn == 2 || pn == 3 || pn == 4){
                if pn % 5 == 0{
                    if !(nn == pn + 1 || nn == pn + 4 || nn == pn - 5){
                        is_over = true
                    }
                }else if(pn % 5 == 4){
                    if !(nn == pn - 1 || nn == pn - 4 || nn == pn - 5){
                        is_over = true
                    }
                }else{
                    if !(nn == pn - 1 || nn == pn + 1 || nn == pn - 5){
                        is_over = true
                    }
                }

            }else if (pn == 0 || pn == 1 || pn == 2 || pn == 3 || pn == 4){
                if pn % 5 == 0{
                    if !(nn == pn + 1 || nn == pn + 4 || nn == 30){
                        is_over = true
                    }
                }else if(pn % 5 == 4){
                    if !(nn == pn - 1 || nn == pn - 4 || nn == 30){
                        is_over = true
                    }
                }else{
                    if !(nn == pn - 1 || nn == pn + 1 || nn == 30){
                        is_over = true
                    }
                }
            }
        }
        return is_over
    }
    
    func enableopen(){
        for i in 0 ... 29{
            xyvalue[i].backgroundColor = UIColor.white
        }
        xyvalue[30].backgroundColor = UIColor.white
        xyvalue[31].backgroundColor = UIColor.white

    }
    
    func end_turn(taken : Int) {
        if taken == 0{
            if take_number < 5{
                take_number += 1
            }
            s_take = take_number
            decreaseMP_text(mp:s_take, symbol:"☼")
            m_take = take_number
            decreaseMP_text(mp:m_take, symbol:"☾")
            count += 1
            count = count % 2
        }
        if(count == 0){
            st.text = "your turn"
            mt.text = " "
        }else{
            st.text = " "
            mt.text = "your turn"
        }
    }
    
    func decreaseMP_text(mp: Int, symbol: String){
        var ml = ""
        var mpp = mp
        if symbol == "☾"{
            while mpp > 0{
                ml += "♜"
                mpp -= 1
            }
            mm.text = "MP : " + ml
        }else if (symbol == "☼"){
            while mpp > 0{
                ml += "♜"
                mpp -= 1
            }
            sm.text = "MP : " + ml
        }
        
    }
    
    func check(_ hp: Int, _ symbol : String){
        if hp == 0{
            var s : String = ""
            var message = ""
            if symbol == "☾"{
                s = "☼☼☼☼☼☼☼☼☼☼☼☼☼☼☼"
                message = "Sun is Winner."
            }
            else{
                s = "☾☾☾☾☾☾☾☾☾☾"
                message = "Moon is Winner."
            }
            let alertController = UIAlertController(title: s, message: message,
                                                preferredStyle: .alert)
            let winButton = UIAlertAction(title: "restart", style: .default,handler: winAction)
            alertController.addAction(winButton)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    func winAction(action: UIAlertAction) {
        count = Int(arc4random_uniform(100)) % 2
        if(count == 0){
            st.text = "your turn"
            mt.text = " "
        }else{
            st.text = " "
            mt.text = "your turn"
        }
        blevel = 1
        rlevel = 1
        bn = 0
        sb = 10
        sun_b.text = "HP : ♜♜♜♜♜♜♜♜♜♜"
        mb = 10
        moon_b.text = "HP : ♜♜♜♜♜♜♜♜♜♜"
        take_number = 1
        m_take = take_number
        s_take = take_number
        decreaseMP_text(mp:m_take,symbol: "☼")
        decreaseMP_text(mp:s_take,symbol: "☾")
        sw.text = " "
        mw.text = " "
        for i in 0 ... 29{
            xyvalue[i].setTitle(" ", for: .normal)
        }
    }
    
    func ws(_ s:Int, _ kind : Int){
        var ws : String = ""
        if kind == 0{
            ws = "over range"
        }
        if kind == 1 {
            ws = "full number"
        }
        
        
        if s == 0{
            sw.text = ws
        }else{
            mw.text = ws
        }
    }
}

