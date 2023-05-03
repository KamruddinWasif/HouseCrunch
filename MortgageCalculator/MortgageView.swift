import SwiftUI

struct MortgageView: View {
    @StateObject var mortgageViewModel = MortgageViewModel()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Loan Details")) {
                    TextField("Loan Amount", text: $mortgageViewModel.loanAmount)
                        .keyboardType(.decimalPad)
                        .accessibilityLabel("Loan amount")
                    
                    TextField("Down Payment", text: $mortgageViewModel.downPayment)
                        .keyboardType(.decimalPad)
                        .accessibilityLabel("Down payment")
                    
                    Toggle("Down Payment as Percentage", isOn: $mortgageViewModel.downPaymentAsPercentage)
                    
                    TextField("Interest Rate", text: $mortgageViewModel.interestRate)
                        .keyboardType(.decimalPad)
                        .accessibilityLabel("Interest rate")
                    
                    Picker("Loan Term", selection: $mortgageViewModel.loanTerm) {
                        ForEach([15, 20, 30], id: \.self) { term in
                            Text("\(term) years").tag(term)
                        }
                    }
                    
                    Picker("Loan Type", selection: $mortgageViewModel.loanType) {
                        ForEach(MortgageLoanType.allCases) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }
                }
                
                Section(header: Text("Additional Costs")) {
                    Toggle("Include Property Taxes", isOn: $mortgageViewModel.includeTaxes)
                    
                    if mortgageViewModel.includeTaxes {
                        TextField("Property Taxes", text: $mortgageViewModel.propertyTaxes)
                            .keyboardType(.decimalPad)
                            .accessibilityLabel("Property taxes")
                    }
                    
                    Toggle("Include Homeowners Insurance", isOn: $mortgageViewModel.includeInsurance)
                    
                    if mortgageViewModel.includeInsurance {
                        TextField("Homeowners Insurance", text: $mortgageViewModel.homeownersInsurance)
                            .keyboardType(.decimalPad)
                            .accessibilityLabel("Homeowners insurance")
                    }
                    
                    Toggle("Include Homeowners Association Fees", isOn: $mortgageViewModel.includeHOAFees)
                    
                    if mortgageViewModel.includeHOAFees {
                        TextField("HOA Fees", text: $mortgageViewModel.homeownersAssociationFees)
                            .keyboardType(.decimalPad)
                            .accessibilityLabel("Homeowners association fees")
                    }
                }
                
                // Implement the UI for prepayment options here
                
                Section(header: Text("Total Monthly Payment")) {
                    Text("$\(mortgageViewModel.totalMonthlyPayment, specifier: "%.2f")")
                        .font(.largeTitle)
                        .accessibilityLabel("Total monthly payment")
                }
            }
            .navigationTitle("Mortgage Calculator")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MortgageView()
    }
}
