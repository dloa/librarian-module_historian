####Alexandria Librarian Module: Historian
A tool to let users capture the historical record of any data that can be returned with an API

A daemon, compiled for mac, win and linux that runs constantly in the background, pinging various APIs periodically and then archiving their responses in a blockchain, and a basic browser of the historical datapoints it has captured.

####Tech stack
Front end coded in web technologies (HTML5 & Javascript)   
Back end coded in Go, Rust or Python preferably, Ruby acceptable.   
App should run as a daemon in the background that communicates via RPC calls to the Floincoin-QT wallet (http://florincoin.org/), launched from the terminal, with a webserver visible at http://localhost:someport/ for basic interfacing.   
App should use a SQLite (or comparable) local database as well as communicate with the Florincoin blockchain to archive data in a permanent and public way and look up previously archived data.

####Required Functions

#####*New Historian*
When daemon is running, http://localhost:someport/new-historian should load a simple web form with the input fields:   
  Historian Name: [historian-name]
  Historian Address: [historian-flo-address]   
  Historian BTC Tip Address: [historian-btc-address]   
  Historian Bit-Message Address: [historian-bm-address]   

When submitted, store all of the records about this new Historian into the local SQLite db and use an RPC call to the Florincoin-QT application to send a transaction to the users own address with a Transaction message to announce the Historian publicly. Also record the TXID of the blockchain submission in the SQLite db.

Relevant RPC calls:
signmessage <florincoinaddress> <message>
sendtoaddress <florincoinaddress> <amount> [comment] [comment-to] [tx-comment]

Message format (this goes in the [tx-comment] field of the RPC call, [comment] and [comment-to] are not used)
```
{ "alexandria-historian": { "name": "[historian-name]", "address": "[historian-flo-address]", "timestamp":1234567890123, "bitcoin": "[historian-btc-address]", "bitmessage": "[historian-bm-address]"}, "signature":"[historian-name]-[historian-flo-address]-[timestamp]signedby[historian-flo-address]"}
```
Example message
```
{ "alexandria-historian": { "name": "test01", "address": "FFsbvNQpqThNoWuWEAb4RGDFMVNWncj7De", "timestamp":1432770884000, "bitcoin": "18BjZUHWYDzCgjYDnJJURw79QRnwZoznFs", "bitmessage": ""}, "signature":"IJnL3rGLwst6CWAJT5DydbScECoiqkgAb2SrtNdlBs8nM66bvMFO0KecJ6xH6irTw5JvJEvX3nrWVxmIfsnOasw="}
```
sign this:
test01-FFsbvNQpqThNoWuWEAb4RGDFMVNWncj7De-1432770884000
with this address:
FFsbvNQpqThNoWuWEAb4RGDFMVNWncj7De
resulting signature:
IJnL3rGLwst6CWAJT5DydbScECoiqkgAb2SrtNdlBs8nM66bvMFO0KecJ6xH6irTw5JvJEvX3nrWVxmIfsnOasw=

formatted for console submission in Florincoin-QT:
```
sendtoaddress FFsbvNQpqThNoWuWEAb4RGDFMVNWncj7De 1.0 "" "" " { \"alexandria-historian\": { \"name\": \"test01\", \"address\": \"FFsbvNQpqThNoWuWEAb4RGDFMVNWncj7De\", \"timestamp\":1432770884000, \"bitcoin\": \"18BjZUHWYDzCgjYDnJJURw79QRnwZoznFs\", \"bitmessage\": \"\"}, \"signature\":\"IJnL3rGLwst6CWAJT5DydbScECoiqkgAb2SrtNdlBs8nM66bvMFO0KecJ6xH6irTw5JvJEvX3nrWVxmIfsnOasw=\"}"
```
Resulting TX:
```
http://florincoin.info/explorer/tx/?txid=a8f7bebb93def02485d24bc94a169567a0f32fd2ee55234520a22d4c41bd606d
```
New History Record
When daemon is running, http://localhost:someport/new-history-record should load a simple web form with the input fields:
History Record Title (for example “Bitcoin Price”)
HTTP API address (for example, “https://api.bitcoinaverage.com/ticker/global/USD/”)
Field(s) to store (for example “24h_average”)
Rate (for example, “1 time per hour”
For personal use or for public use 
Historian Address (florincoin address announced by a ‘new-historian’ submission)

When submitted, store all of the records of the “History Record” into the local SQLite db and use an RPC call to the Florincoin-QT application to send a transaction to the users own address with a Transaction message to announce it to the world. Also record the TXID of the blockchain submission in the SQLite db.

Relevant RPC calls:
signmessage <florincoinaddress> <message>
sendtoaddress <florincoinaddress> <amount> [comment] [comment-to] [tx-comment]

Message format (this goes in the [tx-comment] field of the RPC call, [comment] and [comment-to] are not used)
```
{ "alexandria-history-record": { "title": "[history-record-title]", "address": "[historian-flo-address]", "timestamp":1234567890123, "api":"[HTTP API address]", "fields":"[list of field names]", "rate":"[rate]"}, "signature":"[historian-name]-[history-record-title]-[timestamp]signedby[historian-flo-address]"}
```
Message Example:
```
{ "alexandria-history-record": { "title": "BTC-USD-avg", "address": "FFsbvNQpqThNoWuWEAb4RGDFMVNWncj7De", "timestamp":1432780552, "api":"https://api.bitcoinaverage.com/ticker/global/USD/", "fields":"24h_avg,ask,bid,last,volume_btc,volume_percent", "rate":"1perHour"}, "signature":"[historian-name]-[history-record-title]-[timestamp]signedby[historian-flo-address]"}
```

sign this:
```
test01-BTC-USD-avg-1432780552
```
with this address:
```
FFsbvNQpqThNoWuWEAb4RGDFMVNWncj7De
```
resulting signature:
```
H7H5qbvizmWpLUPnt8iuPr7crxidh4YeNlwD0HlLOVJL0KiP2+8JZGx0e7NrbPl70Xsb59vui9sv1hG3U51zSos=
```
formatted for console submission in Florincoin-QT:
```
sendtoaddress FFsbvNQpqThNoWuWEAb4RGDFMVNWncj7De 1.0 "" "" " { \"alexandria-history-record\": { \"title\": \"BTC-USD-avg\", \"address\": \"FFsbvNQpqThNoWuWEAb4RGDFMVNWncj7De\", \"timestamp\":1432780552, \"api\":\"https://api.bitcoinaverage.com/ticker/global/USD/\", \"fields\":\"24h_avg,ask,bid,last,volume_btc,volume_percent\", \"rate\":\"1perHour\"}, \"signature\":\"H7H5qbvizmWpLUPnt8iuPr7crxidh4YeNlwD0HlLOVJL0KiP2+8JZGx0e7NrbPl70Xsb59vui9sv1hG3U51zSos=\"}"
```
Resulting TX:
```
http://florincoin.info/explorer/tx/?txid=d367ce1bb25d6089e5861925311ed30f9521aad1b62bb96e8737f8361e28f1ac
```







New History Record Datapoint
If the SQLite db has any “New History Record” announcements stored, the daemon should keep track of when it was published and what the user chose for “Rate” to determine when it should next ping the appropriate API. At the appropriate time, the daemon will use the TXID of the “New History Record” announcement to look up the appropriate API address and fields to capture.

Relevant RPC calls:
listtransactions [account] [count=10] [from=0]
getrawtransaction <txid> [verbose=0]
decoderawtransaction <hex string>

Example RPC calls:
(this example is being run on my local machine, the results will not match if you do this yourself - also note that [account] refers to the wallet label on an address, not the address itself)

input:
```
listtransactions alex-historian-test01
```
output:
```
[
{
"account" : "alex-historian-test01",
"address" : "FFsbvNQpqThNoWuWEAb4RGDFMVNWncj7De",
"category" : "receive",
"amount" : 1.00000000,
"confirmations" : 195,
"blockhash" : "5ccaae9281d87b5ed2843747596bbc29a855a5ff9ac5b880f11a588a4a8075e6",
"blockindex" : 3,
"blocktime" : 1432771577,
"txid" : "a8f7bebb93def02485d24bc94a169567a0f32fd2ee55234520a22d4c41bd606d",
"normtxid" : "2fcb46fed07b08d9620bcc51d0f3f9e50eb923419fa33349b6ed1d56cbd86847",
"time" : 1432771492,
"timereceived" : 1432771492
},
{
"account" : "alex-historian-test01",
"address" : "FFsbvNQpqThNoWuWEAb4RGDFMVNWncj7De",
"category" : "receive",
"amount" : 1.00000000,
"confirmations" : 177,
"blockhash" : "2e47c76ebb58548a3aa2b181ce195dead2d435edad875552319ebc22a17b968b",
"blockindex" : 2,
"blocktime" : 1432772447,
"txid" : "6f84eb85e808e9af628aeb6c2a95ab9bc680445adafc16f63f891cde54938269",
"normtxid" : "f6854562b1137832a9b759e148c11efb9fdf9728bd4ea20826e0ac0c8743b691",
"time" : 1432772367,
"timereceived" : 1432772367
},
{
"account" : "alex-historian-test01",
"address" : "FFsbvNQpqThNoWuWEAb4RGDFMVNWncj7De",
"category" : "receive",
"amount" : 1.00000000,
"confirmations" : 99,
"blockhash" : "d22670bb6eb6962341f93f65f677c0b0f3667b8c8bc36ae6a232b102fa2d6069",
"blockindex" : 2,
"blocktime" : 1432776095,
"txid" : "0e72d86be192b13f5fe98c9fed9eab4f83eb2be259f37df847b27e5e31372280",
"normtxid" : "179d8d550065d6d5834b2fad3bb70b8bb93a4f4f8213797548edb43f23695a4c",
"time" : 1432776016,
"timereceived" : 1432776016
},
{
"account" : "alex-historian-test01",
"address" : "FFsbvNQpqThNoWuWEAb4RGDFMVNWncj7De",
"category" : "receive",
"amount" : 1.00000000,
"confirmations" : 19,
"blockhash" : "a4d20761dac741e7c3abb1aa219074363261ba398d7425ea115382b7551635d4",
"blockindex" : 4,
"blocktime" : 1432780948,
"txid" : "d367ce1bb25d6089e5861925311ed30f9521aad1b62bb96e8737f8361e28f1ac",
"normtxid" : "f90d4ac6f684c39e18287aa454ca066282ed204c62650d8b067a3a944ee682c9",
"time" : 1432780938,
"timereceived" : 1432780938
},
{
"account" : "alex-historian-test01",
"address" : "FFsbvNQpqThNoWuWEAb4RGDFMVNWncj7De",
"category" : "receive",
"amount" : 1.00000000,
"confirmations" : 0,
"txid" : "97079f8ddcae8ed93a59cacfcc2885fa4e4505e99ec149260ad3d83c954f2775",
"normtxid" : "73ae06ead43bd95ee66125323d4bd3959418d7bbf739624ac2cdc75d8c602a63",
"time" : 1432781783,
"timereceived" : 1432781783
}
]
```
input:
```
getrawtransaction d367ce1bb25d6089e5861925311ed30f9521aad1b62bb96e8737f8361e28f1ac
```
output:
```
0200000002802237315e7eb247f87df359e22beb834fab9eed9f8ce95f3fb192e16bd8720e000000006a47304402207ed9fa4258526a87c4d380d6c39598328c6fc5bb6f9ea7d9a317ae4efb57806f02203473aee811819982212b6df4ad5e312d95511d951325d4e7020445567c1f4b1a0121033d9c8ea8637be9d57806d6dbd24b24f3575d0057a7b4e4c27ab91057bbc75ddaffffffff802237315e7eb247f87df359e22beb834fab9eed9f8ce95f3fb192e16bd8720e010000006a47304402206706a8181f41693378cc3453ea7d212d4d6b9469f0a1aedd20b657e3b785f0a1022077c7b1eb43cefb631281aa3cf8a8e3d44e1939b2cd9a9ab4136c11b0622c36af012103728047eaab4d79fec7121238aae49b01d3c66f4a9b2cc5613416c9ff1c35b961ffffffff0280f0fa02000000001976a914362e904d0b60973b88d30d84917d65fd54ea6b5488ac00e1f505000000001976a9146e29d86a22ee72cf1c032b4afde179a719cc2e6788ac00000000fd7401207b2022616c6578616e647269612d686973746f72792d7265636f7264223a207b20227469746c65223a20224254432d5553442d617667222c202261646472657373223a202246467362764e51707154684e6f57755745416234524744464d564e576e636a374465222c202274696d657374616d70223a313433323738303535322c2022617069223a2268747470733a2f2f6170692e626974636f696e617665726167652e636f6d2f7469636b65722f676c6f62616c2f5553442f222c20226669656c6473223a223234685f6176672c61736b2c6269642c6c6173742c766f6c756d655f6274632c766f6c756d655f70657263656e74222c202272617465223a2231706572486f7572227d2c20227369676e6174757265223a2248374835716276697a6d57704c55506e743869755072376372786964683459654e6c774430486c4c4f564a4c304b6950322b384a5a47783065374e7262506c37305873623539767569397376316847335535317a536f733d227d
```
input:
```
decoderawtransaction 0200000002802237315e7eb247f87df359e22beb834fab9eed9f8ce95f3fb192e16bd8720e000000006a47304402207ed9fa4258526a87c4d380d6c39598328c6fc5bb6f9ea7d9a317ae4efb57806f02203473aee811819982212b6df4ad5e312d95511d951325d4e7020445567c1f4b1a0121033d9c8ea8637be9d57806d6dbd24b24f3575d0057a7b4e4c27ab91057bbc75ddaffffffff802237315e7eb247f87df359e22beb834fab9eed9f8ce95f3fb192e16bd8720e010000006a47304402206706a8181f41693378cc3453ea7d212d4d6b9469f0a1aedd20b657e3b785f0a1022077c7b1eb43cefb631281aa3cf8a8e3d44e1939b2cd9a9ab4136c11b0622c36af012103728047eaab4d79fec7121238aae49b01d3c66f4a9b2cc5613416c9ff1c35b961ffffffff0280f0fa02000000001976a914362e904d0b60973b88d30d84917d65fd54ea6b5488ac00e1f505000000001976a9146e29d86a22ee72cf1c032b4afde179a719cc2e6788ac00000000fd7401207b2022616c6578616e647269612d686973746f72792d7265636f7264223a207b20227469746c65223a20224254432d5553442d617667222c202261646472657373223a202246467362764e51707154684e6f57755745416234524744464d564e576e636a374465222c202274696d657374616d70223a313433323738303535322c2022617069223a2268747470733a2f2f6170692e626974636f696e617665726167652e636f6d2f7469636b65722f676c6f62616c2f5553442f222c20226669656c6473223a223234685f6176672c61736b2c6269642c6c6173742c766f6c756d655f6274632c766f6c756d655f70657263656e74222c202272617465223a2231706572486f7572227d2c20227369676e6174757265223a2248374835716276697a6d57704c55506e743869755072376372786964683459654e6c774430486c4c4f564a4c304b6950322b384a5a47783065374e7262506c37305873623539767569397376316847335535317a536f733d227d
```
output:
```
{
"txid" : "d367ce1bb25d6089e5861925311ed30f9521aad1b62bb96e8737f8361e28f1ac",
"version" : 2,
"locktime" : 0,
"vin" : [
{
"txid" : "0e72d86be192b13f5fe98c9fed9eab4f83eb2be259f37df847b27e5e31372280",
"vout" : 0,
"scriptSig" : {
"asm" : "304402207ed9fa4258526a87c4d380d6c39598328c6fc5bb6f9ea7d9a317ae4efb57806f02203473aee811819982212b6df4ad5e312d95511d951325d4e7020445567c1f4b1a01 033d9c8ea8637be9d57806d6dbd24b24f3575d0057a7b4e4c27ab91057bbc75dda",
"hex" : "47304402207ed9fa4258526a87c4d380d6c39598328c6fc5bb6f9ea7d9a317ae4efb57806f02203473aee811819982212b6df4ad5e312d95511d951325d4e7020445567c1f4b1a0121033d9c8ea8637be9d57806d6dbd24b24f3575d0057a7b4e4c27ab91057bbc75dda"
},
"sequence" : 4294967295
},
{
"txid" : "0e72d86be192b13f5fe98c9fed9eab4f83eb2be259f37df847b27e5e31372280",
"vout" : 1,
"scriptSig" : {
"asm" : "304402206706a8181f41693378cc3453ea7d212d4d6b9469f0a1aedd20b657e3b785f0a1022077c7b1eb43cefb631281aa3cf8a8e3d44e1939b2cd9a9ab4136c11b0622c36af01 03728047eaab4d79fec7121238aae49b01d3c66f4a9b2cc5613416c9ff1c35b961",
"hex" : "47304402206706a8181f41693378cc3453ea7d212d4d6b9469f0a1aedd20b657e3b785f0a1022077c7b1eb43cefb631281aa3cf8a8e3d44e1939b2cd9a9ab4136c11b0622c36af012103728047eaab4d79fec7121238aae49b01d3c66f4a9b2cc5613416c9ff1c35b961"
},
"sequence" : 4294967295
}
],
"vout" : [
{
"value" : 0.50000000,
"n" : 0,
"scriptPubKey" : {
"asm" : "OP_DUP OP_HASH160 362e904d0b60973b88d30d84917d65fd54ea6b54 OP_EQUALVERIFY OP_CHECKSIG",
"hex" : "76a914362e904d0b60973b88d30d84917d65fd54ea6b5488ac",
"reqSigs" : 1,
"type" : "pubkeyhash",
"addresses" : [
"FAmbjThTVgLnVA8ji1WKpfXefB1XeLqc4g"
]
}
},
{
"value" : 1.00000000,
"n" : 1,
"scriptPubKey" : {
"asm" : "OP_DUP OP_HASH160 6e29d86a22ee72cf1c032b4afde179a719cc2e67 OP_EQUALVERIFY OP_CHECKSIG",
"hex" : "76a9146e29d86a22ee72cf1c032b4afde179a719cc2e6788ac",
"reqSigs" : 1,
"type" : "pubkeyhash",
"addresses" : [
"FFsbvNQpqThNoWuWEAb4RGDFMVNWncj7De"
]
}
}
],
"tx-comment" : " { \"alexandria-history-record\": { \"title\": \"BTC-USD-avg\", \"address\": \"FFsbvNQpqThNoWuWEAb4RGDFMVNWncj7De\", \"timestamp\":1432780552, \"api\":\"https://api.bitcoinaverage.com/ticker/global/USD/\", \"fields\":\"24h_avg,ask,bid,last,volume_btc,volume_percent\", \"rate\":\"1perHour\"}, \"signature\":\"H7H5qbvizmWpLUPnt8iuPr7crxidh4YeNlwD0HlLOVJL0KiP2+8JZGx0e7NrbPl70Xsb59vui9sv1hG3U51zSos=\"}"
}
```
Extracting the relevant datapoints from these results, we can see that the appropriate API address and fields to capture and publish are:
API address: `https://api.bitcoinaverage.com/ticker/global/USD/`
Fields: `24h_avg,ask,bid,last,volume_btc,volume_percent`

The daemon should then check the local SQLite db entry for the “New History Record” to see if they selected “Public Use” or “Personal Use” - this choice does not get published in any blockchain submissions, it is a local preference and can be changed by the user if they wish. If the user chose “Public Use”, then the daemon will work by sending the results from the API calls to a FLO address announced by a third party who is running a “historian gateway” on the web (communicates with their wallet and can display the captured data points on a publicly visible website). If they chose “personal use” then they will send the messages to themselves. For the purposes of this MVP, please treat all situations as if the user chose “personal use” because another mechanism will need to be in place before the “public use” option could fully be implemented.

When submitted, store all of the records of the “History Record Datapoint” into the local SQLite db and use an RPC call to the Florincoin-QT application to send a transaction to the users own address with a Transaction message. Also record the TXID of this blockchain submission in the SQLite db.

Relevant RPC calls
signmessage `<florincoinaddress> <message>`
sendtoaddress `<florincoinaddress> <amount> [comment] [comment-to] [tx-comment]`

Message format (this goes in the [tx-comment] field of the RPC call, [comment] and [comment-to] are not used)
```
{ "alexandria-history-record-datapoint": { "title": "[history-record-title]", "address": "[historian-flo-address]", "timestamp":1234567890123, "api":"[HTTP API address]", "[field1]":"[result-for-field-1]","[field2]":"[result-for-field-2]",}, "signature":"[historian-name]-[history-record-title]-[result-for-field-1]-[timestamp]signedby[historian-flo-address]"}
```
signed this:
`test01-BTC-USD-avg-238.95-1432781149`
with this address:
`FFsbvNQpqThNoWuWEAb4RGDFMVNWncj7De`
resulting sig:
`IMyni1JQimwuR58HNruIDDt8oLBofVSaIiQ2iyxFyB8irkIpaxzSIJ1ELopcib4xsSFdWJA6vt9j3a3lwvIUvLs=`

Example message:
```
{ "alexandria-history-record-datapoint": { "title": "BTC-USD-avg", "address": "FFsbvNQpqThNoWuWEAb4RGDFMVNWncj7De", "timestamp":1432781149, "api":"https://api.bitcoinaverage.com/ticker/global/USD/", "24h_avg":"238.95", "ask":"238.28", "bid":"238.12", "last":"238.35", "volume_btc":"52326.85", "volume_percent":"85.53"}, "signature":"IMyni1JQimwuR58HNruIDDt8oLBofVSaIiQ2iyxFyB8irkIpaxzSIJ1ELopcib4xsSFdWJA6vt9j3a3lwvIUvLs="}
```

formatted for console submission in Florincoin-QT:
```
sendtoaddress FFsbvNQpqThNoWuWEAb4RGDFMVNWncj7De 1.0 "" "" " { \"alexandria-history-record-datapoint\": { \"title\": \"BTC-USD-avg\", \"address\": \"FFsbvNQpqThNoWuWEAb4RGDFMVNWncj7De\", \"timestamp\":1432781149, \"api\":\"https://api.bitcoinaverage.com/ticker/global/USD/\", \"24h_avg\":\"238.95\", \"ask\":\"238.28\", \"bid\":\"238.12\", \"last\":\"238.35\", \"volume_btc\":\"52326.85\", \"volume_percent\":\"85.53\"}, \"signature\":\"IMyni1JQimwuR58HNruIDDt8oLBofVSaIiQ2iyxFyB8irkIpaxzSIJ1ELopcib4xsSFdWJA6vt9j3a3lwvIUvLs=\"}"
```
Resulting TX:
`http://florincoin.info/explorer/tx/?txid=97079f8ddcae8ed93a59cacfcc2885fa4e4505e99ec149260ad3d83c954f2775`

Browse History Records
`http://localhost:someport/history-record-results` should respond with JSON objects of the stored fields (from our example, “24h_average”), the record title (“Bitcoin Price”), API source (“https://api.bitcoinaverage.com/ticker/global/USD/”) and the records timestamps (from the txids)

Relevant RPC calls:
```
listtransactions [account] [count=10] [from=0]
getrawtransaction <txid> [verbose=0]
decoderawtransaction <hex string>
```

Example RPC calls:
(this example is being run on my local machine, the results will not match if you do this yourself - also note that [account] refers to the wallet label on an address, not the address itself)

input:
`listtransactions alex-historian-test01`
output:
```
[
{
"account" : "alex-historian-test01",
"address" : "FFsbvNQpqThNoWuWEAb4RGDFMVNWncj7De",
"category" : "receive",
"amount" : 1.00000000,
"confirmations" : 195,
"blockhash" : "5ccaae9281d87b5ed2843747596bbc29a855a5ff9ac5b880f11a588a4a8075e6",
"blockindex" : 3,
"blocktime" : 1432771577,
"txid" : "a8f7bebb93def02485d24bc94a169567a0f32fd2ee55234520a22d4c41bd606d",
"normtxid" : "2fcb46fed07b08d9620bcc51d0f3f9e50eb923419fa33349b6ed1d56cbd86847",
"time" : 1432771492,
"timereceived" : 1432771492
},
{
"account" : "alex-historian-test01",
"address" : "FFsbvNQpqThNoWuWEAb4RGDFMVNWncj7De",
"category" : "receive",
"amount" : 1.00000000,
"confirmations" : 177,
"blockhash" : "2e47c76ebb58548a3aa2b181ce195dead2d435edad875552319ebc22a17b968b",
"blockindex" : 2,
"blocktime" : 1432772447,
"txid" : "6f84eb85e808e9af628aeb6c2a95ab9bc680445adafc16f63f891cde54938269",
"normtxid" : "f6854562b1137832a9b759e148c11efb9fdf9728bd4ea20826e0ac0c8743b691",
"time" : 1432772367,
"timereceived" : 1432772367
},
{
"account" : "alex-historian-test01",
"address" : "FFsbvNQpqThNoWuWEAb4RGDFMVNWncj7De",
"category" : "receive",
"amount" : 1.00000000,
"confirmations" : 99,
"blockhash" : "d22670bb6eb6962341f93f65f677c0b0f3667b8c8bc36ae6a232b102fa2d6069",
"blockindex" : 2,
"blocktime" : 1432776095,
"txid" : "0e72d86be192b13f5fe98c9fed9eab4f83eb2be259f37df847b27e5e31372280",
"normtxid" : "179d8d550065d6d5834b2fad3bb70b8bb93a4f4f8213797548edb43f23695a4c",
"time" : 1432776016,
"timereceived" : 1432776016
},
{
"account" : "alex-historian-test01",
"address" : "FFsbvNQpqThNoWuWEAb4RGDFMVNWncj7De",
"category" : "receive",
"amount" : 1.00000000,
"confirmations" : 19,
"blockhash" : "a4d20761dac741e7c3abb1aa219074363261ba398d7425ea115382b7551635d4",
"blockindex" : 4,
"blocktime" : 1432780948,
"txid" : "d367ce1bb25d6089e5861925311ed30f9521aad1b62bb96e8737f8361e28f1ac",
"normtxid" : "f90d4ac6f684c39e18287aa454ca066282ed204c62650d8b067a3a944ee682c9",
"time" : 1432780938,
"timereceived" : 1432780938
},
{
"account" : "alex-historian-test01",
"address" : "FFsbvNQpqThNoWuWEAb4RGDFMVNWncj7De",
"category" : "receive",
"amount" : 1.00000000,
"confirmations" : 0,
"txid" : "97079f8ddcae8ed93a59cacfcc2885fa4e4505e99ec149260ad3d83c954f2775",
"normtxid" : "73ae06ead43bd95ee66125323d4bd3959418d7bbf739624ac2cdc75d8c602a63",
"time" : 1432781783,
"timereceived" : 1432781783
}
]
```

input:
`getrawtransaction 97079f8ddcae8ed93a59cacfcc2885fa4e4505e99ec149260ad3d83c954f2775`
output:
```
0200000002acf1281e36f837876eb92bb6d1aa21950fd31e31251986e589605db21bce67d3000000006b48304502203e0b7e6e15a4bd253ccc9fb7acdaad5881c1f98b81a161d7e6699bea2f314e5e022100af1f5f5dd9407fada4691cf126f04e7e6c1874acea5683d8c1042912d0d9b5b90121030a4700d0d16a14142a8f5c0d5f9c51ec6535b77322b3514404c34ee6c744fa67ffffffffacf1281e36f837876eb92bb6d1aa21950fd31e31251986e589605db21bce67d3010000006b4830450220201154f3479bb7b874eb47392731ff856ac887f53be906066a4ee5e8b7a3fb2a022100b4797340a3e3ad1a5a26e46c87eed44bc97c5a932040763a55197ee4973d4984012103728047eaab4d79fec7121238aae49b01d3c66f4a9b2cc5613416c9ff1c35b961ffffffff0200e1f505000000001976a9146e29d86a22ee72cf1c032b4afde179a719cc2e6788ac40787d01000000001976a9144a19e2051fcdd9b5944b6a347229ed9035516e6c88ac00000000fda801207b2022616c6578616e647269612d686973746f72792d7265636f72642d64617461706f696e74223a207b20227469746c65223a20224254432d5553442d617667222c202261646472657373223a202246467362764e51707154684e6f57755745416234524744464d564e576e636a374465222c202274696d657374616d70223a313433323738313134392c2022617069223a2268747470733a2f2f6170692e626974636f696e617665726167652e636f6d2f7469636b65722f676c6f62616c2f5553442f222c20223234685f617667223a223233382e3935222c202261736b223a223233382e3238222c2022626964223a223233382e3132222c20226c617374223a223233382e3335222c2022766f6c756d655f627463223a2235323332362e3835222c2022766f6c756d655f70657263656e74223a2238352e3533227d2c20227369676e6174757265223a22494d796e69314a51696d7775523538484e727549444474386f4c426f66565361496951326979784679423869726b497061787a53494a31454c6f70636962347873534664574a41367674396a3361336c77764955764c733d227d
```

input:
```
decoderawtransaction 0200000002acf1281e36f837876eb92bb6d1aa21950fd31e31251986e589605db21bce67d3000000006b48304502203e0b7e6e15a4bd253ccc9fb7acdaad5881c1f98b81a161d7e6699bea2f314e5e022100af1f5f5dd9407fada4691cf126f04e7e6c1874acea5683d8c1042912d0d9b5b90121030a4700d0d16a14142a8f5c0d5f9c51ec6535b77322b3514404c34ee6c744fa67ffffffffacf1281e36f837876eb92bb6d1aa21950fd31e31251986e589605db21bce67d3010000006b4830450220201154f3479bb7b874eb47392731ff856ac887f53be906066a4ee5e8b7a3fb2a022100b4797340a3e3ad1a5a26e46c87eed44bc97c5a932040763a55197ee4973d4984012103728047eaab4d79fec7121238aae49b01d3c66f4a9b2cc5613416c9ff1c35b961ffffffff0200e1f505000000001976a9146e29d86a22ee72cf1c032b4afde179a719cc2e6788ac40787d01000000001976a9144a19e2051fcdd9b5944b6a347229ed9035516e6c88ac00000000fda801207b2022616c6578616e647269612d686973746f72792d7265636f72642d64617461706f696e74223a207b20227469746c65223a20224254432d5553442d617667222c202261646472657373223a202246467362764e51707154684e6f57755745416234524744464d564e576e636a374465222c202274696d657374616d70223a313433323738313134392c2022617069223a2268747470733a2f2f6170692e626974636f696e617665726167652e636f6d2f7469636b65722f676c6f62616c2f5553442f222c20223234685f617667223a223233382e3935222c202261736b223a223233382e3238222c2022626964223a223233382e3132222c20226c617374223a223233382e3335222c2022766f6c756d655f627463223a2235323332362e3835222c2022766f6c756d655f70657263656e74223a2238352e3533227d2c20227369676e6174757265223a22494d796e69314a51696d7775523538484e727549444474386f4c426f66565361496951326979784679423869726b497061787a53494a31454c6f70636962347873534664574a41367674396a3361336c77764955764c733d227d
```
output:
```
{
"txid" : "97079f8ddcae8ed93a59cacfcc2885fa4e4505e99ec149260ad3d83c954f2775",
"version" : 2,
"locktime" : 0,
"vin" : [
{
"txid" : "d367ce1bb25d6089e5861925311ed30f9521aad1b62bb96e8737f8361e28f1ac",
"vout" : 0,
"scriptSig" : {
"asm" : "304502203e0b7e6e15a4bd253ccc9fb7acdaad5881c1f98b81a161d7e6699bea2f314e5e022100af1f5f5dd9407fada4691cf126f04e7e6c1874acea5683d8c1042912d0d9b5b901 030a4700d0d16a14142a8f5c0d5f9c51ec6535b77322b3514404c34ee6c744fa67",
"hex" : "48304502203e0b7e6e15a4bd253ccc9fb7acdaad5881c1f98b81a161d7e6699bea2f314e5e022100af1f5f5dd9407fada4691cf126f04e7e6c1874acea5683d8c1042912d0d9b5b90121030a4700d0d16a14142a8f5c0d5f9c51ec6535b77322b3514404c34ee6c744fa67"
},
"sequence" : 4294967295
},
{
"txid" : "d367ce1bb25d6089e5861925311ed30f9521aad1b62bb96e8737f8361e28f1ac",
"vout" : 1,
"scriptSig" : {
"asm" : "30450220201154f3479bb7b874eb47392731ff856ac887f53be906066a4ee5e8b7a3fb2a022100b4797340a3e3ad1a5a26e46c87eed44bc97c5a932040763a55197ee4973d498401 03728047eaab4d79fec7121238aae49b01d3c66f4a9b2cc5613416c9ff1c35b961",
"hex" : "4830450220201154f3479bb7b874eb47392731ff856ac887f53be906066a4ee5e8b7a3fb2a022100b4797340a3e3ad1a5a26e46c87eed44bc97c5a932040763a55197ee4973d4984012103728047eaab4d79fec7121238aae49b01d3c66f4a9b2cc5613416c9ff1c35b961"
},
"sequence" : 4294967295
}
],
"vout" : [
{
"value" : 1.00000000,
"n" : 0,
"scriptPubKey" : {
"asm" : "OP_DUP OP_HASH160 6e29d86a22ee72cf1c032b4afde179a719cc2e67 OP_EQUALVERIFY OP_CHECKSIG",
"hex" : "76a9146e29d86a22ee72cf1c032b4afde179a719cc2e6788ac",
"reqSigs" : 1,
"type" : "pubkeyhash",
"addresses" : [
"FFsbvNQpqThNoWuWEAb4RGDFMVNWncj7De"
]
}
},
{
"value" : 0.25000000,
"n" : 1,
"scriptPubKey" : {
"asm" : "OP_DUP OP_HASH160 4a19e2051fcdd9b5944b6a347229ed9035516e6c OP_EQUALVERIFY OP_CHECKSIG",
"hex" : "76a9144a19e2051fcdd9b5944b6a347229ed9035516e6c88ac",
"reqSigs" : 1,
"type" : "pubkeyhash",
"addresses" : [
"FCavUNWKMcX8SWcZd5aa8yCPfWhHJgkfMX"
]
}
}
],
"tx-comment" : " { \"alexandria-history-record-datapoint\": { \"title\": \"BTC-USD-avg\", \"address\": \"FFsbvNQpqThNoWuWEAb4RGDFMVNWncj7De\", \"timestamp\":1432781149, \"api\":\"https://api.bitcoinaverage.com/ticker/global/USD/\", \"24h_avg\":\"238.95\", \"ask\":\"238.28\", \"bid\":\"238.12\", \"last\":\"238.35\", \"volume_btc\":\"52326.85\", \"volume_percent\":\"85.53\"}, \"signature\":\"IMyni1JQimwuR58HNruIDDt8oLBofVSaIiQ2iyxFyB8irkIpaxzSIJ1ELopcib4xsSFdWJA6vt9j3a3lwvIUvLs=\"}"
}
```


Extracting the relevant datapoints from these results, we can now display:
```
History Record Name: BTC-USD-avg
API:  https://api.bitcoinaverage.com/ticker/global/USD/
Datapoint Timestamp: 1432781149 (display as 05/28/2015 @ 2:45am (UTC))
24h_avg: 238.95
ask: 238.28
bid: 238.12
last: 238.35
volume_btc: 52326.85
volume_percent: 85.53
```

And by stringing a series of these datapoints together, we can graph changes over time, for example, here are the results from running getrawtransaction and decoderawtransaction on this txid: `61aa34236ac06d92c4600df95c580160140696cfe4ab1ce884fbb4a67c300189`
```
History Record Name: BTC-USD-avg
API:  https://api.bitcoinaverage.com/ticker/global/USD/
Datapoint Timestamp: 1432784704 (display as 05/28/2015 @ 3:45am (UTC))
24h_avg: 238.93
ask: 238.39
bid: 238.2
last: 238.4
volume_btc: 52913.67
volume_percent: 85.75
```
