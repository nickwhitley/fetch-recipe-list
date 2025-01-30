import SwiftUI

struct RecipeTitleBar: View {
    @Environment(RecipeListViewModel.self) var viewModel
    @State var toolBarVisible: Bool = false
    @State var searchText: String = ""
    //used to disable buttons and search field during animation
    @State var isAnimating: Bool = false
    
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 0) {
                Text("Recipes")
                    .font(.title)
                    .bold()
                    .frame(alignment: .top)
                    .padding(.horizontal)
                Spacer()
                if toolBarVisible {
                    sortBar()
                        .transition(.move(edge: .trailing).combined(with: .opacity))
                }
                searchSortButton()
                    .padding(.horizontal)
            }
            if toolBarVisible {
                @Bindable var bindingVm = viewModel
                searchField(text: $bindingVm.searchText)
                    .transition(.move(edge: .trailing).combined(with: .opacity))
            }
        }
        .dynamicTypeSize(.xLarge)
    }
    
    func searchSortButton() -> some View {
        Button( action: {
            isAnimating = true
            withAnimation {
                toolBarVisible.toggle()
            }
            isAnimating = false
        }, label: {
            if toolBarVisible {
                Image(systemName: "xmark").foregroundStyle(.black)
            } else {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.black)
            }
        })
    }
    
    func sortBar() -> some View {
        HStack(spacing: 15) {
            nameSortButton()
            cuisineSortButton()
        }
        .minimumScaleFactor(0.6)
    }
    
    func searchField(text: Binding<String>) -> some View {
        TextField(text: text, label: {
            Image(systemName: "magnifyingglass")
        })
        .padding(7)
        .background(.white)
        .overlay(
            RoundedRectangle(cornerRadius: 25)
                .stroke(Color.black, lineWidth: 2)
        )
        .frame(height: 25)
        .padding([.horizontal, .bottom])
        .submitLabel(.done)
        .disabled(isAnimating)
        
    }
    
    func nameSortButton() -> some View {
        Button(action: {
            withAnimation {
                viewModel.sortRecipesByName()
            }
        }, label: {
            Text("Name")
                .lineLimit(1)
                .foregroundStyle(viewModel.nameSort == .none ? .gray : .black)
            switch viewModel.nameSort {
            case .none:
                EmptyView()
            case .descending:
                Image(systemName: "arrow.down")
            case .ascending:
                Image(systemName: "arrow.up")
            }
        })
        .disabled(isAnimating)
        .foregroundStyle(.black)
    }
    
    func cuisineSortButton() -> some View {
        Button(action: {
            withAnimation {
                viewModel.sortRecipesByCuisine()
            }
        }, label: {
            Text("Cuisine")
                .lineLimit(1)
                .foregroundStyle(viewModel.cuisineSort == .none ? .gray : .black)
            switch viewModel.cuisineSort {
            case .none:
                EmptyView()
            case .descending:
                Image(systemName: "arrow.down")
            case .ascending:
                Image(systemName: "arrow.up")
            }
            
        })
        .disabled(isAnimating)
        .foregroundStyle(.black)
    }
}

#Preview {
    RecipeTitleBar()
        .addEnvironments()
}


