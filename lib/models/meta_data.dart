import 'package:flutter/material.dart';

final ilVeIlceler = """{
  "Il": [
    {
      "Id": "1",
      "Il": "Adana"
    },
    {
      "Id": "2",
      "Il": "Adıyaman"
    },
    {
      "Id": "3",
      "Il": "Afyonkarahisar"
    },
    {
      "Id": "4",
      "Il": "Ağrı"
    },
    {
      "Id": "5",
      "Il": "Amasya"
    },
    {
      "Id": "6",
      "Il": "Ankara"
    },
    {
      "Id": "7",
      "Il": "Antalya"
    },
    {
      "Id": "8",
      "Il": "Artvin"
    },
    {
      "Id": "9",
      "Il": "Aydın"
    },
    {
      "Id": "10",
      "Il": "Balıkesir"
    },
    {
      "Id": "11",
      "Il": "Bilecik"
    },
    {
      "Id": "12",
      "Il": "Bingöl"
    },
    {
      "Id": "13",
      "Il": "Bitlis"
    },
    {
      "Id": "14",
      "Il": "Bolu"
    },
    {
      "Id": "15",
      "Il": "Burdur"
    },
    {
      "Id": "16",
      "Il": "Bursa"
    },
    {
      "Id": "17",
      "Il": "Çanakkale"
    },
    {
      "Id": "18",
      "Il": "Çankırı"
    },
    {
      "Id": "19",
      "Il": "Çorum"
    },
    {
      "Id": "20",
      "Il": "Denizli"
    },
    {
      "Id": "21",
      "Il": "Diyarbakır"
    },
    {
      "Id": "22",
      "Il": "Edirne"
    },
    {
      "Id": "23",
      "Il": "Elazığ"
    },
    {
      "Id": "24",
      "Il": "Erzincan"
    },
    {
      "Id": "25",
      "Il": "Erzurum"
    },
    {
      "Id": "26",
      "Il": "Eskişehir"
    },
    {
      "Id": "27",
      "Il": "Gaziantep"
    },
    {
      "Id": "28",
      "Il": "Giresun"
    },
    {
      "Id": "29",
      "Il": "Gümüşhane"
    },
    {
      "Id": "30",
      "Il": "Hakkari"
    },
    {
      "Id": "31",
      "Il": "Hatay"
    },
    {
      "Id": "32",
      "Il": "Isparta"
    },
    {
      "Id": "33",
      "Il": "Mersin"
    },
    {
      "Id": "34",
      "Il": "İstanbul"
    },
    {
      "Id": "35",
      "Il": "İzmir"
    },
    {
      "Id": "36",
      "Il": "Kars"
    },
    {
      "Id": "37",
      "Il": "Kastamonu"
    },
    {
      "Id": "38",
      "Il": "Kayseri"
    },
    {
      "Id": "39",
      "Il": "Kırklareli"
    },
    {
      "Id": "40",
      "Il": "Kırşehir"
    },
    {
      "Id": "41",
      "Il": "Kocaeli"
    },
    {
      "Id": "42",
      "Il": "Konya"
    },
    {
      "Id": "43",
      "Il": "Kütahya"
    },
    {
      "Id": "44",
      "Il": "Malatya"
    },
    {
      "Id": "45",
      "Il": "Manisa"
    },
    {
      "Id": "46",
      "Il": "Kahramanmaraş"
    },
    {
      "Id": "47",
      "Il": "Mardin"
    },
    {
      "Id": "48",
      "Il": "Muğla"
    },
    {
      "Id": "49",
      "Il": "Muş"
    },
    {
      "Id": "50",
      "Il": "Nevşehir"
    },
    {
      "Id": "51",
      "Il": "Niğde"
    },
    {
      "Id": "52",
      "Il": "Ordu"
    },
    {
      "Id": "53",
      "Il": "Rize"
    },
    {
      "Id": "54",
      "Il": "Sakarya"
    },
    {
      "Id": "55",
      "Il": "Samsun"
    },
    {
      "Id": "56",
      "Il": "Siirt"
    },
    {
      "Id": "57",
      "Il": "Sinop"
    },
    {
      "Id": "58",
      "Il": "Sivas"
    },
    {
      "Id": "59",
      "Il": "Tekirdağ"
    },
    {
      "Id": "60",
      "Il": "Tokat"
    },
    {
      "Id": "61",
      "Il": "Trabzon"
    },
    {
      "Id": "62",
      "Il": "Tunceli"
    },
    {
      "Id": "63",
      "Il": "Şanlıurfa"
    },
    {
      "Id": "64",
      "Il": "Uşak"
    },
    {
      "Id": "65",
      "Il": "Van"
    },
    {
      "Id": "66",
      "Il": "Yozgat"
    },
    {
      "Id": "67",
      "Il": "Zonguldak"
    },
    {
      "Id": "68",
      "Il": "Aksaray"
    },
    {
      "Id": "69",
      "Il": "Bayburt"
    },
    {
      "Id": "70",
      "Il": "Karaman"
    },
    {
      "Id": "71",
      "Il": "Kırıkkale"
    },
    {
      "Id": "72",
      "Il": "Batman"
    },
    {
      "Id": "73",
      "Il": "Şırnak"
    },
    {
      "Id": "74",
      "Il": "Bartın"
    },
    {
      "Id": "75",
      "Il": "Ardahan"
    },
    {
      "Id": "76",
      "Il": "Iğdır"
    },
    {
      "Id": "77",
      "Il": "Yalova"
    },
    {
      "Id": "78",
      "Il": "Karabük"
    },
    {
      "Id": "79",
      "Il": "Kilis"
    },
    {
      "Id": "80",
      "Il": "Osmaniye"
    },
    {
      "Id": "81",
      "Il": "Düzce"
    }
  ],
  "Ilce": [
    {
      "Id": "1",
      "Ilce": "Seyhan",
      "Il_Id": "1"
    },
    {
      "Id": "2",
      "Ilce": "Ceyhan",
      "Il_Id": "1"
    },
    {
      "Id": "3",
      "Ilce": "Feke",
      "Il_Id": "1"
    },
    {
      "Id": "4",
      "Ilce": "Karaisalı",
      "Il_Id": "1"
    },
    {
      "Id": "5",
      "Ilce": "Karataş",
      "Il_Id": "1"
    },
    {
      "Id": "6",
      "Ilce": "Kozan",
      "Il_Id": "1"
    },
    {
      "Id": "7",
      "Ilce": "Pozantı",
      "Il_Id": "1"
    },
    {
      "Id": "8",
      "Ilce": "Saimbeyli",
      "Il_Id": "1"
    },
    {
      "Id": "9",
      "Ilce": "Tufanbeyli",
      "Il_Id": "1"
    },
    {
      "Id": "10",
      "Ilce": "Yumurtalık",
      "Il_Id": "1"
    },
    {
      "Id": "11",
      "Ilce": "Yüreğir",
      "Il_Id": "1"
    },
    {
      "Id": "12",
      "Ilce": "Aladağ",
      "Il_Id": "1"
    },
    {
      "Id": "13",
      "Ilce": "İmamoğlu",
      "Il_Id": "1"
    },
    {
      "Id": "14",
      "Ilce": "Sarıçam",
      "Il_Id": "1"
    },
    {
      "Id": "15",
      "Ilce": "Çukurova",
      "Il_Id": "1"
    },
    {
      "Id": "16",
      "Ilce": "Adıyaman Merkez",
      "Il_Id": "2"
    },
    {
      "Id": "17",
      "Ilce": "Besni",
      "Il_Id": "2"
    },
    {
      "Id": "18",
      "Ilce": "Çelikhan",
      "Il_Id": "2"
    },
    {
      "Id": "19",
      "Ilce": "Gerger",
      "Il_Id": "2"
    },
    {
      "Id": "20",
      "Ilce": "Gölbaşı / Adıyaman",
      "Il_Id": "2"
    },
    {
      "Id": "21",
      "Ilce": "Kahta",
      "Il_Id": "2"
    },
    {
      "Id": "22",
      "Ilce": "Samsat",
      "Il_Id": "2"
    },
    {
      "Id": "23",
      "Ilce": "Sincik",
      "Il_Id": "2"
    },
    {
      "Id": "24",
      "Ilce": "Tut",
      "Il_Id": "2"
    },
    {
      "Id": "25",
      "Ilce": "Afyonkarahisar Merkez",
      "Il_Id": "3"
    },
    {
      "Id": "26",
      "Ilce": "Bolvadin",
      "Il_Id": "3"
    },
    {
      "Id": "27",
      "Ilce": "Çay",
      "Il_Id": "3"
    },
    {
      "Id": "28",
      "Ilce": "Dazkırı",
      "Il_Id": "3"
    },
    {
      "Id": "29",
      "Ilce": "Dinar",
      "Il_Id": "3"
    },
    {
      "Id": "30",
      "Ilce": "Emirdağ",
      "Il_Id": "3"
    },
    {
      "Id": "31",
      "Ilce": "İhsaniye",
      "Il_Id": "3"
    },
    {
      "Id": "32",
      "Ilce": "Sandıklı",
      "Il_Id": "3"
    },
    {
      "Id": "33",
      "Ilce": "Sinanpaşa",
      "Il_Id": "3"
    },
    {
      "Id": "34",
      "Ilce": "Sultandağı",
      "Il_Id": "3"
    },
    {
      "Id": "35",
      "Ilce": "Şuhut",
      "Il_Id": "3"
    },
    {
      "Id": "36",
      "Ilce": "Başmakçı",
      "Il_Id": "3"
    },
    {
      "Id": "37",
      "Ilce": "Bayat / Afyonkarahisar",
      "Il_Id": "3"
    },
    {
      "Id": "38",
      "Ilce": "İscehisar",
      "Il_Id": "3"
    },
    {
      "Id": "39",
      "Ilce": "Çobanlar",
      "Il_Id": "3"
    },
    {
      "Id": "40",
      "Ilce": "Evciler",
      "Il_Id": "3"
    },
    {
      "Id": "41",
      "Ilce": "Hocalar",
      "Il_Id": "3"
    },
    {
      "Id": "42",
      "Ilce": "Kızılören",
      "Il_Id": "3"
    },
    {
      "Id": "43",
      "Ilce": "Ağrı Merkez",
      "Il_Id": "4"
    },
    {
      "Id": "44",
      "Ilce": "Diyadin",
      "Il_Id": "4"
    },
    {
      "Id": "45",
      "Ilce": "Doğubayazıt",
      "Il_Id": "4"
    },
    {
      "Id": "46",
      "Ilce": "Eleşkirt",
      "Il_Id": "4"
    },
    {
      "Id": "47",
      "Ilce": "Hamur",
      "Il_Id": "4"
    },
    {
      "Id": "48",
      "Ilce": "Patnos",
      "Il_Id": "4"
    },
    {
      "Id": "49",
      "Ilce": "Taşlıçay",
      "Il_Id": "4"
    },
    {
      "Id": "50",
      "Ilce": "Tutak",
      "Il_Id": "4"
    },
    {
      "Id": "51",
      "Ilce": "Amasya Merkez",
      "Il_Id": "5"
    },
    {
      "Id": "52",
      "Ilce": "Göynücek",
      "Il_Id": "5"
    },
    {
      "Id": "53",
      "Ilce": "Gümüşhacıköy",
      "Il_Id": "5"
    },
    {
      "Id": "54",
      "Ilce": "Merzifon",
      "Il_Id": "5"
    },
    {
      "Id": "55",
      "Ilce": "Suluova",
      "Il_Id": "5"
    },
    {
      "Id": "56",
      "Ilce": "Taşova",
      "Il_Id": "5"
    },
    {
      "Id": "57",
      "Ilce": "Hamamözü",
      "Il_Id": "5"
    },
    {
      "Id": "58",
      "Ilce": "Altındağ",
      "Il_Id": "6"
    },
    {
      "Id": "59",
      "Ilce": "Ayaş",
      "Il_Id": "6"
    },
    {
      "Id": "60",
      "Ilce": "Bala",
      "Il_Id": "6"
    },
    {
      "Id": "61",
      "Ilce": "Beypazarı",
      "Il_Id": "6"
    },
    {
      "Id": "62",
      "Ilce": "Çamlıdere",
      "Il_Id": "6"
    },
    {
      "Id": "63",
      "Ilce": "Çankaya",
      "Il_Id": "6"
    },
    {
      "Id": "64",
      "Ilce": "Çubuk",
      "Il_Id": "6"
    },
    {
      "Id": "65",
      "Ilce": "Elmadağ",
      "Il_Id": "6"
    },
    {
      "Id": "66",
      "Ilce": "Güdül",
      "Il_Id": "6"
    },
    {
      "Id": "67",
      "Ilce": "Haymana",
      "Il_Id": "6"
    },
    {
      "Id": "68",
      "Ilce": "Kalecik",
      "Il_Id": "6"
    },
    {
      "Id": "69",
      "Ilce": "Kızılcahamam",
      "Il_Id": "6"
    },
    {
      "Id": "70",
      "Ilce": "Nallıhan",
      "Il_Id": "6"
    },
    {
      "Id": "71",
      "Ilce": "Polatlı",
      "Il_Id": "6"
    },
    {
      "Id": "72",
      "Ilce": "Şereflikoçhisar",
      "Il_Id": "6"
    },
    {
      "Id": "73",
      "Ilce": "Yenimahalle",
      "Il_Id": "6"
    },
    {
      "Id": "74",
      "Ilce": "Gölbaşı / Ankara",
      "Il_Id": "6"
    },
    {
      "Id": "75",
      "Ilce": "Keçiören",
      "Il_Id": "6"
    },
    {
      "Id": "76",
      "Ilce": "Mamak",
      "Il_Id": "6"
    },
    {
      "Id": "77",
      "Ilce": "Sincan",
      "Il_Id": "6"
    },
    {
      "Id": "78",
      "Ilce": "Kazan",
      "Il_Id": "6"
    },
    {
      "Id": "79",
      "Ilce": "Akyurt",
      "Il_Id": "6"
    },
    {
      "Id": "80",
      "Ilce": "Etimesgut",
      "Il_Id": "6"
    },
    {
      "Id": "81",
      "Ilce": "Evren",
      "Il_Id": "6"
    },
    {
      "Id": "82",
      "Ilce": "Pursaklar",
      "Il_Id": "6"
    },
    {
      "Id": "83",
      "Ilce": "Akseki",
      "Il_Id": "7"
    },
    {
      "Id": "84",
      "Ilce": "Alanya",
      "Il_Id": "7"
    },
    {
      "Id": "85",
      "Ilce": "Elmalı",
      "Il_Id": "7"
    },
    {
      "Id": "86",
      "Ilce": "Finike",
      "Il_Id": "7"
    },
    {
      "Id": "87",
      "Ilce": "Gazipaşa",
      "Il_Id": "7"
    },
    {
      "Id": "88",
      "Ilce": "Gündoğmuş",
      "Il_Id": "7"
    },
    {
      "Id": "89",
      "Ilce": "Kaş",
      "Il_Id": "7"
    },
    {
      "Id": "90",
      "Ilce": "Korkuteli",
      "Il_Id": "7"
    },
    {
      "Id": "91",
      "Ilce": "Kumluca",
      "Il_Id": "7"
    },
    {
      "Id": "92",
      "Ilce": "Manavgat",
      "Il_Id": "7"
    },
    {
      "Id": "93",
      "Ilce": "Serik",
      "Il_Id": "7"
    },
    {
      "Id": "94",
      "Ilce": "Demre",
      "Il_Id": "7"
    },
    {
      "Id": "95",
      "Ilce": "İbradı",
      "Il_Id": "7"
    },
    {
      "Id": "96",
      "Ilce": "Kemer / Antalya",
      "Il_Id": "7"
    },
    {
      "Id": "97",
      "Ilce": "Aksu / Antalya",
      "Il_Id": "7"
    },
    {
      "Id": "98",
      "Ilce": "Döşemealtı",
      "Il_Id": "7"
    },
    {
      "Id": "99",
      "Ilce": "Kepez",
      "Il_Id": "7"
    },
    {
      "Id": "100",
      "Ilce": "Konyaaltı",
      "Il_Id": "7"
    },
    {
      "Id": "101",
      "Ilce": "Muratpaşa",
      "Il_Id": "7"
    },
    {
      "Id": "102",
      "Ilce": "Ardanuç",
      "Il_Id": "8"
    },
    {
      "Id": "103",
      "Ilce": "Arhavi",
      "Il_Id": "8"
    },
    {
      "Id": "104",
      "Ilce": "Artvin Merkez",
      "Il_Id": "8"
    },
    {
      "Id": "105",
      "Ilce": "Borçka",
      "Il_Id": "8"
    },
    {
      "Id": "106",
      "Ilce": "Hopa",
      "Il_Id": "8"
    },
    {
      "Id": "107",
      "Ilce": "Şavşat",
      "Il_Id": "8"
    },
    {
      "Id": "108",
      "Ilce": "Yusufeli",
      "Il_Id": "8"
    },
    {
      "Id": "109",
      "Ilce": "Murgul",
      "Il_Id": "8"
    },
    {
      "Id": "110",
      "Ilce": "Bozdoğan",
      "Il_Id": "9"
    },
    {
      "Id": "111",
      "Ilce": "Çine",
      "Il_Id": "9"
    },
    {
      "Id": "112",
      "Ilce": "Germencik",
      "Il_Id": "9"
    },
    {
      "Id": "113",
      "Ilce": "Karacasu",
      "Il_Id": "9"
    },
    {
      "Id": "114",
      "Ilce": "Koçarlı",
      "Il_Id": "9"
    },
    {
      "Id": "115",
      "Ilce": "Kuşadası",
      "Il_Id": "9"
    },
    {
      "Id": "116",
      "Ilce": "Kuyucak",
      "Il_Id": "9"
    },
    {
      "Id": "117",
      "Ilce": "Nazilli",
      "Il_Id": "9"
    },
    {
      "Id": "118",
      "Ilce": "Söke",
      "Il_Id": "9"
    },
    {
      "Id": "119",
      "Ilce": "Sultanhisar",
      "Il_Id": "9"
    },
    {
      "Id": "120",
      "Ilce": "Yenipazar / Aydın",
      "Il_Id": "9"
    },
    {
      "Id": "121",
      "Ilce": "Buharkent",
      "Il_Id": "9"
    },
    {
      "Id": "122",
      "Ilce": "İncirliova",
      "Il_Id": "9"
    },
    {
      "Id": "123",
      "Ilce": "Karpuzlu",
      "Il_Id": "9"
    },
    {
      "Id": "124",
      "Ilce": "Köşk",
      "Il_Id": "9"
    },
    {
      "Id": "125",
      "Ilce": "Didim",
      "Il_Id": "9"
    },
    {
      "Id": "126",
      "Ilce": "Efeler",
      "Il_Id": "9"
    },
    {
      "Id": "127",
      "Ilce": "Ayvalık",
      "Il_Id": "10"
    },
    {
      "Id": "128",
      "Ilce": "Balya",
      "Il_Id": "10"
    },
    {
      "Id": "129",
      "Ilce": "Bandırma",
      "Il_Id": "10"
    },
    {
      "Id": "130",
      "Ilce": "Bigadiç",
      "Il_Id": "10"
    },
    {
      "Id": "131",
      "Ilce": "Burhaniye",
      "Il_Id": "10"
    },
    {
      "Id": "132",
      "Ilce": "Dursunbey",
      "Il_Id": "10"
    },
    {
      "Id": "133",
      "Ilce": "Edremit / Balıkesir",
      "Il_Id": "10"
    },
    {
      "Id": "134",
      "Ilce": "Erdek",
      "Il_Id": "10"
    },
    {
      "Id": "135",
      "Ilce": "Gönen / Balıkesir",
      "Il_Id": "10"
    },
    {
      "Id": "136",
      "Ilce": "Havran",
      "Il_Id": "10"
    },
    {
      "Id": "137",
      "Ilce": "İvrindi",
      "Il_Id": "10"
    },
    {
      "Id": "138",
      "Ilce": "Kepsut",
      "Il_Id": "10"
    },
    {
      "Id": "139",
      "Ilce": "Manyas",
      "Il_Id": "10"
    },
    {
      "Id": "140",
      "Ilce": "Savaştepe",
      "Il_Id": "10"
    },
    {
      "Id": "141",
      "Ilce": "Sındırgı",
      "Il_Id": "10"
    },
    {
      "Id": "142",
      "Ilce": "Susurluk",
      "Il_Id": "10"
    },
    {
      "Id": "143",
      "Ilce": "Marmara",
      "Il_Id": "10"
    },
    {
      "Id": "144",
      "Ilce": "Gömeç",
      "Il_Id": "10"
    },
    {
      "Id": "145",
      "Ilce": "Altıeylül",
      "Il_Id": "10"
    },
    {
      "Id": "146",
      "Ilce": "Karesi",
      "Il_Id": "10"
    },
    {
      "Id": "147",
      "Ilce": "Bilecik Merkez",
      "Il_Id": "11"
    },
    {
      "Id": "148",
      "Ilce": "Bozüyük",
      "Il_Id": "11"
    },
    {
      "Id": "149",
      "Ilce": "Gölpazarı",
      "Il_Id": "11"
    },
    {
      "Id": "150",
      "Ilce": "Osmaneli",
      "Il_Id": "11"
    },
    {
      "Id": "151",
      "Ilce": "Pazaryeri",
      "Il_Id": "11"
    },
    {
      "Id": "152",
      "Ilce": "Söğüt",
      "Il_Id": "11"
    },
    {
      "Id": "153",
      "Ilce": "Yenipazar / Bilecik",
      "Il_Id": "11"
    },
    {
      "Id": "154",
      "Ilce": "İnhisar",
      "Il_Id": "11"
    },
    {
      "Id": "155",
      "Ilce": "Bingöl Merkez",
      "Il_Id": "12"
    },
    {
      "Id": "156",
      "Ilce": "Genç",
      "Il_Id": "12"
    },
    {
      "Id": "157",
      "Ilce": "Karlıova",
      "Il_Id": "12"
    },
    {
      "Id": "158",
      "Ilce": "Kiğı",
      "Il_Id": "12"
    },
    {
      "Id": "159",
      "Ilce": "Solhan",
      "Il_Id": "12"
    },
    {
      "Id": "160",
      "Ilce": "Adaklı",
      "Il_Id": "12"
    },
    {
      "Id": "161",
      "Ilce": "Yayladere",
      "Il_Id": "12"
    },
    {
      "Id": "162",
      "Ilce": "Yedisu",
      "Il_Id": "12"
    },
    {
      "Id": "163",
      "Ilce": "Adilcevaz",
      "Il_Id": "13"
    },
    {
      "Id": "164",
      "Ilce": "Ahlat",
      "Il_Id": "13"
    },
    {
      "Id": "165",
      "Ilce": "Bitlis Merkez",
      "Il_Id": "13"
    },
    {
      "Id": "166",
      "Ilce": "Hizan",
      "Il_Id": "13"
    },
    {
      "Id": "167",
      "Ilce": "Mutki",
      "Il_Id": "13"
    },
    {
      "Id": "168",
      "Ilce": "Tatvan",
      "Il_Id": "13"
    },
    {
      "Id": "169",
      "Ilce": "Güroymak",
      "Il_Id": "13"
    },
    {
      "Id": "170",
      "Ilce": "Bolu Merkez",
      "Il_Id": "14"
    },
    {
      "Id": "171",
      "Ilce": "Gerede",
      "Il_Id": "14"
    },
    {
      "Id": "172",
      "Ilce": "Göynük",
      "Il_Id": "14"
    },
    {
      "Id": "173",
      "Ilce": "Kıbrıscık",
      "Il_Id": "14"
    },
    {
      "Id": "174",
      "Ilce": "Mengen",
      "Il_Id": "14"
    },
    {
      "Id": "175",
      "Ilce": "Mudurnu",
      "Il_Id": "14"
    },
    {
      "Id": "176",
      "Ilce": "Seben",
      "Il_Id": "14"
    },
    {
      "Id": "177",
      "Ilce": "Dörtdivan",
      "Il_Id": "14"
    },
    {
      "Id": "178",
      "Ilce": "Yeniçağa",
      "Il_Id": "14"
    },
    {
      "Id": "179",
      "Ilce": "Ağlasun",
      "Il_Id": "15"
    },
    {
      "Id": "180",
      "Ilce": "Bucak",
      "Il_Id": "15"
    },
    {
      "Id": "181",
      "Ilce": "Burdur Merkez",
      "Il_Id": "15"
    },
    {
      "Id": "182",
      "Ilce": "Gölhisar",
      "Il_Id": "15"
    },
    {
      "Id": "183",
      "Ilce": "Tefenni",
      "Il_Id": "15"
    },
    {
      "Id": "184",
      "Ilce": "Yeşilova",
      "Il_Id": "15"
    },
    {
      "Id": "185",
      "Ilce": "Karamanlı",
      "Il_Id": "15"
    },
    {
      "Id": "186",
      "Ilce": "Kemer / Burdur",
      "Il_Id": "15"
    },
    {
      "Id": "187",
      "Ilce": "Altınyayla / Burdur",
      "Il_Id": "15"
    },
    {
      "Id": "188",
      "Ilce": "Çavdır",
      "Il_Id": "15"
    },
    {
      "Id": "189",
      "Ilce": "Çeltikçi",
      "Il_Id": "15"
    },
    {
      "Id": "190",
      "Ilce": "Gemlik",
      "Il_Id": "16"
    },
    {
      "Id": "191",
      "Ilce": "İnegöl",
      "Il_Id": "16"
    },
    {
      "Id": "192",
      "Ilce": "İznik",
      "Il_Id": "16"
    },
    {
      "Id": "193",
      "Ilce": "Karacabey",
      "Il_Id": "16"
    },
    {
      "Id": "194",
      "Ilce": "Keles",
      "Il_Id": "16"
    },
    {
      "Id": "195",
      "Ilce": "Mudanya",
      "Il_Id": "16"
    },
    {
      "Id": "196",
      "Ilce": "Mustafakemalpaşa",
      "Il_Id": "16"
    },
    {
      "Id": "197",
      "Ilce": "Orhaneli",
      "Il_Id": "16"
    },
    {
      "Id": "198",
      "Ilce": "Orhangazi",
      "Il_Id": "16"
    },
    {
      "Id": "199",
      "Ilce": "Yenişehir / Bursa",
      "Il_Id": "16"
    },
    {
      "Id": "200",
      "Ilce": "Büyükorhan",
      "Il_Id": "16"
    },
    {
      "Id": "201",
      "Ilce": "Harmancık",
      "Il_Id": "16"
    },
    {
      "Id": "202",
      "Ilce": "Nilüfer",
      "Il_Id": "16"
    },
    {
      "Id": "203",
      "Ilce": "Osmangazi",
      "Il_Id": "16"
    },
    {
      "Id": "204",
      "Ilce": "Yıldırım",
      "Il_Id": "16"
    },
    {
      "Id": "205",
      "Ilce": "Gürsu",
      "Il_Id": "16"
    },
    {
      "Id": "206",
      "Ilce": "Kestel",
      "Il_Id": "16"
    },
    {
      "Id": "207",
      "Ilce": "Ayvacık / Çanakkale",
      "Il_Id": "17"
    },
    {
      "Id": "208",
      "Ilce": "Bayramiç",
      "Il_Id": "17"
    },
    {
      "Id": "209",
      "Ilce": "Biga",
      "Il_Id": "17"
    },
    {
      "Id": "210",
      "Ilce": "Bozcaada",
      "Il_Id": "17"
    },
    {
      "Id": "211",
      "Ilce": "Çan",
      "Il_Id": "17"
    },
    {
      "Id": "212",
      "Ilce": "Çanakkale Merkez",
      "Il_Id": "17"
    },
    {
      "Id": "213",
      "Ilce": "Eceabat",
      "Il_Id": "17"
    },
    {
      "Id": "214",
      "Ilce": "Ezine",
      "Il_Id": "17"
    },
    {
      "Id": "215",
      "Ilce": "Gelibolu",
      "Il_Id": "17"
    },
    {
      "Id": "216",
      "Ilce": "Gökçeada",
      "Il_Id": "17"
    },
    {
      "Id": "217",
      "Ilce": "Lapseki",
      "Il_Id": "17"
    },
    {
      "Id": "218",
      "Ilce": "Yenice / Çanakkale",
      "Il_Id": "17"
    },
    {
      "Id": "219",
      "Ilce": "Çankırı Merkez",
      "Il_Id": "18"
    },
    {
      "Id": "220",
      "Ilce": "Çerkeş",
      "Il_Id": "18"
    },
    {
      "Id": "221",
      "Ilce": "Eldivan",
      "Il_Id": "18"
    },
    {
      "Id": "222",
      "Ilce": "Ilgaz",
      "Il_Id": "18"
    },
    {
      "Id": "223",
      "Ilce": "Kurşunlu",
      "Il_Id": "18"
    },
    {
      "Id": "224",
      "Ilce": "Orta",
      "Il_Id": "18"
    },
    {
      "Id": "225",
      "Ilce": "Şabanözü",
      "Il_Id": "18"
    },
    {
      "Id": "226",
      "Ilce": "Yapraklı",
      "Il_Id": "18"
    },
    {
      "Id": "227",
      "Ilce": "Atkaracalar",
      "Il_Id": "18"
    },
    {
      "Id": "228",
      "Ilce": "Kızılırmak",
      "Il_Id": "18"
    },
    {
      "Id": "229",
      "Ilce": "Bayramören",
      "Il_Id": "18"
    },
    {
      "Id": "230",
      "Ilce": "Korgun",
      "Il_Id": "18"
    },
    {
      "Id": "231",
      "Ilce": "Alaca",
      "Il_Id": "19"
    },
    {
      "Id": "232",
      "Ilce": "Bayat / Çorum",
      "Il_Id": "19"
    },
    {
      "Id": "233",
      "Ilce": "Çorum Merkez",
      "Il_Id": "19"
    },
    {
      "Id": "234",
      "Ilce": "İskilip",
      "Il_Id": "19"
    },
    {
      "Id": "235",
      "Ilce": "Kargı",
      "Il_Id": "19"
    },
    {
      "Id": "236",
      "Ilce": "Mecitözü",
      "Il_Id": "19"
    },
    {
      "Id": "237",
      "Ilce": "Ortaköy / Çorum",
      "Il_Id": "19"
    },
    {
      "Id": "238",
      "Ilce": "Osmancık",
      "Il_Id": "19"
    },
    {
      "Id": "239",
      "Ilce": "Sungurlu",
      "Il_Id": "19"
    },
    {
      "Id": "240",
      "Ilce": "Boğazkale",
      "Il_Id": "19"
    },
    {
      "Id": "241",
      "Ilce": "Uğurludağ",
      "Il_Id": "19"
    },
    {
      "Id": "242",
      "Ilce": "Dodurga",
      "Il_Id": "19"
    },
    {
      "Id": "243",
      "Ilce": "Laçin",
      "Il_Id": "19"
    },
    {
      "Id": "244",
      "Ilce": "Oğuzlar",
      "Il_Id": "19"
    },
    {
      "Id": "245",
      "Ilce": "Acıpayam",
      "Il_Id": "20"
    },
    {
      "Id": "246",
      "Ilce": "Buldan",
      "Il_Id": "20"
    },
    {
      "Id": "247",
      "Ilce": "Çal",
      "Il_Id": "20"
    },
    {
      "Id": "248",
      "Ilce": "Çameli",
      "Il_Id": "20"
    },
    {
      "Id": "249",
      "Ilce": "Çardak",
      "Il_Id": "20"
    },
    {
      "Id": "250",
      "Ilce": "Çivril",
      "Il_Id": "20"
    },
    {
      "Id": "251",
      "Ilce": "Güney",
      "Il_Id": "20"
    },
    {
      "Id": "252",
      "Ilce": "Kale / Denizli",
      "Il_Id": "20"
    },
    {
      "Id": "253",
      "Ilce": "Sarayköy",
      "Il_Id": "20"
    },
    {
      "Id": "254",
      "Ilce": "Tavas",
      "Il_Id": "20"
    },
    {
      "Id": "255",
      "Ilce": "Babadağ",
      "Il_Id": "20"
    },
    {
      "Id": "256",
      "Ilce": "Bekilli",
      "Il_Id": "20"
    },
    {
      "Id": "257",
      "Ilce": "Honaz",
      "Il_Id": "20"
    },
    {
      "Id": "258",
      "Ilce": "Serinhisar",
      "Il_Id": "20"
    },
    {
      "Id": "259",
      "Ilce": "Pamukkale",
      "Il_Id": "20"
    },
    {
      "Id": "260",
      "Ilce": "Baklan",
      "Il_Id": "20"
    },
    {
      "Id": "261",
      "Ilce": "Beyağaç",
      "Il_Id": "20"
    },
    {
      "Id": "262",
      "Ilce": "Bozkurt / Denizli",
      "Il_Id": "20"
    },
    {
      "Id": "263",
      "Ilce": "Merkezefendi",
      "Il_Id": "20"
    },
    {
      "Id": "264",
      "Ilce": "Bismil",
      "Il_Id": "21"
    },
    {
      "Id": "265",
      "Ilce": "Çermik",
      "Il_Id": "21"
    },
    {
      "Id": "266",
      "Ilce": "Çınar",
      "Il_Id": "21"
    },
    {
      "Id": "267",
      "Ilce": "Çüngüş",
      "Il_Id": "21"
    },
    {
      "Id": "268",
      "Ilce": "Dicle",
      "Il_Id": "21"
    },
    {
      "Id": "269",
      "Ilce": "Ergani",
      "Il_Id": "21"
    },
    {
      "Id": "270",
      "Ilce": "Hani",
      "Il_Id": "21"
    },
    {
      "Id": "271",
      "Ilce": "Hazro",
      "Il_Id": "21"
    },
    {
      "Id": "272",
      "Ilce": "Kulp",
      "Il_Id": "21"
    },
    {
      "Id": "273",
      "Ilce": "Lice",
      "Il_Id": "21"
    },
    {
      "Id": "274",
      "Ilce": "Silvan",
      "Il_Id": "21"
    },
    {
      "Id": "275",
      "Ilce": "Eğil",
      "Il_Id": "21"
    },
    {
      "Id": "276",
      "Ilce": "Kocaköy",
      "Il_Id": "21"
    },
    {
      "Id": "277",
      "Ilce": "Bağlar",
      "Il_Id": "21"
    },
    {
      "Id": "278",
      "Ilce": "Kayapınar",
      "Il_Id": "21"
    },
    {
      "Id": "279",
      "Ilce": "Sur",
      "Il_Id": "21"
    },
    {
      "Id": "280",
      "Ilce": "Yenişehir / Diyarbakır",
      "Il_Id": "21"
    },
    {
      "Id": "281",
      "Ilce": "Edirne Merkez",
      "Il_Id": "22"
    },
    {
      "Id": "282",
      "Ilce": "Enez",
      "Il_Id": "22"
    },
    {
      "Id": "283",
      "Ilce": "Havsa",
      "Il_Id": "22"
    },
    {
      "Id": "284",
      "Ilce": "İpsala",
      "Il_Id": "22"
    },
    {
      "Id": "285",
      "Ilce": "Keşan",
      "Il_Id": "22"
    },
    {
      "Id": "286",
      "Ilce": "Lalapaşa",
      "Il_Id": "22"
    },
    {
      "Id": "287",
      "Ilce": "Meriç",
      "Il_Id": "22"
    },
    {
      "Id": "288",
      "Ilce": "Uzunköprü",
      "Il_Id": "22"
    },
    {
      "Id": "289",
      "Ilce": "Süloğlu",
      "Il_Id": "22"
    },
    {
      "Id": "290",
      "Ilce": "Ağın",
      "Il_Id": "23"
    },
    {
      "Id": "291",
      "Ilce": "Baskil",
      "Il_Id": "23"
    },
    {
      "Id": "292",
      "Ilce": "Elazığ Merkez",
      "Il_Id": "23"
    },
    {
      "Id": "293",
      "Ilce": "Karakoçan",
      "Il_Id": "23"
    },
    {
      "Id": "294",
      "Ilce": "Keban",
      "Il_Id": "23"
    },
    {
      "Id": "295",
      "Ilce": "Maden",
      "Il_Id": "23"
    },
    {
      "Id": "296",
      "Ilce": "Palu",
      "Il_Id": "23"
    },
    {
      "Id": "297",
      "Ilce": "Sivrice",
      "Il_Id": "23"
    },
    {
      "Id": "298",
      "Ilce": "Arıcak",
      "Il_Id": "23"
    },
    {
      "Id": "299",
      "Ilce": "Kovancılar",
      "Il_Id": "23"
    },
    {
      "Id": "300",
      "Ilce": "Alacakaya",
      "Il_Id": "23"
    },
    {
      "Id": "301",
      "Ilce": "Çayırlı",
      "Il_Id": "24"
    },
    {
      "Id": "302",
      "Ilce": "Erzincan Merkez",
      "Il_Id": "24"
    },
    {
      "Id": "303",
      "Ilce": "İliç",
      "Il_Id": "24"
    },
    {
      "Id": "304",
      "Ilce": "Kemah",
      "Il_Id": "24"
    },
    {
      "Id": "305",
      "Ilce": "Kemaliye",
      "Il_Id": "24"
    },
    {
      "Id": "306",
      "Ilce": "Refahiye",
      "Il_Id": "24"
    },
    {
      "Id": "307",
      "Ilce": "Tercan",
      "Il_Id": "24"
    },
    {
      "Id": "308",
      "Ilce": "Üzümlü",
      "Il_Id": "24"
    },
    {
      "Id": "309",
      "Ilce": "Otlukbeli",
      "Il_Id": "24"
    },
    {
      "Id": "310",
      "Ilce": "Aşkale",
      "Il_Id": "25"
    },
    {
      "Id": "311",
      "Ilce": "Çat",
      "Il_Id": "25"
    },
    {
      "Id": "312",
      "Ilce": "Hınıs",
      "Il_Id": "25"
    },
    {
      "Id": "313",
      "Ilce": "Horasan",
      "Il_Id": "25"
    },
    {
      "Id": "314",
      "Ilce": "İspir",
      "Il_Id": "25"
    },
    {
      "Id": "315",
      "Ilce": "Karayazı",
      "Il_Id": "25"
    },
    {
      "Id": "316",
      "Ilce": "Narman",
      "Il_Id": "25"
    },
    {
      "Id": "317",
      "Ilce": "Oltu",
      "Il_Id": "25"
    },
    {
      "Id": "318",
      "Ilce": "Olur",
      "Il_Id": "25"
    },
    {
      "Id": "319",
      "Ilce": "Pasinler",
      "Il_Id": "25"
    },
    {
      "Id": "320",
      "Ilce": "Şenkaya",
      "Il_Id": "25"
    },
    {
      "Id": "321",
      "Ilce": "Tekman",
      "Il_Id": "25"
    },
    {
      "Id": "322",
      "Ilce": "Tortum",
      "Il_Id": "25"
    },
    {
      "Id": "323",
      "Ilce": "Karaçoban",
      "Il_Id": "25"
    },
    {
      "Id": "324",
      "Ilce": "Uzundere",
      "Il_Id": "25"
    },
    {
      "Id": "325",
      "Ilce": "Pazaryolu",
      "Il_Id": "25"
    },
    {
      "Id": "326",
      "Ilce": "Aziziye",
      "Il_Id": "25"
    },
    {
      "Id": "327",
      "Ilce": "Köprüköy",
      "Il_Id": "25"
    },
    {
      "Id": "328",
      "Ilce": "Palandöken",
      "Il_Id": "25"
    },
    {
      "Id": "329",
      "Ilce": "Yakutiye",
      "Il_Id": "25"
    },
    {
      "Id": "330",
      "Ilce": "Çifteler",
      "Il_Id": "26"
    },
    {
      "Id": "331",
      "Ilce": "Mahmudiye",
      "Il_Id": "26"
    },
    {
      "Id": "332",
      "Ilce": "Mihalıççık",
      "Il_Id": "26"
    },
    {
      "Id": "333",
      "Ilce": "Sarıcakaya",
      "Il_Id": "26"
    },
    {
      "Id": "334",
      "Ilce": "Seyitgazi",
      "Il_Id": "26"
    },
    {
      "Id": "335",
      "Ilce": "Sivrihisar",
      "Il_Id": "26"
    },
    {
      "Id": "336",
      "Ilce": "Alpu",
      "Il_Id": "26"
    },
    {
      "Id": "337",
      "Ilce": "Beylikova",
      "Il_Id": "26"
    },
    {
      "Id": "338",
      "Ilce": "İnönü",
      "Il_Id": "26"
    },
    {
      "Id": "339",
      "Ilce": "Günyüzü",
      "Il_Id": "26"
    },
    {
      "Id": "340",
      "Ilce": "Han",
      "Il_Id": "26"
    },
    {
      "Id": "341",
      "Ilce": "Mihalgazi",
      "Il_Id": "26"
    },
    {
      "Id": "342",
      "Ilce": "Odunpazarı",
      "Il_Id": "26"
    },
    {
      "Id": "343",
      "Ilce": "Tepebaşı",
      "Il_Id": "26"
    },
    {
      "Id": "344",
      "Ilce": "Araban",
      "Il_Id": "27"
    },
    {
      "Id": "345",
      "Ilce": "İslahiye",
      "Il_Id": "27"
    },
    {
      "Id": "346",
      "Ilce": "Nizip",
      "Il_Id": "27"
    },
    {
      "Id": "347",
      "Ilce": "Oğuzeli",
      "Il_Id": "27"
    },
    {
      "Id": "348",
      "Ilce": "Yavuzeli",
      "Il_Id": "27"
    },
    {
      "Id": "349",
      "Ilce": "Şahinbey",
      "Il_Id": "27"
    },
    {
      "Id": "350",
      "Ilce": "Şehitkamil",
      "Il_Id": "27"
    },
    {
      "Id": "351",
      "Ilce": "Karkamış",
      "Il_Id": "27"
    },
    {
      "Id": "352",
      "Ilce": "Nurdağı",
      "Il_Id": "27"
    },
    {
      "Id": "353",
      "Ilce": "Alucra",
      "Il_Id": "28"
    },
    {
      "Id": "354",
      "Ilce": "Bulancak",
      "Il_Id": "28"
    },
    {
      "Id": "355",
      "Ilce": "Dereli",
      "Il_Id": "28"
    },
    {
      "Id": "356",
      "Ilce": "Espiye",
      "Il_Id": "28"
    },
    {
      "Id": "357",
      "Ilce": "Eynesil",
      "Il_Id": "28"
    },
    {
      "Id": "358",
      "Ilce": "Giresun Merkez",
      "Il_Id": "28"
    },
    {
      "Id": "359",
      "Ilce": "Görele",
      "Il_Id": "28"
    },
    {
      "Id": "360",
      "Ilce": "Keşap",
      "Il_Id": "28"
    },
    {
      "Id": "361",
      "Ilce": "Şebinkarahisar",
      "Il_Id": "28"
    },
    {
      "Id": "362",
      "Ilce": "Tirebolu",
      "Il_Id": "28"
    },
    {
      "Id": "363",
      "Ilce": "Piraziz",
      "Il_Id": "28"
    },
    {
      "Id": "364",
      "Ilce": "Yağlıdere",
      "Il_Id": "28"
    },
    {
      "Id": "365",
      "Ilce": "Çamoluk",
      "Il_Id": "28"
    },
    {
      "Id": "366",
      "Ilce": "Çanakçı",
      "Il_Id": "28"
    },
    {
      "Id": "367",
      "Ilce": "Doğankent",
      "Il_Id": "28"
    },
    {
      "Id": "368",
      "Ilce": "Güce",
      "Il_Id": "28"
    },
    {
      "Id": "369",
      "Ilce": "Gümüşhane Merkez",
      "Il_Id": "29"
    },
    {
      "Id": "370",
      "Ilce": "Kelkit",
      "Il_Id": "29"
    },
    {
      "Id": "371",
      "Ilce": "Şiran",
      "Il_Id": "29"
    },
    {
      "Id": "372",
      "Ilce": "Torul",
      "Il_Id": "29"
    },
    {
      "Id": "373",
      "Ilce": "Köse",
      "Il_Id": "29"
    },
    {
      "Id": "374",
      "Ilce": "Kürtün",
      "Il_Id": "29"
    },
    {
      "Id": "375",
      "Ilce": "Çukurca",
      "Il_Id": "30"
    },
    {
      "Id": "376",
      "Ilce": "Hakkari Merkez",
      "Il_Id": "30"
    },
    {
      "Id": "377",
      "Ilce": "Şemdinli",
      "Il_Id": "30"
    },
    {
      "Id": "378",
      "Ilce": "Yüksekova",
      "Il_Id": "30"
    },
    {
      "Id": "379",
      "Ilce": "Altınözü",
      "Il_Id": "31"
    },
    {
      "Id": "380",
      "Ilce": "Dörtyol",
      "Il_Id": "31"
    },
    {
      "Id": "381",
      "Ilce": "Hassa",
      "Il_Id": "31"
    },
    {
      "Id": "382",
      "Ilce": "İskenderun",
      "Il_Id": "31"
    },
    {
      "Id": "383",
      "Ilce": "Kırıkhan",
      "Il_Id": "31"
    },
    {
      "Id": "384",
      "Ilce": "Reyhanlı",
      "Il_Id": "31"
    },
    {
      "Id": "385",
      "Ilce": "Samandağ",
      "Il_Id": "31"
    },
    {
      "Id": "386",
      "Ilce": "Yayladağı",
      "Il_Id": "31"
    },
    {
      "Id": "387",
      "Ilce": "Erzin",
      "Il_Id": "31"
    },
    {
      "Id": "388",
      "Ilce": "Belen",
      "Il_Id": "31"
    },
    {
      "Id": "389",
      "Ilce": "Kumlu",
      "Il_Id": "31"
    },
    {
      "Id": "390",
      "Ilce": "Antakya",
      "Il_Id": "31"
    },
    {
      "Id": "391",
      "Ilce": "Arsuz",
      "Il_Id": "31"
    },
    {
      "Id": "392",
      "Ilce": "Defne",
      "Il_Id": "31"
    },
    {
      "Id": "393",
      "Ilce": "Payas",
      "Il_Id": "31"
    },
    {
      "Id": "394",
      "Ilce": "Atabey",
      "Il_Id": "32"
    },
    {
      "Id": "395",
      "Ilce": "Eğirdir",
      "Il_Id": "32"
    },
    {
      "Id": "396",
      "Ilce": "Gelendost",
      "Il_Id": "32"
    },
    {
      "Id": "397",
      "Ilce": "Isparta Merkez",
      "Il_Id": "32"
    },
    {
      "Id": "398",
      "Ilce": "Keçiborlu",
      "Il_Id": "32"
    },
    {
      "Id": "399",
      "Ilce": "Senirkent",
      "Il_Id": "32"
    },
    {
      "Id": "400",
      "Ilce": "Sütçüler",
      "Il_Id": "32"
    },
    {
      "Id": "401",
      "Ilce": "Şarkikaraağaç",
      "Il_Id": "32"
    },
    {
      "Id": "402",
      "Ilce": "Uluborlu",
      "Il_Id": "32"
    },
    {
      "Id": "403",
      "Ilce": "Yalvaç",
      "Il_Id": "32"
    },
    {
      "Id": "404",
      "Ilce": "Aksu / Isparta",
      "Il_Id": "32"
    },
    {
      "Id": "405",
      "Ilce": "Gönen / Isparta",
      "Il_Id": "32"
    },
    {
      "Id": "406",
      "Ilce": "Yenişarbademli",
      "Il_Id": "32"
    },
    {
      "Id": "407",
      "Ilce": "Anamur",
      "Il_Id": "33"
    },
    {
      "Id": "408",
      "Ilce": "Erdemli",
      "Il_Id": "33"
    },
    {
      "Id": "409",
      "Ilce": "Gülnar",
      "Il_Id": "33"
    },
    {
      "Id": "410",
      "Ilce": "Mut",
      "Il_Id": "33"
    },
    {
      "Id": "411",
      "Ilce": "Silifke",
      "Il_Id": "33"
    },
    {
      "Id": "412",
      "Ilce": "Tarsus",
      "Il_Id": "33"
    },
    {
      "Id": "413",
      "Ilce": "Aydıncık / Mersin",
      "Il_Id": "33"
    },
    {
      "Id": "414",
      "Ilce": "Bozyazı",
      "Il_Id": "33"
    },
    {
      "Id": "415",
      "Ilce": "Çamlıyayla",
      "Il_Id": "33"
    },
    {
      "Id": "416",
      "Ilce": "Akdeniz",
      "Il_Id": "33"
    },
    {
      "Id": "417",
      "Ilce": "Mezitli",
      "Il_Id": "33"
    },
    {
      "Id": "418",
      "Ilce": "Toroslar",
      "Il_Id": "33"
    },
    {
      "Id": "419",
      "Ilce": "Yenişehir / Mersin",
      "Il_Id": "33"
    },
    {
      "Id": "420",
      "Ilce": "Adalar",
      "Il_Id": "34"
    },
    {
      "Id": "421",
      "Ilce": "Bakırköy",
      "Il_Id": "34"
    },
    {
      "Id": "422",
      "Ilce": "Beşiktaş",
      "Il_Id": "34"
    },
    {
      "Id": "423",
      "Ilce": "Beykoz",
      "Il_Id": "34"
    },
    {
      "Id": "424",
      "Ilce": "Beyoğlu",
      "Il_Id": "34"
    },
    {
      "Id": "425",
      "Ilce": "Çatalca",
      "Il_Id": "34"
    },
    {
      "Id": "426",
      "Ilce": "Eyüp",
      "Il_Id": "34"
    },
    {
      "Id": "427",
      "Ilce": "Fatih",
      "Il_Id": "34"
    },
    {
      "Id": "428",
      "Ilce": "Gaziosmanpaşa",
      "Il_Id": "34"
    },
    {
      "Id": "429",
      "Ilce": "Kadıköy",
      "Il_Id": "34"
    },
    {
      "Id": "430",
      "Ilce": "Kartal",
      "Il_Id": "34"
    },
    {
      "Id": "431",
      "Ilce": "Sarıyer",
      "Il_Id": "34"
    },
    {
      "Id": "432",
      "Ilce": "Silivri",
      "Il_Id": "34"
    },
    {
      "Id": "433",
      "Ilce": "Şile",
      "Il_Id": "34"
    },
    {
      "Id": "434",
      "Ilce": "Şişli",
      "Il_Id": "34"
    },
    {
      "Id": "435",
      "Ilce": "Üsküdar",
      "Il_Id": "34"
    },
    {
      "Id": "436",
      "Ilce": "Zeytinburnu",
      "Il_Id": "34"
    },
    {
      "Id": "437",
      "Ilce": "Büyükçekmece",
      "Il_Id": "34"
    },
    {
      "Id": "438",
      "Ilce": "Kağıthane",
      "Il_Id": "34"
    },
    {
      "Id": "439",
      "Ilce": "Küçükçekmece",
      "Il_Id": "34"
    },
    {
      "Id": "440",
      "Ilce": "Pendik",
      "Il_Id": "34"
    },
    {
      "Id": "441",
      "Ilce": "Ümraniye",
      "Il_Id": "34"
    },
    {
      "Id": "442",
      "Ilce": "Bayrampaşa",
      "Il_Id": "34"
    },
    {
      "Id": "443",
      "Ilce": "Avcılar",
      "Il_Id": "34"
    },
    {
      "Id": "444",
      "Ilce": "Bağcılar",
      "Il_Id": "34"
    },
    {
      "Id": "445",
      "Ilce": "Bahçelievler",
      "Il_Id": "34"
    },
    {
      "Id": "446",
      "Ilce": "Güngören",
      "Il_Id": "34"
    },
    {
      "Id": "447",
      "Ilce": "Maltepe",
      "Il_Id": "34"
    },
    {
      "Id": "448",
      "Ilce": "Sultanbeyli",
      "Il_Id": "34"
    },
    {
      "Id": "449",
      "Ilce": "Tuzla",
      "Il_Id": "34"
    },
    {
      "Id": "450",
      "Ilce": "Esenler",
      "Il_Id": "34"
    },
    {
      "Id": "451",
      "Ilce": "Arnavutköy",
      "Il_Id": "34"
    },
    {
      "Id": "452",
      "Ilce": "Ataşehir",
      "Il_Id": "34"
    },
    {
      "Id": "453",
      "Ilce": "Başakşehir",
      "Il_Id": "34"
    },
    {
      "Id": "454",
      "Ilce": "Beylikdüzü",
      "Il_Id": "34"
    },
    {
      "Id": "455",
      "Ilce": "Çekmeköy",
      "Il_Id": "34"
    },
    {
      "Id": "456",
      "Ilce": "Esenyurt",
      "Il_Id": "34"
    },
    {
      "Id": "457",
      "Ilce": "Sancaktepe",
      "Il_Id": "34"
    },
    {
      "Id": "458",
      "Ilce": "Sultangazi",
      "Il_Id": "34"
    },
    {
      "Id": "459",
      "Ilce": "Aliağa",
      "Il_Id": "35"
    },
    {
      "Id": "460",
      "Ilce": "Bayındır",
      "Il_Id": "35"
    },
    {
      "Id": "461",
      "Ilce": "Bergama",
      "Il_Id": "35"
    },
    {
      "Id": "462",
      "Ilce": "Bornova",
      "Il_Id": "35"
    },
    {
      "Id": "463",
      "Ilce": "Çeşme",
      "Il_Id": "35"
    },
    {
      "Id": "464",
      "Ilce": "Dikili",
      "Il_Id": "35"
    },
    {
      "Id": "465",
      "Ilce": "Foça",
      "Il_Id": "35"
    },
    {
      "Id": "466",
      "Ilce": "Karaburun",
      "Il_Id": "35"
    },
    {
      "Id": "467",
      "Ilce": "Karşıyaka",
      "Il_Id": "35"
    },
    {
      "Id": "468",
      "Ilce": "Kemalpaşa / İzmir",
      "Il_Id": "35"
    },
    {
      "Id": "469",
      "Ilce": "Kınık",
      "Il_Id": "35"
    },
    {
      "Id": "470",
      "Ilce": "Kiraz",
      "Il_Id": "35"
    },
    {
      "Id": "471",
      "Ilce": "Menemen",
      "Il_Id": "35"
    },
    {
      "Id": "472",
      "Ilce": "Ödemiş",
      "Il_Id": "35"
    },
    {
      "Id": "473",
      "Ilce": "Seferihisar",
      "Il_Id": "35"
    },
    {
      "Id": "474",
      "Ilce": "Selçuk",
      "Il_Id": "35"
    },
    {
      "Id": "475",
      "Ilce": "Tire",
      "Il_Id": "35"
    },
    {
      "Id": "476",
      "Ilce": "Torbalı",
      "Il_Id": "35"
    },
    {
      "Id": "477",
      "Ilce": "Urla",
      "Il_Id": "35"
    },
    {
      "Id": "478",
      "Ilce": "Beydağ",
      "Il_Id": "35"
    },
    {
      "Id": "479",
      "Ilce": "Buca",
      "Il_Id": "35"
    },
    {
      "Id": "480",
      "Ilce": "Konak",
      "Il_Id": "35"
    },
    {
      "Id": "481",
      "Ilce": "Menderes",
      "Il_Id": "35"
    },
    {
      "Id": "482",
      "Ilce": "Balçova",
      "Il_Id": "35"
    },
    {
      "Id": "483",
      "Ilce": "Çiğli",
      "Il_Id": "35"
    },
    {
      "Id": "484",
      "Ilce": "Gaziemir",
      "Il_Id": "35"
    },
    {
      "Id": "485",
      "Ilce": "Narlıdere",
      "Il_Id": "35"
    },
    {
      "Id": "486",
      "Ilce": "Güzelbahçe",
      "Il_Id": "35"
    },
    {
      "Id": "487",
      "Ilce": "Bayraklı",
      "Il_Id": "35"
    },
    {
      "Id": "488",
      "Ilce": "Karabağlar",
      "Il_Id": "35"
    },
    {
      "Id": "489",
      "Ilce": "Arpaçay",
      "Il_Id": "36"
    },
    {
      "Id": "490",
      "Ilce": "Digor",
      "Il_Id": "36"
    },
    {
      "Id": "491",
      "Ilce": "Kağızman",
      "Il_Id": "36"
    },
    {
      "Id": "492",
      "Ilce": "Kars Merkez",
      "Il_Id": "36"
    },
    {
      "Id": "493",
      "Ilce": "Sarıkamış",
      "Il_Id": "36"
    },
    {
      "Id": "494",
      "Ilce": "Selim",
      "Il_Id": "36"
    },
    {
      "Id": "495",
      "Ilce": "Susuz",
      "Il_Id": "36"
    },
    {
      "Id": "496",
      "Ilce": "Akyaka",
      "Il_Id": "36"
    },
    {
      "Id": "497",
      "Ilce": "Abana",
      "Il_Id": "37"
    },
    {
      "Id": "498",
      "Ilce": "Araç",
      "Il_Id": "37"
    },
    {
      "Id": "499",
      "Ilce": "Azdavay",
      "Il_Id": "37"
    },
    {
      "Id": "500",
      "Ilce": "Bozkurt / Kastamonu",
      "Il_Id": "37"
    },
    {
      "Id": "501",
      "Ilce": "Cide",
      "Il_Id": "37"
    },
    {
      "Id": "502",
      "Ilce": "Çatalzeytin",
      "Il_Id": "37"
    },
    {
      "Id": "503",
      "Ilce": "Daday",
      "Il_Id": "37"
    },
    {
      "Id": "504",
      "Ilce": "Devrekani",
      "Il_Id": "37"
    },
    {
      "Id": "505",
      "Ilce": "İnebolu",
      "Il_Id": "37"
    },
    {
      "Id": "506",
      "Ilce": "Kastamonu Merkez",
      "Il_Id": "37"
    },
    {
      "Id": "507",
      "Ilce": "Küre",
      "Il_Id": "37"
    },
    {
      "Id": "508",
      "Ilce": "Taşköprü",
      "Il_Id": "37"
    },
    {
      "Id": "509",
      "Ilce": "Tosya",
      "Il_Id": "37"
    },
    {
      "Id": "510",
      "Ilce": "İhsangazi",
      "Il_Id": "37"
    },
    {
      "Id": "511",
      "Ilce": "Pınarbaşı / Kastamonu",
      "Il_Id": "37"
    },
    {
      "Id": "512",
      "Ilce": "Şenpazar",
      "Il_Id": "37"
    },
    {
      "Id": "513",
      "Ilce": "Ağlı",
      "Il_Id": "37"
    },
    {
      "Id": "514",
      "Ilce": "Doğanyurt",
      "Il_Id": "37"
    },
    {
      "Id": "515",
      "Ilce": "Hanönü",
      "Il_Id": "37"
    },
    {
      "Id": "516",
      "Ilce": "Seydiler",
      "Il_Id": "37"
    },
    {
      "Id": "517",
      "Ilce": "Bünyan",
      "Il_Id": "38"
    },
    {
      "Id": "518",
      "Ilce": "Develi",
      "Il_Id": "38"
    },
    {
      "Id": "519",
      "Ilce": "Felahiye",
      "Il_Id": "38"
    },
    {
      "Id": "520",
      "Ilce": "İncesu",
      "Il_Id": "38"
    },
    {
      "Id": "521",
      "Ilce": "Pınarbaşı / Kayseri",
      "Il_Id": "38"
    },
    {
      "Id": "522",
      "Ilce": "Sarıoğlan",
      "Il_Id": "38"
    },
    {
      "Id": "523",
      "Ilce": "Sarız",
      "Il_Id": "38"
    },
    {
      "Id": "524",
      "Ilce": "Tomarza",
      "Il_Id": "38"
    },
    {
      "Id": "525",
      "Ilce": "Yahyalı",
      "Il_Id": "38"
    },
    {
      "Id": "526",
      "Ilce": "Yeşilhisar",
      "Il_Id": "38"
    },
    {
      "Id": "527",
      "Ilce": "Akkışla",
      "Il_Id": "38"
    },
    {
      "Id": "528",
      "Ilce": "Talas",
      "Il_Id": "38"
    },
    {
      "Id": "529",
      "Ilce": "Kocasinan",
      "Il_Id": "38"
    },
    {
      "Id": "530",
      "Ilce": "Melikgazi",
      "Il_Id": "38"
    },
    {
      "Id": "531",
      "Ilce": "Hacılar",
      "Il_Id": "38"
    },
    {
      "Id": "532",
      "Ilce": "Özvatan",
      "Il_Id": "38"
    },
    {
      "Id": "533",
      "Ilce": "Babaeski",
      "Il_Id": "39"
    },
    {
      "Id": "534",
      "Ilce": "Demirköy",
      "Il_Id": "39"
    },
    {
      "Id": "535",
      "Ilce": "Kırklareli Merkez",
      "Il_Id": "39"
    },
    {
      "Id": "536",
      "Ilce": "Kofçaz",
      "Il_Id": "39"
    },
    {
      "Id": "537",
      "Ilce": "Lüleburgaz",
      "Il_Id": "39"
    },
    {
      "Id": "538",
      "Ilce": "Pehlivanköy",
      "Il_Id": "39"
    },
    {
      "Id": "539",
      "Ilce": "Pınarhisar",
      "Il_Id": "39"
    },
    {
      "Id": "540",
      "Ilce": "Vize",
      "Il_Id": "39"
    },
    {
      "Id": "541",
      "Ilce": "Çiçekdağı",
      "Il_Id": "40"
    },
    {
      "Id": "542",
      "Ilce": "Kaman",
      "Il_Id": "40"
    },
    {
      "Id": "543",
      "Ilce": "Kırşehir Merkez",
      "Il_Id": "40"
    },
    {
      "Id": "544",
      "Ilce": "Mucur",
      "Il_Id": "40"
    },
    {
      "Id": "545",
      "Ilce": "Akpınar",
      "Il_Id": "40"
    },
    {
      "Id": "546",
      "Ilce": "Akçakent",
      "Il_Id": "40"
    },
    {
      "Id": "547",
      "Ilce": "Boztepe",
      "Il_Id": "40"
    },
    {
      "Id": "548",
      "Ilce": "Gebze",
      "Il_Id": "41"
    },
    {
      "Id": "549",
      "Ilce": "Gölcük",
      "Il_Id": "41"
    },
    {
      "Id": "550",
      "Ilce": "Kandıra",
      "Il_Id": "41"
    },
    {
      "Id": "551",
      "Ilce": "Karamürsel",
      "Il_Id": "41"
    },
    {
      "Id": "552",
      "Ilce": "Körfez",
      "Il_Id": "41"
    },
    {
      "Id": "553",
      "Ilce": "Derince",
      "Il_Id": "41"
    },
    {
      "Id": "554",
      "Ilce": "Başiskele",
      "Il_Id": "41"
    },
    {
      "Id": "555",
      "Ilce": "Çayırova",
      "Il_Id": "41"
    },
    {
      "Id": "556",
      "Ilce": "Darıca",
      "Il_Id": "41"
    },
    {
      "Id": "557",
      "Ilce": "Dilovası",
      "Il_Id": "41"
    },
    {
      "Id": "558",
      "Ilce": "İzmit",
      "Il_Id": "41"
    },
    {
      "Id": "559",
      "Ilce": "Kartepe",
      "Il_Id": "41"
    },
    {
      "Id": "560",
      "Ilce": "Akşehir",
      "Il_Id": "42"
    },
    {
      "Id": "561",
      "Ilce": "Beyşehir",
      "Il_Id": "42"
    },
    {
      "Id": "562",
      "Ilce": "Bozkır",
      "Il_Id": "42"
    },
    {
      "Id": "563",
      "Ilce": "Cihanbeyli",
      "Il_Id": "42"
    },
    {
      "Id": "564",
      "Ilce": "Çumra",
      "Il_Id": "42"
    },
    {
      "Id": "565",
      "Ilce": "Doğanhisar",
      "Il_Id": "42"
    },
    {
      "Id": "566",
      "Ilce": "Ereğli / Konya",
      "Il_Id": "42"
    },
    {
      "Id": "567",
      "Ilce": "Hadim",
      "Il_Id": "42"
    },
    {
      "Id": "568",
      "Ilce": "Ilgın",
      "Il_Id": "42"
    },
    {
      "Id": "569",
      "Ilce": "Kadınhanı",
      "Il_Id": "42"
    },
    {
      "Id": "570",
      "Ilce": "Karapınar",
      "Il_Id": "42"
    },
    {
      "Id": "571",
      "Ilce": "Kulu",
      "Il_Id": "42"
    },
    {
      "Id": "572",
      "Ilce": "Sarayönü",
      "Il_Id": "42"
    },
    {
      "Id": "573",
      "Ilce": "Seydişehir",
      "Il_Id": "42"
    },
    {
      "Id": "574",
      "Ilce": "Yunak",
      "Il_Id": "42"
    },
    {
      "Id": "575",
      "Ilce": "Akören",
      "Il_Id": "42"
    },
    {
      "Id": "576",
      "Ilce": "Altınekin",
      "Il_Id": "42"
    },
    {
      "Id": "577",
      "Ilce": "Derebucak",
      "Il_Id": "42"
    },
    {
      "Id": "578",
      "Ilce": "Hüyük",
      "Il_Id": "42"
    },
    {
      "Id": "579",
      "Ilce": "Karatay",
      "Il_Id": "42"
    },
    {
      "Id": "580",
      "Ilce": "Meram",
      "Il_Id": "42"
    },
    {
      "Id": "581",
      "Ilce": "Selçuklu",
      "Il_Id": "42"
    },
    {
      "Id": "582",
      "Ilce": "Taşkent",
      "Il_Id": "42"
    },
    {
      "Id": "583",
      "Ilce": "Ahırlı",
      "Il_Id": "42"
    },
    {
      "Id": "584",
      "Ilce": "Çeltik",
      "Il_Id": "42"
    },
    {
      "Id": "585",
      "Ilce": "Derbent",
      "Il_Id": "42"
    },
    {
      "Id": "586",
      "Ilce": "Emirgazi",
      "Il_Id": "42"
    },
    {
      "Id": "587",
      "Ilce": "Güneysınır",
      "Il_Id": "42"
    },
    {
      "Id": "588",
      "Ilce": "Halkapınar",
      "Il_Id": "42"
    },
    {
      "Id": "589",
      "Ilce": "Tuzlukçu",
      "Il_Id": "42"
    },
    {
      "Id": "590",
      "Ilce": "Yalıhüyük",
      "Il_Id": "42"
    },
    {
      "Id": "591",
      "Ilce": "Altıntaş",
      "Il_Id": "43"
    },
    {
      "Id": "592",
      "Ilce": "Domaniç",
      "Il_Id": "43"
    },
    {
      "Id": "593",
      "Ilce": "Emet",
      "Il_Id": "43"
    },
    {
      "Id": "594",
      "Ilce": "Gediz",
      "Il_Id": "43"
    },
    {
      "Id": "595",
      "Ilce": "Kütahya Merkez",
      "Il_Id": "43"
    },
    {
      "Id": "596",
      "Ilce": "Simav",
      "Il_Id": "43"
    },
    {
      "Id": "597",
      "Ilce": "Tavşanlı",
      "Il_Id": "43"
    },
    {
      "Id": "598",
      "Ilce": "Aslanapa",
      "Il_Id": "43"
    },
    {
      "Id": "599",
      "Ilce": "Dumlupınar",
      "Il_Id": "43"
    },
    {
      "Id": "600",
      "Ilce": "Hisarcık",
      "Il_Id": "43"
    },
    {
      "Id": "601",
      "Ilce": "Şaphane",
      "Il_Id": "43"
    },
    {
      "Id": "602",
      "Ilce": "Çavdarhisar",
      "Il_Id": "43"
    },
    {
      "Id": "603",
      "Ilce": "Pazarlar",
      "Il_Id": "43"
    },
    {
      "Id": "604",
      "Ilce": "Akçadağ",
      "Il_Id": "44"
    },
    {
      "Id": "605",
      "Ilce": "Arapgir",
      "Il_Id": "44"
    },
    {
      "Id": "606",
      "Ilce": "Arguvan",
      "Il_Id": "44"
    },
    {
      "Id": "607",
      "Ilce": "Darende",
      "Il_Id": "44"
    },
    {
      "Id": "608",
      "Ilce": "Doğanşehir",
      "Il_Id": "44"
    },
    {
      "Id": "609",
      "Ilce": "Hekimhan",
      "Il_Id": "44"
    },
    {
      "Id": "610",
      "Ilce": "Pütürge",
      "Il_Id": "44"
    },
    {
      "Id": "611",
      "Ilce": "Yeşilyurt / Malatya",
      "Il_Id": "44"
    },
    {
      "Id": "612",
      "Ilce": "Battalgazi",
      "Il_Id": "44"
    },
    {
      "Id": "613",
      "Ilce": "Doğanyol",
      "Il_Id": "44"
    },
    {
      "Id": "614",
      "Ilce": "Kale / Malatya",
      "Il_Id": "44"
    },
    {
      "Id": "615",
      "Ilce": "Kuluncak",
      "Il_Id": "44"
    },
    {
      "Id": "616",
      "Ilce": "Yazıhan",
      "Il_Id": "44"
    },
    {
      "Id": "617",
      "Ilce": "Akhisar",
      "Il_Id": "45"
    },
    {
      "Id": "618",
      "Ilce": "Alaşehir",
      "Il_Id": "45"
    },
    {
      "Id": "619",
      "Ilce": "Demirci",
      "Il_Id": "45"
    },
    {
      "Id": "620",
      "Ilce": "Gördes",
      "Il_Id": "45"
    },
    {
      "Id": "621",
      "Ilce": "Kırkağaç",
      "Il_Id": "45"
    },
    {
      "Id": "622",
      "Ilce": "Kula",
      "Il_Id": "45"
    },
    {
      "Id": "623",
      "Ilce": "Salihli",
      "Il_Id": "45"
    },
    {
      "Id": "624",
      "Ilce": "Sarıgöl",
      "Il_Id": "45"
    },
    {
      "Id": "625",
      "Ilce": "Saruhanlı",
      "Il_Id": "45"
    },
    {
      "Id": "626",
      "Ilce": "Selendi",
      "Il_Id": "45"
    },
    {
      "Id": "627",
      "Ilce": "Soma",
      "Il_Id": "45"
    },
    {
      "Id": "628",
      "Ilce": "Turgutlu",
      "Il_Id": "45"
    },
    {
      "Id": "629",
      "Ilce": "Ahmetli",
      "Il_Id": "45"
    },
    {
      "Id": "630",
      "Ilce": "Gölmarmara",
      "Il_Id": "45"
    },
    {
      "Id": "631",
      "Ilce": "Köprübaşı / Manisa",
      "Il_Id": "45"
    },
    {
      "Id": "632",
      "Ilce": "Şehzadeler",
      "Il_Id": "45"
    },
    {
      "Id": "633",
      "Ilce": "Yunusemre",
      "Il_Id": "45"
    },
    {
      "Id": "634",
      "Ilce": "Afşin",
      "Il_Id": "46"
    },
    {
      "Id": "635",
      "Ilce": "Andırın",
      "Il_Id": "46"
    },
    {
      "Id": "636",
      "Ilce": "Elbistan",
      "Il_Id": "46"
    },
    {
      "Id": "637",
      "Ilce": "Göksun",
      "Il_Id": "46"
    },
    {
      "Id": "638",
      "Ilce": "Pazarcık",
      "Il_Id": "46"
    },
    {
      "Id": "639",
      "Ilce": "Türkoğlu",
      "Il_Id": "46"
    },
    {
      "Id": "640",
      "Ilce": "Çağlayancerit",
      "Il_Id": "46"
    },
    {
      "Id": "641",
      "Ilce": "Ekinözü",
      "Il_Id": "46"
    },
    {
      "Id": "642",
      "Ilce": "Nurhak",
      "Il_Id": "46"
    },
    {
      "Id": "643",
      "Ilce": "Dulkadiroğlu",
      "Il_Id": "46"
    },
    {
      "Id": "644",
      "Ilce": "Onikişubat",
      "Il_Id": "46"
    },
    {
      "Id": "645",
      "Ilce": "Derik",
      "Il_Id": "47"
    },
    {
      "Id": "646",
      "Ilce": "Kızıltepe",
      "Il_Id": "47"
    },
    {
      "Id": "647",
      "Ilce": "Mazıdağı",
      "Il_Id": "47"
    },
    {
      "Id": "648",
      "Ilce": "Midyat",
      "Il_Id": "47"
    },
    {
      "Id": "649",
      "Ilce": "Nusaybin",
      "Il_Id": "47"
    },
    {
      "Id": "650",
      "Ilce": "Ömerli",
      "Il_Id": "47"
    },
    {
      "Id": "651",
      "Ilce": "Savur",
      "Il_Id": "47"
    },
    {
      "Id": "652",
      "Ilce": "Dargeçit",
      "Il_Id": "47"
    },
    {
      "Id": "653",
      "Ilce": "Yeşilli",
      "Il_Id": "47"
    },
    {
      "Id": "654",
      "Ilce": "Artuklu",
      "Il_Id": "47"
    },
    {
      "Id": "655",
      "Ilce": "Bodrum",
      "Il_Id": "48"
    },
    {
      "Id": "656",
      "Ilce": "Datça",
      "Il_Id": "48"
    },
    {
      "Id": "657",
      "Ilce": "Fethiye",
      "Il_Id": "48"
    },
    {
      "Id": "658",
      "Ilce": "Köyceğiz",
      "Il_Id": "48"
    },
    {
      "Id": "659",
      "Ilce": "Marmaris",
      "Il_Id": "48"
    },
    {
      "Id": "660",
      "Ilce": "Milas",
      "Il_Id": "48"
    },
    {
      "Id": "661",
      "Ilce": "Ula",
      "Il_Id": "48"
    },
    {
      "Id": "662",
      "Ilce": "Yatağan",
      "Il_Id": "48"
    },
    {
      "Id": "663",
      "Ilce": "Dalaman",
      "Il_Id": "48"
    },
    {
      "Id": "664",
      "Ilce": "Ortaca",
      "Il_Id": "48"
    },
    {
      "Id": "665",
      "Ilce": "Kavaklıdere",
      "Il_Id": "48"
    },
    {
      "Id": "666",
      "Ilce": "Menteşe",
      "Il_Id": "48"
    },
    {
      "Id": "667",
      "Ilce": "Seydikemer",
      "Il_Id": "48"
    },
    {
      "Id": "668",
      "Ilce": "Bulanık",
      "Il_Id": "49"
    },
    {
      "Id": "669",
      "Ilce": "Malazgirt",
      "Il_Id": "49"
    },
    {
      "Id": "670",
      "Ilce": "Muş Merkez",
      "Il_Id": "49"
    },
    {
      "Id": "671",
      "Ilce": "Varto",
      "Il_Id": "49"
    },
    {
      "Id": "672",
      "Ilce": "Hasköy",
      "Il_Id": "49"
    },
    {
      "Id": "673",
      "Ilce": "Korkut",
      "Il_Id": "49"
    },
    {
      "Id": "674",
      "Ilce": "Avanos",
      "Il_Id": "50"
    },
    {
      "Id": "675",
      "Ilce": "Derinkuyu",
      "Il_Id": "50"
    },
    {
      "Id": "676",
      "Ilce": "Gülşehir",
      "Il_Id": "50"
    },
    {
      "Id": "677",
      "Ilce": "Hacıbektaş",
      "Il_Id": "50"
    },
    {
      "Id": "678",
      "Ilce": "Kozaklı",
      "Il_Id": "50"
    },
    {
      "Id": "679",
      "Ilce": "Nevşehir Merkez",
      "Il_Id": "50"
    },
    {
      "Id": "680",
      "Ilce": "Ürgüp",
      "Il_Id": "50"
    },
    {
      "Id": "681",
      "Ilce": "Acıgöl",
      "Il_Id": "50"
    },
    {
      "Id": "682",
      "Ilce": "Bor",
      "Il_Id": "51"
    },
    {
      "Id": "683",
      "Ilce": "Çamardı",
      "Il_Id": "51"
    },
    {
      "Id": "684",
      "Ilce": "Niğde Merkez",
      "Il_Id": "51"
    },
    {
      "Id": "685",
      "Ilce": "Ulukışla",
      "Il_Id": "51"
    },
    {
      "Id": "686",
      "Ilce": "Altunhisar",
      "Il_Id": "51"
    },
    {
      "Id": "687",
      "Ilce": "Çiftlik",
      "Il_Id": "51"
    },
    {
      "Id": "688",
      "Ilce": "Akkuş",
      "Il_Id": "52"
    },
    {
      "Id": "689",
      "Ilce": "Aybastı",
      "Il_Id": "52"
    },
    {
      "Id": "690",
      "Ilce": "Fatsa",
      "Il_Id": "52"
    },
    {
      "Id": "691",
      "Ilce": "Gölköy",
      "Il_Id": "52"
    },
    {
      "Id": "692",
      "Ilce": "Korgan",
      "Il_Id": "52"
    },
    {
      "Id": "693",
      "Ilce": "Kumru",
      "Il_Id": "52"
    },
    {
      "Id": "694",
      "Ilce": "Mesudiye",
      "Il_Id": "52"
    },
    {
      "Id": "695",
      "Ilce": "Perşembe",
      "Il_Id": "52"
    },
    {
      "Id": "696",
      "Ilce": "Ulubey / Ordu",
      "Il_Id": "52"
    },
    {
      "Id": "697",
      "Ilce": "Ünye",
      "Il_Id": "52"
    },
    {
      "Id": "698",
      "Ilce": "Gülyalı",
      "Il_Id": "52"
    },
    {
      "Id": "699",
      "Ilce": "Gürgentepe",
      "Il_Id": "52"
    },
    {
      "Id": "700",
      "Ilce": "Çamaş",
      "Il_Id": "52"
    },
    {
      "Id": "701",
      "Ilce": "Çatalpınar",
      "Il_Id": "52"
    },
    {
      "Id": "702",
      "Ilce": "Çaybaşı",
      "Il_Id": "52"
    },
    {
      "Id": "703",
      "Ilce": "İkizce",
      "Il_Id": "52"
    },
    {
      "Id": "704",
      "Ilce": "Kabadüz",
      "Il_Id": "52"
    },
    {
      "Id": "705",
      "Ilce": "Kabataş",
      "Il_Id": "52"
    },
    {
      "Id": "706",
      "Ilce": "Altınordu",
      "Il_Id": "52"
    },
    {
      "Id": "707",
      "Ilce": "Ardeşen",
      "Il_Id": "53"
    },
    {
      "Id": "708",
      "Ilce": "Çamlıhemşin",
      "Il_Id": "53"
    },
    {
      "Id": "709",
      "Ilce": "Çayeli",
      "Il_Id": "53"
    },
    {
      "Id": "710",
      "Ilce": "Fındıklı",
      "Il_Id": "53"
    },
    {
      "Id": "711",
      "Ilce": "İkizdere",
      "Il_Id": "53"
    },
    {
      "Id": "712",
      "Ilce": "Kalkandere",
      "Il_Id": "53"
    },
    {
      "Id": "713",
      "Ilce": "Pazar / Rize",
      "Il_Id": "53"
    },
    {
      "Id": "714",
      "Ilce": "Rize Merkez",
      "Il_Id": "53"
    },
    {
      "Id": "715",
      "Ilce": "Güneysu",
      "Il_Id": "53"
    },
    {
      "Id": "716",
      "Ilce": "Derepazarı",
      "Il_Id": "53"
    },
    {
      "Id": "717",
      "Ilce": "Hemşin",
      "Il_Id": "53"
    },
    {
      "Id": "718",
      "Ilce": "İyidere",
      "Il_Id": "53"
    },
    {
      "Id": "719",
      "Ilce": "Akyazı",
      "Il_Id": "54"
    },
    {
      "Id": "720",
      "Ilce": "Geyve",
      "Il_Id": "54"
    },
    {
      "Id": "721",
      "Ilce": "Hendek",
      "Il_Id": "54"
    },
    {
      "Id": "722",
      "Ilce": "Karasu",
      "Il_Id": "54"
    },
    {
      "Id": "723",
      "Ilce": "Kaynarca",
      "Il_Id": "54"
    },
    {
      "Id": "724",
      "Ilce": "Sapanca",
      "Il_Id": "54"
    },
    {
      "Id": "725",
      "Ilce": "Kocaali",
      "Il_Id": "54"
    },
    {
      "Id": "726",
      "Ilce": "Pamukova",
      "Il_Id": "54"
    },
    {
      "Id": "727",
      "Ilce": "Taraklı",
      "Il_Id": "54"
    },
    {
      "Id": "728",
      "Ilce": "Ferizli",
      "Il_Id": "54"
    },
    {
      "Id": "729",
      "Ilce": "Karapürçek",
      "Il_Id": "54"
    },
    {
      "Id": "730",
      "Ilce": "Söğütlü",
      "Il_Id": "54"
    },
    {
      "Id": "731",
      "Ilce": "Adapazarı",
      "Il_Id": "54"
    },
    {
      "Id": "732",
      "Ilce": "Arifiye",
      "Il_Id": "54"
    },
    {
      "Id": "733",
      "Ilce": "Erenler",
      "Il_Id": "54"
    },
    {
      "Id": "734",
      "Ilce": "Serdivan",
      "Il_Id": "54"
    },
    {
      "Id": "735",
      "Ilce": "Alaçam",
      "Il_Id": "55"
    },
    {
      "Id": "736",
      "Ilce": "Bafra",
      "Il_Id": "55"
    },
    {
      "Id": "737",
      "Ilce": "Çarşamba",
      "Il_Id": "55"
    },
    {
      "Id": "738",
      "Ilce": "Havza",
      "Il_Id": "55"
    },
    {
      "Id": "739",
      "Ilce": "Kavak",
      "Il_Id": "55"
    },
    {
      "Id": "740",
      "Ilce": "Ladik",
      "Il_Id": "55"
    },
    {
      "Id": "741",
      "Ilce": "Terme",
      "Il_Id": "55"
    },
    {
      "Id": "742",
      "Ilce": "Vezirköprü",
      "Il_Id": "55"
    },
    {
      "Id": "743",
      "Ilce": "Asarcık",
      "Il_Id": "55"
    },
    {
      "Id": "745",
      "Ilce": "Salıpazarı",
      "Il_Id": "55"
    },
    {
      "Id": "746",
      "Ilce": "Tekkeköy",
      "Il_Id": "55"
    },
    {
      "Id": "747",
      "Ilce": "Ayvacık / Samsun",
      "Il_Id": "55"
    },
    {
      "Id": "748",
      "Ilce": "Yakakent",
      "Il_Id": "55"
    },
    {
      "Id": "749",
      "Ilce": "Atakum",
      "Il_Id": "55"
    },
    {
      "Id": "750",
      "Ilce": "Canik",
      "Il_Id": "55"
    },
    {
      "Id": "751",
      "Ilce": "İlkadım",
      "Il_Id": "55"
    },
    {
      "Id": "752",
      "Ilce": "Baykan",
      "Il_Id": "56"
    },
    {
      "Id": "753",
      "Ilce": "Eruh",
      "Il_Id": "56"
    },
    {
      "Id": "754",
      "Ilce": "Kurtalan",
      "Il_Id": "56"
    },
    {
      "Id": "755",
      "Ilce": "Pervari",
      "Il_Id": "56"
    },
    {
      "Id": "756",
      "Ilce": "Siirt Merkez",
      "Il_Id": "56"
    },
    {
      "Id": "757",
      "Ilce": "Şirvan",
      "Il_Id": "56"
    },
    {
      "Id": "758",
      "Ilce": "Tillo",
      "Il_Id": "56"
    },
    {
      "Id": "759",
      "Ilce": "Ayancık",
      "Il_Id": "57"
    },
    {
      "Id": "760",
      "Ilce": "Boyabat",
      "Il_Id": "57"
    },
    {
      "Id": "761",
      "Ilce": "Durağan",
      "Il_Id": "57"
    },
    {
      "Id": "762",
      "Ilce": "Erfelek",
      "Il_Id": "57"
    },
    {
      "Id": "763",
      "Ilce": "Gerze",
      "Il_Id": "57"
    },
    {
      "Id": "764",
      "Ilce": "Sinop Merkez",
      "Il_Id": "57"
    },
    {
      "Id": "765",
      "Ilce": "Türkeli",
      "Il_Id": "57"
    },
    {
      "Id": "766",
      "Ilce": "Dikmen",
      "Il_Id": "57"
    },
    {
      "Id": "767",
      "Ilce": "Saraydüzü",
      "Il_Id": "57"
    },
    {
      "Id": "768",
      "Ilce": "Divriği",
      "Il_Id": "58"
    },
    {
      "Id": "769",
      "Ilce": "Gemerek",
      "Il_Id": "58"
    },
    {
      "Id": "770",
      "Ilce": "Gürün",
      "Il_Id": "58"
    },
    {
      "Id": "771",
      "Ilce": "Hafik",
      "Il_Id": "58"
    },
    {
      "Id": "772",
      "Ilce": "İmranlı",
      "Il_Id": "58"
    },
    {
      "Id": "773",
      "Ilce": "Kangal",
      "Il_Id": "58"
    },
    {
      "Id": "774",
      "Ilce": "Koyulhisar",
      "Il_Id": "58"
    },
    {
      "Id": "775",
      "Ilce": "Sivas Merkez",
      "Il_Id": "58"
    },
    {
      "Id": "776",
      "Ilce": "Suşehri",
      "Il_Id": "58"
    },
    {
      "Id": "777",
      "Ilce": "Şarkışla",
      "Il_Id": "58"
    },
    {
      "Id": "778",
      "Ilce": "Yıldızeli",
      "Il_Id": "58"
    },
    {
      "Id": "779",
      "Ilce": "Zara",
      "Il_Id": "58"
    },
    {
      "Id": "780",
      "Ilce": "Akıncılar",
      "Il_Id": "58"
    },
    {
      "Id": "781",
      "Ilce": "Altınyayla / Sivas",
      "Il_Id": "58"
    },
    {
      "Id": "782",
      "Ilce": "Doğanşar",
      "Il_Id": "58"
    },
    {
      "Id": "783",
      "Ilce": "Gölova",
      "Il_Id": "58"
    },
    {
      "Id": "784",
      "Ilce": "Ulaş",
      "Il_Id": "58"
    },
    {
      "Id": "785",
      "Ilce": "Çerkezköy",
      "Il_Id": "59"
    },
    {
      "Id": "786",
      "Ilce": "Çorlu",
      "Il_Id": "59"
    },
    {
      "Id": "787",
      "Ilce": "Hayrabolu",
      "Il_Id": "59"
    },
    {
      "Id": "788",
      "Ilce": "Malkara",
      "Il_Id": "59"
    },
    {
      "Id": "789",
      "Ilce": "Muratlı",
      "Il_Id": "59"
    },
    {
      "Id": "790",
      "Ilce": "Saray / Tekirdağ",
      "Il_Id": "59"
    },
    {
      "Id": "791",
      "Ilce": "Şarköy",
      "Il_Id": "59"
    },
    {
      "Id": "792",
      "Ilce": "Marmaraereğlisi",
      "Il_Id": "59"
    },
    {
      "Id": "793",
      "Ilce": "Ergene",
      "Il_Id": "59"
    },
    {
      "Id": "794",
      "Ilce": "Kapaklı",
      "Il_Id": "59"
    },
    {
      "Id": "795",
      "Ilce": "Süleymanpaşa",
      "Il_Id": "59"
    },
    {
      "Id": "796",
      "Ilce": "Almus",
      "Il_Id": "60"
    },
    {
      "Id": "797",
      "Ilce": "Artova",
      "Il_Id": "60"
    },
    {
      "Id": "798",
      "Ilce": "Erbaa",
      "Il_Id": "60"
    },
    {
      "Id": "799",
      "Ilce": "Niksar",
      "Il_Id": "60"
    },
    {
      "Id": "800",
      "Ilce": "Reşadiye",
      "Il_Id": "60"
    },
    {
      "Id": "801",
      "Ilce": "Tokat Merkez",
      "Il_Id": "60"
    },
    {
      "Id": "802",
      "Ilce": "Turhal",
      "Il_Id": "60"
    },
    {
      "Id": "803",
      "Ilce": "Zile",
      "Il_Id": "60"
    },
    {
      "Id": "804",
      "Ilce": "Pazar / Tokat",
      "Il_Id": "60"
    },
    {
      "Id": "805",
      "Ilce": "Yeşilyurt / Tokat",
      "Il_Id": "60"
    },
    {
      "Id": "806",
      "Ilce": "Başçiftlik",
      "Il_Id": "60"
    },
    {
      "Id": "807",
      "Ilce": "Sulusaray",
      "Il_Id": "60"
    },
    {
      "Id": "808",
      "Ilce": "Akçaabat",
      "Il_Id": "61"
    },
    {
      "Id": "809",
      "Ilce": "Araklı",
      "Il_Id": "61"
    },
    {
      "Id": "810",
      "Ilce": "Arsin",
      "Il_Id": "61"
    },
    {
      "Id": "811",
      "Ilce": "Çaykara",
      "Il_Id": "61"
    },
    {
      "Id": "812",
      "Ilce": "Maçka",
      "Il_Id": "61"
    },
    {
      "Id": "813",
      "Ilce": "Of",
      "Il_Id": "61"
    },
    {
      "Id": "814",
      "Ilce": "Sürmene",
      "Il_Id": "61"
    },
    {
      "Id": "815",
      "Ilce": "Tonya",
      "Il_Id": "61"
    },
    {
      "Id": "816",
      "Ilce": "Vakfıkebir",
      "Il_Id": "61"
    },
    {
      "Id": "817",
      "Ilce": "Yomra",
      "Il_Id": "61"
    },
    {
      "Id": "818",
      "Ilce": "Beşikdüzü",
      "Il_Id": "61"
    },
    {
      "Id": "819",
      "Ilce": "Şalpazarı",
      "Il_Id": "61"
    },
    {
      "Id": "820",
      "Ilce": "Çarşıbaşı",
      "Il_Id": "61"
    },
    {
      "Id": "821",
      "Ilce": "Dernekpazarı",
      "Il_Id": "61"
    },
    {
      "Id": "822",
      "Ilce": "Düzköy",
      "Il_Id": "61"
    },
    {
      "Id": "823",
      "Ilce": "Hayrat",
      "Il_Id": "61"
    },
    {
      "Id": "824",
      "Ilce": "Köprübaşı / Trabzon",
      "Il_Id": "61"
    },
    {
      "Id": "825",
      "Ilce": "Ortahisar",
      "Il_Id": "61"
    },
    {
      "Id": "826",
      "Ilce": "Çemişgezek",
      "Il_Id": "62"
    },
    {
      "Id": "827",
      "Ilce": "Hozat",
      "Il_Id": "62"
    },
    {
      "Id": "828",
      "Ilce": "Mazgirt",
      "Il_Id": "62"
    },
    {
      "Id": "829",
      "Ilce": "Nazımiye",
      "Il_Id": "62"
    },
    {
      "Id": "830",
      "Ilce": "Ovacık / Tunceli",
      "Il_Id": "62"
    },
    {
      "Id": "831",
      "Ilce": "Pertek",
      "Il_Id": "62"
    },
    {
      "Id": "832",
      "Ilce": "Pülümür",
      "Il_Id": "62"
    },
    {
      "Id": "833",
      "Ilce": "Tunceli Merkez",
      "Il_Id": "62"
    },
    {
      "Id": "834",
      "Ilce": "Akçakale",
      "Il_Id": "63"
    },
    {
      "Id": "835",
      "Ilce": "Birecik",
      "Il_Id": "63"
    },
    {
      "Id": "836",
      "Ilce": "Bozova",
      "Il_Id": "63"
    },
    {
      "Id": "837",
      "Ilce": "Ceylanpınar",
      "Il_Id": "63"
    },
    {
      "Id": "838",
      "Ilce": "Halfeti",
      "Il_Id": "63"
    },
    {
      "Id": "839",
      "Ilce": "Hilvan",
      "Il_Id": "63"
    },
    {
      "Id": "840",
      "Ilce": "Siverek",
      "Il_Id": "63"
    },
    {
      "Id": "841",
      "Ilce": "Suruç",
      "Il_Id": "63"
    },
    {
      "Id": "842",
      "Ilce": "Viranşehir",
      "Il_Id": "63"
    },
    {
      "Id": "843",
      "Ilce": "Harran",
      "Il_Id": "63"
    },
    {
      "Id": "844",
      "Ilce": "Eyyübiye",
      "Il_Id": "63"
    },
    {
      "Id": "845",
      "Ilce": "Haliliye",
      "Il_Id": "63"
    },
    {
      "Id": "846",
      "Ilce": "Karaköprü",
      "Il_Id": "63"
    },
    {
      "Id": "847",
      "Ilce": "Banaz",
      "Il_Id": "64"
    },
    {
      "Id": "848",
      "Ilce": "Eşme",
      "Il_Id": "64"
    },
    {
      "Id": "849",
      "Ilce": "Karahallı",
      "Il_Id": "64"
    },
    {
      "Id": "850",
      "Ilce": "Sivaslı",
      "Il_Id": "64"
    },
    {
      "Id": "851",
      "Ilce": "Ulubey / Uşak",
      "Il_Id": "64"
    },
    {
      "Id": "852",
      "Ilce": "Uşak Merkez",
      "Il_Id": "64"
    },
    {
      "Id": "853",
      "Ilce": "Başkale",
      "Il_Id": "65"
    },
    {
      "Id": "854",
      "Ilce": "Çatak",
      "Il_Id": "65"
    },
    {
      "Id": "855",
      "Ilce": "Erciş",
      "Il_Id": "65"
    },
    {
      "Id": "856",
      "Ilce": "Gevaş",
      "Il_Id": "65"
    },
    {
      "Id": "857",
      "Ilce": "Gürpınar",
      "Il_Id": "65"
    },
    {
      "Id": "858",
      "Ilce": "Muradiye",
      "Il_Id": "65"
    },
    {
      "Id": "859",
      "Ilce": "Özalp",
      "Il_Id": "65"
    },
    {
      "Id": "860",
      "Ilce": "Bahçesaray",
      "Il_Id": "65"
    },
    {
      "Id": "861",
      "Ilce": "Çaldıran",
      "Il_Id": "65"
    },
    {
      "Id": "862",
      "Ilce": "Edremit / Van",
      "Il_Id": "65"
    },
    {
      "Id": "863",
      "Ilce": "Saray / Van",
      "Il_Id": "65"
    },
    {
      "Id": "864",
      "Ilce": "İpekyolu",
      "Il_Id": "65"
    },
    {
      "Id": "865",
      "Ilce": "Tuşba",
      "Il_Id": "65"
    },
    {
      "Id": "866",
      "Ilce": "Akdağmadeni",
      "Il_Id": "66"
    },
    {
      "Id": "867",
      "Ilce": "Boğazlıyan",
      "Il_Id": "66"
    },
    {
      "Id": "868",
      "Ilce": "Çayıralan",
      "Il_Id": "66"
    },
    {
      "Id": "869",
      "Ilce": "Çekerek",
      "Il_Id": "66"
    },
    {
      "Id": "870",
      "Ilce": "Sarıkaya",
      "Il_Id": "66"
    },
    {
      "Id": "871",
      "Ilce": "Sorgun",
      "Il_Id": "66"
    },
    {
      "Id": "872",
      "Ilce": "Şefaatli",
      "Il_Id": "66"
    },
    {
      "Id": "873",
      "Ilce": "Yerköy",
      "Il_Id": "66"
    },
    {
      "Id": "874",
      "Ilce": "Yozgat Merkez",
      "Il_Id": "66"
    },
    {
      "Id": "875",
      "Ilce": "Aydıncık / Yozgat",
      "Il_Id": "66"
    },
    {
      "Id": "876",
      "Ilce": "Çandır",
      "Il_Id": "66"
    },
    {
      "Id": "877",
      "Ilce": "Kadışehri",
      "Il_Id": "66"
    },
    {
      "Id": "878",
      "Ilce": "Saraykent",
      "Il_Id": "66"
    },
    {
      "Id": "879",
      "Ilce": "Yenifakılı",
      "Il_Id": "66"
    },
    {
      "Id": "880",
      "Ilce": "Çaycuma",
      "Il_Id": "67"
    },
    {
      "Id": "881",
      "Ilce": "Devrek",
      "Il_Id": "67"
    },
    {
      "Id": "882",
      "Ilce": "Ereğli / Zonguldak",
      "Il_Id": "67"
    },
    {
      "Id": "883",
      "Ilce": "Zonguldak Merkez",
      "Il_Id": "67"
    },
    {
      "Id": "884",
      "Ilce": "Alaplı",
      "Il_Id": "67"
    },
    {
      "Id": "885",
      "Ilce": "Gökçebey",
      "Il_Id": "67"
    },
    {
      "Id": "886",
      "Ilce": "Kilimli",
      "Il_Id": "67"
    },
    {
      "Id": "887",
      "Ilce": "Kozlu",
      "Il_Id": "67"
    },
    {
      "Id": "888",
      "Ilce": "Aksaray Merkez",
      "Il_Id": "68"
    },
    {
      "Id": "889",
      "Ilce": "Ortaköy / Aksaray",
      "Il_Id": "68"
    },
    {
      "Id": "890",
      "Ilce": "Ağaçören",
      "Il_Id": "68"
    },
    {
      "Id": "891",
      "Ilce": "Güzelyurt",
      "Il_Id": "68"
    },
    {
      "Id": "892",
      "Ilce": "Sarıyahşi",
      "Il_Id": "68"
    },
    {
      "Id": "893",
      "Ilce": "Eskil",
      "Il_Id": "68"
    },
    {
      "Id": "894",
      "Ilce": "Gülağaç",
      "Il_Id": "68"
    },
    {
      "Id": "895",
      "Ilce": "Bayburt Merkez",
      "Il_Id": "69"
    },
    {
      "Id": "896",
      "Ilce": "Aydıntepe",
      "Il_Id": "69"
    },
    {
      "Id": "897",
      "Ilce": "Demirözü",
      "Il_Id": "69"
    },
    {
      "Id": "898",
      "Ilce": "Ermenek",
      "Il_Id": "70"
    },
    {
      "Id": "899",
      "Ilce": "Karaman Merkez",
      "Il_Id": "70"
    },
    {
      "Id": "900",
      "Ilce": "Ayrancı",
      "Il_Id": "70"
    },
    {
      "Id": "901",
      "Ilce": "Kazımkarabekir",
      "Il_Id": "70"
    },
    {
      "Id": "902",
      "Ilce": "Başyayla",
      "Il_Id": "70"
    },
    {
      "Id": "903",
      "Ilce": "Sarıveliler",
      "Il_Id": "70"
    },
    {
      "Id": "904",
      "Ilce": "Delice",
      "Il_Id": "71"
    },
    {
      "Id": "905",
      "Ilce": "Keskin",
      "Il_Id": "71"
    },
    {
      "Id": "906",
      "Ilce": "Kırıkkale Merkez",
      "Il_Id": "71"
    },
    {
      "Id": "907",
      "Ilce": "Sulakyurt",
      "Il_Id": "71"
    },
    {
      "Id": "908",
      "Ilce": "Bahşili",
      "Il_Id": "71"
    },
    {
      "Id": "909",
      "Ilce": "Balışeyh",
      "Il_Id": "71"
    },
    {
      "Id": "910",
      "Ilce": "Çelebi",
      "Il_Id": "71"
    },
    {
      "Id": "911",
      "Ilce": "Karakeçili",
      "Il_Id": "71"
    },
    {
      "Id": "912",
      "Ilce": "Yahşihan",
      "Il_Id": "71"
    },
    {
      "Id": "913",
      "Ilce": "Batman Merkez",
      "Il_Id": "72"
    },
    {
      "Id": "914",
      "Ilce": "Beşiri",
      "Il_Id": "72"
    },
    {
      "Id": "915",
      "Ilce": "Gercüş",
      "Il_Id": "72"
    },
    {
      "Id": "916",
      "Ilce": "Kozluk",
      "Il_Id": "72"
    },
    {
      "Id": "917",
      "Ilce": "Sason",
      "Il_Id": "72"
    },
    {
      "Id": "918",
      "Ilce": "Hasankeyf",
      "Il_Id": "72"
    },
    {
      "Id": "919",
      "Ilce": "Beytüşşebap",
      "Il_Id": "73"
    },
    {
      "Id": "920",
      "Ilce": "Cizre",
      "Il_Id": "73"
    },
    {
      "Id": "921",
      "Ilce": "İdil",
      "Il_Id": "73"
    },
    {
      "Id": "922",
      "Ilce": "Silopi",
      "Il_Id": "73"
    },
    {
      "Id": "923",
      "Ilce": "Şırnak Merkez",
      "Il_Id": "73"
    },
    {
      "Id": "924",
      "Ilce": "Uludere",
      "Il_Id": "73"
    },
    {
      "Id": "925",
      "Ilce": "Güçlükonak",
      "Il_Id": "73"
    },
    {
      "Id": "926",
      "Ilce": "Bartın Merkez",
      "Il_Id": "74"
    },
    {
      "Id": "927",
      "Ilce": "Kurucaşile",
      "Il_Id": "74"
    },
    {
      "Id": "928",
      "Ilce": "Ulus",
      "Il_Id": "74"
    },
    {
      "Id": "929",
      "Ilce": "Amasra",
      "Il_Id": "74"
    },
    {
      "Id": "930",
      "Ilce": "Ardahan Merkez",
      "Il_Id": "75"
    },
    {
      "Id": "931",
      "Ilce": "Çıldır",
      "Il_Id": "75"
    },
    {
      "Id": "932",
      "Ilce": "Göle",
      "Il_Id": "75"
    },
    {
      "Id": "933",
      "Ilce": "Hanak",
      "Il_Id": "75"
    },
    {
      "Id": "934",
      "Ilce": "Posof",
      "Il_Id": "75"
    },
    {
      "Id": "935",
      "Ilce": "Damal",
      "Il_Id": "75"
    },
    {
      "Id": "936",
      "Ilce": "Aralık",
      "Il_Id": "76"
    },
    {
      "Id": "937",
      "Ilce": "Iğdır Merkez",
      "Il_Id": "76"
    },
    {
      "Id": "938",
      "Ilce": "Tuzluca",
      "Il_Id": "76"
    },
    {
      "Id": "939",
      "Ilce": "Karakoyunlu",
      "Il_Id": "76"
    },
    {
      "Id": "940",
      "Ilce": "Yalova Merkez",
      "Il_Id": "77"
    },
    {
      "Id": "941",
      "Ilce": "Altınova",
      "Il_Id": "77"
    },
    {
      "Id": "942",
      "Ilce": "Armutlu",
      "Il_Id": "77"
    },
    {
      "Id": "943",
      "Ilce": "Çınarcık",
      "Il_Id": "77"
    },
    {
      "Id": "944",
      "Ilce": "Çiftlikköy",
      "Il_Id": "77"
    },
    {
      "Id": "945",
      "Ilce": "Termal",
      "Il_Id": "77"
    },
    {
      "Id": "946",
      "Ilce": "Eflani",
      "Il_Id": "78"
    },
    {
      "Id": "947",
      "Ilce": "Eskipazar",
      "Il_Id": "78"
    },
    {
      "Id": "948",
      "Ilce": "Karabük Merkez",
      "Il_Id": "78"
    },
    {
      "Id": "949",
      "Ilce": "Ovacık / Karabük",
      "Il_Id": "78"
    },
    {
      "Id": "950",
      "Ilce": "Safranbolu",
      "Il_Id": "78"
    },
    {
      "Id": "951",
      "Ilce": "Yenice / Karabük",
      "Il_Id": "78"
    },
    {
      "Id": "952",
      "Ilce": "Kilis Merkez",
      "Il_Id": "79"
    },
    {
      "Id": "953",
      "Ilce": "Elbeyli",
      "Il_Id": "79"
    },
    {
      "Id": "954",
      "Ilce": "Musabeyli",
      "Il_Id": "79"
    },
    {
      "Id": "955",
      "Ilce": "Polateli",
      "Il_Id": "79"
    },
    {
      "Id": "956",
      "Ilce": "Bahçe",
      "Il_Id": "80"
    },
    {
      "Id": "957",
      "Ilce": "Kadirli",
      "Il_Id": "80"
    },
    {
      "Id": "958",
      "Ilce": "Osmaniye Merkez",
      "Il_Id": "80"
    },
    {
      "Id": "959",
      "Ilce": "Düziçi",
      "Il_Id": "80"
    },
    {
      "Id": "960",
      "Ilce": "Hasanbeyli",
      "Il_Id": "80"
    },
    {
      "Id": "961",
      "Ilce": "Sumbas",
      "Il_Id": "80"
    },
    {
      "Id": "962",
      "Ilce": "Toprakkale",
      "Il_Id": "80"
    },
    {
      "Id": "963",
      "Ilce": "Akçakoca",
      "Il_Id": "81"
    },
    {
      "Id": "964",
      "Ilce": "Düzce Merkez",
      "Il_Id": "81"
    },
    {
      "Id": "965",
      "Ilce": "Yığılca",
      "Il_Id": "81"
    },
    {
      "Id": "966",
      "Ilce": "Cumayeri",
      "Il_Id": "81"
    },
    {
      "Id": "967",
      "Ilce": "Gölyaka",
      "Il_Id": "81"
    },
    {
      "Id": "968",
      "Ilce": "Çilimli",
      "Il_Id": "81"
    },
    {
      "Id": "969",
      "Ilce": "Gümüşova",
      "Il_Id": "81"
    },
    {
      "Id": "970",
      "Ilce": "Kaynaşlı",
      "Il_Id": "81"
    }
  ]
}""";

