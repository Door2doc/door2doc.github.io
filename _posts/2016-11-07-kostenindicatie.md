---
layout: post
title: "Kosten indicatie"
description: "Omschrijving."
date: 2017-01-13
tags: []
comments: false
share: false
---

Tekstje over inhoud standaard pakket.
Dit pakket kan aangevuld worden met het zorgverlenerspakket.
  <form action="" id="kosten-indicatie">
    <div class="formfield-container checkbox-container">
      <label><input type="checkbox" id="checkbox-ab" name="checkbox-ab">Inclusief zorgverlenerspakket</label>
    </div>
    <div class="formfield-container textfield-container">
      <label for="num-visitors">Aantal bezoekers</label>
      <input type="number" id="num-visitors" name="num-visitors">
    </div>

    <div class="formfield-container textfield-container">
      <label for="num-visitors">Aantal locaties</label>
      <input type="number" id="num-locations" name="num-locations">
    </div>

    <div class="formfield-container button-container">
      <input type="button" value="Bereken" onclick="showCosts()"/>
    </div>
  </form>

  <div id="kosten-indicatie-result">
    <div class="result-container">
      <span class="label">Indicatie prijs : </span>
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
          feeBasic = 6000,
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
  
