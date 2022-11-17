//Get cryptocurrencies from coinlayer.com. Return results as JSON.

codeunit 50101 "KTN Crypto Currency Impl."
{
    procedure GetCryptoCurrencies()
    begin
        GetCryptoCurrenciesJson();
    end;

    local procedure GetCryptoCurrenciesJson()
    var
        Uri: Text;
        Response: Text;
        HttpClient: HttpClient;
        HttpResponseMessage: HttpResponseMessage;
    begin
        Uri := 'http://api.coinlayer.com/list?access_key=' + GetAccessKey();

        HttpClient.Get(Uri, HttpResponseMessage);

        if HttpResponseMessage.HttpStatusCode = 200 then
            HttpResponseMessage.Content.ReadAs(Response)
        else
            Error('Error getting crypto currency list from coinlayer.com');

        SaveResult(Response);
    end;


    local procedure GetAccessKey(): Text
    begin
        exit('[YOUR ACCESS KEY]');
    end;

    local procedure SaveResult(Response: Text)
    var
        JObj: JsonObject;
        CryptoJTtn: JsonToken;
        JTkn: JsonToken;
        JArr: JsonArray;
        i: Integer;
    begin
        //save json response from https://api.coinlayer.com/api/list to currencies table

        //create json object from response
        JObj.ReadFrom(Response);

        JObj.Get('crypto', CryptoJTtn);

        //loop through json object and get json values
        for i := 1 to CryptoJTtn.AsObject().Values.Count do begin
            CryptoJTtn.AsObject().Values.Get(i, JTkn);
            SaveCurrency(JTkn);
        end;
    end;


    local procedure SaveCurrency(CryptoCurrencyJTkn: JsonToken)
    var
        Currency: Record Currency;
        Jtkn: JsonToken;
        PictureInStream: InStream;
    begin
        CryptoCurrencyJTkn.AsObject().Get('symbol', JTkn);
        if not Currency.Get(JTkn.AsValue().AsText()) then begin
            Currency.Init();
            Currency.Code := JTkn.AsValue().AsText();

            CryptoCurrencyJTkn.AsObject().Get('name', JTkn);
            Currency.Description := CopyStr(JTkn.AsValue().AsText(), 1, MaxStrLen(Currency.Description));

            CryptoCurrencyJTkn.AsObject().Get('icon_url', JTkn);
            GetCryptoCurrencyImageFromUrl(jtkn.AsValue().AsText(), PictureInStream);
            Currency."KTN Type" := Currency."KTN Type"::"Crypto Currency";
            Currency.Insert();

            Currency."KTN Picture".ImportStream(PictureInStream, Currency.Description);
            Currency.Modify();
        end;
    end;

    local procedure GetCryptoCurrencyImageFromUrl(Url: Text; var PictureInStream: InStream)
    var
        HttpClient: HttpClient;
        HttpResponseMessage: HttpResponseMessage;
    begin
        HttpClient.Get(Url, HttpResponseMessage);
        if HttpResponseMessage.HttpStatusCode = 200 then
            HttpResponseMessage.Content.ReadAs(PictureInStream)
        else
            Error('Error getting crypto currency image from coinlayer.com');
    end;

}