% LICENSE: Do whatever you want with this code

-module(hex).
-author('Max Lapshin <max@maxidoors.ru>').

-export([hex/1, unhex/1, from_hex/1]).


unhex(Bin) ->
  unhex(Bin, <<>>).

unhex(<<>>, Acc) ->
  Acc;

unhex(<<C1,C2, Rest/binary>>, Acc) ->
  I1 = from_hex(C1),
  I2 = from_hex(C2),
  unhex(Rest, <<Acc/binary, (I1*16 + I2)>>).


from_hex(C) when C >= $0 andalso C =< $9 -> C - $0;
from_hex(C) when C >= $a andalso C =< $f -> C - $a + 16#a;
from_hex(C) when C >= $A andalso C =< $F -> C - $A + 16#A.


hex(SHA1) -> hex(SHA1, <<>>).





hex(<<0,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "00">>);
hex(<<1,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "01">>);
hex(<<2,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "02">>);
hex(<<3,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "03">>);
hex(<<4,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "04">>);
hex(<<5,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "05">>);
hex(<<6,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "06">>);
hex(<<7,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "07">>);
hex(<<8,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "08">>);
hex(<<9,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "09">>);
hex(<<10,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "0a">>);
hex(<<11,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "0b">>);
hex(<<12,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "0c">>);
hex(<<13,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "0d">>);
hex(<<14,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "0e">>);
hex(<<15,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "0f">>);
hex(<<16,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "10">>);
hex(<<17,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "11">>);
hex(<<18,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "12">>);
hex(<<19,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "13">>);
hex(<<20,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "14">>);
hex(<<21,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "15">>);
hex(<<22,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "16">>);
hex(<<23,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "17">>);
hex(<<24,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "18">>);
hex(<<25,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "19">>);
hex(<<26,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "1a">>);
hex(<<27,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "1b">>);
hex(<<28,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "1c">>);
hex(<<29,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "1d">>);
hex(<<30,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "1e">>);
hex(<<31,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "1f">>);
hex(<<32,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "20">>);
hex(<<33,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "21">>);
hex(<<34,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "22">>);
hex(<<35,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "23">>);
hex(<<36,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "24">>);
hex(<<37,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "25">>);
hex(<<38,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "26">>);
hex(<<39,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "27">>);
hex(<<40,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "28">>);
hex(<<41,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "29">>);
hex(<<42,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "2a">>);
hex(<<43,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "2b">>);
hex(<<44,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "2c">>);
hex(<<45,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "2d">>);
hex(<<46,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "2e">>);
hex(<<47,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "2f">>);
hex(<<48,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "30">>);
hex(<<49,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "31">>);
hex(<<50,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "32">>);
hex(<<51,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "33">>);
hex(<<52,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "34">>);
hex(<<53,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "35">>);
hex(<<54,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "36">>);
hex(<<55,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "37">>);
hex(<<56,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "38">>);
hex(<<57,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "39">>);
hex(<<58,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "3a">>);
hex(<<59,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "3b">>);
hex(<<60,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "3c">>);
hex(<<61,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "3d">>);
hex(<<62,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "3e">>);
hex(<<63,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "3f">>);
hex(<<64,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "40">>);
hex(<<65,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "41">>);
hex(<<66,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "42">>);
hex(<<67,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "43">>);
hex(<<68,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "44">>);
hex(<<69,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "45">>);
hex(<<70,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "46">>);
hex(<<71,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "47">>);
hex(<<72,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "48">>);
hex(<<73,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "49">>);
hex(<<74,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "4a">>);
hex(<<75,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "4b">>);
hex(<<76,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "4c">>);
hex(<<77,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "4d">>);
hex(<<78,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "4e">>);
hex(<<79,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "4f">>);
hex(<<80,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "50">>);
hex(<<81,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "51">>);
hex(<<82,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "52">>);
hex(<<83,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "53">>);
hex(<<84,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "54">>);
hex(<<85,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "55">>);
hex(<<86,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "56">>);
hex(<<87,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "57">>);
hex(<<88,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "58">>);
hex(<<89,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "59">>);
hex(<<90,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "5a">>);
hex(<<91,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "5b">>);
hex(<<92,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "5c">>);
hex(<<93,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "5d">>);
hex(<<94,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "5e">>);
hex(<<95,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "5f">>);
hex(<<96,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "60">>);
hex(<<97,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "61">>);
hex(<<98,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "62">>);
hex(<<99,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "63">>);
hex(<<100,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "64">>);
hex(<<101,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "65">>);
hex(<<102,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "66">>);
hex(<<103,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "67">>);
hex(<<104,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "68">>);
hex(<<105,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "69">>);
hex(<<106,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "6a">>);
hex(<<107,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "6b">>);
hex(<<108,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "6c">>);
hex(<<109,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "6d">>);
hex(<<110,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "6e">>);
hex(<<111,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "6f">>);
hex(<<112,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "70">>);
hex(<<113,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "71">>);
hex(<<114,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "72">>);
hex(<<115,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "73">>);
hex(<<116,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "74">>);
hex(<<117,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "75">>);
hex(<<118,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "76">>);
hex(<<119,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "77">>);
hex(<<120,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "78">>);
hex(<<121,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "79">>);
hex(<<122,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "7a">>);
hex(<<123,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "7b">>);
hex(<<124,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "7c">>);
hex(<<125,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "7d">>);
hex(<<126,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "7e">>);
hex(<<127,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "7f">>);
hex(<<128,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "80">>);
hex(<<129,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "81">>);
hex(<<130,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "82">>);
hex(<<131,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "83">>);
hex(<<132,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "84">>);
hex(<<133,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "85">>);
hex(<<134,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "86">>);
hex(<<135,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "87">>);
hex(<<136,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "88">>);
hex(<<137,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "89">>);
hex(<<138,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "8a">>);
hex(<<139,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "8b">>);
hex(<<140,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "8c">>);
hex(<<141,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "8d">>);
hex(<<142,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "8e">>);
hex(<<143,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "8f">>);
hex(<<144,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "90">>);
hex(<<145,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "91">>);
hex(<<146,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "92">>);
hex(<<147,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "93">>);
hex(<<148,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "94">>);
hex(<<149,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "95">>);
hex(<<150,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "96">>);
hex(<<151,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "97">>);
hex(<<152,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "98">>);
hex(<<153,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "99">>);
hex(<<154,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "9a">>);
hex(<<155,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "9b">>);
hex(<<156,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "9c">>);
hex(<<157,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "9d">>);
hex(<<158,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "9e">>);
hex(<<159,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "9f">>);
hex(<<160,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "a0">>);
hex(<<161,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "a1">>);
hex(<<162,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "a2">>);
hex(<<163,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "a3">>);
hex(<<164,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "a4">>);
hex(<<165,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "a5">>);
hex(<<166,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "a6">>);
hex(<<167,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "a7">>);
hex(<<168,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "a8">>);
hex(<<169,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "a9">>);
hex(<<170,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "aa">>);
hex(<<171,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "ab">>);
hex(<<172,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "ac">>);
hex(<<173,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "ad">>);
hex(<<174,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "ae">>);
hex(<<175,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "af">>);
hex(<<176,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "b0">>);
hex(<<177,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "b1">>);
hex(<<178,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "b2">>);
hex(<<179,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "b3">>);
hex(<<180,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "b4">>);
hex(<<181,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "b5">>);
hex(<<182,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "b6">>);
hex(<<183,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "b7">>);
hex(<<184,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "b8">>);
hex(<<185,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "b9">>);
hex(<<186,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "ba">>);
hex(<<187,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "bb">>);
hex(<<188,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "bc">>);
hex(<<189,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "bd">>);
hex(<<190,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "be">>);
hex(<<191,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "bf">>);
hex(<<192,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "c0">>);
hex(<<193,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "c1">>);
hex(<<194,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "c2">>);
hex(<<195,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "c3">>);
hex(<<196,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "c4">>);
hex(<<197,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "c5">>);
hex(<<198,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "c6">>);
hex(<<199,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "c7">>);
hex(<<200,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "c8">>);
hex(<<201,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "c9">>);
hex(<<202,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "ca">>);
hex(<<203,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "cb">>);
hex(<<204,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "cc">>);
hex(<<205,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "cd">>);
hex(<<206,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "ce">>);
hex(<<207,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "cf">>);
hex(<<208,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "d0">>);
hex(<<209,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "d1">>);
hex(<<210,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "d2">>);
hex(<<211,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "d3">>);
hex(<<212,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "d4">>);
hex(<<213,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "d5">>);
hex(<<214,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "d6">>);
hex(<<215,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "d7">>);
hex(<<216,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "d8">>);
hex(<<217,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "d9">>);
hex(<<218,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "da">>);
hex(<<219,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "db">>);
hex(<<220,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "dc">>);
hex(<<221,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "dd">>);
hex(<<222,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "de">>);
hex(<<223,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "df">>);
hex(<<224,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "e0">>);
hex(<<225,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "e1">>);
hex(<<226,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "e2">>);
hex(<<227,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "e3">>);
hex(<<228,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "e4">>);
hex(<<229,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "e5">>);
hex(<<230,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "e6">>);
hex(<<231,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "e7">>);
hex(<<232,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "e8">>);
hex(<<233,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "e9">>);
hex(<<234,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "ea">>);
hex(<<235,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "eb">>);
hex(<<236,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "ec">>);
hex(<<237,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "ed">>);
hex(<<238,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "ee">>);
hex(<<239,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "ef">>);
hex(<<240,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "f0">>);
hex(<<241,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "f1">>);
hex(<<242,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "f2">>);
hex(<<243,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "f3">>);
hex(<<244,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "f4">>);
hex(<<245,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "f5">>);
hex(<<246,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "f6">>);
hex(<<247,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "f7">>);
hex(<<248,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "f8">>);
hex(<<249,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "f9">>);
hex(<<250,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "fa">>);
hex(<<251,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "fb">>);
hex(<<252,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "fc">>);
hex(<<253,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "fd">>);
hex(<<254,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "fe">>);
hex(<<255,Bin/binary>>, Acc) -> hex(Bin, <<Acc/binary, "ff">>);
hex(<<>>, Acc) -> Acc.