final profil_iconlar = [

{
"image": "assets/profil_icon/lider.png",
"title": "Lider",
"sayi": "0",
},

{
"image": "assets/profil_icon/cilgin.png",
"title": "Çılgın",
  "sayi": "0",
},


  {
    "image": "assets/profil_icon/adalet.png",
    "title": "Adaletli",
    "sayi": "0",
  },

  {
    "image": "assets/profil_icon/saygili.png",
    "title": "Saygılı",
    "sayi": "0",
  },
  {
    "image": "assets/profil_icon/guvenilir.png",
    "title": "Güvenilir",
    "sayi": "0",
  },
  {
    "image": "assets/profil_icon/romantik.png",
    "title": "Romantik",
    "sayi": "0",
  },
  {
    "image": "assets/profil_icon/comert.png",
    "title": "Cömert",
    "sayi": "0",
  },
  {
    "image": "assets/profil_icon/istekli.png",
    "title": "EK",
    "sayi": "0",
  }
];


final kafalar = [
  {
    "image": "assets/logo.jpeg",
    "title": "Diğer",
  },
  {
    "image": "assets/kafalar/alisveris_kafasi.png",
    "title": "Alışveriş\nKafası",
  },
  {
    "image": "assets/kafalar/alkol_kafasi.png",
    "title": "Pub\nKafası",
  },
  {
    "image": "assets/kafalar/bilgisayar_kafasi.png",
    "title": "Bilgisayar\nKafası",
  },
  {
    "image": "assets/kafalar/bilim_kafasi.png",
    "title": "Bilim\nKafası",
  },
  {
    "image": "assets/kafalar/cay_kafasi.png",
    "title": "Çay\nKafası",
  },
  {
    "image": "assets/kafalar/dans_kafasi.png",
    "title": "Dans\nKafası",
  },
  {
    "image": "assets/kafalar/doga_sporlari_kafasi.png",
    "title": "Doga\nSporlari\nKafası",
  },
  {
    "image": "assets/kafalar/fitness_kafasi.png",
    "title": "Fitness\nKafası",
  },
  {
    "image": "assets/kafalar/fotograf_kafasi.png",
    "title": "Fotoğraf\nKafası",
  },
  {
    "image": "assets/kafalar/hayvanlar_alemi_kafasi.png",
    "title": "Hayvanlar\nAlemi\nKafası",
  },
  {
    "image": "assets/kafalar/iliski_kafasi.png",
    "title": "İlişki\nKafası",
  },
  {
    "image": "assets/kafalar/is_kafasi.png",
    "title": "İş\nKafası",
  },
  {
    "image": "assets/kafalar/kamp_kafasi.png",
    "title": "Kamp\nKafası",
  },
  {
    "image": "assets/kafalar/kisisel_gelisim_kafasi.png",
    "title": "Kişisel\nGelişim\nKafası",
  },
  {
    "image": "assets/kafalar/kitap_kafasi.png",
    "title": "Kitap\nKafası",
  },
  {
    "image": "assets/kafalar/konser_kafasi.png",
    "title": "Konser\nKafası",
  },
  {
    "image": "assets/kafalar/kultur_kafasi.png",
    "title": "Kültür\nKafası",
  },
  {
    "image": "assets/kafalar/muze_kafasi.png",
    "title": "Müze\nKafası",
  },
  {
    "image": "assets/kafalar/muzik_kafasi.png",
    "title": "Müzik\nKafası",
  },

  {
    "image": "assets/kafalar/oyun_kafasi.png",
    "title": "Oyun\nKafası",
  },
  {
    "image": "assets/kafalar/piknik_kafasi.png",
    "title": "Piknik\nKafası",
  },
  
  {
    "image": "assets/kafalar/psikoloji_kafasi.png",
    "title": "Psikoloji\nKafası",
  },
  {
    "image": "assets/kafalar/sanat_kafasi.png",
    "title": "Sanat\nKafası",
  },
  {
    "image": "assets/kafalar/sinema_kafasi.png",
    "title": "Sinema\nKafası",
  },
  {
    "image": "assets/kafalar/sohbet_kafasi.png",
    "title": "Sohbet\nKafası",
  },
  {
    "image": "assets/kafalar/sosyal_sorumluluk_kafasi.png",
    "title": "Sosyal\nSorumluluk\nKafası",
  },
  {
    "image": "assets/kafalar/spor_kafasi.png",
    "title": "Spor\nKafası",
  },
  {
    "image": "assets/kafalar/tanisma_kafasi.png",
    "title": "Tanışma\nKafası",
  },
  {
    "image": "assets/kafalar/tarih_kafasi.png",
    "title": "Tarih\nKafası",
  },
  {
    "image": "assets/kafalar/tiyatro_kafasi.png",
    "title": "Tiyatro\nKafası",
  },
  {
    "image": "assets/kafalar/yabanci_dil_kafasi.png",
    "title": "Yabanci\nDil\nKafası",
  },
  {
    "image": "assets/kafalar/yemek_kafasi.png",
    "title": "Yemek\nKafası",
  },
  {
    "image": "assets/kafalar/yuruyus_kafasi.png",
    "title": "Yürüyüş\nKafası",
  },
  {
    "image": "assets/kafalar/yuruyus_kafasi.png",
    "title": "Gezi\nKafası",
  },
  {
    "image": "assets/kafalar/parti_kafasi.png",
    "title": "Parti\nKafası",
  },


];


