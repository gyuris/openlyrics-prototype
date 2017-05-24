/**
 * OpenLyrics XML+CSS stylesheet
 * OpenLyrics 0.9 chords
 *
 * For Prince only:
 * https://www.princexml.com/doc/gen-content/
 * https://www.princexml.com/doc/javascript/
 *
 * Running example:
 * prince --javascript --script=stylesheets/css/xml/openlyrics-0.9-chord.xml.js Alleluja\,\ dicsőség\ a\ mennyben\ Istenenünknek.xml -o Alleluja\,\ dicsőség\ a\ mennyben\ Istenenünknek.xml.pdf
 */

"use strict";

var oNotation = {
//         eng.  german dutch  hun.    neolat.
  "C"  : [ "C",  "C",   "C",   "C",    "Do"   ],
  "C#" : [ "C♯", "Cis", "Cis", "Cisz", "Do♯"  ],
  "Db" : [ "D♭", "Des", "Des", "Desz", "Re♭"  ],
  "D"  : [ "D",  "D",   "D",   "D",    "Re"   ],
  "D#" : [ "D♯", "Dis", "Dis", "Disz", "Re♯"  ],
  "Eb" : [ "E♭", "Es",  "Es",  "Esz",  "Mi♭"  ],
  "E"  : [ "E",  "E",   "E",   "E",    "Mi"   ],
  "F"  : [ "F",  "F",   "F",   "F",    "Fa"   ],
  "F#" : [ "F♯", "Fis", "Fis", "Fisz", "Fa♯"  ],
  "Gb" : [ "G♭", "Ges", "Ges", "Gesz", "Sol♭" ],
  "G"  : [ "G",  "G",   "G",   "G",    "Sol"  ],
  "G#" : [ "G♯", "Gis", "Gis", "Gisz", "Sl♯"  ],
  "Ab" : [ "A♭", "As",  "As",  "Asz",  "La♭"  ],
  "A"  : [ "A",  "A",   "A",   "A",    "La"   ],
  "A#" : [ "A♯", "Ais", "Ais", "Aisz", "La♯"  ],
  "Bb" : [ "B♭", "B",   "Bes", "B",    "Si♭"  ],
  "B"  : [ "B",  "H",   "B",   "H",    "Si"   ]
};

var oStructure = {
  add : function( sId, sSortand, sName ) {
    this[sId] = sName;
    this[sSortand] = sName;
  }
};
// 2 note chords
oStructure.add( "5",        "power", "5" /*"omit3"*/ );
// 3 note chords
oStructure.add( "3-5",      "",      "" /*"omit3"*/ );
oStructure.add( "m3-5",     "min",   "m" /*"−"*/ /*"min"*/ );
oStructure.add( "3-#5",     "aug",   "+" /*"5♯"*/ /*"(♯5)"*/ );
oStructure.add( "m3-b5",    "dim",   ""  /*"m,5b"*/ /*"m(b5)"*/ );
// 4 note chords
oStructure.add( "3-5-m7",   "dom7",  "7" );
oStructure.add( "3-5-7",    "maj7",  "Δ" /*"Maj7"*/ /*"M7"*/ /*"Δ7"*/ );
oStructure.add( "m3-5-m7",  "min7",  "m7" /*"−7"*/ /*"min7"*/ );
oStructure.add( "m3-b5-b7", "dim7",  "°" /*"dim7"*/ /*"°7"*/ );
oStructure.add( "4-5",      "sus4",  "4" /*"sus4"*/ /*"sus"*/ );

var NOTATION = 0; // 0 = english
                  // 1 = german
                  // 2 = dutch
                  // 3 = hungarian
                  // 4 = neolatin

Prince.addScriptFunc("getChord", function(sRoot, sStructure, sBass) {
  var sReturn = "";
  if (sRoot) {
    sReturn += (oNotation[sRoot] === "undefined") ? sRoot : oNotation[sRoot][NOTATION];
  }
  sReturn += (oStructure[sStructure] === "undefined") ? sStructure : oStructure[sStructure];
  if (sBass) {
    sReturn += (oNotation[sBass] === "undefined") ? "/" + sBass : "/" + oNotation[sBass][NOTATION];
  }
  console.log( "root:'" + sRoot + "', structure:'" + sStructure + "', bass:'" + sStructure + "', -> " + sReturn);
  return sReturn;
});

