import 'package:flutter/material.dart';

const PrimaryColor = Color.fromARGB(255, 248, 185, 13);
const PrimaryLightColor = Color(0xFFFFECDF);
const PrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color.fromARGB(255, 248, 185, 13),Color.fromARGB(255, 228, 190, 109)],
);
const SecondaryColor = Color(0xFFECE7E7);
const TextColor1 = Colors.black;
const TextColor2 = Color(0xFF757575);

const navBarPages = ['home', 'cart', 'wishlist', 'checkout'];

final items = [
  "Islamabad",
  "Ahmed Nager",
  "Ahmadpur East",
  "Ali Khan",
  "Alipur",
  "Arifwala",
  "Attock",
  "Bhera",
  "Bhalwal",
  "Bahawalnagar",
  "Bahawalpur",
  "Bhakkar",
  "Burewala",
  "Chillianwala",
  "Chakwal",
  "Chichawatni",
  "Chiniot",
  "Chishtian",
  "Daska",
  "Darya Khan",
  "Dera Ghazi",
  "Dhaular",
  "Dina",
  "Dinga",
  "Dipalpur",
  "Faisalabad",
  "Fateh Jhang",
  "Ghakhar Mandi",
  "Gojra",
  "Gujranwala",
  "Gujrat",
  "Gujar Khan",
  "Hafizabad",
  "Haroonabad",
  "Hasilpur",
  "Haveli",
  "Lakha",
  "Jalalpur",
  "Jattan",
  "Jampur",
  "Jaranwala",
  "Jhang",
  "Jhelum",
  "Kalabagh",
  "Karor Lal",
  "Kasur",
  "Kamalia",
  "Kamoke",
  "Khanewal",
  "Khanpur",
  "Kharian",
  "Khushab",
  "Kot Adu",
  "Jauharabad",
  "Lahore",
  "Lalamusa",
  "Layyah",
  "Liaquat Pur",
  "Lodhran",
  "Malakwal",
  "Mamoori",
  "Mailsi",
  "Mandi Bahauddin",
  "mian Channu",
  "Mianwali",
  "Multan",
  "Murree",
  "Muridke",
  "Mianwali Bangla",
  "Muzaffargarh",
  "Narowal",
  "Okara",
  "Renala Khurd",
  "Pakpattan",
  "Pattoki",
  "Pir Mahal",
  "Qaimpur",
  "Qila Didar",
  "Rabwah",
  "Raiwind",
  "Rajanpur",
  "Rahim Yar",
  "Rawalpindi",
  "Sadiqabad",
  "Safdarabad",
  "Sahiwal",
  "Sangla Hill",
  "Sarai Alamgir",
  "Sargodha",
  "Shakargarh",
  "Sheikhupura",
  "Sialkot",
  "Sohawa",
  "Soianwala",
  "Siranwali",
  "Talagang",
  "Taxila",
  "Toba Tek",
  "Vehari",
  "Wah Cantonment",
  "Wazirabad",
  "Badin",
  "Bhirkan",
  "Rajo Khanani",
  "Chak",
  "Dadu",
  "Digri",
  "Diplo",
  "Dokri",
  "Ghotki",
  "Haala",
  "Hyderabad",
  "Islamkot",
  "Jacobabad",
  "Jamshoro",
  "Jungshahi",
  "Kandhkot",
  "Kandiaro",
  "Karachi",
  "Kashmore",
  "Keti Bandar",
  "Khairpur",
  "Kotri",
  "Larkana",
  "Matiari",
  "Mehar",
  "Mirpur Khas",
  "Mithani",
  "Mithi",
  "Mehrabpur",
  "Moro",
  "Nagarparkar",
  "Naudero",
  "Naushahro Feroze",
  "Naushara",
  "Nawabshah",
  "Nazimabad",
  "Qambar",
  "Qasimabad",
  "Ranipur",
  "Ratodero",
  "Rohri",
  "Sakrand",
  "Sanghar",
  "Shahbandar",
  "Shahdadkot",
  "Shahdadpur",
  "Shahpur Chakar",
  "Shikarpaur",
  "Sukkur",
  "Tangwani",
  "Tando Adam",
  "Tando Allahyar",
  "Tando Muhammad",
  "Thatta",
  "Umerkot",
  "Warah",
  "Abbottabad",
  "Adezai",
  "Alpuri",
  "Akora Khattak",
  "Ayubia",
  "Banda Daud",
  "Bannu",
  "Batkhela",
  "Battagram",
  "Birote",
  "Chakdara",
  "Charsadda",
  "Chitral",
  "Daggar",
  "Dargai",
  "Darya Khan",
  "dera Ismail",
  "Doaba",
  "Dir",
  "Drosh",
  "Hangu",
  "Haripur",
  "Karak",
  "Kohat",
  "Kulachi",
  "Lakki Marwat",
  "Latamber",
  "Madyan",
  "Mansehra",
  "Mardan",
  "Mastuj",
  "Mingora",
  "Nowshera",
  "Paharpur",
  "Pabbi",
  "Peshawar",
  "Saidu Sharif",
  "Shorkot",
  "Shewa Adda",
  "Swabi",
  "Swat",
  "Tangi",
  "Tank",
  "Thall",
  "Timergara",
  "Tordher",
  "Awaran",
  "Barkhan",
  "Chagai",
  "Dera Bugti",
  "Gwadar",
  "Harnai",
  "Jafarabad",
  "Jhal Magsi",
  "Kacchi",
  "Kalat",
  "Kech",
  "Kharan",
  "Khuzdar",
  "Killa Abdullah",
  "Killa Saifullah",
  "Kohlu",
  "Lasbela",
  "Lehri",
  "Loralai",
  "Mastung",
  "Musakhel",
  "Nasirabad",
  "Nushki",
  "Panjgur",
  "Pishin valley",
  "Quetta",
  "Sherani",
  "Sibi",
  "Sohbatpur",
  "Washuk",
  "Zhob",
  "Ziarat"
];

final otpInputDecoration = InputDecoration(
  contentPadding:
  EdgeInsets.symmetric(vertical: 15),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(color: TextColor2),
  );
}