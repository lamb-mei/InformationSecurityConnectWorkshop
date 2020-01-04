# 資訊安全從連線加密開始workshop



##功能

功能說明

  - Send Data
      - ViewController1.swift
      - 使用 Alamofire傳送網路請求
  - HMAC 
        - ViewController2.swift
        - 使用HMAC金鑰進行資料傳輸簽名



## API

網站網域domain  http://isw.lamb-mei.com   或 https://isw.lamb-mei.com

清單
 -  hmacList 取得HMAC 列表
 -  verifyHMAC 驗證資料使用HMAC簽名是否正確


###  API001 - hmacList 取得HMAC 列表

> 提供 HMAC 金鑰列表 

#### HTTP URL

> {{domain}}/api/hmacList
>
> 方法: `GET`



#### Request  parameters

| Property | Type | Required | Description |
| :------- | :--: | :------: | :---------- |
| -        |      |          |             |

#### Response parameters

| Property |  Type  | Description              |
| :------- | :----: | :----------------------- |
| k1  | string | k1 keyID, value為 HMAC key                  |
| k2   | string | -                 |
| k3  | String | - |
| k4  | String | - |
| k5  | String | - |

#### Example
```
{
    "k1": "b637b17af08aced8850c18cccde915da",
    "k2": "61620957a1443c946a143cf99a7d24fa",
    "k3": "f7ab469d1dc79166fc874dadcc0dd854",
    "k4": "c90b440e841a6b82e1f9b3299164296b",
    "k5": "97b2f1edf640580f66056cc4bfcf6335"
}
```


###  API002 -  verifyHMAC 驗證資料使用HMAC簽名是否正確

> 驗證資料使用HMAC簽名是否正確

#### HTTP URL

> {{domain}}/api/verifyHMAC
>
> 方法: `POST`


#### Request  HEADER

| Property | Type | Required | Description |
| :------- | :--: | :------: | :---------- |
| x-keyid        |   string   |     Required     |    HMAC 金鑰識別碼    |
| x-signature     |  string   |     Required     |    HMAC 資料簽名    |

HMAC 採用 SHA 256

#### Request  parameters

| Property | Type | Required | Description |
| :------- | :--: | :------: | :---------- |
| p1     |   string   | option         |  欄位1           |
| p2     |   string   | option       |  欄位1     |

可傳送任意欄位名稱資料

#### Response parameters

| Property |  Type  | Description              |
| :------- | :----: | :----------------------- |
| output  | object | 判斷後輸出資料                  |
| output.verify   | bool | 簽名驗證是否成功                 |
| output.signature_must_be   | string | 服務端計算出來的簽名  |
| input  | object | 前端輸入的資料顯示 |
| input.keyID  | String | 使用的 HMAD 金鑰識別碼 |
| input.Key  | String | server 對應的 key |
| input.signature  | String | 內文對應的簽名 |
| input.body  | String | 內文 |

#### Example
```
{
    "output": {
        "verify": true,
        "signature_must_be": "41d18b3e74f6270192376d9173da3c2f97e68650e1a1864cf6289bd27c7242ba"
    },
    "input": {
        "keyID": "k1",
        "Key": "b637b17af08aced8850c18cccde915da",
        "signature": "41d18b3e74f6270192376d9173da3c2f97e68650e1a1864cf6289bd27c7242ba",
        "body": "p1=10&p2=20"
    }
}
```

