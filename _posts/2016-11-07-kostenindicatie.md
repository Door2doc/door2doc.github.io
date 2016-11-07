---
layout: post
title: "Kosten indicatie"
description: "Omschrijving."
date: 2016-11-07
tags: [sample post, readability, test, intro]
comments: true
share: true
---

<form action="">
    <div formfield-container>
      <label for="num-visitors">Aantal bezoekers</label>
      <input type="text" id="num-visitors" name="num-visitors">
    </div>

    <div formfield-container>
      <label for="num-visitors">Aantal locaties</label>
      <input type="text" id="num-locations" name="num-locations">
    </div>

    <div formfield-container>
      <input type="button" value="Bereken" onclick="showCosts()"/>
    </div>
</form>
<div class="result-container">
    <span class="label">Indicatie prijs A: </span>
    <span class="result" id="resultAMonth"></span>
    <span> per maand,</span>
    <span class="result" id="resultA"></span>
    <span> per jaar</span>
  </div>

  <div class="result-container">
    <span class="label">Indicatie prijs AB: </span>
    <span class="result" id="resultABMonth"></span>
    <span> per maand,</span>
    <span class="result" id="resultAB"></span>
    <span> per jaar</span>
  </div>

  <div class="result-container">
    <span class="label">Eenmalige aansluitkosten: </span>
    <span class="result" id="connectionFee"></span>
  </div>
  
<script>

    function showCosts() {
      var inputVisitors = document.getElementById('num-visitors').value,
          inputLocations = document.getElementById('num-locations').value
          ;
      if (inputVisitors == "") {
        inputVisitors = 0;
      }

      if (inputLocations == "") {
        inputLocations = 0;
      }


      var result = calculateCosts(parseInt(inputVisitors), parseInt(inputLocations));


        document.getElementById('resultA').textContent        = parseFloat(result.priceA).toFixed(2);
        document.getElementById('resultAMonth').textContent   = parseFloat(result.priceA / 12).toFixed(2);
        document.getElementById('resultAB').textContent       = parseFloat(result.priceAB).toFixed(2);
        document.getElementById('resultABMonth').textContent  = parseFloat(result.priceAB / 12).toFixed(2);
        document.getElementById('connectionFee').textContent  = parseFloat(result.connectionFee).toFixed(2);

    }

//     reductie 40% bij aantal > 40k, 20% bij aantal tussen 20-40k
    function calculateCosts(numVisitors, numLocations) {
      var rateA = .6,
          rateAB = .8,
          priceA = 0,
          priceAB = 0,
          priceAMonth  = 0,
          priceABMonth = 0,
          feeBasic = 6000,
          feeNext = 4000,
          connectionFee = 0,
          limitVisitors_1 = 20000,
          limitVisitors_2 = 40000
      ;

      if ( numVisitors > limitVisitors_2 ){

        priceA = parseInt(numVisitors - limitVisitors_2) * rateA * (1-0.4) + limitVisitors_1 * rateA * (1.8);
        priceAB = (numVisitors - limitVisitors_2) *rateAB * (1-0.4) + limitVisitors_1 * rateAB * (1.8) ;

      } else if (numVisitors > limitVisitors_1) {

        priceA = (numVisitors - limitVisitors_1) * rateA * (1-0.2) + limitVisitors_1 * rateA;
        priceAB = (numVisitors - limitVisitors_1) * rateAB*(1-0.2) + limitVisitors_1 * rateAB;

      } else {

        priceA = numVisitors * rateA;
        priceAB = numVisitors * rateAB;

      }

      if(numLocations > 1) {

        connectionFee = feeBasic + (numLocations - 1) * feeNext;

      } else {

        connectionFee = feeBasic;

      }

      return ({"priceA":priceA, "priceAB":priceAB, "connectionFee":connectionFee});
    }

  </script>
  