final kafalarList = [
     "Diğer",
     "Alışveriş Kafası",
     "Pub Kafası",
     "Bilgisayar Kafası",
     "Bilim Kafası",
     "Çay Kafası",
     "Dans Kafası",
     "Doga Sporlari Kafası",
     "Fitness Kafası",
     "Fotoğraf Kafası",
      "Gezi Kafası",
     "Hayvanlar Alemi Kafası",
     "İlişki Kafası",
     "İş Kafası",
     "Kamp Kafası",
     "Kişisel Gelişim Kafası",
     "Kitap Kafası",
     "Konser Kafası",
     "Kültür Kafası",
     "Parti Kafası",
     "Müze Kafası",
     "Müzik Kafası",
     "Oyun Kafası",
     "Piknik Kafası",
     "Psikoloji Kafası",
     "Sanat Kafası",
     "Sinema Kafası",
     "Sohbet Kafası",
     "Sosyal Sorumluluk Kafası",
     "Tanışma Kafası",
     "Tarih Kafası",
     "Tiyatro Kafası",
     "Spor Kafası",
     "Yabanci Dil Kafası",
     "Yemek Kafası",
     "Yürüyüş Kafası",

];


final drawerObject = [
  {
    "title": "Profil",
    'icon': Icons.person,
    'onPressed': (context) => {Navigator.of(context).pop()}
  },
  {
    "title": "Mesajlar",
    'icon': Icons.message,
    'onPressed': null,
  },
  {
    "title": "Etkinliklerim",
    'icon': Icons.date_range,
    'onPressed': null,
  },
  {
    "title": "Market",
    'icon': Icons.shopping_basket,
    'onPressed': null,
  },
  {
    "title": "Ayarlar",
    'icon': Icons.settings,
    'onPressed': null,
  },
  {
    "title": "Hakkımızda",
    'icon': Icons.info,
    'onPressed': null,
  },
  {
    "title": "İletişim",
    'icon': Icons.perm_phone_msg,
    'onPressed': null,
  },
  {
    "title": "Çıkış",
    'icon': Icons.logout,
    "onPressed": null,
  },
];

