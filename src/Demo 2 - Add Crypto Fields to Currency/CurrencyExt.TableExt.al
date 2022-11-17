//add crypto related fields to the currency table
tableextension 50100 "KTN CurrencyExt" extends Currency
{
    fields
    {
        field(50100; "KTN Type"; enum "KTN Crypto Currency Type")
        {
            Caption = 'Type';
        }
        field(50101; "KTN Picture"; Media)
        {
            Caption = 'Picture';
        }
        field(50102; "KTN CoinGeckoID"; Code[50])
        {
            Caption = 'CoinGeckoID';
        }
        field(50103; "KTN CoinMarketCapID"; Code[50])
        {
            Caption = 'CoinMarketCapID';
        }
        field(50104; "KTN CoinPaprikaID"; Code[50])
        {
            Caption = 'CoinPaprikaID';
        }
        field(50105; "KTN CoinloreID"; Code[50])
        {
            Caption = 'CoinloreID';
        }
        field(50106; "KTN CoinGeckoRank"; Integer)
        {
            Caption = 'CoinGeckoRank';
        }
        field(50107; "KTN CoinMarketCapRank"; Integer)
        {
            Caption = 'CoinMarketCapRank';
        }
        field(50108; "KTN CoinPaprikaRank"; Integer)
        {
            Caption = 'CoinPaprikaRank';
        }
        field(50109; "KTN CoinloreRank"; Integer)
        {
            Caption = 'CoinloreRank';
        }
        field(50110; "KTN CoinGeckoPrice"; Decimal)
        {
            Caption = 'CoinGeckoPrice';
            DecimalPlaces = 10 : 10;
        }
        field(50111; "KTN CoinMarketCapPrice"; Decimal)
        {
            Caption = 'CoinMarketCapPrice';
            DecimalPlaces = 10 : 10;
        }
        field(50112; "KTN CoinPaprikaPrice"; Decimal)
        {
            Caption = 'CoinPaprikaPrice';
            DecimalPlaces = 10 : 10;
        }
        field(50113; "KTN CoinlorePrice"; Decimal)
        {
            Caption = 'CoinlorePrice';
            DecimalPlaces = 10 : 10;
        }
        field(50114; "KTN CoinGeckoMarketCap"; Decimal)
        {
            Caption = 'CoinGeckoMarketCap';
            DecimalPlaces = 10 : 10;
        }
        field(50115; "KTN CoinMarketCapMarketCap"; Decimal)
        {
            Caption = 'CoinMarketCapMarketCap';
            DecimalPlaces = 10 : 10;
        }
        field(50116; "KTN CoinPaprikaMarketCap"; Decimal)
        {
        }
    }

    fieldgroups
    {
        addlast(Brick; "KTN Picture")
        {

        }
    }

}

