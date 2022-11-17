//add a field to the G/L entry table to check if corresponding Vendor or Customer ledger entry is open or not
pageextension 50100 "KTN G/L Entries" extends "General Ledger Entries"
{
    layout
    {
        addlast(Control1)
        {
            field("KTN Open"; Open)
            {
                ApplicationArea = All;
                Caption = 'Open';
                ToolTip = 'Indicates whether the corresponding Vendor or Customer ledger entry is open or not.';
            }
        }
    }

    var
        Open: Boolean;

    trigger OnAfterGetRecord()
    begin
        Clear(Open);
        CheckIfCustomerLedgerEntryIsOpen();
        CheckIfVendorLedgerEntryIsOpen();
    end;

    local procedure CheckIfCustomerLedgerEntryIsOpen()
    var
        CustomerLedgerEntry: Record "Cust. Ledger Entry";
    begin
        if Rec."Source Type" <> Rec."Source Type"::Customer then
            exit;

        if not CustomerLedgerEntry.Get(Rec."Entry No.") then
            exit;

        Open := CustomerLedgerEntry."Open";
    end;

    local procedure CheckIfVendorLedgerEntryIsOpen()
    var
        VendorLedgerEntry: Record "Vendor Ledger Entry";
    begin
        if Rec."Source Type" <> Rec."Source Type"::Vendor then
            exit;

        if not VendorLedgerEntry.Get(Rec."Entry No.") then
            exit;

        Open := VendorLedgerEntry."Open";
    end;



}