final dummyEtkinlikler = [
  {
    "id": "1",
    "baslik": "Konser 1",
    "etkinlikFoto": "assets/konser1.png",
    "katilimciSayisi": 342,
    "konum": "Maçka Küçükçiflik Park",
    "yayinlayan": "Ali Yılmaz",
    "tarih": "25 Haziran",
//      "baslangicTarihi": "25.06.2021 20:00:00",
//      "bitisTarihi": "25.06.2021 22:00:00",
    "hakkinda":
        """Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua""",
  },
  {
    "id": "2",
    "baslik": "Konser 2",
    "etkinlikFoto": "assets/konser2.png",
    "katilimciSayisi": 142,
    "konum": "Maçka Küçükçiflik Park",
    "yayinlayan": "Ali Yılmaz",
//      "baslangicTarihi": "25.06.2021 20:00:00",
//      "bitisTarihi": "25.06.2021 22:00:00",
    "hakkinda": "Konser 1 hakkında",
  }
];

final dummyMesajlar = [
  {
    "id": 1,
    "odaId": "1",
    "gondericiUserId": "1",
    "aliciUserId": "2",
    "tarih": DateTime.parse("2021-01-19 15:30:00"),
    "iletildi": true,
    "okundu": false,
    "mesaj": "Selam Nasılsın?",
  },
  {
    "id": 2,
    "odaId": "1",
    "gondericiUserId": "2",
    "aliciUserId": "1",
    "tarih": DateTime.parse("2021-01-20 15:30:00"),
    "iletildi": true,
    "okundu": false,
    "mesaj": "iyidir senden naber"
  },
  {
    "id": 3,
    "odaId": "1",
    "gondericiUserId": "1",
    "aliciUserId": "2",
    "tarih": DateTime.parse("2021-01-20 15:30:00"),
    "iletildi": true,
    "okundu": false,
    "mesaj": "Bende iyiyim"
  },
  {
    "id": 4,
    "odaId": "1",
    "gondericiUserId": "1",
    "aliciUserId": "2",
    "tarih": DateTime.parse("2021-01-20 15:30:00"),
    "iletildi": true,
    "okundu": false,
    "mesaj": "Görüşmek üzere"
  }
];
