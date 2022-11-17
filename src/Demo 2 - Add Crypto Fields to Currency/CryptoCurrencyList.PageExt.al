//add crypto fields to the currency list
pageextension 50101 "KTN Crypto Currency List" extends "Currencies"
{
    layout
    {
        addafter(Code)
        {
            field("KTN Type"; Rec."KTN Type")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        addlast(processing)
        {
            action("KTN UpdateCryptoCurrencies")
            {
                ApplicationArea = All;
                Caption = 'Update Crypto Currencies';
                Image = UpdateXML;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Update Crypto Currencies';

                trigger OnAction()
                var
                    CryptoCurrency: Codeunit "KTN Get CryptoCurrList Impl.";
                begin
                    CryptoCurrency.GetCryptocurrenciesListFromAPI();
                end;
            }
        }
    }
}