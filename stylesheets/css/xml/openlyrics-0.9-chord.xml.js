/**
 * OpenLyrics XML+CSS stylesheet
 * OpenLyrics 0.9 chords
 *
 * For Prince only:
 * https://www.princexml.com/doc/gen-content/
 * https://www.princexml.com/doc/javascript/
 *
 * Running example:
 * prince --javascript --script=stylesheets/css/xml/openlyrics-0.9-chord.xml.js file.xml -o output.xml.pdf
 */

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
    if (sSortand !== null) {
      this[sSortand] = sName;
    }
  }
};

// 2 note chords
oStructure.add("5",                 "power",    "5" /*omit3*/ );
// 3 note chords
oStructure.add("3-5",               "",         "" );
oStructure.add("m3-5",              "min",      "m" /*-*/ /*min*/ );
oStructure.add("3-#5",              "aug",      "+" /*5♯*/ /*(♯5)*/ );
oStructure.add("m3-b5",             "dim",      "°" /*m,5♭*/ /*m(♭5)*/ );
// 4 note chords
oStructure.add("3-5-m7",            "dom7",     "7" );
oStructure.add("3-5-7",             "maj7",     "Δ" /*Maj7*/ /*M7*/ /*Δ7*/ );
oStructure.add("m3-5-m7",           "min7",     "m7" /*-7*/ /*min7*/ );
oStructure.add("m3-b5-b7",          "dim7",     "°7" /*dim7*/ );
oStructure.add("m3-b5-m7",          "halfdim7", "ø" /*m7,5♭*/ /*m7(♭5)*/ /*-7(♭5)*/ /*ø7*/ /*halfdim*/ );
oStructure.add("m3-5-7",            "minmaj7",  "mΔ" /*mMaj7*/ /*mM7*/ /*-M7*/ /*-Δ*/ /*-Δ7*/ );
oStructure.add("3-#5-7",            "augmaj7",  "+Δ" /*Maj7(♯5)*/ /*+Maj7*/ /*+M7*/ /*+Δ7*/ );
oStructure.add("3-b5-m7",           null,       "7,5♭" /*7(♭5)*/ );
oStructure.add("3-#5-m7",           "aug7",     "7" /*7,5♯*/ /*7(♯5)*/ );
oStructure.add("m3-b5-7",           null,       "mΔ,5♭" /*mΔ(5♭)*/ /*mMaj7(♭5)*/ /*mM7(♭5)*/ /*-Δ7(♭5)*/ );
oStructure.add("3-b5-7",            null,       "Δ,5♭" /*Δ7(♭5)*/ /*Maj7(♭5)*/ /*M7(♭5)*/ );
oStructure.add("3-5-6",             "maj6",     "6" /*M6*/ /*add6*/ );
oStructure.add("3-5-m6",            "maj6b",    "6♭" /*(♭6)*/ );
oStructure.add("m3-5-6",            "min6",     "m6" /*m,add6*/ );
oStructure.add("m3-5-m6",           "min6b",    "m6♭" /*m(♭6)*/ );
// 5 note chords
oStructure.add("3-5-m7-9",          "dom9",     "9" /*7,9*/ );
oStructure.add("3-5-m7-m9",         "dom9b",    "7,9♭" /*7(♭9)*/ );
oStructure.add("3-5-7-9",           "maj9",     "Δ9" /*Maj9*/ /*M9*/ );
oStructure.add("m3-5-m7-9",         "min9",     "m9" /*m7,9*/ /*-9*/ /*min9*/ );
oStructure.add("m3-5-7-9",          "minmaj9",  "mΔ9" /*mMaj9*/ /*mM9*/ /*-M9*/ /*-Δ9*/ );
oStructure.add("3-#5-7-9",          null,       "+Δ9" /*Maj9(♯5)*/ /*+Maj9*/ /*+M9*/ );
oStructure.add("3-#5-m7-9",         "aug9",     "9" /*7,9*/ /*9,5♯*/ /*9(♯5)*/ );
oStructure.add("m3-b5-m7-9",        "halfdim9", "ø9" /*m9,5♭*/ /*m9(♭5)*/ /*-9(♭5)*/ /*halfdim9*/ );
oStructure.add("m3-b5-m7-m9",       null,       "ø9♭" /*ø(♭9)*/ /*m7,9♭,5♭*/ /*m7(♭9,♭5)*/ /*-7(♭9,♭5)*/ /*halfdim(♭9)*/ );
oStructure.add("m3-b5-b7-9",        null,       "°9" /*dim9*/ );
oStructure.add("m3-b5-b7-m9",       null,       "°9♭" /*°(♭9)*/ /*dim7,9♭*/ /*°7,9♭*/ );
oStructure.add("3-5-m7-m10",        null,       "7,10♭" /*7(♭10)*/ );
// 6 note chords
oStructure.add("3-5-m7-9-11",       null,       "11" );
oStructure.add("3-5-7-9-11",        null,       "Δ11" /*Maj11*/ /*M11*/ );
oStructure.add("m3-5-m7-9-11",      null,       "m11" /*-11*/ /*min11*/ );
oStructure.add("m3-5-7-9-11",       null,       "mΔ11" /*mMaj11*/ /*mM11*/ /*-M11*/ /*-Δ11*/ );
oStructure.add("3-5-m7-9-#11",      null,       "11♯" );
oStructure.add("3-5-7-9-#11",       null,       "Δ11♯" /*Δ(♯11)*/ /*Maj(♯11)*/ /*M(♯11)*/ );
oStructure.add("m3-5-m7-9-#11",     null,       "m11♯" /*m(♯11)*/ /*-(♯11)*/ /*min(♯11)*/ );
oStructure.add("m3-5-7-9-#11",      null,       "mΔ11♯" /*mΔ(♯11)*/ /*mMaj(♯11)*/ /*mM(♯11)*/ /*-M(♯11)*/ /*-Δ(♯11)*/ );
oStructure.add("3-#5-7-9-11",       null,       "+Δ11" /*Maj11(♯5)*/ /*+Maj11*/ /*+M11*/ );
oStructure.add("3-#5-m7-9-11",      null,       "11" /*11,5♯*/ /*11(♯5)*/ );
oStructure.add("m3-b5-m7-m9-11",    null,       "ø11" /*m11,5♭*/ /*m11(♭5)*/ /*-11(♭5)*/ /*halfdim11*/ );
oStructure.add("m3-b5-b7-m9-b11",   null,       "°11" /*dim11*/ );
// 7 note chords
oStructure.add("3-5-m7-9-11-13",    null,       "13" );
oStructure.add("3-5-7-9-11-13",     null,       "Δ13" /*Maj13*/ /*M13*/ );
oStructure.add("m3-5-m7-9-11-13",   null,       "m13" /*-13*/ /*min13*/ );
oStructure.add("m3-5-7-9-11-13",    null,       "mΔ13" /*mMaj13*/ /*mM13*/ /*-M13*/ /*-Δ13*/ );
oStructure.add("3-5-m7-9-#11-13",   null,       "13(♯11)" );
oStructure.add("3-5-7-9-#11-13",    null,       "Δ13(♯11)" /*Maj13(♯11)*/ /*M13(♯11)*/ );
oStructure.add("m3-5-m7-9-#11-13",  null,       "m13(♯11)" /*-13(♯11)*/ /*min13(♯11)*/ );
oStructure.add("m3-5-7-9-#11-13",   null,       "mΔ13(♯11)" /*mMaj13(♯11)*/ /*mM13(♯11)*/ /*-M13(♯11)*/ /*-Δ13(♯11)*/ );
oStructure.add("3-#5-7-9-11-13",    null,       "+Δ13" /*Maj13(♯5)*/ /*+Maj13*/ /*+M13*/ );
oStructure.add("3-#5-m7-9-11-13",   null,       "13" /*13,5♯*/ /*13(♯5)*/ );
oStructure.add("m3-b5-m7-m9-11-13", null,       "ø13" /*m13,5♭*/ /*m13(♭5)*/ /*-13(♭5)*/ /*halfdim13*/ );
// Figured 3 note chords
oStructure.add("4-5",               "sus4",     "4" /*sus4*/ /*sus*/ );
oStructure.add("2-5",               "sus2",     "2" /*sus2*/ );
// Figured 4 note chords
oStructure.add("3-5-m7-13",         null,       "7,6" /*7(add13)*/ /*7(add6)*/ );
oStructure.add("3-5-6-9",           null,       "6,9" /*6(add9)*/ );
oStructure.add("3-5-9",             "add9",     "add9" );
oStructure.add("4-5-m7",            null,       "7,4" /*7sus4*/ );
oStructure.add("2-5-m7",            null,       "7,2" /*7sus2*/ );
oStructure.add("4-5-7",             null,       "Δ,4" /*Maj7,4*/ /*M7,4*/ /*Δ7,4*/ /*Δsus4*/ /*M7sus4*/ );
oStructure.add("2-5-7",             null,       "Δ,2" /*Maj7,2*/ /*M7,2*/ /*Δ7,2*/ /*Δsus2*/ /*M7sus2*/ );
// Figured 5 note chords
oStructure.add("4-5-m7-9",          null,       "9,4" /*9sus4*/ );
oStructure.add("4-5-m7-m9",         null,       "7,9♭,4" /*7(♭9)*/ /*7,9♭,sus4*/ /*7(♭9)sus4*/ );
oStructure.add("4-5-7-9",           null,       "Δ9,4" /*Δ9sus4*/ /*Maj9,4*/ /*M9,4*/ /*Maj9sus4*/ /*M9sus4*/ );
oStructure.add("4-#5-7-9",          null,       "+Δ9,4" /*+Δ9sus4*/ /*Maj9(♯5)4*/ /*+M9,4*/ /*+M9sus4*/ /*+Maj9,4*/ );
oStructure.add("4-#5-m7-9",         null,       "9,4" /*+9sus4*/ /*9(♯5)sus4*/ );

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
  console.log( "root:'" + sRoot + "', structure:'" + sStructure + "', bass:'" + sBass + "', -> " + sReturn);
  return sReturn;
});

