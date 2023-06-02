//
//  FloatingButtonView.swift
//  ToDoList
//
//  Created by N N on 05/01/2023.
//

import SwiftUI

struct FloatingButtonView: View {
    
    @EnvironmentObject var viewModel: ViewModel
    @State var animate: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                NavigationLink(destination: TaskCreationView(), label: {
                    Text("Add New Task")
                        .font(.headline)
                })
                .environmentObject(viewModel)
                .padding(15)
                .foregroundColor(.white)
                .background(animate ? Color("tungsten") : Color.accentColor)
                .cornerRadius(30)
            }
            .padding(.horizontal, animate ? 30 : 50)
            .shadow(
                color: animate ? Color("tungsten").opacity(0.7) : Color.accentColor.opacity(0.7),
                radius: animate ? 50 : 30,
                x: 0,
                y: animate ? 50 : 30)
            .scaleEffect(animate ? 1.1 : 1.0)
            .offset(y: animate ? -7 : 0)
        }
        .padding(.bottom, 50)
        .onAppear(perform: addAnimation)
    }
    
    func addAnimation() {
        guard !animate else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(
                Animation
                    .easeInOut(duration: 2.0)
                    .repeatForever()
            ) {
                animate.toggle()
            }
        }
    }
}

struct FloatingButtonView_Previews: PreviewProvider {
    static var previews: some View {
        FloatingButtonView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
