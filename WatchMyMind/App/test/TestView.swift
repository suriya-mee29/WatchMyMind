//
//  TestView.swift
//  WatchMyMind
//
//  Created by Suriya on 24/2/2564 BE.
//

import SwiftUI


struct detailView : View {
    
    let pet : String
    var body: some View{
        VStack{
            
            Text("\(pet)")
                .font(.title)
                .fontWeight(.heavy)
        }
    }
}

struct TestView: View {
    @ObservedObject var textRecognition = TextRecognition()
    let element = ["dog", "cat", "fish","hamster"]
    func test(){
        
        
    
    }
    
    var body: some View {
        NavigationView {
            VStack {
              Text("test")
                ForEach(element , id: \.self){  pet in
                   NavigationLink(
                    destination: detailView(pet: pet),
                    label: {
                        Text("\(pet)")
                            .padding(.vertical)
                    })
                        
                }
                   
            }
            .onAppear(perform: {
                
               // self.textRecognition.SSense(text: "ฉันน่าจะอยู่ที่ตรงนั้นข้างๆเธอได้เดินร่วมทางกันเหมือนเดิม แต่ก็รู้ว่าเสียใจเมื่อมันสายเกินไม่มีแล้วที่เคยรักกัน")
               
                
                self.textRecognition.SSense(text: "ฉันน่าจะอยู่ที่ตรงนั้น ข้างๆเธอได้เดินรวมทางกันเหมือนเดิมแต่ก็รู้ ว่าเสียใจเมื่อมันสายเกินไม่มีแล้วที่เคยรักกัน﻿"){ ssense in
                    if ssense != nil {
                        print("scroe\(ssense?.sentiment.score)")
                        print("\((ssense?.sentiment.polarity_neg)! ? "negative" : "positive" )")
                    }
                    
                }
            
              
        })
        } //EO-onApprar
       
        
        
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
