//
//  NoItemView.swift
//  ToDoList
//
//  Created by N N on 05/01/2023.
//

import SwiftUI

struct NoItemView: View {

    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.colorScheme) var colorScheme
    @State var animate: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                Spacer()

                Text("Nothing to see here...")
                    .font(.title)
                    .fontWeight(.semibold)
                Text("🫣")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                Text("Go click the Add button\n and add a bunch of items to your to do list!")
                
                Spacer()
            }
            .padding(30)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .multilineTextAlignment(.center)
            .onAppear(perform: addAnimation)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Picker("", selection: $viewModel.selectedFilter) {
                        ForEach(TaskFilter.allCases, id: \.self) { filter in
                            Button {
                                withAnimation {
                                    viewModel.selectedFilter = filter
                                    viewModel.fetchTasks()
                                }
                            } label: {
                                Text(filter.rawValue)
                            }
                        }
                    }
                    .foregroundColor(.accentColor)
                    .accessibilityIdentifier("filterPicker")
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
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

struct NoItemView_Previews: PreviewProvider {
    static var previews: some View {
        NoItemView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
