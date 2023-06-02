//
//  DateScollerView.swift
//  ToDoList
//
//  Created by N N on 05/01/2023.
//

import SwiftUI

struct DateScrollerView: View {
    
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack {
            Spacer()
            
            Button(action: moveBack) {
                Image(systemName: "lessthan")
                    .imageScale(.medium)
                    .foregroundColor(.accentColor)
            }
            
            Text(dateFormatted())
                .accessibilityIdentifier("Date scroller")
                .foregroundColor(colorScheme == .dark ? .black : .black)
                .font(.title2)
                .bold()
                .animation(.none)
                .frame(maxWidth: .infinity)
            
            Button(action: moveForward) {
                Image(systemName: "greaterthan")
                    .imageScale(.medium)
                    .foregroundColor(.accentColor)
            }
        }
    }
    
    func dateFormatted() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd LLL yy"
        return dateFormatter.string(from: viewModel.date)
    }
    
    func moveBack() {
        withAnimation {
            viewModel.moveDate(-1)
        }
    }
    
    func moveForward() {
        withAnimation {
            viewModel.moveDate(1)
        }
    }
}

struct DateScrollerView_Previews: PreviewProvider {
    static var previews: some View {
        DateScrollerView()
    }
}
