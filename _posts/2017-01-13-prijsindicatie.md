---
layout: post
title: "Prijsindicatie cloudservice Door2doc"
description: ""
date: 2017-01-13
tags: []
comments: false
share: false
---

Hieronder kunt u een prijsindicatie opvragen voor het abonnement op de cloudservice van Door2doc voor de Spoedeisende Hulp en Eerste Harthulp.

Het standaardabonnement bevat realtime informatie over verwachte wacht- en verblijftijden voor patiënten in de wachtkamer en de behandelkamers (Live en myLive tools). Deze informatie is tevens op te vragen via pc’s en tablets overal in het ziekenhuis en (indien gewenst) op de ziekenhuiswebsite.

Door2doc biedt hiernaast ook andere realtime informatie, bedoeld voor artsen, verpleegkundigen en managers: realtime operational control van de doorstroom en verwachte werkdruk (Timeline, Target tools) en tactisch inzicht voor dienstroosteroptimalisatie op basis van Treatment Point Staffing (Capacity tool). 

  <form action="" id="kosten-indicatie">
    <div class="formfield-container textfield-container">
      <label for="num-visitors">Bezoeken SEH/EHH per jaar</label>
      <input type="number" id="num-visitors" name="num-visitors">
    </div>

    <div class="formfield-container textfield-container">
      <label for="num-visitors">Aantal locaties</label>
      <input type="number" id="num-locations" name="num-locations">
    </div>
    <div class="formfield-container checkbox-container">
      <label><input type="checkbox" id="checkbox-ab" name="checkbox-ab">Inclusief tools voor professionals (Timeline, Target, Capacity)</label>
    </div>
    <div class="formfield-container button-container">
      <input type="button" value="Indicatie" onclick="showCosts()"/>
    </div>
  </form>

  <div id="kosten-indicatie-result">
    <div class="result-container">
      <span class="label">Indicatie abonnementskosten: </span>
      <strong class="result" id="resultMonth"></strong>
      <span> per maand,</span>
      <span class="result" id="result"></span>
      <span> per jaar</span>
    </div>

    <div class="result-container">
      <span class="label">Eenmalige aansluitkosten: </span>
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
   
      var rateA = .6,
          rateAB = .8,
          price = 0,
          feeBasic = 4000,
          feeNext = 4000,
          connectionFee = 0,
          limitVisitors_1 = 20000,
          limitVisitors_2 = 40000,
          ab_included = ab,
          rate = ab_included ? rateAB : rateA;

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
