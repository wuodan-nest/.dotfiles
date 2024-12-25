// #################################################################################################################

// .           ..         .           .       .           .           .
//        .         .            .          .       .
//              .         ..xxxxxxxxxx....               .       .             .
//      .             MWMWMWWMWMWMWMWMWMWMWMWMW                       .
//                IIIIMWMWMWMWMWMWMWMWMWMWMWMWMWMttii:        .           .
//   .      IIYVVXMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWxx...         .           .
//       IWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMx..
//     IIWMWMWMWMWMWMWMWMWBY%ZACH%AND%OWENMWMWMWMWMWMWMWMWMWMWMWMWMx..        .
//      ""MWMWMWMWMWM"""""""".  .:..   ."""""MWMWMWMWMWMWMWMWMWMWMWMWMWti.
//   .     ""   . `  .: . :. : .  . :.  .  . . .  """"MWMWMWMWMWMWMWMWMWMWMWMWMti=
//          . .   :` . :   .  .'.' '....xxxxx...,'. '   ' ."""YWMWMWMWMWMWMWMWMWMW+
//       ; . ` .  . : . .' :  . ..XXXXXXXXXXXXXXXXXXXXx.    `     . "YWMWMWMWMWMWMW
//  .    .  .  .    . .   .  ..XXXXXXXXWWWWWWWWWWWWWWWWXXXX.  .     .     """""""
//          ' :  : . : .  ...XXXXXWWW"   W88N88@888888WWWWWXX.   .   .       . .
//     . ' .    . :   ...XXXXXXWWW"    M88N88GGGGGG888^8M "WMBX.          .   ..  :
//           :     ..XXXXXXXXWWW"     M88888WWRWWWMW8oo88M   WWMX.     .    :    .
//             "XXXXXXXXXXXXWW"       WN8888WWWWW  W8@@@8M    BMBRX.         .  : :
//    .       XXXXXXXX=MMWW":  .      W8N888WWWWWWWW88888W      XRBRXX.  .       .
//       ....  ""XXXXXMM::::. .        W8@889WWWWWM8@8N8W      . . :RRXx.    .
//           ``...'''  MMM::.:.  .      W888N89999888@8W      . . ::::"RXV    .  :
//   .       ..'''''      MMMm::.  .      WW888N88888WW     .  . mmMMMMMRXx
//        ..' .            ""MMmm .  .       WWWWWWW   . :. :,miMM"""  : ""`    .
//     .                .       ""MMMMmm . .  .  .   ._,mMMMM"""  :  ' .  :
//                 .                  ""MMMMMMMMMMMMM""" .  : . '   .        .
//            .              .     .    .                      .         .
//  .

//  Author	:	wuodan aka sudhanshu selvan
//  Version	:	v1.0.1
//  Date	:	25-12-24
//  Description	:	eslint file for global and local use. made in js for extra flexibility
//  Usage	:	use it in the root folder or individual local folders for added flexibility.

// #################################################################################################################
// 
//    DO NOT RUN THIS WITHOUT KNOWING WHAT IT EXECUTES. RUN AT YOUR OWN RISK.
// 
// #################################################################################################################

module.exports = {
  "parser": "babel-eslint",
  "plugins": [ "react" ],
  "env": {
    "browser": true,
    "es6": true,
    "node": true
  },
  "ecmaFeatures": {
    "arrowFunctions": true,
    "blockBindings": true,
    "classes": true,
    "defaultParams": true,
    "destructuring": true,
    "forOf": true,
    "generators": true,
    "modules": true,
    "spread": true,
    "templateStrings": true,
    "jsx": true
  },
  "rules": {
    "consistent-return": "off",
    "key-spacing": "off",
    "quotes": "off",
    "new-cap": "off",
    "no-multi-spaces": "off",
    "no-shadow": "off",
    "no-unused-vars": "warn",
    "no-use-before-define": ["error", "nofunc"],
    "react/jsx-no-undef": "warn",
    "react/jsx-uses-react": "warn",
    "react/jsx-uses-vars": "warn"
  }
};

