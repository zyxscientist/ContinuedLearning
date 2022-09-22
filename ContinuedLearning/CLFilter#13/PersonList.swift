//
//  PersonList.swift
//  ContinuedLearning
//
//  Created by 朱宇軒 on 2022/9/22.
//

import SwiftUI

struct PersonList: View {
    
    @StateObject var vm: PersonViewModel = PersonViewModel()
    
    var body: some View {
            List {
                ForEach(vm.dataArray) { item in
                    HStack {
                        VStack(alignment:.leading) {
                            Text(item.name)
                                .font(.body)
                                .fontWeight(.medium)
                                .foregroundColor(.black)
                            Text("\(item.points)")
                                .font(.body)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        if item.isVerified {
                            Image(systemName: "person.fill.checkmark")
                                .foregroundColor(Color.blue)
                        }
                    }
                }
            }
    }
}

struct PersonList_Previews: PreviewProvider {
    static var previews: some View {
        PersonList()
    }
}
