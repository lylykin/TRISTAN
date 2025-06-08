import 'package:flutter/material.dart';
import 'dart:math';

class LeSaviezVous extends StatelessWidget {
  final String? materialId;
  const LeSaviezVous({super.key, this.materialId});

  @override
  Widget build(BuildContext context) {
    Map<String, List<String>> facts = {
      "pet": [
        "Le saviez-vous? Le PET est entièrement recyclable, presque infiniment ! ",
        "Le saviez-vous? Le PET est l’un des matériaux d’emballage plastique les plus utilisés au monde !",
        "Le saviez-vous? 1,5 million d'animaux sont tués par le plastique chaque année",
        "Conseils: Pensez à bien vider les bouteilles et flacons. Ne pas laver les emballages, Écraser les bouteilles dans le sens de la hauteur. Pensez à visser les bouchons sur les bouteilles pour qu’ils soient recyclés ou bien gardez les pour l’association BOUCHONS d’AMOUR : ",
      ],
      "hdpe": [],
      "pvc": [
        "Le saviez-vous? Le PVC est composé de : 57 % de sel de mer + 43 % de dérivés du pétrole",
        "Le saviez-vous?  Le PVC a été découvert par accident en 1835 par Henri Victor Regnault, un physicien français",
        "Le saviez-vous? Plus de 50 % de la production annuelle de PVC en France est consommée par le secteur du BTP",
        " Le saviez-vous? L’industrie du PVC en Europe s’est engagée à recycler 900 000 tonnes de plastiques de PVC d’ici 2025 au travers du plan VinylPlus. Au début des années 2000, ce matériau n’était même pas considéré comme un plastique recyclable et présentait un vrai danger pour l’environnement…",
      ],
      "pap": [
        "Le saviez-vous? Le papier ne se recycle pas indéfiniment. En théorie, le papier peut être réutilisé 9 fois",
        " Le saviez-vous? 70 à 85 kilos par an et par salarié : c’est la consommation annuelle de papier estimée par l’ADEME.",
        "Le saviez-vous? Seulement 60 % des papiers sont recyclés en France",
        "Conseils: Pensez à retirer les films plastiques autour des revues. Ne déchirez pas les feuilles en petits morceaux et évitez de les froisser.",
      ],
      "pp": [
        "Le saviez-vous? Le polypropylène résiste à des températures pouvant aller jusqu’à 100°C!!!",
      ],
      "ps": [
        "Le saviez-vous? Le principal obstacle à la collecte reste le caractère diffus et très fin du polystyrène, que l’on trouve sous forme d’une barquette d’emballage alimentaire par exemple. Le taux de recyclage est estimé à 30 %, alors que le matériau est 100 % valorisable...",
        "Le saviez-vous?  Le polystyrène expansé (PSE), le plus courant en France, est composé à 98 % de gaz et 2 % de matière valorisable.",
      ],
      "fe": [
        "Le saviez-vous? En 2018, plus de 12 millions de tonnes de matières premières ferreuses (fer, fonte, et acier) ont été produites par les entreprises françaises de recyclage, ce qui a permis une économie de 17 Mt de CO2.",
        "Le saviez-vous? Dans la nature, le fer ou l’acier mettent jusqu’à plus de 10 ans à rouiller puis disparaître.",
      ],
      "alu": [
        "Le saviez-vous? L’aluminium recyclé permet d’économiser jusqu’à 95 % d’énergie et 70 % d’eau par rapport aux quantités consommées au moment de l’élaboration de l’aluminium primaire par le procédé d’électrolyse.",
        " Le saviez-vous? 660 canettes en aluminium recyclées permettent de fabriquer un vélo, 48.000 une voiture et 15 millions un avion A380 d’Airbus !",
        " Le saviez-vous? Le recyclage d’un contenant en aluminium se fait sur un cycle très court. En revanche, jetées dans la nature, les canettes d’aluminium mettent environ 500 ans avant de se dégrader.",
      ],
      "gl": [
        "Le saviez-vous? 1 tonne de verre recyclée = 1 tonne de verre reconstituée = 0,46 tonne eq. CO2 économisée ",
        "Le saviez-vous? 77,9% du verre a été recyclé en France en 2017 selon l’ADEME, soit plus de 3 bouteilles sur 4.",
      ],
      "ldpe": [
        "Le saviez-vous? Depuis le 1er janvier 2017, la loi relative à la transition énergétique pour la croissance verte a imposé l’interdiction des sacs plastiques aux caisses des commerces en France",
      ],
      "carton": [
        "Le saviez-vous? La production annuelle de déchets cartons de la grande distribution en France est de 1 million de tonnes. ",
        "Conseils: Inutile de laver les briques alimentaires avant de les déposer dans la colonne jaune. Séparez les emballages carton de leurs suremballages en plastique (barquettes, sachets, films). Les gros cartons d’emballage marron sont à apporter en déchèterie.",
      ],
      "Erreur : Objet null": ["Le saviez-vous ? [INFO LAMBDA]"],
    };
    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style, // hérite du style global
        children: [
          TextSpan(
            text: facts[materialId]?[Random().nextInt(facts[materialId]!.length)],
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              backgroundColor: Theme.of(context).colorScheme.surface,
            ),
          ),
        ],
      ),
    );
  }
}
