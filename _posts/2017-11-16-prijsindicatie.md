---
layout: post
title: "Prijsindicatie Door2doc SEH/EHH"
description: ""
date: 2017-11-16
tags: []
comments: false
share: false
---

Bedankt voor uw belangstelling voor Door2doc. Op deze pagina kunt u een prijsindicatie opvragen van Door2doc voor de Spoedeisende Hulp (SEH) en Eerste Harthulp (EHH).

Wij bieden twee versies aan van ons abonnement voor de SEH en EHH.
* Een abonnement met alleen informatie voor patiënten. Namens het ziekenhuis geven wij patiënten realtime informatie over de verwachte wacht- en verblijftijden op de afdeling, te zien in de wachtkamer en de behandelkamers via beeldschermen van het ziekenhuis (*Live en myLive*). Patiënten zien tevens berichten met algemene uitleg over de gang van zaken op de afdeling en ontvangen informatie over de actuele drukte en eventuele verstoringen.
* Een abonnement met de informatie voor patiënten én aanvullende informatie voor professionals in het ziekenhuis (artsen, verpleegkundigen, managers). Hiermee hebben zij realtime grip op de doorstroom (*Timeline*) en krijgen zij inzicht in de actuele prestaties (*Target*) en een optimale inzet van verpleegkundigen en artsen (*Capacity*).

Door2doc SEH/EHH is voor alle professionals overal binnen het ziekenhuis te benaderen via onze gratis app voor mobiel en tablet ([Apple](https://itunes.apple.com/us/app/door2doc-grip-op-wachttijd/id1237548513?l=nl&ls=1&mt=8)/[Android](https://play.google.com/store/apps/details?id=com.door2doc.app)) en de webbrowser op de pc. Tevens maken wij actuele informatie naar wens kosteloos beschikbaar voor patiënten, huisartsen en ambulancediensten via uw ziekenhuiswebsite. Dit doen wij ook voor andere externe koppelingen zoals landelijke crisisinformatiediensten en kwaliteitsrapportages [via Door2doc Connect](http://docs.door2doc.com/2017-11-16/Door2doc-Connect).

De abonnementsprijs is gebaseerd op het totaal aantal bezoeken per kalenderjaar op beide afdelingen en voor alle locaties samen van uw organisatie(s). Bij grotere aantallen geldt een korting (vanaf 20.000 bezoeken en nogmaals vanaf 40.000). Wij rekenen eenmalig kosten voor de [aansluiting](http://docs.door2doc.com/2017-11-16/aansluitinformatie/) op onze cloud. Bij de aansluitkosten is een evaluatieperiode van vier maanden inbegrepen voor het abonnement. Indien u tevreden bent en na deze periode het gebruik van Door2doc SEH/EHH wilt voortzetten, sluiten wij een meerjarige Saas-overeenkomst af voor het abonnement (maandelijkse facturatie). Updates en onderhoud van onze cloudservice zijn altijd inbegrepen, onze software is voortdurend in ontwikkeling.

#### Voer gegevens in van uw organisatie(s)
<p>

  <form action="" id="kosten-indicatie">
    <div class="formfield-container textfield-container">
      <label for="num-visitors">Aantal bezoeken SEH en EHH per jaar:</label>
      <input type="number" id="num-visitors" name="num-visitors">
    </div>

    <div class="formfield-container textfield-container">
      <label for="num-visitors">Aantal locaties:</label>
      <input type="number" id="num-locations" name="num-locations">
    </div>
    <div class="formfield-container checkbox-container">
      <label><input type="checkbox" id="checkbox-ab" name="checkbox-ab">Inclusief informatie voor professionals (Timeline, Target, Capacity)</label>
    </div>
    <div class="formfield-container button-container">
      <input type="button" value="Bekijk indicatie" onclick="showCosts()"/>
    </div>
  </form>

  <div id="kosten-indicatie-result">
    <div class="result-container">
      <span class="label">Indicatie abonnementskosten: </span>
      <strong class="result" id="resultMonth"></strong>
      <span> per maand (</span>
      <span class="result" id="result"></span>
      <span> per jaar)</span>
    </div>

    <div class="result-container">
      <span class="label">Eenmalige aansluitkosten inclusief vier maanden evaluatieperiode: </span>
      <span class="result" id="connectionFee"></span>
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
    function calculateCosts(numVisitors, numLocations, ab) {
   
      var rateA = .65,
          rateAB = .85,
          price = 0,
          feeBasicA = 7450,
          feeBasicAB = 12450,
          feeNextA = 5000,
          feeNextAB = 6000,
          connectionFee = 0,
          limitVisitors_1 = 20000,
          limitVisitors_2 = 40000,
          ab_included = ab,
          rate = ab_included ? rateAB : rateA;
          feeBasic = ab_included ? feeBasicAB : feeBasicA;
          feeNext = ab_included ? feeNextAB : feeNextA;


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

      return ({"price":price, "connectionFee":connectionFee});
    }    

    function showCosts() {

      var inputVisitors = parseInt(document.getElementById('num-visitors').value),
          inputLocations = parseInt(document.getElementById('num-locations').value),
          ab_included = Boolean(document.getElementById('checkbox-ab').checked);

      if (inputVisitors == "") {
        inputVisitors = 0;
      }

      if (inputLocations == "") {
        inputLocations = 0;
      }
      
      var result = calculateCosts(parseInt(inputVisitors), parseInt(inputLocations), ab_included),
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
