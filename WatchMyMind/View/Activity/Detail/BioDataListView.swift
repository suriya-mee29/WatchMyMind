//
//  BioDataListView.swift
//  WatchMyMind
//
//  Created by Suriya on 11/2/2564 BE.
//

import SwiftUI

struct BioDataListView: View {
    // MARK: - PROPERTIES
    let headLine : String
    @State var mindfulnessArr = [MindfulnessModel]()
    @ObservedObject var mindfulnessMV : MindfulnessStore
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [])
    var MindfulnessCollection : FetchedResults<Mindfulness>
    @State private var isPresented = true
    // MARK: - CONSTRUCTOR
    init(headline: String) {
        self.headLine = headline
        mindfulnessMV = MindfulnessStore(MindfulnessArr: [])
       
    }
   
    // MARK: - FUNCTION
    private func loadData(){
        var arr = [MindfulnessModel]()
        if MindfulnessCollection.count != 0 {
            MindfulnessCollection.forEach { mf in
                guard let id = mf.id else {return}
                guard let date = mf.date else {return}
                let time = mf.time
                arr.append(MindfulnessModel(id: id, date: date, time: time))
            }//: LOOP
            self.mindfulnessMV.setMindfulness(newData: arr)
        }else{
           //base case
            print("base case --> one")
        }
       
    }
    // MARK: - BODY
    var body: some View {
        ZStack {
            VStack {
                NavigationBarViewII(title: "watchmymind", imageIconRight: "plus")
                    
                    .padding(.horizontal , 15)
                    .padding(.bottom)
                    .padding(.top ,
                             UIApplication.shared.windows.first?.safeAreaInsets.top)
                ScrollView(.vertical, showsIndicators: true){
                   
                    ForEach(self.mindfulnessMV.mindfulnessArr){ data in
                        BioDataCardIView(title: "breathing", breating: "\(data.time)", date: data.date)
                        
                    }//: LOOP
                        
                }//: SCROLL VIEW
                    
                
               
 
                
                .ignoresSafeArea(.all , edges: .bottom)
                Spacer()
            }//: VSTACK
           
            .ignoresSafeArea(.all , edges: .bottom)
                
        }//: ZSTACK
        .ignoresSafeArea(.all , edges : .top)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: {
                    
                }, label: {
                    Image(systemName: "plus")
                })
                            }
            }//: TOOL BAR
        .fullScreenCover(isPresented: $isPresented, content: {
            LoadingView(showModal: self.$isPresented, decription: "please use your Apple Watch to complete an activity by use The Breathe app").environment(\.managedObjectContext, viewContext)
        })
        .onAppear(perform: {
            print("OnAppear in loadData")
            loadData()
            
        })
        .onChange(of: isPresented, perform: { value in
            print("chang")
            loadData()
        })
        
       
       
    }
}
// MARK: -PREVIEW
struct BioDataListView_Previews: PreviewProvider {
    static var previews: some View {
        BioDataListView(headline: "BREATHING")
            
    }
}
