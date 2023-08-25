Il programma va senza errori. Tuttavia, quando inserisco il numero di cellulare e il codice non riesco ad effettuare il login, nonostante stia usando il numero di telefono e il codice di test che ho aggiunto su firebase (e ovviamente abbia abilitato il login tramite numero di telefono).
Non ricevo alcuna notifica, nonostante credo che lo script sia corretto. Forse è un problema del mio emulatore.
Nel file login_page.dart alla riga 118 c'è questa linea di codice:  MaterialPageRoute(builder: (context) => HomePage())
In realtà quella giusta sarebbe questa: MaterialPageRoute(builder: (context) => OtpPage(smsCodeId: 246810.toString(), phone: 1234567890.toString()))
Però ho tenuto quella in cima a scopo di test visto che non riuscivo a fare il login
Flutter version:  3.10.1
                  
