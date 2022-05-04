# RUNNING TEXT ON 7-SEG DISPLAYS

### Team members

* Karel Beránek
* Filip Kounický
* Honza Bukovský
* Marian Dvořáček

### Table of contents

* [Project objectives](#objectives)
* [Hardware description](#hardware)
* [VHDL modules description and simulations](#modules)
* [TOP module description and simulations](#top)
* [Video](#video)
* [References](#references)

<a name="objectives"></a>

## Project objectives

Měli jsme úkol rozběhat text na 7-segmentovém displeji. Naše práce došla k závěru dvou řešení, 
* první řešení: (vztahují se všechny testbenche apod.) Ovládání je řešeno pomocí switche 0 - 5 (6-bit) a jedno tlačítko reset. Pokud podržíme tlačítko reset, tak se nám stopne běh programu a můžeme pozorovat na segmentu 0 volené ASCII znaky pomocí šesti přepínačů (abecedu a čísla), poté co pustíme tlačítko reset tak vidíme jak se nám navolený znak pohybuje do leva. Vždy můžeme editovat pouze segment 0.
* druhé řešení: (pokročilejší než první) Ovládání je řešeno pomocí: switche 0 - 5 (6-bit), 9 (reset), 13 (programovaní pomocí přepínačů), 14 (programovaní pomocí tlačítek nahoru & dolů za předpokladu že je přepínač zapnut), 15 (STOP & GO) a pomocí všech pěti tlačítek. Po zapnutí desky se nám spustí program s defaultním textem (který lze později editovat). Text se edituje stejným způsubem jako u prvního řešení nebo pomocí switche 14. Když se stane, že budeme mí sepnuty přepínače 13 & 14 tak má vyšší prioritu přepínač 13. Rychlost měníme pomocí tlačítek nahoru a dolů. Vždy můžeme editovat pouze segment 0.

<a name="hardware"></a>

## Hardware description

U obou verzí používáme pouze desku: XYLINX NEXYS A7 (ARTIX-7 50T)

<a name="modules"></a>

## VHDL modules description and simulations

Write your text here.

<a name="top"></a>

## TOP module description and simulations


```vhdl

```

<a name="video"></a>

## Video

Write your text here

<a name="references"></a>

## References

https://github.com/tomas-fryza/digital-electronics-1

https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.avrfreaks.net%2Fforum%2Fatmel-studio-7-7-segment-display-code-help&psig=AOvVaw13xJjc6fvRvp7L_0X9eaH4&ust=1651752406772000&source=images&cd=vfe&ved=0CAkQjRxqFwoTCKj3ka3nxfcCFQAAAAAdAAAAABAE
