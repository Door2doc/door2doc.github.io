---
layout: post
title: "Prijsindicatie Door2doc SEH/EHH"
description: ""
date: 2017-12-07
tags: []
comments: false
share: false
---

Bedankt voor uw belangstelling voor de [informatiediensten](http://docs.door2doc.com/2017-12-09/Door2doc/) van Door2doc. Op deze pagina kunt u een prijsindicatie opvragen van Door2doc voor de Spoedeisende Hulp (SEH) en Eerste Harthulp (EHH).

Het abonnement Door2doc SEH/EHH bevat het volgende:
* Actuele informatie voor patiënten over wachttijden en drukte. Namens het ziekenhuis geven wij patiënten realtime informatie over de verwachte wacht- en verblijftijden op de afdeling, te zien in de wachtkamer en de behandelkamers via beeldschermen van het ziekenhuis. Patiënten zien tevens berichten met algemene uitleg over de gang van zaken op de afdeling en ontvangen informatie over de actuele drukte en eventuele verstoringen.
* Doorlopende informatie over de doorstroom, realtime prestaties en de [meest productieve inzet](http://docs.door2doc.com/2017-12-08/Grip-op-werkdruk/) van verpleegkundigen en artsen. Alle professionals (artsen, verpleegkundigen, managers/bestuurders) hebben overal binnen het ziekenhuis toegang tot de actuele informatie via onze gratis app voor mobiel en tablet ([Apple](https://itunes.apple.com/nl/app/door2doc/id1237548513?mt=8)/[Android](https://play.google.com/store/apps/details?id=com.door2doc.app)) en de webbrowser op de pc.
* Tevens delen wij actuele informatie over wachttijden en capaciteit naar wens kosteloos met huisartsen, ambulancediensten en patiënten via uw ziekenhuiswebsite. Wij verzorgen namens het ziekenhuis ook kwaliteits- en keteninformatie via [Door2doc Connect](http://docs.door2doc.com/2017-12-05/Door2doc-Connect).

In combinatie met het abonnement leveren wij online managementinformatie via de aanvullende dienst [Door2doc Reporting](http://docs.door2doc.com/2017-12-04/Door2doc-Reporting). Hiermee beschikt u over vaste rapportages over de prestaties en trends op de SEH en EHH, een ideaal hulpmiddel voor structurele (en automatische) evaluatie van verbeterprojecten en andere veranderingen op de afdeling. De managementinformatie is alleen persoonlijk toegankelijk, altijd up-to-date en overal beschikbaar, ook buiten het ziekenhuis.

De abonnementsprijs van Door2doc SEH/EHH is afhankelijk van het totaal aantal bezoeken per kalenderjaar op de SEH/EHH (er geldt een korting vanaf 20.000 bezoeken en nogmaals vanaf 40.000). Wij brengen hiernaast kosten in rekening voor de [aansluiting op onze cloud](http://docs.door2doc.com/2017-12-06/aansluitinformatie/) en de inrichtingswerkzaamheden, op basis van het aantal locaties van uw organisatie. Facturatie van de abonnements- en aansluitkosten geschiedt maandelijks op basis van een meerjarige SaaS-overeenkomst (Software as a Service). Updates en onderhoud zijn altijd inbegrepen, onze software is voortdurend in ontwikkeling.

#### Voer gegevens in van uw organisatie
<p>

  <form action="" id="kosten-indicatie">
    <div class="formfield-container textfield-container">
      <label for="num-visitors">Aantal bezoeken SEH en EHH per jaar:</label>
      <input type="number" id="num-visitors" name="num-visitors" value="">
    </div>
  
    <div class="formfield-container textfield-container">
      <label for="num-visitors">Aantal locaties:</label>
      <input type="number" id="num-locations" name="num-locations" value="">
    </div>
    <div class="formfield-container checkbox-container">
      <label><input type="checkbox" id="checkbox-online-info" name="checkbox-online-info">Inclusief online managementinformatie (toegang voor twee gebruikers)</label>
    </div>
    <div class="formfield-container button-container">
      <input type="button" value="Bekijk indicatie" onclick="showCosts()"/>
    </div>
  </form>
  
  <div id="kosten-indicatie-result">
    <div class="result-container">
      <span>Prijsindicatie Door2doc SEH/EHH (bedragen exclusief BTW):</span><br>
      <span>- abonnementskosten </span><strong><span class="result" id="resultMonth"></span></strong><span> per maand (</span><span class="result" id="result"></span><span> per jaar)</span><br>
      <span>- kosten voor de aansluiting en inrichting </span><span class="result" id="connectionFee"></span>
    </div>
  </div>
  
  <script>
      document.getElementById("kosten-indicatie").addEventListener("keypress", function(ev) {
          if (ev.keyCode == 13) {
              showCosts();
          }
      });
  
      function numberWithCommas(x) {
          return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".");
      }
  
      //  reductie 40% bij aantal > 40k, 20% bij aantal tussen 20-40k
      function calculateCosts(numVisitors, numLocations, oi) {
  
          var rate = .75,
              feeBasic = 12450,
              feeNext = 6000,
              feeOI = 1800,
              price = 0,
              connectionFee = 0,
              connectionFeeOI = 5500,
              limitVisitors_1 = 20000,
              limitVisitors_2 = 40000,
              oi_included = oi;
  
  
  
          if ( numVisitors > limitVisitors_2 ){
  
              price = parseInt(numVisitors - limitVisitors_2) * rate * (1-0.4) + limitVisitors_1 * rate * (1.8);
  
          } else if (numVisitors > limitVisitors_1) {
  
              price = parseInt(numVisitors - limitVisitors_1) * rate * (1-0.2) + limitVisitors_1 * rate;
  
          } else {
  
              price = numVisitors * rate;
  
          }
  
          if(numLocations > 1) {
  
              connectionFee = feeBasic + (numLocations - 1) * feeNext;
  
          } else {
  
              connectionFee = feeBasic;
  
          }
  
          if(oi_included) {
              price += feeOI;
              connectionFee += connectionFeeOI;
          }
  
          return ({"price":price, "connectionFee":connectionFee});
      }
  
      function showCosts() {
  
          var inputVisitors = parseInt(document.getElementById('num-visitors').value),
              inputLocations = parseInt(document.getElementById('num-locations').value),
              online_info_included = Boolean(document.getElementById('checkbox-online-info').checked);
  
          if (inputVisitors == "") {
              inputVisitors = 0;
          }
  
          if (inputLocations == "") {
              inputLocations = 0;
          }
  
          var result = calculateCosts(parseInt(inputVisitors), parseInt(inputLocations), online_info_included),
              unit = '€',
              cents = ',-';
  
          document.getElementById('result').textContent        = unit + " " + numberWithCommas(parseInt(result.price)) + cents;
          document.getElementById('resultMonth').textContent   = unit + " " + numberWithCommas(parseInt(result.price / 12)) + cents;
                   document.getElementById('connectionFee').textContent  = unit + " " + numberWithCommas(parseInt(result.connectionFee)) + cents;
  
          var resultContainer = document.getElementById('kosten-indicatie-result');
  
          if (resultContainer) {
              resultContainer.className = 'show';
          }
      }
  
  </script>
