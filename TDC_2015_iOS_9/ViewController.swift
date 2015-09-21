//
//  ViewController.swift
//  TDC_2015_iOS_9
//
//  Created by Mauricio Meirelles on 9/14/15.
//  Copyright © 2015 Meirelles and Zaquia. All rights reserved.
//

import UIKit
import CoreSpotlight

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!

    let palestrantesArray = [(image:"meirelles",twitter:"@mauriciom",name:"Mauricio Meirelles",desc:"Formado em Sistemas de Informação e pós-graduado em Gestão de Negócios, ambos pela PUCRS. Especialista em iOS, trabalha exclusivamente com a plataforma desde 2009. É sócio-fundador da Beelieve, empresa com foco em mobile, e já desenvolveu apps de destaque na App Store como Zero-Hora e BeHere. Organizador do CocoaHeads POA é membro ativo de comunidades iOS no Brasil"),(image:"zaquia",twitter:"@mtzaquia",name:"Mauricio T Zaquia",desc:"Formado em Sistemas de Informação, Zaquia trabalha com iOS desde 2010, ano no qual iniciou projetos com a tecnologia em freelances. Atualmente, atua como instrutor em um dos maiores cursos de desenvolvimento para dispositivos Apple do Brasil, possuindo o título de Apple Distinguished Educator. Desenvolveu aplicativos como 'BeHere' - com repercussão mundial, 'Central de Alunos' para estudantes da PUCRS e 'Decision', para alunos de graduação da FGV.")]



    enum TDCError: ErrorType
    {
        case AnxiousPresenter
        case JokeNotFunny
        case BoringSlides
        case SleepyAudience
        case CoffeRequired
    }



    func howIsTheKeynoteGoing(keynoteId:String?) throws -> String
    {
        guard let keynoteIdAux = keynoteId else {
            throw TDCError.JokeNotFunny
        }

        return keynoteIdAux + " - is going well!"
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Novidades iOS 9"
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView(frame: CGRectZero)



        ////////////////////////////
        ////   Swift 2  ////////////
        ////////////////////////////

        for case let (_,_,"Mauricio Meirelles",desc) in palestrantesArray
        {
            print(desc)
        }


        for palestranteObj in palestrantesArray where palestranteObj.image == "meirelles"
        {
            print(palestranteObj.name)
        }



        ////////////////////////////
        ///  Error Handling  ///////
        ////////////////////////////

        defer {
            print("This is running after everything ends")
        }

        do{
            print("Will call howIsTheKeynoteGoing")

            try print(howIsTheKeynoteGoing("Novidades iOS 9"))
            try print(howIsTheKeynoteGoing(nil))
        }
        catch let error as TDCError
        {
            print("Received \(error) error")
        }
        catch
        {
            print("Other Error")
        }




        ////////////////////////////
        ////  CoreSpotlight  ///////
        ////////////////////////////



        for (index,palestranteObj) in palestrantesArray.enumerate()
        {
            let attrSet = CSSearchableItemAttributeSet(
                itemContentType: "kUTTypeImage"
            )

            attrSet.title = palestranteObj.name
            attrSet.contentDescription = palestranteObj.desc


            guard let imagePalestrante = UIImage(named: palestranteObj.image) else {break}


            attrSet.thumbnailData = UIImageJPEGRepresentation(imagePalestrante, 1.0)

            let item = CSSearchableItem(
                uniqueIdentifier: "\(index)",
                domainIdentifier: "com.TDCPOA",
                attributeSet: attrSet
            )

            CSSearchableIndex
                .defaultSearchableIndex()
                .indexSearchableItems([item]) { error in
            }
            
        }





    }



    override func traitCollectionDidChange(previousTraitCollection: UITraitCollection?) {
        self.tableView.reloadData()
    }
    

    //tableview
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return palestrantesArray.count;
    }


    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell?

        let lblName = cell?.viewWithTag(10) as! UILabel
        let lblDesc = cell?.viewWithTag(11) as! UILabel
        let imgThumb = cell?.viewWithTag(12) as! UIImageView
        let lblTwitter = cell?.viewWithTag(13) as! UILabel

        lblName.text = palestrantesArray[indexPath.row].name
        lblDesc.text = palestrantesArray[indexPath.row].desc
        lblTwitter.text = palestrantesArray[indexPath.row].twitter
        imgThumb.image = UIImage(named:palestrantesArray[indexPath.row].image)


        let titleStackView = cell?.viewWithTag(20) as! UIStackView
        titleStackView.axis = self.traitCollection.horizontalSizeClass == .Compact ? .Vertical : .Horizontal
        titleStackView.alignment = self.traitCollection.horizontalSizeClass == .Compact ? .Leading : .Center

        return cell!
    }


}

