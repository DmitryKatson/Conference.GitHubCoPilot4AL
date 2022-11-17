// import crypto currency list from coinlayer API. Use this to populate the currency table with the list of crypto currencies. Use the next json response payload
// {
//   "success": true,
//   "crypto": {
//     "611": {
//       "symbol": "611",
//       "name": "SixEleven",
//       "name_full": "SixEleven (611)",
//       "max_supply": 611000,
//       "icon_url": "https://assets.coinlayer.com/icons/611.png"
//     },
//     "ABC": {
//       "symbol": "ABC",
//       "name": "AB-Chain",
//       "name_full": "AB-Chain (ABC)",
//       "max_supply": 210000000,
//       "icon_url": "https://assets.coinlayer.com/icons/ABC.png"
//     },
//     [...]
//   },
//   "fiat": {
//     "AED": "United Arab Emirates Dirham",
//     "AFN": "Afghan Afghani",
//     "ALL": "Albanian Lek",
//     "AMD": "Armenian Dram",
//     "ANG": "Netherlands Antillean Guilder",
//     "AOA": "Angolan Kwanza",
//     [...]
//   }
// }



codeunit 50100 "KTN Get CryptoCurrList Impl."
{
    procedure GetCryptocurrenciesListFromAPI()
    var
        uri: Text;
        HttpClient: HttpClient;
        HttpResponseMessage: HttpResponseMessage;
        JsonText: Text;
    begin
        uri := 'http://api.coinlayer.com/api/list?access_key=' + GetAccessKey();
        HttpClient.Get(uri, HttpResponseMessage);

        if HttpResponseMessage.HttpStatusCode <> 200 then
            Error('Error getting cryptocurrencies list from API');

        HttpResponseMessage.Content.ReadAs(JsonText);
        InsertCryptoCurrency(JsonText);
    end;

    local procedure InsertCryptoCurrency(JsonText: Text)
    var
        JsonValue: JsonValue;
        JsonObject: JsonObject;
        JsonToken: JsonToken;
        CryptoListJObj: JsonObject;
        CryptoListJTkn: JsonToken;
        CryptoJsonToken: JsonToken;
        CryptoJsonObj: JsonObject;
        Currency: Record "Currency";
        CryptoCurrencyName: Text;
        CryptoCurrencySymbol: Text;
        CryptoCurrencyMaxSupply: Decimal;
        CryptoCurrencyIconUrl: Text;
        i: Integer;
    begin
        CryptoListJObj.ReadFrom(JsonText);
        CryptoListJObj.Get('crypto', CryptoListJTkn);

        for i := 1 to CryptoListJTkn.AsObject().Values.Count do begin
            CryptoListJTkn.AsObject().Values.Get(i, CryptoJsonToken);
            JsonObject := CryptoJsonToken.AsObject();

            JsonObject.Get('name_full', JsonToken);
            CryptoCurrencyName := JsonToken.AsValue().AsText();

            JsonObject.Get('symbol', JsonToken);
            CryptoCurrencySymbol := JsonToken.AsValue().AsText();

            JsonObject.Get('icon_url', JsonToken);
            CryptoCurrencyIconUrl := JsonToken.AsValue().AsText();

            if not Currency.Get(CryptoCurrencySymbol) then begin
                Currency.Init();
                Currency."Code" := CryptoCurrencySymbol;
                Currency.Description := CopyStr(CryptoCurrencyName, 1, MaxStrLen(Currency.Description));
                Currency.Insert();

                ImportCurrencyIconFromUrl(CryptoCurrencyIconUrl, Currency);
            end;
        end;
    end;

    local procedure ImportCurrencyIconFromUrl(Url: Text; var Currency: Record "Currency")
    var
        HttpClient: HttpClient;
        HttpResponseMessage: HttpResponseMessage;
        ImageStream: InStream;
    begin
        HttpClient.Get(Url, HttpResponseMessage);
        if HttpResponseMessage.HttpStatusCode <> 200 then
            Error('Error getting currency icon from API');

        HttpResponseMessage.Content.ReadAs(ImageStream);
        Currency."KTN Picture".ImportStream(ImageStream, Currency.Description);
        Currency.Modify();
    end;


    local procedure GetAccessKey(): Text
    begin
        exit('[YOUR ACCESS KEY]');
    end;

}